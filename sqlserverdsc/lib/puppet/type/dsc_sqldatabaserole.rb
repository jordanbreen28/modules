require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqldatabaserole',
  dscmeta_resource_friendly_name: 'SqlDatabaseRole',
  dscmeta_resource_name: 'DSC_SqlDatabaseRole',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlDatabaseRole resource type.
         Automatically generated from version 16.5.0',
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
    dsc_name: {
      type: 'String',
      desc: 'The name of the database role to be added or removed.',

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
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'The host name of the _SQL Server_ to be configured. Default value is the current computer name.',


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
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: "If `'Present'` then the role will be added to the database and the role membership will be set. If `'Absent'` then the role will be removed from the database. Default value is `'Present'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_memberstoinclude: {
      type: 'Optional[Array[String]]',
      desc: "The members the database role should include. This parameter will only add members to a database role. Will only be used when parameter **Ensure** is set to `'Present'`. Can not be used at the same time as parameter **Members**.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_databasename: {
      type: 'String',
      desc: 'The name of the database in which the role should be configured.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_membersindesiredstate: {
      type: 'Optional[Boolean]',
      desc: 'Returns whether the database role members are in the desired state.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_members: {
      type: 'Optional[Array[String]]',
      desc: "The members the database role should have. This parameter will replace all the current database role members with the specified members. Will only be used when parameter **Ensure** is set to `'Present'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_databaseisupdateable: {
      type: 'Optional[Boolean]',
      desc: 'Returns if the database is updatable. If the database is updatable, this will return `$true`. Otherwise it will return `$false`.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_memberstoexclude: {
      type: 'Optional[Array[String]]',
      desc: "The members the database role should exclude. This parameter will only remove members from a database role. Will only be used when parameter **Ensure** is set to `'Present'`. Can not be used at the same time as parameter **Members**.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
  },
)
