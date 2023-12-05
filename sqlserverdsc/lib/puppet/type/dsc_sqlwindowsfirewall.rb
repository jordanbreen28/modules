require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlwindowsfirewall',
  dscmeta_resource_friendly_name: 'SqlWindowsFirewall',
  dscmeta_resource_name: 'DSC_SqlWindowsFirewall',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlWindowsFirewall resource type.
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
    dsc_sourcepath: {
      type: 'Optional[String]',
      desc: 'UNC path to the root of the source files for installation.',


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
    dsc_browserfirewall: {
      type: 'Optional[Boolean]',
      desc: 'Returns wether the firewall rule(s) for the _SQL Server Browser_ is enabled.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: "Ensures that _SQL Server_ services firewall rules are `'Present'` or `'Absent'` on the machine.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sourcecredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'Credentials used to access the path set in the parameter **SourcePath**. This parameter is optional either if built-in parameter **PsDscRunAsCredential** is used, or if the source path can be access using the SYSTEM account.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_instancename: {
      type: 'String',
      desc: '_SQL Server_ instance to enable firewall rules for.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_integrationservicesfirewall: {
      type: 'Optional[Boolean]',
      desc: 'Returns wether the firewall rule(s) for the _SQL Server Integration Services_ is enabled.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_features: {
      type: 'String',
      desc: '_SQL Server_ features to enable firewall rules for.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_reportingservicesfirewall: {
      type: 'Optional[Boolean]',
      desc: 'Returns wether the firewall rule(s) for _SQL Server Reporting Services_ is enabled.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_databaseenginefirewall: {
      type: 'Optional[Boolean]',
      desc: 'Returns wether the firewall rule(s) for the _SQL Server Database Engine_ is enabled.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_analysisservicesfirewall: {
      type: 'Optional[Boolean]',
      desc: 'Returns wether the firewall rule(s) for _SQL Server Analysis Services_ is enabled.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
