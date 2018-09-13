# Changelog

### 0.1.6

- Move to use the batching sink provided as part of the Semlogr core.

### 0.1.5

- Fix faraday include as it clashed with the new semlogr-faraday module

### 0.1.4

- Downgrade to faraday 0.12 grrr

### 0.1.3

- Downgrade to faraday 0.13 to help compatibility

### 0.1.2

- Fix rookie mistake which broke logging of errors

### 0.1.1

- Add clef formatter instead of tacking onto existing JSON formatter
- Adding support to flush buffer on application exit so that we don't lose messages

### 0.1.0

- Initial release
