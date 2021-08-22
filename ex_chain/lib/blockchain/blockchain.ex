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

  def valid_chain?(%__MODULE__{chain: chain}) do
    chain
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [prev_block, block] -> valid_last_hash?(prev_block, block) && Block.valid_block_hash?(prev_block) end)
  end

  defp valid_last_hash?(%Block{hash: hash}, %Block{last_hash: last_hash}) do
    hash == last_hash
  end
end
