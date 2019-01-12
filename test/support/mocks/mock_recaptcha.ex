defmodule VerifyRecaptcha.MockRecaptcha do
  def verify("good-key") do
    {:ok, "good"}
  end

  def verify("bad-key") do
    {:error, "bad"}
  end

  def verify(_) do
    {:unexpected, "not a good response"}
  end
end
