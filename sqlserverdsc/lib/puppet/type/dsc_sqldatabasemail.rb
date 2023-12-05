require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqldatabasemail',
  dscmeta_resource_friendly_name: 'SqlDatabaseMail',
  dscmeta_resource_name: 'DSC_SqlDatabaseMail',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlDatabaseMail resource type.
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
    dsc_profilename: {
      type: 'String',
      desc: 'The name of the _Database Mail_ profile.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_description: {
      type: 'Optional[String]',
      desc: 'The description for the _Database Mail_ profile and account.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'The hostname of the _SQL Server_ to be configured. Default value is the current computer name.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_displayname: {
      type: 'Optional[String]',
      desc: 'The display name of the originating email address. Default value is the same value assigned to the parameter **EmailAddress**.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_emailaddress: {
      type: 'String',
      desc: 'The e-mail address from which mail will originate.',

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
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "Specifies the desired state of the _Database Mail_ account. When set to `'Present'` the _Database Mail_ account will be created. When set to `'Absent'` the _Database Mail_ account will be removed. Default value is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_logginglevel: {
      type: "Optional[Enum['Normal', 'Extended', 'Verbose', 'normal', 'extended', 'verbose']]",
      desc: "The logging level that the _Database Mail_ will use. If not specified the default logging level is `'Extended'`.",

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
    dsc_replytoaddress: {
      type: 'Optional[String]',
      desc: 'The e-mail address to which the receiver of e-mails will reply to. Default value is the same e-mail address assigned to parameter **EmailAddress**.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_mailservername: {
      type: 'String',
      desc: 'The fully qualified domain name (FQDN) of the mail server name to which e-mail are sent.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_tcpport: {
      type: 'Optional[Integer[0, 65535]]',
      desc: 'The TCP port used for communication. Default value is port `25`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_accountname: {
      type: 'String',
      desc: 'The name of the _Database Mail_ account.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
