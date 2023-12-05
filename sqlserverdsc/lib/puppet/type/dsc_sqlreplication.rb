require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlreplication',
  dscmeta_resource_friendly_name: 'SqlReplication',
  dscmeta_resource_name: 'DSC_SqlReplication',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlReplication resource type.
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
    dsc_workingdirectory: {
      type: 'String',
      desc: 'Publisher working directory.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_distributiondbname: {
      type: 'Optional[String]',
      desc: "Distribution database name. If the parameter **DistributionMode**  is set to `'Local'` this will be created, if `'Remote'` needs to match distribution database on remote distributor. Default value is `'distributor'`.",

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
    dsc_uninstallwithforce: {
      type: 'Optional[Boolean]',
      desc: 'Force flag for uninstall procedure. Default values is `$trueÂ´.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Specifies the _SQL Server_ instance name where replication distribution will be configured.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "`'Present'` will configure replication, `'Absent'` will disable (remove) replication. Default value is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_adminlinkcredentials: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'AdminLink password to be used when setting up publisher distributor relationship.',
      behaviour: :parameter,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_remotedistributor: {
      type: 'Optional[String]',
      desc: "Specifies the _SQL Server_ network name that will be used as distributor for local instance. Required if parameter **DistributionMode**  is set to `'Remote'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_distributormode: {
      type: "Enum['Local', 'Remote', 'local', 'remote']",
      desc: "`'Local'` - Instance will be configured as it's own distributor. `'Remote'` - Instance will be configure with remote distributor (remote distributor needs to be already configured for distribution).",

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_usetrustedconnection: {
      type: 'Optional[Boolean]',
      desc: 'Publisher security mode. Default value is `$true`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
