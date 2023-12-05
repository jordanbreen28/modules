require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlwaitforag',
  dscmeta_resource_friendly_name: 'SqlWaitForAG',
  dscmeta_resource_name: 'DSC_SqlWaitForAG',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlWaitForAG resource type.
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
    dsc_retrycount: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Maximum number of retries until the resource will timeout and throw an error. Default values is `30` times.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'Name of the cluster role/group to look for (normally the same as the _Availability Group_ name).',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_retryintervalsec: {
      type: 'Optional[Integer[0, 18446744073709551615]]',
      desc: 'The interval, in seconds, to check for the presence of the cluster role/group. Default value is `20` seconds. When the cluster role/group has been found the resource will wait for this amount of time once more before returning.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt64',
      mof_is_embedded: false,
    },
    dsc_groupexist: {
      type: 'Optional[Boolean]',
      desc: 'Returns `$true` if the cluster role/group exist, otherwise it returns `$false`. Used by _Get_.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
