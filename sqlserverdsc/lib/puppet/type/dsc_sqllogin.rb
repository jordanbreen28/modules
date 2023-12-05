require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqllogin',
  dscmeta_resource_friendly_name: 'SqlLogin',
  dscmeta_resource_name: 'DSC_SqlLogin',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlLogin resource type.
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
    dsc_name: {
      type: 'String',
      desc: 'The name of the login.',
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
      desc: 'The hostname of the _SQL Server_ to be configured. Default value is the current computer name.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Name of the _SQL Server_ instance to be configured.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "The specified login should be `'Present'` or `'Absent'`. Default is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_disabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the login is disabled. Default value is `$false`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_logincredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'Specifies the password as a `[PSCredential]` object. Only applies to _SQL Logins_.',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_defaultdatabase: {
      type: 'Optional[String]',
      desc: 'Specifies the default database name.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_loginmustchangepassword: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the login is required to have its password change on the next login. Only applies to _SQL Logins_. This cannot be updated on a pre-existing _SQL Login_ and any attempt to do this will throw an exception.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_logintype: {
      type: "Optional[Enum['WindowsUser', 'WindowsGroup', 'SqlLogin', 'Certificate', 'AsymmetricKey', 'ExternalUser', 'ExternalGroup', 'windowsuser', 'windowsgroup', 'sqllogin', 'certificate', 'asymmetrickey', 'externaluser', 'externalgroup']]",
      desc: "The type of login to be created. If LoginType is `'WindowsUser'` or `'WindowsGroup'` then provide the name in the format `DOMAIN\name`. Default is `'WindowsUser'`. The login types `'Certificate'`, `'AsymmetricKey'`, `'ExternalUser'`, and `'ExternalGroup'` are not yet implemented and will currently throw an exception if used.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_loginpasswordexpirationenabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the login password is required to expire in accordance to the operating system security policy. Only applies to _SQL Logins_.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_loginpasswordpolicyenforced: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the login password is required to conform to the password policy specified in the system security policy. Only applies to _SQL Logins_.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
