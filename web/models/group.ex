defmodule Manager.Group do
  use Manager.Web, :model

  schema "groups" do
    field :name, :string
    many_to_many :users, Manager.User, join_through: "members"
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
