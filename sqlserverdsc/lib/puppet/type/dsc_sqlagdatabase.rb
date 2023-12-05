require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlagdatabase',
  dscmeta_resource_friendly_name: 'SqlAGDatabase',
  dscmeta_resource_name: 'DSC_SqlAGDatabase',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlAGDatabase resource type.
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
    dsc_isactivenode: {
      type: 'Optional[Boolean]',
      desc: 'Returns if the current node is actively hosting the _SQL Server_ instance.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_availabilitygroupname: {
      type: 'String',
      desc: 'The name of the availability group in which to manage the database membership(s).',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'String',
      desc: 'Hostname of the _SQL Server_ where the primary replica of the availability group lives. If the availability group is not currently on this server, the resource will attempt to connect to the server where the primary replica lives.',
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
    dsc_statementtimeout: {
      type: 'Optional[Integer[-2147483648, 2147483647]]',
      desc: 'Set the query timeout in seconds for the backup and restore operations. The default is 600 seconds (10mins).',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'SInt32',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "Specifies the membership of the database(s) in the availability group. The option `'Present'` means that the defined database(s) are added to the availability group. All other databases that may be a member of the availability group are ignored. The option `'Absent'` means that the defined database(s) are removed from the availability group. All other databases that may be a member of the availability group are ignored. The default is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Name of the _SQL Server_ instance where the primary replica of the availability group lives. If the availability group is not currently on this instance, the resource will attempt to connect to the instance where the primary replica lives.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_databasename: {
      type: 'Array[String]',
      desc: 'The name of the database(s) to add to the availability group. This accepts wildcards.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_replaceexisting: {
      type: 'Optional[Boolean]',
      desc: 'If set to `$true`, this adds the restore option `WITH REPLACE`. If set to `$false`, existing databases and files will block the restore and throw error. The default is `$false`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_backuppath: {
      type: 'String',
      desc: 'The path used to seed the availability group replicas. This should be a path that is accessible by all of the replicas.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_matchdatabaseowner: {
      type: 'Optional[Boolean]',
      desc: 'If set to `$true`, this ensures the database owner of the database on the primary replica is the owner of the database on all secondary replicas. This requires the database owner is available as a login on all replicas and that the **PsDscRunAsCredential** has _impersonate any login_, _control server_, _impersonate login_, or _control login_ permissions. If set to `$false`, the owner of the database will be the username specified in **PsDscRunAsCredential**. The default is `$false`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_processonlyonactivenode: {
      type: 'Optional[Boolean]',
      desc: 'Specifies that the resource will only determine if a change is needed if the target node is the active host of the _SQL Server_ instance.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_force: {
      type: 'Optional[Boolean]',
      desc: "When parameter **Ensure** is set to `'Present'` it ensures the specified database(s) are the only databases that are a member of the specified Availability Group. This parameter is ignored when parameter **Ensure** is set to `'Absent'`.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
