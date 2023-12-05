require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlprotocol',
  dscmeta_resource_friendly_name: 'SqlProtocol',
  dscmeta_resource_name: 'DSC_SqlProtocol',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlProtocol resource type.
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
    dsc_enabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the protocol should be enabled or disabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Specifies the name of the _SQL Server_ instance to enable the protocol for.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'Specifies the host name of the _SQL Server_ to be configured. If the SQL Server belongs to a cluster or availability group specify the host name for the listener or cluster group. Default value is the current computer name.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_keepalive: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'Specifies the keep alive duration in milliseconds. Only used for the _TCP/IP_ protocol, ignored for all other protocols.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
    dsc_listenonallipaddresses: {
      type: 'Optional[Boolean]',
      desc: 'Specifies to listen on all IP addresses. Only used for the _TCP/IP_ protocol, ignored for all other protocols.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_suppressrestart: {
      type: 'Optional[Boolean]',
      desc: 'If set to `$true` then the any attempt by the resource to restart the service is suppressed. The default value is `$false`.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_protocolname: {
      type: "Enum['SharedMemory', 'sharedmemory', 'NamedPipes', 'namedpipes', 'TcpIp', 'tcpip']",
      desc: 'Specifies the name of network protocol to be configured.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_hasmultiipaddresses: {
      type: 'Optional[Boolean]',
      desc: 'Returns `$true` or `$false` whether the instance has multiple IP addresses or not.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_restarttimeout: {
      type: 'Optional[Integer[0, 65535]]',
      desc: 'Timeout value for restarting the _SQL Server_ services. The default value is `120` seconds.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_pipename: {
      type: 'Optional[String]',
      desc: 'Specifies the name of the named pipe. Only used for the _Named Pipes_ protocol, ignored for all other protocols.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    ensurable: {
      type: 'Boolean[false]',
      desc: 'Default attribute added to all dsc types without an ensure property. This resource is not ensurable.',
      default: false,

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
