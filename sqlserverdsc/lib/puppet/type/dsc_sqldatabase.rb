require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqldatabase',
  dscmeta_resource_friendly_name: 'SqlDatabase',
  dscmeta_resource_name: 'DSC_SqlDatabase',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlDatabase resource type.
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
    dsc_psdscrunascredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: ' ',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_ownername: {
      type: 'Optional[String]',
      desc: 'Specifies the name of the login that should be the owner of the database.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'The name of the _SQL Server_ instance to be configured.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "When set to `'Present'`, the database will be created. When set to `'Absent'`, the database will be dropped. Default value is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'The host name of the _SQL Server_ to be configured. Default value is the current computer name.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'The name of the _SQL Server_ database.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_compatibilitylevel: {
      type: "Optional[Enum['Version80', 'Version90', 'Version100', 'Version110', 'Version120', 'Version130', 'Version140', 'Version150', 'version80', 'version90', 'version100', 'version110', 'version120', 'version130', 'version140', 'version150']]",
      desc: 'Specifies the version of the _SQL Database Compatibility Level_ to use for the specified database.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_collation: {
      type: 'Optional[String]',
      desc: 'The name of the collation to use for the new database. Default value is the collation used by the server.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_recoverymodel: {
      type: "Optional[Enum['Simple', 'Full', 'BulkLogged', 'simple', 'full', 'bulklogged']]",
      desc: 'The recovery model for the specified database.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
