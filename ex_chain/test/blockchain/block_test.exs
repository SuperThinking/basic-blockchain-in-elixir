defmodule ExChain.Blockchain.BlockTest do
  use ExUnit.Case
  alias ExChain.Blockchain.Block

  describe "block" do
    test "Genesis is valid" do
      assert %Block{
        data: "Genesis Block",
        hash: "FDE671660AD65606C79867F819BC0423C2D476B886FD1032BA2B656E24BB69A3",
        last_hash: nil,
        timestamp: 1629490917054859,
        height: 0
      } == Block.genesis()
    end

    test "Mining returns a new block" do
      genesis_block = Block.genesis()
      %Block{hash: hash} = genesis_block
      data = %{from: "X", to: "Y"}
      assert %Block{data: data, last_hash: ^hash} = Block.mine_block(genesis_block, data)
    end
  end
end
