defmodule Manager.Group do
  use Manager.Web, :model

  schema "groups" do
    field :name, :string
    has_many :members, Manager.Member
    has_many :elements, Element
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> cast_assoc(:members, required: true)
  end
end
