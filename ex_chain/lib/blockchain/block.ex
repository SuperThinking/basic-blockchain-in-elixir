defmodule ExChain.Blockchain.Block do
  @moduledoc """
      Single block struct in a blockchain
  """

  alias __MODULE__
  
  @derive Jason.Encoder
  defstruct [:timestamp, :last_hash, :hash, :data]

  def new(timestamp, last_hash, data) do
    hash = hash(timestamp, last_hash, data)
    %__MODULE__{
        data: data,
        hash: hash,
        last_hash: last_hash,
        timestamp: timestamp
    }
  end

  def genesis() do
    genesis_block_timestamp = 1629490917054859
    __MODULE__.new(
        genesis_block_timestamp,
        nil,
        "Genesis Block"
    )
  end

  def mine_block(%__MODULE__{hash: last_hash}, data) do
    current_timestamp = DateTime.utc_now() |> DateTime.to_unix(1_000_000)
    __MODULE__.new(current_timestamp, last_hash, data)
  end

  defp hash(timestamp, last_hash, data) do
    data = "#{timestamp}#{last_hash}#{Jason.encode!(data)}"
    Base.encode16(:crypto.hash(:sha256, data))
  end

end
