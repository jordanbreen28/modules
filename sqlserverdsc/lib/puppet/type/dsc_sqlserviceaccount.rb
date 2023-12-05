require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlserviceaccount',
  dscmeta_resource_friendly_name: 'SqlServiceAccount',
  dscmeta_resource_name: 'DSC_SqlServiceAccount',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlServiceAccount resource type.
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
      desc: 'The host name of the _SQL Server_ to be configured. Default value is the current computer name.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_restartservice: {
      type: 'Optional[Boolean]',
      desc: 'Determines whether the service is automatically restarted when a change to the configuration was needed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_versionnumber: {
      type: 'Optional[String]',
      desc: "The version number for the service type to be managed for the instance that is specified in parameter **InstanceName**. Mandatory when parameter **ServiceType** is set to `'IntegrationServices'`.",


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
    dsc_servicetype: {
      type: "Enum['DatabaseEngine', 'databaseengine', 'SQLServerAgent', 'sqlserveragent', 'Search', 'search', 'IntegrationServices', 'integrationservices', 'AnalysisServices', 'analysisservices', 'ReportingServices', 'reportingservices', 'SQLServerBrowser', 'sqlserverbrowser', 'NotificationServices', 'notificationservices']",
      desc: 'The service type to be managed for the instance that is specified in parameter **InstanceName**.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_force: {
      type: 'Optional[Boolean]',
      desc: 'Forces the service account to be updated. Useful for password changes. This will cause _Set_ to be run on each consecutive run.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_serviceaccount: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'The service account that should be used when running the _Windows_ service.',

      behaviour: :parameter,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_serviceaccountname: {
      type: 'Optional[String]',
      desc: 'Returns the service account username for the service.',

      behaviour: :read_only,
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
