require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlag',
  dscmeta_resource_friendly_name: 'SqlAG',
  dscmeta_resource_name: 'DSC_SqlAG',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlAG resource type.
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
    dsc_databasehealthtrigger: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the option _Database Level Health Detection_ is enabled. This is only available is _SQL Server 2016_ and later and is ignored when applied to previous versions.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'String',
      desc: 'Hostname of the SQL Server to be configured.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_endpointport: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Returns the port the database mirroring endpoint is listening on.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_backuppriority: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the desired priority of the replicas in performing backups. The acceptable values for this parameter are: integers from `0` through `100`. Of the set of replicas which are online and available, the replica that has the highest priority performs the backup. When creating a group the default is `50`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_connectionmodeinsecondaryrole: {
      type: "Optional[Enum['AllowNoConnections', 'AllowReadIntentConnectionsOnly', 'AllowAllConnections', 'allownoconnections', 'allowreadintentconnectionsonly', 'allowallconnections']]",
      desc: 'Specifies how the availability replica handles connections when in the secondary role.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_healthchecktimeout: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the length of time, in milliseconds, after which _AlwaysOn Availability Groups_ declare an unresponsive server to be unhealthy. When creating a group the default is `30000`.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_automatedbackuppreference: {
      type: "Optional[Enum['Primary', 'SecondaryOnly', 'Secondary', 'None', 'primary', 'secondaryonly', 'secondary', 'none']]",
      desc: "Specifies the automated backup preference for the availability group. When creating a group the default is `'None'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_failureconditionlevel: {
      type: "Optional[Enum['OnServerDown', 'OnServerUnresponsive', 'OnCriticalServerErrors', 'OnModerateServerErrors', 'OnAnyQualifiedFailureCondition', 'onserverdown', 'onserverunresponsive', 'oncriticalservererrors', 'onmoderateservererrors', 'onanyqualifiedfailurecondition']]",
      desc: 'Specifies the automatic failover behavior of the availability group.',

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
    dsc_endpointurl: {
      type: 'Optional[String]',
      desc: 'Returns the URL of the availability group replica endpoint.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "Specifies if the availability group should be present or absent. Default value is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_connectionmodeinprimaryrole: {
      type: "Optional[Enum['AllowAllConnections', 'AllowReadWriteConnections', 'allowallconnections', 'allowreadwriteconnections']]",
      desc: 'Specifies how the availability replica handles connections when in the primary role.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Name of the SQL instance to be configured.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: 'Specifies the name of the availability group.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_version: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Returns the major version of the _SQL Server_ instance.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_availabilitymode: {
      type: "Optional[Enum['AsynchronousCommit', 'SynchronousCommit', 'asynchronouscommit', 'synchronouscommit']]",
      desc: "Specifies the replica availability mode. When creating a group the default is `'AsynchronousCommit'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
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
    dsc_failovermode: {
      type: "Optional[Enum['Automatic', 'Manual', 'automatic', 'manual']]",
      desc: "Specifies the failover mode. When creating a group the default is `'Manual'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_basicavailabilitygroup: {
      type: 'Optional[Boolean]',
      desc: 'Specifies the type of availability group is Basic. This is only available is _SQL Server 2016_ and later and is ignored when applied to previous versions.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_dtcsupportenabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the option _Database DTC Support_ is enabled. This is only available is _SQL Server 2016_ and later and is ignored when applied to previous versions. This can not be altered once the availability group is created and is ignored if it is the case.',

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
    dsc_endpointhostname: {
      type: 'Optional[String]',
      desc: 'Specifies the hostname or IP address of the availability group replica endpoint. When creating a group the default is the instance network name.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
