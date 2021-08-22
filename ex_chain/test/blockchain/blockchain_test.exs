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
        timestamp: 1629490917054859,
        height: 0
      } == hd(Blockchain.new().chain)
    end

    test "Add a new block to blockchain" do
      blockchain = Blockchain.new()
      %Block{hash: hash} = hd(blockchain.chain)
      data = %{from: "X", to: "Y"}
      blockchain = Blockchain.add_block(blockchain, data)
      assert %Block{data: data, last_hash: ^hash, height: 1} = Enum.at(blockchain.chain, -1)
    end

    test "Validate Blockchain" do
      blockchain = Blockchain.new()
      blockchain = Blockchain.add_block(blockchain, %{from: "X", to: "Y"})
      blockchain = Blockchain.add_block(blockchain, %{from: "X", to: "Z"})
      blockchain = Blockchain.add_block(blockchain, %{from: "Z", to: "Y"})
      assert(Blockchain.valid_chain?(blockchain))
    end

    test "Invalidate Blockchain if some data is tampered" do
      blockchain = Blockchain.new()
      blockchain = Blockchain.add_block(blockchain, %{from: "X", to: "Y"}) # 0
      blockchain = Blockchain.add_block(blockchain, %{from: "X", to: "Z"}) # 1
      blockchain = Blockchain.add_block(blockchain, %{from: "Z", to: "Y"}) # 2
      tampered_block = put_in(Enum.at(blockchain.chain, 1).data, %{from: "Z", to: "X"})
      tampered_chain = List.replace_at(blockchain.chain, 1, tampered_block)
      blockchain = %Blockchain{chain: tampered_chain}
      refute(Blockchain.valid_chain?(blockchain))
    end

    test "Invalidate Blockchain if hash of some block is tampered" do
      blockchain = Blockchain.new()
      blockchain = Blockchain.add_block(blockchain, %{from: "X", to: "Y"}) # 0
      blockchain = Blockchain.add_block(blockchain, %{from: "X", to: "Z"}) # 1
      blockchain = Blockchain.add_block(blockchain, %{from: "Z", to: "Y"}) # 2
      tampered_block = put_in(Enum.at(blockchain.chain, 1).hash, "Hash123")
      tampered_chain = List.replace_at(blockchain.chain, 1, tampered_block)
      blockchain = %Blockchain{chain: tampered_chain}
      refute(Blockchain.valid_chain?(blockchain))
    end
  end
end
