require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_useraccountcontrol',
  dscmeta_resource_friendly_name: 'UserAccountControl',
  dscmeta_resource_name: 'DSC_UserAccountControl',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC UserAccountControl resource type.
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
    dsc_suppressrestart: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if a restart of the node should be suppressed. By default the node will be restarted if the value is changed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_consentpromptbehavioradmin: {
      type: "Optional[Enum['0', '1', '2', '3', '4', '5']]",
      desc: 'Specifies the prompt behavior for the Consent Administrator.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
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
    dsc_enableinstallerdetection: {
      type: "Optional[Enum['0', '1']]",
      desc: 'Specifies how package installations are handled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_consentpromptbehavioruser: {
      type: "Optional[Enum['0', '1', '3']]",
      desc: 'Specifies how the operations that requires elevation is handled for users.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_notificationlevel: {
      type: "Optional[Enum['AlwaysNotify', 'alwaysnotify', 'AlwaysNotifyAndAskForCredentials', 'alwaysnotifyandaskforcredentials', 'NotifyChanges', 'notifychanges', 'NotifyChangesWithoutDimming', 'notifychangeswithoutdimming', 'NeverNotify', 'nevernotify', 'NeverNotifyAndDisableAll', 'nevernotifyanddisableall']]",
      desc: 'Specifies the desired notification level for the User Account Control setting. This parameter can not be used at the same time as any of the granular parameters.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_validateadmincodesignatures: {
      type: "Optional[Enum['0', '1']]",
      desc: 'Specifies how cryptographic signatures on interactive applications are handled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_filteradministratortoken: {
      type: "Optional[Enum['0', '1']]",
      desc: 'Specifies the mode for the built-in administrator account (RID 500).',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_enablelua: {
      type: "Optional[Enum['0', '1']]",
      desc: "Specifies how the 'administrator in Admin Approval Mode' user type are handled.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_enablevirtualization: {
      type: "Optional[Enum['0', '1']]",
      desc: 'Specifies how redirection of legacy application File and Registry writes are handled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_promptonsecuredesktop: {
      type: "Optional[Enum['0', '1']]",
      desc: 'Specifies if secure desktop prompting are used.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_issingleinstance: {
      type: "Enum['Yes', 'yes']",
      desc: "Specifies the resource is a single instance, the value must be 'Yes'.",

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
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
