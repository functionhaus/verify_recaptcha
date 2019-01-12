defmodule VerifyRecaptchaTest do
  use ExUnit.Case
  use Plug.Test
  doctest VerifyRecaptcha

  setup do
    :meck.expect(Recaptcha, :verify, &VerifyRecaptcha.MockRecaptcha.verify/1)
    :ok
  end

  test "returns the conn if the recaptcha is verified" do
    conn = conn(:get, "/")
      |> Map.put(:params, %{ "recaptcha" => "good-key" })

    assert VerifyRecaptcha.call(conn, nil) == conn
  end

  test "returns a 401 error if no recaptcha is provided" do
    conn = conn(:get, "/")
      |> Map.put(:params, %{})
      |> VerifyRecaptcha.call(nil)

    assert conn.status == 401
  end

  test "returns a 403 error if an invalid recaptcha is provided" do
    conn = conn(:get, "/")
      |> Map.put(:params, %{ "recaptcha" => "bad-key" })
      |> VerifyRecaptcha.call(nil)

    assert conn.status == 403
  end

  test "returns a 500 error if Recaptcha gives an unexpected response" do
    conn = conn(:get, "/")
      |> Map.put(:params, %{ "recaptcha" => "nonsense" })
      |> VerifyRecaptcha.call(nil)

    assert conn.status == 500
  end
end
