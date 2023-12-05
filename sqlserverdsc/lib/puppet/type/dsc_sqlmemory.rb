require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlmemory',
  dscmeta_resource_friendly_name: 'SqlMemory',
  dscmeta_resource_name: 'DSC_SqlMemory',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlMemory resource type.
         Automatically generated from version 16.5.0',
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
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'The host name of the _SQL Server_ to be configured. Default value is the current computer name.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'The name of the _SQL Server_ instance to be configured.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: "When set to `'Present'` then min and max memory will be set to either the value in parameter **MinMemory** and **MaxMemory**, or dynamically configured when parameter **DynamicAlloc** is set to `$true`. When set to `'Absent'` min and max memory will be set to its default values. Default value is `'Present'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_minmemorypercent: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'Minimum amount of memory, as a percentage of total server memory, in the buffer pool used by the instance of _SQL Server_.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
    dsc_isactivenode: {
      type: 'Optional[Boolean]',
      desc: 'Returns if the current node is actively hosting the _SQL Server_ instance.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_dynamicalloc: {
      type: 'Optional[Boolean]',
      desc: 'If set to `$true` then max memory will be dynamically configured. When this parameter is set to `$true`, the parameter **MaxMemory** must be set to `$null` or not be configured. Default value is `$false`.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_maxmemory: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'Maximum amount of memory, in MB, in the buffer pool used by the instance of _SQL Server_.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
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
    dsc_minmemory: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'Minimum amount of memory, in MB, in the buffer pool used by the instance of _SQL Server_.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
    dsc_maxmemorypercent: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'Maximum amount of memory, as a percentage of total server memory, in the buffer pool used by the instance of _SQL Server_.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
  },
)
