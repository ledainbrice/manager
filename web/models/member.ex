defmodule Manager.Member do
  use Manager.Web, :model

  schema "members" do
    field :role, :string
    belongs_to :user, Manager.User
    belongs_to :group, Manager.Group
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:role,:user_id])
    |> validate_required([:role])
    |> unique_constraint(:unique_user_group_access)
  end
end
