defmodule ExChain.Blockchain.Blockchain do
  @moduledoc """
      Chain of Blocks
  """

  alias __MODULE__
  alias ExChain.Blockchain.Block

  @derive Jason.Encoder
  defstruct [:chain]

  def new() do
    %__MODULE__{} |> add_genesis()
  end

  defp add_genesis(blockchain = %__MODULE__{}) do
    %{blockchain | chain: [Block.genesis()]}
  end

  def add_block(blockchain = %__MODULE__{}, data) do
    last_block = Enum.at(blockchain.chain, -1)
    %{blockchain | chain: blockchain.chain ++ [Block.mine_block(last_block, data)]}
  end
end
