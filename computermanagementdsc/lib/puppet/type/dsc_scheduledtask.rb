require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_scheduledtask',
  dscmeta_resource_friendly_name: 'ScheduledTask',
  dscmeta_resource_name: 'DSC_ScheduledTask',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC ScheduledTask resource type.
         Automatically generated from version 9.0.0',
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
    dsc_repetitionduration: {
      type: 'Optional[String]',
      desc: 'Specifies how long the repetition pattern repeats after the task starts. May be set to `Indefinitely` to specify an indefinite duration.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_daysinterval: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the interval between the days in the schedule. An interval of 1 produces a daily schedule. An interval of 2 produces an every-other day schedule.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_disallowhardterminate: {
      type: 'Optional[Boolean]',
      desc: 'Indicates whether the task is prohibited to be terminated or not. Defaults to $false.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_description: {
      type: 'Optional[String]',
      desc: 'The task description.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_eventsubscription: {
      type: 'Optional[String]',
      desc: 'Specifies the EventSubscription in XML. This can be easily generated using the Windows Eventlog Viewer. For the query schema please check: https://docs.microsoft.com/en-us/windows/desktop/WES/queryschema-schema. Can only be used in combination with ScheduleType OnEvent.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_taskpath: {
      type: 'Optional[String]',
      desc: 'The path to the task - defaults to the root directory.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_scheduletype: {
      type: "Optional[Enum['Once', 'once', 'Daily', 'daily', 'Weekly', 'weekly', 'AtStartup', 'atstartup', 'AtLogOn', 'atlogon', 'OnEvent', 'onevent']]",
      desc: 'When should the task be executed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_disallowdemandstart: {
      type: 'Optional[Boolean]',
      desc: 'Indicates whether the task is prohibited to run on demand or not. Defaults to $false.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_executeascredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'The credential this task should execute as. If not specified defaults to running as the local system account.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_dontstoponidleend: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that Task Scheduler does not terminate the task if the idle condition ends before the task is completed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_allowstartifonbatteries: {
      type: 'Optional[Boolean]',
      desc: 'Indicates whether the task should start if the machine is on batteries or not. Defaults to $false.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_networkname: {
      type: 'Optional[String]',
      desc: 'Specifies the name of a network profile that Task Scheduler uses to determine if the task can run. The Task Scheduler UI uses this setting for display purposes. Specify a network name if you specify the RunOnlyIfNetworkAvailable parameter.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_repeatinterval: {
      type: 'Optional[String]',
      desc: 'How many units (minutes, hours, days) between each run of this task?',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_builtinaccount: {
      type: "Optional[Enum['SYSTEM', 'system', 'LOCAL SERVICE', 'local service', 'NETWORK SERVICE', 'network service']]",
      desc: "Run the task as one of the built in service accounts. When set ExecuteAsCredential will be ignored and LogonType will be set to 'ServiceAccount'.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_daysofweek: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies an array of the days of the week on which Task Scheduler runs the task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_priority: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the priority level of the task. Priority must be an integer from 0 (highest priority) to 10 (lowest priority). The default value is 7. Priority levels 7 and 8 are used for background tasks. Priority levels 4, 5, and 6 are used for interactive tasks.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_runlevel: {
      type: "Optional[Enum['Limited', 'limited', 'Highest', 'highest']]",
      desc: "Specifies the level of user rights that Task Scheduler uses to run the tasks that are associated with the principal. Defaults to 'Limited'.",


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_user: {
      type: 'Optional[String]',
      desc: 'Specifies the identifier of the user for a trigger that starts a task when a user logs on.',


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
    dsc_enable: {
      type: 'Optional[Boolean]',
      desc: 'True if the task should be enabled, false if it should be disabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_runonlyifnetworkavailable: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that Task Scheduler runs the task only when a network is available. Task Scheduler uses the NetworkID parameter and NetworkName parameter that you specify in this cmdlet to determine if the network is available.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_executeasgmsa: {
      type: 'Optional[String]',
      desc: 'The gMSA (Group Managed Service Account) this task should execute as. Cannot be used in combination with ExecuteAsCredential or BuiltInAccount.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_startwhenavailable: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that Task Scheduler can start the task at any time after its scheduled time has passed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_idlewaittimeout: {
      type: 'Optional[String]',
      desc: 'Specifies the amount of time that Task Scheduler waits for an idle condition to occur.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_restartonidle: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that Task Scheduler restarts the task when the computer cycles into an idle condition more than once.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_waketorun: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that Task Scheduler wakes the computer before it runs the task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_randomdelay: {
      type: 'Optional[String]',
      desc: 'Specifies a random amount of time to delay the start time of the trigger. The delay time is a random time between the time the task triggers and the time that you specify in this setting.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'present', 'Absent', 'absent']]",
      desc: 'Present if the task should exist, Absent if it should be removed.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_multipleinstances: {
      type: "Optional[Enum['IgnoreNew', 'ignorenew', 'Parallel', 'parallel', 'Queue', 'queue', 'StopExisting', 'stopexisting']]",
      desc: 'Specifies the policy that defines how Task Scheduler handles multiple instances of the task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_starttime: {
      type: 'Optional[Timestamp]',
      desc: 'The time of day this task should start at - defaults to 12:00 AM. Not valid for AtLogon and AtStartup tasks.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'DateTime',
      mof_is_embedded: false,
    },
    dsc_weeksinterval: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the interval between the weeks in the schedule. An interval of 1 produces a weekly schedule. An interval of 2 produces an every-other week schedule.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_disallowstartonremoteappsession: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that the task does not start if the task is triggered to run in a Remote Applications Integrated Locally (RAIL) session.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_hidden: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that the task is hidden in the Task Scheduler UI.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_dontstopifgoingonbatteries: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that the task does not stop if the computer switches to battery power.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_actionexecutable: {
      type: 'Optional[String]',
      desc: 'The path to the .exe for this task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_actionarguments: {
      type: 'Optional[String]',
      desc: 'The arguments to pass the executable.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_restartcount: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the number of times that Task Scheduler attempts to restart the task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_taskname: {
      type: 'String',
      desc: 'The name of the task.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_runonlyifidle: {
      type: 'Optional[Boolean]',
      desc: 'Indicates that Task Scheduler runs the task only when the computer is idle.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_logontype: {
      type: "Optional[Enum['Group', 'group', 'Interactive', 'interactive', 'InteractiveOrPassword', 'interactiveorpassword', 'None', 'none', 'Password', 'password', 'S4U', 's4u', 'ServiceAccount', 'serviceaccount']]",
      desc: 'Specifies the security logon method that Task Scheduler uses to run the tasks that are associated with the principal.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_compatibility: {
      type: "Optional[Enum['AT', 'at', 'V1', 'v1', 'Vista', 'vista', 'Win7', 'win7', 'Win8', 'win8']]",
      desc: 'The task compatibility level. Defaults to Vista.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_synchronizeacrosstimezone: {
      type: 'Optional[Boolean]',
      desc: 'Enable the scheduled task option to synchronize across time zones. This is enabled by including the timezone offset in the scheduled task trigger. Defaults to false which does not include the timezone offset.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_executiontimelimit: {
      type: 'Optional[String]',
      desc: 'Specifies the amount of time that Task Scheduler is allowed to complete the task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_restartinterval: {
      type: 'Optional[String]',
      desc: 'Specifies the amount of time that Task Scheduler attempts to restart the task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_idleduration: {
      type: 'Optional[String]',
      desc: 'Specifies the amount of time that the computer must be in an idle state before Task Scheduler runs the task.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_delay: {
      type: 'Optional[String]',
      desc: 'Specifies a delay to the start of the trigger. The delay is a static delay before the task is executed. Can only be used in combination with ScheduleType OnEvent.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_actionworkingpath: {
      type: 'Optional[String]',
      desc: 'The working path to specify for the executable.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
