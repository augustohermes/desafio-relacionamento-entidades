defmodule Repoex.GetReposBehaviour do
  alias Repoex.Error

  @callback call(String.t()) :: {:ok, map()} | {:error, Error.t()}
end
