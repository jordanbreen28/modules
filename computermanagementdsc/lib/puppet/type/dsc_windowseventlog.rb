require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_windowseventlog',
  dscmeta_resource_friendly_name: 'WindowsEventLog',
  dscmeta_resource_name: 'DSC_WindowsEventLog',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC WindowsEventLog resource type.
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
    dsc_messageresourcefile: {
      type: 'Optional[String]',
      desc: 'Specifies the message resource file for the event source',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_parameterresourcefile: {
      type: 'Optional[String]',
      desc: 'Specifies the parameter resource file for the event source',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_categoryresourcefile: {
      type: 'Optional[String]',
      desc: 'Specifies the category resource file for the event source',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_logmode: {
      type: "Optional[Enum['AutoBackup', 'autobackup', 'Circular', 'circular', 'Retain', 'retain']]",
      desc: 'Specifies the log mode for the specified event log',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_securitydescriptor: {
      type: 'Optional[String]',
      desc: 'Specifies the SDDL for the specified event log',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_isenabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the specified event log should be enabled or disabled',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_logname: {
      type: 'String',
      desc: 'Specifies the name of a valid event log',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_registeredsource: {
      type: 'Optional[String]',
      desc: 'Specifies the name of an event source to register for the specified event log',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_logretentiondays: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'Specifies the number of days to retain events when the log mode is AutoBackup',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
    dsc_maximumsizeinbytes: {
      type: 'Optional[Integer[-9223372036854775808, 9223372036854775807]]',
      desc: 'Specifies the maximum size in bytes for the specified event log',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt64',
      mof_is_embedded: false,
    },
    dsc_restrictguestaccess: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether to allow guests to have access to the specified event log',


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
    dsc_logfilepath: {
      type: 'Optional[String]',
      desc: 'Specifies the file name and path for the specified event log',


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
