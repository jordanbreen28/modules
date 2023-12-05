require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_virtualmemory',
  dscmeta_resource_friendly_name: 'VirtualMemory',
  dscmeta_resource_name: 'DSC_VirtualMemory',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC VirtualMemory resource type.
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
    dsc_initialsize: {
      type: 'Optional[Integer[-9223372036854775808, 9223372036854775807]]',
      desc: 'The initial size of the page file in Megabyte',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt64',
      mof_is_embedded: false,
    },
    dsc_drive: {
      type: 'String',
      desc: 'The drive letter for which paging settings should be set. Can be letter only, letter and colon or letter with colon and trailing slash.',

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
    dsc_type: {
      type: "Enum['AutoManagePagingFile', 'automanagepagingfile', 'CustomSize', 'customsize', 'SystemManagedSize', 'systemmanagedsize', 'NoPagingFile', 'nopagingfile']",
      desc: 'The type of the paging setting to use. If set to AutoManagePagingFile, the drive letter will be ignored. If set to SystemManagedSize, the values for InitialSize and MaximumSize will be ignored',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_maximumsize: {
      type: 'Optional[Integer[-9223372036854775808, 9223372036854775807]]',
      desc: 'The maximum size of the page file in Megabyte',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt64',
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
