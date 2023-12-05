require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_computer',
  dscmeta_resource_friendly_name: 'Computer',
  dscmeta_resource_name: 'DSC_Computer',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC Computer resource type.
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
    dsc_options: {
      type: "Optional[Array[Enum['AccountCreate', 'accountcreate', 'Win9XUpgrade', 'win9xupgrade', 'UnsecuredJoin', 'unsecuredjoin', 'PasswordPass', 'passwordpass', 'JoinWithNewName', 'joinwithnewname', 'JoinReadOnly', 'joinreadonly', 'InstallInvoke', 'installinvoke']]]",
      desc: 'Specifies advanced options for the Add-Computer join operation',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'The desired computer name.',

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
    dsc_workgroupname: {
      type: 'Optional[String]',
      desc: 'The name of the workgroup.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_server: {
      type: 'Optional[String]',
      desc: 'The Active Directory Domain Controller to use to join the domain',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_unjoincredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'Credential to be used to leave a domain.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_currentou: {
      type: 'Optional[String]',
      desc: 'A read-only property that specifies the organizational unit that the computer account is currently in.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_description: {
      type: 'Optional[String]',
      desc: 'The value assigned here will be set as the local computer description.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_domainname: {
      type: 'Optional[String]',
      desc: 'The name of the domain to join.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_joinou: {
      type: 'Optional[String]',
      desc: 'The distinguished name of the organizational unit that the computer account will be created in.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_credential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'Credential to be used to join a domain.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
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
