require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlrssetup',
  dscmeta_resource_friendly_name: 'SqlRSSetup',
  dscmeta_resource_name: 'DSC_SqlRSSetup',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlRSSetup resource type.
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
    dsc_action: {
      type: "Optional[Enum['Install', 'install', 'Uninstall', 'uninstall']]",
      desc: "The action to be performed. Default value is `'Install'` which performs either install or upgrade.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_versionupgrade: {
      type: 'Optional[Boolean]',
      desc: 'Upgrades installed product version if the major product version of the source executable is higher than the currently installed major version. Requires that either the **ProductKey** or the **Edition** parameter is also assigned. Default is `$false`.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_editionupgrade: {
      type: 'Optional[Boolean]',
      desc: 'Upgrades the edition of the installed product. Requires that either the **ProductKey** or the **Edition** parameter is also assigned. By default no edition upgrade is performed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_setupprocesstimeout: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'The timeout, in seconds, to wait for the setup process to finish. Default value is `7200` seconds (2 hours). If the setup process does not finish before this time an error will be thrown.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_iacceptlicenseterms: {
      type: "Enum['Yes', 'yes']",
      desc: "Accept licens terms. This must be set to `'Yes'`.",


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
    dsc_sourcepath: {
      type: 'String',
      desc: 'The path to the installation media file to be used for installation, e.g an UNC path to a shared resource. Environment variables can be used in the path.',


      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_currentversion: {
      type: 'Optional[String]',
      desc: 'Returns the current version of the installed _Microsoft SQL Server Reporting Service_ instance.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_productkey: {
      type: 'Optional[String]',
      desc: "Sets the custom license key, e.g. `'12345-12345-12345-12345-12345'`. This parameter is mutually exclusive with the parameter **Edition**.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: "Enum['SSRS', 'ssrs']",
      desc: "Name of the _Microsoft SQL Server Reporting Service_ instance to installed. This can only be set to `'SSRS'`.",

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_edition: {
      type: "Optional[Enum['Development', 'development', 'Evaluation', 'evaluation', 'ExpressAdvanced', 'expressadvanced']]",
      desc: 'Sets the custom free edition. This parameter is mutually exclusive with the parameter **ProductKey**.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_forcerestart: {
      type: 'Optional[Boolean]',
      desc: 'Forces a restart after installation is finished. If set to `$true` then it will override the parameter **SuppressRestart**.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_servicename: {
      type: 'Optional[String]',
      desc: 'Returns the current name of the _Microsoft SQL Server Reporting Service_ instance _Windows_ service.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_installfolder: {
      type: 'Optional[String]',
      desc: 'Sets the install folder, e.g. `C:\Program Files\SSRS`. Default value is `C:\Program Files\Microsoft SQL Server Reporting Services`.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sourcecredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'Credentials used to access the path set in the parameter **SourcePath**.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_errordumpdirectory: {
      type: 'Optional[String]',
      desc: 'Returns the path to error dump log files.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_suppressrestart: {
      type: 'Optional[Boolean]',
      desc: 'Suppresses any attempts to restart.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_logpath: {
      type: 'Optional[String]',
      desc: 'Specifies the setup log file location, e.g. `log.txt`. By default log files are created under `%TEMP%`.',


      mandatory_for_get: false,
      mandatory_for_set: false,
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
