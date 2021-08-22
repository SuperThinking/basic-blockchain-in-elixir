Following the tutorial [here](https://medium.com/coinmonks/building-a-blockchain-in-elixir-part-1-4d4ed889525b) to build a blockchain in elixir.


Each block has the following properties:

- Index
- Timestamp
- Previous Hash
- Hash
- Data

---

Run Tests

```bash
cd ex_chain
mix test
```

---

Try Out!

```bash
cd ex_chain
iex -S mix
```

```elixir
alias ExChain.Blockchain.{Block, Blockchain}
# Initialize Blockchain
blockchain = Blockchain.new()
# Add a block to this blockchain
blockchain = Blockchain.add_block(blockchain, "Some Data")
```
___


Glossary (full list can be found [here](https://consensys.net/knowledge-base/a-blockchain-glossary-for-beginners/)):

- Genesis Block - It's the first block in any blockchain.
- Mining - The process by which blocks (or transactions) are verified and added to the blockchain.
