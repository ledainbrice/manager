defmodule Manager.User do
  use Manager.Web, :model

  schema "users" do
    field :email, :string
    field :name, :string
    has_many :members, Manager.Member
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :name])
    |> validate_required([:email, :name])
    |> unique_constraint(:email)
    |> unique_constraint(:name)
  end
end
