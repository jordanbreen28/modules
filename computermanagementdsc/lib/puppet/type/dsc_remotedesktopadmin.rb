require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_remotedesktopadmin',
  dscmeta_resource_friendly_name: 'RemoteDesktopAdmin',
  dscmeta_resource_name: 'DSC_RemoteDesktopAdmin',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC RemoteDesktopAdmin resource type.
         Automatically generated from version 9.0.0',
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
    dsc_userauthentication: {
      type: "Optional[Enum['Secure', 'secure', 'NonSecure', 'nonsecure']]",
      desc: 'Setting this value to Secure configures the machine to require Network Level Authentication (NLA) for remote desktop connections.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_issingleinstance: {
      type: "Enum['Yes', 'yes']",
      desc: "Specifies the resource is a single instance, the value must be 'Yes'",

      behaviour: :namevar,
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
    dsc_ensure: {
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: 'Determines whether or not the computer should accept remote desktop connections.  Present sets the value to Enabled and Absent sets the value to Disabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
