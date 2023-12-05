require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_powershellexecutionpolicy',
  dscmeta_resource_friendly_name: 'PowerShellExecutionPolicy',
  dscmeta_resource_name: 'DSC_PowerShellExecutionPolicy',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC PowerShellExecutionPolicy resource type.
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
    dsc_executionpolicyscope: {
      type: "Enum['CurrentUser', 'currentuser', 'LocalMachine', 'localmachine', 'MachinePolicy', 'machinepolicy', 'Process', 'process', 'UserPolicy', 'userpolicy']",
      desc: 'Defines the scope for the preference of the Windows PowerShell execution policy.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_executionpolicy: {
      type: "Enum['Bypass', 'bypass', 'Restricted', 'restricted', 'AllSigned', 'allsigned', 'RemoteSigned', 'remotesigned', 'Unrestricted', 'unrestricted']",
      desc: 'Changes the preference for the Windows PowerShell execution policy.',


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
