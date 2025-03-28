# Versioning

We follow the [semver](https://semver.org/) standard for versioning.

The following is considered the node's public API, and will therefore be considered as breaking changes.

- RPC gRPC specification (note that this _excludes_ internal inter-component gRPC schemas).
- Node configuration options.
- Faucet configuration options.
- Database schema changes which cannot be reverted.
- Large protocol and behavioral changes.

We intend to include our OpenTelemetry trace specification in this once it stabilizes.

We _will_ also call out non-breaking behvioral changes in our changelog and release notes.
