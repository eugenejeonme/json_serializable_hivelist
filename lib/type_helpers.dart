/// this library file exports custom type helpers used for json_serializable code generation for built_value and kt.dart collections.
/// normal users of this library should not need this, this is for advanced users who want to add their own, additional TypeHelpers
/// and write their own builder
library json_serializable_hivelist_type_helpers;

export 'src/hive_list_type_helpers.dart'
    show HiveListTypeHelper;
