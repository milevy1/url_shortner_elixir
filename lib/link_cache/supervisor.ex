defmodule LinkCache.Supervisor do
  use Supervisor

  def start_link(_params) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(LinkCache.Cache, [[name: LinkCache.Cache]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
