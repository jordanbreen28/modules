require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqldatabaseuser',
  dscmeta_resource_friendly_name: 'SqlDatabaseUser',
  dscmeta_resource_name: 'DSC_SqlDatabaseUser',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlDatabaseUser resource type.
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
    dsc_loginname: {
      type: 'Optional[String]',
      desc: "Specifies the name of the login to associate with the database user. This must be specified if parameter **UserType** is set to `'Login'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'Specifies the name of the database user to be added or removed.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
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
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'Specifies the host name of the _SQL Server_ on which the instance exist. Default value is the current computer name.',


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
    dsc_certificatename: {
      type: 'Optional[String]',
      desc: "Specifies the name of the certificate to associate with the database user. This must be specified if parameter **UserType** is set to `'Certificate'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: "Specifies if the database user should be present or absent. If `'Present'` then the database user will be added to the database and, if needed, the login mapping will be updated. If `'Absent'` then the database user will be removed from the database. Default value is `'Present'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_authenticationtype: {
      type: 'Optional[String]',
      desc: "Returns the authentication type of the login connected to the database user. This will return either `'Windows'`, `'Instance'`, or `'None'`. The value `'Windows'` means the login is using _Windows Authentication_, `'Instance'` means that the login is using _SQL Authentication_, and `'None'` means that the database user have no login connected to it.",

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Specifies the _SQL Server_ instance in which the database exist.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_databasename: {
      type: 'String',
      desc: 'Specifies the name of the database in which to configure the database user.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_usertype: {
      type: "Optional[Enum['Login', 'login', 'NoLogin', 'nologin', 'Certificate', 'certificate', 'AsymmetricKey', 'asymmetrickey']]",
      desc: "Specifies the type of the database user. Default value is `'NoLogin'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_asymmetrickeyname: {
      type: 'Optional[String]',
      desc: "Specifies the name of the asymmetric key to associate with the database user. This must be specified if parameter **UserType** is set to `'AsymmetricKey'`.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_logintype: {
      type: 'Optional[String]',
      desc: 'Returns the login type of the login connected to the database user. If no login is connected to the database user this returns `$null`.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_force: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if it is allowed to re-create the database user if either the user type, the asymmetric key, or the certificate changes. Default value is `$false` not allowing database users to be re-created.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
