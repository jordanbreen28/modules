require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlsecureconnection',
  dscmeta_resource_friendly_name: 'SqlSecureConnection',
  dscmeta_resource_name: 'DSC_SqlSecureConnection',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlSecureConnection resource type.
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
    dsc_thumbprint: {
      type: 'String',
      desc: "Thumbprint of the certificate being used for encryption. If parameter **Ensure** is set to `'Absent'` then the parameter **Certificate** can be set to an empty string.",


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
      desc: 'Specifies the host name that will be used when restarting the SQL Server instance. If the SQL Server belongs to a cluster or availability group specify the host name for the listener or cluster group. The specified name must match the name that is used by the certificate specified for the parameter `Thumbprint`. Default value is `localhost`.',


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
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: "If encryption should be enabled (`'Present'`) or disabled (`'Absent'`).",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_suppressrestart: {
      type: 'Optional[Boolean]',
      desc: 'If set to `$true` then the required restart will be suppressed. You will need to restart the service before changes will take effect. The default value is `$false`.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_serviceaccount: {
      type: 'String',
      desc: "Name of the account running the _SQL Server_ _Windows_ service. If this parameter is set to `'LocalSystem'` then a connection error is displayed, instead use the value `'SYSTEM'`.",


      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_forceencryption: {
      type: 'Optional[Boolean]',
      desc: 'If all connections to the _SQL Server_ instance should be encrypted. If this parameter is not assigned a value, the default value is `$true` meaning that all connections must be encrypted.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
