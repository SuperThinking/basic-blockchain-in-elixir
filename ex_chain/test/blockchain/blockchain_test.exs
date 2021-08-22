defmodule ExChain.Blockchain.BlockchainTest do
  use ExUnit.Case
  alias ExChain.Blockchain.Blockchain
  alias ExChain.Blockchain.Block

  describe "blockchain" do
    test "First block of blockchain is the Genesis block" do
      assert %Block{
        data: "Genesis Block",
        hash: "FDE671660AD65606C79867F819BC0423C2D476B886FD1032BA2B656E24BB69A3",
        last_hash: nil,
        timestamp: 1629490917054859
      } == hd(Blockchain.new().chain)
    end

    test "Add a new block to blockchain" do
      blockchain = Blockchain.new()
      %Block{hash: hash} = hd(blockchain.chain)
      data = %{from: "X", to: "Y"}
      blockchain = Blockchain.add_block(blockchain, data)
      assert %Block{data: data, last_hash: ^hash} = Enum.at(blockchain.chain, -1)
    end
  end
end
