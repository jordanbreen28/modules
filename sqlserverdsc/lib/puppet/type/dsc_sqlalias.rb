require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlalias',
  dscmeta_resource_friendly_name: 'SqlAlias',
  dscmeta_resource_name: 'DSC_SqlAlias',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlAlias resource type.
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
      desc: 'The _SQL Server_ you are aliasing. This should be set to the NetBIOS name or fully qualified domain name (FQDN).',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "Determines whether the alias should be added (`'Present'`) or removed (`'Absent'`). Default value is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_usedynamictcpport: {
      type: 'Optional[Boolean]',
      desc: 'Specifies that the Net-Library will determine the port dynamically. The port number specified in **Port** will be ignored. Default value is `$false`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: "The name of Alias (e.g. `'svr01\inst01'`).",
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_tcpport: {
      type: 'Optional[Integer[0, 65535]]',
      desc: "The TCP port the _SQL Server_ instance is listening on. Only used when **Protocol** is set to `'TCP'`. Default value is port `1433`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_protocol: {
      type: "Optional[Enum['TCP', 'NP', 'tcp', 'np']]",
      desc: "Protocol to use when connecting. Valid values are `'TCP'` (_TCP/IP_) or `'NP'` (_Named Pipes_). Default value is `'TCP'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_pipename: {
      type: 'Optional[String]',
      desc: "Returns the _Named Pipes_ path if **Protocol** is set to `'NP'`.",
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
