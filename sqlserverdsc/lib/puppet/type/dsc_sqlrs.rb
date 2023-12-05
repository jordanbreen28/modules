require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlrs',
  dscmeta_resource_friendly_name: 'SqlRS',
  dscmeta_resource_name: 'DSC_SqlRS',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlRS resource type.
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
    dsc_suppressrestart: {
      type: 'Optional[Boolean]',
      desc: '_Reporting Services_ need to be restarted after initialization or settings change. If this parameter is set to `$true`, _Reporting Services_ will not be restarted, even after initialization.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_encrypt: {
      type: "Optional[Enum['Mandatory', 'mandatory', 'Optional', 'optional', 'Strict', 'strict']]",
      desc: 'Specifies how encryption should be enforced when using command `Invoke-SqlCmd`. When not specified, the default value is `Mandatory`.',


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
    dsc_databaseservername: {
      type: 'String',
      desc: 'Name of the _SQL Server_ to host the _Reporting Services_ database.',


      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_databaseinstancename: {
      type: 'String',
      desc: 'Name of the _SQL Server_ instance to host the _Reporting Services_ database.',


      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_reportserverreservedurl: {
      type: 'Optional[Array[String]]',
      desc: "_Report Server_ URL reservations. Optional. If not specified, `'http://+:80'` URL reservation will be used.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Name of the _SQL Server Reporting Services_ instance to be configured.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_reportsreservedurl: {
      type: 'Optional[Array[String]]',
      desc: "_Report Manager_ or _Report Web App_ URL reservations. Optional. If not specified, `'http://+:80'` URL reservation will be used.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_reportsvirtualdirectory: {
      type: 'Optional[String]',
      desc: '_Report Manager_ or _Report Web App_ virtual directory name. Optional.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_reportservervirtualdirectory: {
      type: 'Optional[String]',
      desc: '_Report Server Web Service_ virtual directory. Optional.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_usessl: {
      type: 'Optional[Boolean]',
      desc: 'If connections to the _Reporting Services_ must use SSL. If this parameter is not assigned a value, the default is that _Reporting Services_ does not use SSL.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_isinitialized: {
      type: 'Optional[Boolean]',
      desc: 'Returns if the _Reporting Services_ instance initialized or not.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
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
