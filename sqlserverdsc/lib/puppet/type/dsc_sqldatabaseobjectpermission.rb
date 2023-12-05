require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqldatabaseobjectpermission',
  dscmeta_resource_friendly_name: 'SqlDatabaseObjectPermission',
  dscmeta_resource_name: 'DSC_SqlDatabaseObjectPermission',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlDatabaseObjectPermission resource type.
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
    dsc_permission: {
      type: "Array[Struct[{
              permission => Optional[String],
              ensure => Optional[Enum['Present', 'present', 'Absent', 'absent']],
              state => Optional[Enum['Grant', 'grant', 'Deny', 'deny', 'GrantWithGrant', 'grantwithgrant']]
            }]]",
      desc: 'Specifies the permissions for the database object and the principal. The permissions is an array of embedded instances of the `DSC_DatabaseObjectPermission` CIM class.',


      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'DSC_DatabaseObjectPermission[]',
      mof_is_embedded: true,
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
      desc: 'Specifies the host name of the _SQL Server_ to be configured. Default value is the current computer name.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Specifies the name of the _SQL Server_ instance to be configured.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_objecttype: {
      type: "Enum['Schema', 'schema', 'Table', 'table', 'View', 'view', 'StoredProcedure', 'storedprocedure']",
      desc: 'Specifies the type of the database object specified in parameter **ObjectName**.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_databasename: {
      type: 'String',
      desc: 'Specifies the name of the database where the object resides.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'Specifies the name of the database user, user-defined database role, or database application role that will have the permission.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_force: {
      type: 'Optional[Boolean]',
      desc: "Specifies that permissions that has parameter **Ensure** set to `'Present'` (the default value for permissions) should always be enforced even if that encompasses cascading revocations. An example if the desired state is `'Grant'` but the current state is `'GrantWithGrant'`. If parameter **Force** is set to `$true` the _With Grant_ permission is revoked, if set to `$false` an exception is thrown since the desired state could not be set. Default is to throw an exception.",

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_objectname: {
      type: 'String',
      desc: 'Specifies the name of the database object to set permission for. Can be an empty value when setting permission for a schema.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_schemaname: {
      type: 'String',
      desc: 'Specifies the name of the schema for the database object.',

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
