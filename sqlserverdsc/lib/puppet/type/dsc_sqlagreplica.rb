require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlagreplica',
  dscmeta_resource_friendly_name: 'SqlAGReplica',
  dscmeta_resource_name: 'DSC_SqlAGReplica',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlAGReplica resource type.
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
      desc: 'Returns if the current node is actively hosting the _SQL Server Database Engine_ instance.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_availabilitygroupname: {
      type: 'String',
      desc: 'The name of the availability group.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_primaryreplicaservername: {
      type: 'Optional[String]',
      desc: 'Hostname of the _SQL Server_ where the primary replica is expected to be active. If the primary replica is not found here, the resource will attempt to find the host that holds the primary replica and connect to it.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_endpointport: {
      type: 'Optional[Integer[0, 65535]]',
      desc: 'Returns the network port the endpoint is listening on.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_backuppriority: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the desired priority of the replicas in performing backups. The acceptable values for this parameter are: integers from `0` through `100`. Of the set of replicas which are online and available, the replica that has the highest priority performs the backup. When creating a replica the default is `50`.',

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
    dsc_failovermode: {
      type: "Optional[Enum['Automatic', 'Manual', 'automatic', 'manual']]",
      desc: "Specifies the failover mode. When creating a replica the default value is `'Manual'`.",

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
      desc: "Specifies if the availability group replica should be present or absent. Default value is `'Present'`.",

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
      desc: 'Name of the _SQL Server_ instance to be configured.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: "The name of the availability group replica. For named instances this must be in the following format `'ServerName\InstanceName'`.",
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_availabilitymode: {
      type: "Optional[Enum['AsynchronousCommit', 'SynchronousCommit', 'asynchronouscommit', 'synchronouscommit']]",
      desc: "Specifies the replica availability mode. When creating a replica the default is `'AsynchronousCommit'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'String',
      desc: 'Hostname of the _SQL Server_ to be configured.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_readonlyroutinglist: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies an ordered list of replica server names that represent the probe sequence for connection director to use when redirecting read-only connections through this availability replica. This parameter applies if the availability replica is the current primary replica of the availability group.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_readonlyroutingconnectionurl: {
      type: 'Optional[String]',
      desc: 'Specifies the fully qualified domain name (FQDN) and port to use when routing to the replica for read only connections.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_primaryreplicainstancename: {
      type: 'Optional[String]',
      desc: 'Name of the _SQL Server Database Engine_ instance where the primary replica lives.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
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
      desc: 'Specifies the hostname or IP address of the availability group replica endpoint. When creating a group the default is the instance network name which is set in the code because the value can only be determined when connected to the _SQL Server_ instance.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
