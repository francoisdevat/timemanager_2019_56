defmodule Gotham.Guardian do
  use Guardian

  # Ajoute le user ID au sub du token
  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  # Récupère le user grâce au user ID dans le sub
  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Gotham.Accounts.get_user!(id)
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end