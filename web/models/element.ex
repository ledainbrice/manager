defmodule Manager.Element do
  use Manager.Web, :model

  schema "elements" do
    field :name, :string
    field :body, :string
    belongs_to :group, Manager.Group

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :body])
    |> validate_required([:name, :body])
  end
end
