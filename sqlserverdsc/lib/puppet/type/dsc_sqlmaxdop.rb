require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlmaxdop',
  dscmeta_resource_friendly_name: 'SqlMaxDop',
  dscmeta_resource_name: 'DSC_SqlMaxDop',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlMaxDop resource type.
         Automatically generated from version 16.0.0',
  features: ['simple_get_filter', 'canonicalize', 'custom_insync'],
  attributes: {
    name: {
      type:      'String',
      desc:      'Description of the purpose for this resource declaration.',
      behaviour: :namevar,
    },
    validation_mode: {
      type:      'Enum[property, resource]',
      desc:      'Whether to check if the resource is in the desired state by property (default) or using Invoke-DscResource in Test mode (resource).',
      behaviour: :parameter,
      default:   'property',
    },
    dsc_psdscrunascredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: ' ',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_maxdop: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'A numeric value to limit the number of processors used in parallel plan execution.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'The name of the SQL instance to be configured.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "When set to `'Present'` then max degree of parallelism will be set to either the value in parameter **MaxDop** or dynamically configured when parameter **DynamicAlloc** is set to `$true`. When set to `'Absent'` max degree of parallelism will be set to `0` which means no limit in number of processors used in parallel plan execution.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'The host name of the _SQL Server_ to be configured. Default value is the current computer name.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_isactivenode: {
      type: 'Optional[Boolean]',
      desc: 'Determines if the current node is actively hosting the _SQL Server_ instance.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_dynamicalloc: {
      type: 'Optional[Boolean]',
      desc: 'If set to `$true` then max degree of parallelism will be dynamically configured. When this is set parameter is set to `$true`, the parameter **MaxDop** must be set to `$null` or not be configured.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_processonlyonactivenode: {
      type: 'Optional[Boolean]',
      desc: 'Specifies that the resource will only determine if a change is needed if the target node is the active host of the _SQL Server_ instance.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
