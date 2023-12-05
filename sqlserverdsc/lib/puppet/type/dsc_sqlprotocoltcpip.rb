require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlprotocoltcpip',
  dscmeta_resource_friendly_name: 'SqlProtocolTcpIp',
  dscmeta_resource_name: 'DSC_SqlProtocolTcpIp',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlProtocolTcpIp resource type.
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
    dsc_restarttimeout: {
      type: 'Optional[Integer[0, 65535]]',
      desc: 'Timeout value for restarting the _SQL Server_ services. The default value is `120` seconds.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'Specifies the host name of the _SQL Server_ to be configured. If the _SQL Server_ belongs to a cluster or availability group specify the host name for the listener or cluster group. Default value is the current computer name.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ipaddress: {
      type: 'Optional[String]',
      desc: "Specifies the IP address for the IP address group. Only used if the parameter **IpAddressGroup** is _not_ set to `'IPAll'`. If not specified, the existing value will not be changed.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_isactive: {
      type: 'Optional[Boolean]',
      desc: "Returns `$true` or `$false` whether the IP address group is active. Not applicable for IP address group `'IPAll'`.",

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_ipaddressgroup: {
      type: 'String',
      desc: "Specifies the name of the IP address group in the TCP/IP protocol, e.g. `'IP1'`, `'IP2'` etc., or `'IPAll'`.",

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_addressfamily: {
      type: 'Optional[String]',
      desc: "Returns the IP address's adress family. Not applicable for IP address group `'IPAll'`.",

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_usetcpdynamicport: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the _SQL Server_ instance should use a dynamic port. If not specified, the existing value will not be changed. This parameter is not allowed to be used at the same time as the parameter **TcpPort**.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Specifies the name of the _SQL Server_ instance to manage the IP address group for.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_tcpdynamicport: {
      type: 'Optional[String]',
      desc: "Returns the TCP/IP dynamic port. Only applicable for the IP address group `'IPAll'`.",

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_enabled: {
      type: 'Optional[Boolean]',
      desc: "Specified if the IP address group should be enabled or disabled. Only used if the parameter **IpAddressGroup** is _not_ set to `'IPAll'`. If not specified, the existing value will not be changed.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
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
    dsc_tcpport: {
      type: 'Optional[String]',
      desc: "Specifies the TCP port(s) that _SQL Server_ instance should be listening on. If the IP address should listen on more than one port, list all ports as a string value with the port numbers separated with a comma, e.g. `'1433,1500,1501'`. This parameter is limited to 2047 characters. If not specified, the existing value will not be changed. This parameter is not allowed to be used at the same time as the parameter **UseTcpDynamicPort**.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
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
