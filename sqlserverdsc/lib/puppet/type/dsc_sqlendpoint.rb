require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlendpoint',
  dscmeta_resource_friendly_name: 'SqlEndpoint',
  dscmeta_resource_name: 'DSC_SqlEndpoint',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlEndpoint resource type.
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
    dsc_endpointtype: {
      type: "Enum['DatabaseMirroring', 'ServiceBroker', 'databasemirroring', 'servicebroker']",
      desc: 'Specifies the type of endpoint. Currently the only types that are supported are the _Database Mirroring_ and the _Service Broker_ type.',

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
      desc: 'The host name of the SQL Server to be configured. Default value is the current computer name.',

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
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: "If the endpoint should be present or absent. Default values is `'Present'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_messageforwardingsize: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum amount of storage in megabytes to allocate for the endpoint to use when storing messages that are to be forwarded.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_ismessageforwardingenabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether messages received by this endpoint that are for services located elsewhere will be forwarded.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_owner: {
      type: 'Optional[String]',
      desc: 'The owner of the endpoint. Default is the login used for the creation.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_endpointname: {
      type: 'String',
      desc: 'The name of the endpoint.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_state: {
      type: "Optional[Enum['Started', 'Stopped', 'Disabled', 'started', 'stopped', 'disabled']]",
      desc: 'Specifies the state of the endpoint. When an endpoint is created and the state is not specified then the endpoint will be started after it is created. The state will not be enforced unless the parameter is specified.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_port: {
      type: 'Optional[Integer[0, 65535]]',
      desc: 'The network port the endpoint is listening on. Default value is `5022`, but default value is only used during endpoint creation, it is not enforce.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt16',
      mof_is_embedded: false,
    },
    dsc_ipaddress: {
      type: 'Optional[String]',
      desc: "The network IP address the endpoint is listening on. Default value is `'0.0.0.0'` which means listen on any valid IP address. The default value is only used during endpoint creation, it is not enforce.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
