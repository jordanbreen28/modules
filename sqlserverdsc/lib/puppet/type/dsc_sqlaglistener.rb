require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlaglistener',
  dscmeta_resource_friendly_name: 'SqlAGListener',
  dscmeta_resource_name: 'DSC_SqlAGListener',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlAGListener resource type.
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
    dsc_name: {
      type: 'String',
      desc: 'The name of the availability group listener, max 15 characters. This name will be used as the _Virtual Computer Object_ (VCO).',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
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
      type: 'String',
      desc: 'The host name or fully qualified domain name (FQDN) of the primary replica.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'The _SQL Server_ instance name of the primary replica.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "If the availability group listener should be present or absent. Default value is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_dhcp: {
      type: 'Optional[Boolean]',
      desc: 'If DHCP should be used for the availability group listener instead of static IP address.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_port: {
      type: 'Optional[Integer[0, 65535]]',
      desc: 'The port used for the availability group listener.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_ipaddress: {
      type: 'Optional[Array[String]]',
      desc: "The IP address used for the availability group listener, in the format `'192.168.10.45/255.255.252.0'`. If using DHCP, set to the first IP-address of the DHCP subnet, in the format `'192.168.8.1/255.255.252.0'`. Must be valid in the cluster-allowed IP range.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_availabilitygroup: {
      type: 'String',
      desc: 'The name of the availability group to which the availability group listener is or will be connected.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
