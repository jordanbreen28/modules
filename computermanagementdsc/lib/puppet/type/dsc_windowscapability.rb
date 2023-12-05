require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_windowscapability',
  dscmeta_resource_friendly_name: 'WindowsCapability',
  dscmeta_resource_name: 'DSC_WindowsCapability',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC WindowsCapability resource type.
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
    dsc_source: {
      type: 'Optional[String]',
      desc: 'Specifies the location of the files that are required to add a Windows capability package to an image. You can specify the Windows directory of a mounted image or a running Windows installation that is shared on the network.',


      mandatory_for_get: false,
      mandatory_for_set: false,
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
      desc: 'Specifies whether the Windows Capability should be installed or uninstalled. To install the Windows Capability, set this property to Present. To uninstall the Windows Capability, set the property to Absent.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_logpath: {
      type: 'Optional[String]',
      desc: "Specifies the full path and file name to log to. This is a write only parameter that is used when updating the status of a Windows Capability. If not specified, the default is '%WINDIR%\Logs\Dism\dism.log'.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'Specifies the name of the Windows Capability.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_loglevel: {
      type: "Optional[Enum['Errors', 'errors', 'Warnings', 'warnings', 'WarningsInfo', 'warningsinfo']]",
      desc: "Specifies the given Log Level of a Windows Capability. This is a write only parameter that is used when updating the status of a Windows Capability. If not specified, the default is 'WarningsInfo'.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
