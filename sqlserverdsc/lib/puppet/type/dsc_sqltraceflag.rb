require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqltraceflag',
  dscmeta_resource_friendly_name: 'SqlTraceFlag',
  dscmeta_resource_name: 'DSC_SqlTraceFlag',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlTraceFlag resource type.
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
    dsc_traceflagstoexclude: {
      type: 'Optional[Array[Integer[0, 4294967295]]]',
      desc: 'An array of trace flags to be removed from the existing trace flags.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32[]',
      mof_is_embedded: false,
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
    dsc_restartservice: {
      type: 'Optional[Boolean]',
      desc: 'Forces a restart of the Database Engine service and dependent services after the desired state is set. Default values is $false.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
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
    dsc_restarttimeout: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'The time the resource waits while the sql server services are restarted. Defaults to 120 seconds',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_traceflags: {
      type: 'Optional[Array[Integer[0, 4294967295]]]',
      desc: 'An array of trace flags that startup options should have. This parameter will replace all the current trace flags with the specified trace flags.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32[]',
      mof_is_embedded: false,
    },
    dsc_traceflagstoinclude: {
      type: 'Optional[Array[Integer[0, 4294967295]]]',
      desc: 'An array of trace flags to be added to the existing trace flags.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32[]',
      mof_is_embedded: false,
    },
  },
)
