require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_pendingreboot',
  dscmeta_resource_friendly_name: 'PendingReboot',
  dscmeta_resource_name: 'DSC_PendingReboot',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC PendingReboot resource type.
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
    dsc_windowsupdate: {
      type: 'Optional[Boolean]',
      desc: 'A value indicating whether Windows Update requested a reboot.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'Specifies the name of this pending reboot check.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_skippendingcomputerrename: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether to skip reboots triggered by a pending computer rename.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_componentbasedservicing: {
      type: 'Optional[Boolean]',
      desc: 'A value indicating whether the Component-Based Servicing component requested a reboot.',

      behaviour: :read_only,
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
    dsc_skipcomponentbasedservicing: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether to skip reboots triggered by the Component-Based Servicing component.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_rebootrequired: {
      type: 'Optional[Boolean]',
      desc: 'A value indicating whether the node requires a reboot.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_skipccmclientsdk: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether to skip reboots triggered by the ConfigMgr client. Defaults to True.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_skipwindowsupdate: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether to skip reboots triggered by Windows Update.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_ccmclientsdk: {
      type: 'Optional[Boolean]',
      desc: 'A value indicating whether the ConfigMgr client triggered a reboot.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_pendingcomputerrename: {
      type: 'Optional[Boolean]',
      desc: 'A value indicating whether a pending computer rename triggered a reboot.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_skippendingfilerename: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether to skip pending file rename reboots.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_pendingfilerename: {
      type: 'Optional[Boolean]',
      desc: 'A value indicating whether a pending file rename triggered a reboot.',

      behaviour: :read_only,
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
