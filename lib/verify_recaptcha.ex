defmodule VerifyRecaptcha do
  @moduledoc """
  VerifyRecaptcha is a simple Plug module for verifying input from a Recaptcha
  instance and passing back a structured response.
  """

  import ConnArtist, only: [halt_json: 3]

  @spec init(%{}) :: %{}
  def init(opts), do: opts

  @spec call(%Plug.Conn{}, any()) :: %Plug.Conn{}
  def call(conn, _) do
    recaptcha = conn.params
    |> Map.get("recaptcha")

    case recaptcha && Recaptcha.verify(recaptcha) do
      {:ok, _} -> conn
      {:error, msg} -> halt_json(conn, 403, error(msg))
      nil -> halt_json(conn, 401, error("no recaptcha given"))
      _ -> halt_json(conn, 500, error("unexpected recaptcha error"))
    end
  end

  @spec error(binary()) :: %{required(binary()) => [binary()]}
  defp error(msg) do
    %{"recaptcha" => [msg]}
  end
end
