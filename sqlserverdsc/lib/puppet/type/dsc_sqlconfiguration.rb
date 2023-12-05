require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlconfiguration',
  dscmeta_resource_friendly_name: 'SqlConfiguration',
  dscmeta_resource_name: 'DSC_SqlConfiguration',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlConfiguration resource type.
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
    dsc_restartservice: {
      type: 'Optional[Boolean]',
      desc: 'Determines whether the instance should be restarted after updating the configuration option.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
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
    dsc_optionname: {
      type: 'String',
      desc: 'The name of the _SQL Server Database Engine_ instance configuration option. For all possible values reference the article [Server Configuration Options (SQL Server)](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/server-configuration-options-sql-server) or run `sp_configure`.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_optionvalue: {
      type: 'Integer[-2147483648, 2147483647]',
      desc: 'The desired value of the configuration option.',


      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
    dsc_restarttimeout: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'The length of time, in seconds, to wait for the service to restart. Default is `120` seconds.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
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
