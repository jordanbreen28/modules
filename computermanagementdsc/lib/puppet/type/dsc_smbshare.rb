require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_smbshare',
  dscmeta_resource_friendly_name: 'SmbShare',
  dscmeta_resource_name: 'DSC_SmbShare',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC SmbShare resource type.
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
    dsc_description: {
      type: 'Optional[String]',
      desc: 'Specifies the description of the SMB share.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_folderenumerationmode: {
      type: "Optional[Enum['AccessBased', 'accessbased', 'Unrestricted', 'unrestricted']]",
      desc: 'Specifies which files and folders in the new SMB share are visible to users.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'Specifies the name of the SMB share.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sharestate: {
      type: 'Optional[String]',
      desc: 'Specifies the state of the SMB share.',

      behaviour: :read_only,
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
    dsc_readaccess: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies which accounts is granted read permission to access the SMB share.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_special: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if this SMB share is a special share. E.g. an admin share, default shares, or IPC$ share.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: 'Specifies if the SMB share should be added or removed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_continuouslyavailable: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the SMB share should be continuously available.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_fullaccess: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies which accounts are granted full permission to access the SMB share.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_sharetype: {
      type: 'Optional[String]',
      desc: 'Specifies the type of the SMB share.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_shadowcopy: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if this SMB share is a ShadowCopy.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_encryptdata: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that the SMB share is encrypted.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_changeaccess: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies which accounts will be granted modify permission to access the SMB share.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_scopename: {
      type: 'Optional[String]',
      desc: 'Specifies the scope in which the share should be created.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_path: {
      type: 'String',
      desc: 'Specifies the path of the SMB share.',


      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_concurrentuserlimit: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum number of concurrently connected users that the new SMB share may accommodate. If this parameter is set to zero (0), then the number of users is unlimited. The default value is zero (0).',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_noaccess: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies which accounts are denied access to the SMB share.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_force: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the SMB share is allowed to be dropped and recreated (required when the path changes).',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_cachingmode: {
      type: "Optional[Enum['None', 'none', 'Manual', 'manual', 'Programs', 'programs', 'Documents', 'documents', 'BranchCache', 'branchcache']]",
      desc: 'Specifies the caching mode of the offline files for the SMB share.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
