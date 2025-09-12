[**@demox-labs/miden-sdk**](../README.md)

***

[@demox-labs/miden-sdk](../README.md) / AccountId

# Class: AccountId

## Methods

### free()

> **free**(): `void`

#### Returns

`void`

***

### isFaucet()

> **isFaucet**(): `boolean`

#### Returns

`boolean`

***

### isRegularAccount()

> **isRegularAccount**(): `boolean`

#### Returns

`boolean`

***

### prefix()

> **prefix**(): [`Felt`](Felt.md)

#### Returns

[`Felt`](Felt.md)

***

### suffix()

> **suffix**(): [`Felt`](Felt.md)

#### Returns

[`Felt`](Felt.md)

***

### toBech32()

> **toBech32**(`network_id`, `account_interface`): `string`

Will turn the Account ID into its bech32 string representation. To avoid a potential
wrongful encoding, this function will expect only IDs for either mainnet ("mm"),
testnet ("mtst") or devnet ("mdev"). To use a custom bech32 prefix, see
`Self::to_bech_32_custom`.

#### Parameters

##### network\_id

[`NetworkId`](../enumerations/NetworkId.md)

##### account\_interface

[`AccountInterface`](../enumerations/AccountInterface.md)

#### Returns

`string`

***

### toBech32Custom()

> **toBech32Custom**(`custom_network_id`, `account_interface`): `string`

Turn this Account ID into its bech32 string representation. This method accepts a custom
network ID.

#### Parameters

##### custom\_network\_id

`string`

##### account\_interface

[`AccountInterface`](../enumerations/AccountInterface.md)

#### Returns

`string`

***

### toString()

> **toString**(): `string`

#### Returns

`string`

***

### fromHex()

> `static` **fromHex**(`hex`): `AccountId`

#### Parameters

##### hex

`string`

#### Returns

`AccountId`
