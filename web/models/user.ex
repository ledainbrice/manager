defmodule Manager.User do
  use Manager.Web, :model

  schema "users" do
    field :email, :string
    field :token, :string
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :token, :name])
    |> validate_required([:email, :token, :name])
  end
end
