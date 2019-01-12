defmodule VerifyRecaptcha do
  @moduledoc """
  Documentation for VerifyRecaptcha.
  """

  import ConnArtist, only: [halt_json: 3]

  def init(opts), do: opts

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

  defp error(msg) do
    %{"recaptcha" => [msg]}
  end
end
