defmodule Manager.Element do
  use Manager.Web, :model
  alias Manager.Repo

  schema "elements" do
    field :name, :string
    field :body, :string
    belongs_to :group, Manager.Group
    has_many :children, Manager.Element, foreign_key: :element_id
    belongs_to :parent, Manager.Element, foreign_key: :element_id
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :body,:group_id,:element_id])
    |> validate_required([:name, :body])
  end


   @doc """
    Recursively loads parents into the given struct until it hits nil
  """
  def load_parents(parent) do
    load_parents(parent, 10)
  end

  def load_parents(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_parents(%Manager.Element{parent: nil} = parent, _), do: parent

  def load_parents(%Manager.Element{parent: %Ecto.Association.NotLoaded{}} = parent, limit) do
    parent = parent |> Repo.preload(:parent)
    Map.update!(parent, :parent, &Manager.Element.load_parents(&1, limit - 1))
  end

  def load_parents(nil, _), do: nil

  @doc """
    Recursively loads children into the given struct until it hits []
  """
  def load_children(model), do: load_children(model, 10)

  def load_children(_, limit) when limit < 0, do: raise "Recursion limit reached"

  def load_children(%Manager.Element{children: %Ecto.Association.NotLoaded{}} = model, limit) do
    model = model |> Repo.preload(:children) # maybe include a custom query here to preserve some order
    Map.update!(model, :children, fn(list) ->
      Enum.map(list, &Manager.Element.load_children(&1, limit - 1))
    end)
  end
end
