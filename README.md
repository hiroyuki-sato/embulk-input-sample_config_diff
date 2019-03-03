# Sample Config Diff input plugin for Embulk

Sample plugin for managing config_diff parameter.

## Overview

* **Plugin type**: input
* **Resume supported**: yes
* **Cleanup supported**: yes
* **Guess supported**: no

## Configuration

- **option1**: description (integer, required)
- **option2**: description (string, default: `"myvalue"`)
- **option3**: description (string, default: `null`)

## Example

```yaml
in:
  type: sample_config_diff
  option1: example1
  option2: example2
```

Execute plugin.

```
embulk run -I lib -c /tmp/diff.yml example/sample_config_diff.yml
```


## Build

```
$ rake
```
