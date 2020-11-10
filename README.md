# json_serializable_hivelist

[![Pub Package](https://img.shields.io/pub/v/json_serializable_hivelist.svg)](https://pub.dartlang.org/packages/json_serializable_hivelist)


(De-)Serialize more collections using json_serializable.

Unofficial package, meant to extend the functionality of json_serializable.

## Features:

Behaves like json_serializable, but supports more collections.

Currently supported:

- All types supported by json_serializable
- HiveList

## How to use

Add to your dev_dependencies:

```yaml
    json_serializable_hivelist: <current_version>
```

Add to your `build.yaml` (create the file if necessary, this is necessary to avoid conflicts between json_serializable and this library):

```yaml
    targets:
      $default:
        builders:
          json_serializable_hivelist:
            # configure your options here, same as json_serializable
            options:
              explicit_to_json: true
          json_serializable:json_serializable:
            generate_for:
              # exclude everything to avoid conflicts, this library uses a custom builder
              include:
              exclude:
                - test/**
                - lib/**
```



