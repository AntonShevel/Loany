defmodule Loany do
  @moduledoc """
  Loany keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defmodule Model do
    defmacro __using__(_) do
      quote do
        use Ecto.Schema

        alias __MODULE__

        import Ecto.Changeset
        import Ecto.Query
      end
    end
  end
end
