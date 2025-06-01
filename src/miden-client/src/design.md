The Miden client has the following architectural components:

- [Store](#store)
- [RPC client](#rpc-client)
- [Transaction executor](#transaction-executor)
- [Keystore](#keystore)
- [Note screener](#note-screener)

> [!Tip]
> - The RPC client and the store are Rust traits.
> - This allow developers and users to easily customize their implementations.

## Store

The store is central to the client's design.

It manages the persistence of the following entities:

- Accounts; including their state history and related information such as vault assets and account code.
- Transactions and their scripts.
- Notes.
- Note tags.
- Block headers and chain information that the client needs to execute transactions and consume notes.

Because Miden allows off-chain executing and proving, the client needs to know about the state of the blockchain at the moment of execution. To avoid state bloat, however, the client does not need to see the whole blockchain history, just the chain history intervals that are relevant to the user.

The store can track any number of accounts, and any number of notes that those accounts might have created or may want to consume.

## RPC client

The RPC client communicates with the node through a defined set of gRPC methods. The provided client works both in `std` and `wasm` environments.

Currently, these include:

- `CheckNullifiers`: Returns proofs for specific provided full nullifiers.
- `CheckNullifiersByPrefix`: Returns a list of tracked nullifiers that match specific prefixes. This is useful for checking if a note has been consumed without revealing the nullifiers that the client is tracking.
- `GetAccountDetails`: Returns the account details for a specific account ID. The available information will depend on the account type (public or private).
- `GetAccountProofs`: Returns the account data needed to perform a Foreign Procedure Invocation (FPI) on the specified foreign accounts.
- `GetAccountStateDelta`: Returns the state delta for a specific account ID between two block numbers.
- `GetBlockByNumber`: Returns a proven block given a specific block number.
- `GetBlockHeaderByNumber`: Returns the block header information given a specific block number.
- `GetNotesById`: Returns a list of notes given a specific note ID. The available information for each note will depend on the note type (public or private).
- `SubmitProvenTransaction`: Sends a locally-proved transaction to the node for inclusion in the blockchain.
- `SyncNotes`: Asks the node for information about notes that have been created or consumed.
- `SyncState`: Asks the node for information relevant to the client. For example, specific account changes, whether relevant notes have been created or consumed, etc.

## Transaction executor

The transaction executor uses the [Miden VM](https://0xmiden.github.io/miden-docs/imported/miden-vm/src/intro/main.html) to execute transactions. All transactions run within the [transaction kernel](https://0xmiden.github.io/miden-docs/imported/miden-base/src/transaction.html).

When executing, the executor needs access to relevant blockchain history. The executor uses a `DataStore` interface for accessing this data. This means that there may be some coupling between the executor and the store.

## Keystore

The keystore is responsible for storing and managing the private keys of the accounts tracked by the client.

These private keys are used by the executor to sign and authenticate transactions. Implementations for both rust and web keystores are provided.

## Note Screener

The note screener is used to check the consumability of notes by tracked accounts. It performs fast static checks (e.g. checking the inputs for well known notes) and also dry runs of consumption transactions.

It can find the tracked accounts that can consume a note, and whether the note can be consumed at the moment or in the future.

## State Sync component

The state sync component encapsulates the logic for dealing with synchronization of the client state with the network. It repeatedly queries the node with sync state requests until the chain tip is reached. On every requests it updates the provided tracked elements (accounts, notes, transactions, etc.) and returns an updated state at the end which can be used to update the store (this component does not modify the store directly).

The component also exposes a specific customizable callback which can be used to react to new note arrivals.
