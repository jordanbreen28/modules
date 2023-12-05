#Region './prefix.ps1' 0
$script:dscResourceCommonModulePath = Join-Path -Path $PSScriptRoot -ChildPath 'Modules/DscResource.Common'
Import-Module -Name $script:dscResourceCommonModulePath

# TODO: The goal would be to remove this, when no classes and public or private functions need it.
$script:sqlServerDscCommonModulePath = Join-Path -Path $PSScriptRoot -ChildPath 'Modules/SqlServerDsc.Common'
Import-Module -Name $script:sqlServerDscCommonModulePath

$script:localizedData = Get-LocalizedData -DefaultUICulture 'en-US'
#EndRegion './prefix.ps1' 9
#Region './Enum/1.Ensure.ps1' 0
<#
    .SYNOPSIS
        The possible states for the DSC resource parameter Ensure.
#>

enum Ensure
{
    Present
    Absent
}
#EndRegion './Enum/1.Ensure.ps1' 11
#Region './Classes/002.DatabasePermission.ps1' 0
<#
    .SYNOPSIS
        The possible database permission states.

    .PARAMETER State
        The state of the permission.

    .PARAMETER Permission
        The permissions to be granted or denied for the user in the database.

    .NOTES
        The DSC properties specifies the attribute Mandatory but State was meant
        to be attribute Key, but those attributes are not honored correctly during
        compilation in the current implementation of PowerShell DSC. If the
        attribute would have been left as Key then it would not have been possible
        to add an identical instance of DatabasePermission in two separate DSC
        resource instances in a DSC configuration. The Key property only works
        on the top level DSC properties. E.g. two resources instances of
        SqlDatabasePermission in a DSC configuration trying to grant the database
        permission 'connect' in two separate databases would have failed compilation
        as a the property State would have been seen as "duplicate resource".

        Since it is not possible to use the attribute Key the State property is
        evaluate during runtime so that no two states are enforcing the same
        permission.

        The method Equals() returns $false if type is not the same on both sides
        of the comparison. There was a thought to throw an exception if the object
        being compared was of another type, but since there was issues with using
        for example [ServerPermission[]], it was left out. This can be the correct
        way since if moving for example [ServerPermission[]] to the left side and
        the for example [ServerPermission] to the right side, then the left side
        array is filtered with the matching values on the right side. This is the
        normal behavior for other types.
#>
class DatabasePermission : IComparable, System.IEquatable[Object]
{
    [DscProperty(Mandatory)]
    [ValidateSet('Grant', 'GrantWithGrant', 'Deny')]
    [System.String]
    $State

    [DscProperty(Mandatory)]
    [AllowEmptyCollection()]
    [ValidateSet(
        'Alter',
        'AlterAnyAsymmetricKey',
        'AlterAnyApplicationRole',
        'AlterAnyAssembly',
        'AlterAnyCertificate',
        'AlterAnyDatabaseAudit',
        'AlterAnyDataspace',
        'AlterAnyDatabaseEventNotification',
        'AlterAnyExternalDataSource',
        'AlterAnyExternalFileFormat',
        'AlterAnyFulltextCatalog',
        'AlterAnyMask',
        'AlterAnyMessageType',
        'AlterAnyRole',
        'AlterAnyRoute',
        'AlterAnyRemoteServiceBinding',
        'AlterAnyContract',
        'AlterAnySymmetricKey',
        'AlterAnySchema',
        'AlterAnySecurityPolicy',
        'AlterAnyService',
        'AlterAnyDatabaseDdlTrigger',
        'AlterAnyUser',
        'Authenticate',
        'BackupDatabase',
        'BackupLog',
        'Control',
        'Connect',
        'ConnectReplication',
        'Checkpoint',
        'CreateAggregate',
        'CreateAsymmetricKey',
        'CreateAssembly',
        'CreateCertificate',
        'CreateDatabase',
        'CreateDefault',
        'CreateDatabaseDdlEventNotification',
        'CreateFunction',
        'CreateFulltextCatalog',
        'CreateMessageType',
        'CreateProcedure',
        'CreateQueue',
        'CreateRole',
        'CreateRoute',
        'CreateRule',
        'CreateRemoteServiceBinding',
        'CreateContract',
        'CreateSymmetricKey',
        'CreateSchema',
        'CreateSynonym',
        'CreateService',
        'CreateTable',
        'CreateType',
        'CreateView',
        'CreateXmlSchemaCollection',
        'Delete',
        'Execute',
        'Insert',
        'References',
        'Select',
        'Showplan',
        'SubscribeQueryNotifications',
        'TakeOwnership',
        'Unmask',
        'Update',
        'ViewDefinition',
        'ViewDatabaseState'
    )]
    [System.String[]]
    $Permission

    [System.Boolean] Equals([System.Object] $object)
    {
        $isEqual = $false

        if ($object -is $this.GetType())
        {
            if ($this.Grant -eq $object.Grant)
            {
                if (-not (Compare-Object -ReferenceObject $this.Permission -DifferenceObject $object.Permission))
                {
                    $isEqual = $true
                }
            }
        }

        return $isEqual
    }

    [System.Int32] CompareTo([Object] $object)
    {
        [System.Int32] $returnValue = 0

        if ($null -eq $object)
        {
            return 1
        }

        if ($object -is $this.GetType())
        {
            <#
                Less than zero    - The current instance precedes the object specified by the CompareTo
                                    method in the sort order.
                Zero              - This current instance occurs in the same position in the sort order
                                    as the object specified by the CompareTo method.
                Greater than zero - This current instance follows the object specified by the CompareTo
                                    method in the sort order.
            #>
            $returnValue = 0

            # Order objects in the order 'Grant', 'GrantWithGrant', 'Deny'.
            switch ($this.State)
            {
                'Grant'
                {
                    if ($object.State -in @('GrantWithGrant', 'Deny'))
                    {
                        # This current instance precedes $object
                        $returnValue = -1
                    }
                }

                'GrantWithGrant'
                {
                    if ($object.State -in @('Grant'))
                    {
                        # This current instance follows $object
                        $returnValue = 1
                    }

                    if ($object.State -in @('Deny'))
                    {
                        # This current instance precedes $object
                        $returnValue = -1
                    }
                }

                'Deny'
                {
                    if ($object.State -in @('Grant', 'GrantWithGrant'))
                    {
                        # This current instance follows $object
                        $returnValue = 1
                    }
                }
            }
        }
        else
        {
            $errorMessage = $script:localizedData.InvalidTypeForCompare -f @(
                $this.GetType().FullName,
                $object.GetType().FullName
            )

            New-InvalidArgumentException -ArgumentName 'Object' -Message $errorMessage
        }

        return $returnValue
    }
}
#EndRegion './Classes/002.DatabasePermission.ps1' 206
#Region './Classes/002.Reason.ps1' 0
class Reason
{
    [DscProperty()]
    [System.String]
    $Code

    [DscProperty()]
    [System.String]
    $Phrase
}
#EndRegion './Classes/002.Reason.ps1' 11
#Region './Classes/002.ServerPermission.ps1' 0
<#
    .SYNOPSIS
        The possible server permission states.

    .PARAMETER State
        The state of the permission.

    .PARAMETER Permission
        The permissions to be granted or denied for the user in the database.

    .NOTES
        The DSC properties specifies the attribute Mandatory but State was meant
        to be attribute Key, but those attributes are not honored correctly during
        compilation in the current implementation of PowerShell DSC. If the
        attribute would have been left as Key then it would not have been possible
        to add an identical instance of ServerPermission in two separate DSC
        resource instances in a DSC configuration. The Key property only works
        on the top level DSC properties. E.g. two resources instances of
        SqlPermission in a DSC configuration trying to grant the database
        permission 'AlterAnyDatabase' in two separate databases would have failed compilation
        as a the property State would have been seen as "duplicate resource".

        Since it is not possible to use the attribute Key the State property is
        evaluate during runtime so that no two states are enforcing the same
        permission.

        The method Equals() returns $false if type is not the same on both sides
        of the comparison. There was a thought to throw an exception if the object
        being compared was of another type, but since there was issues with using
        for example [ServerPermission[]], it was left out. This can be the correct
        way since if moving for example [ServerPermission[]] to the left side and
        the for example [ServerPermission] to the right side, then the left side
        array is filtered with the matching values on the right side. This is the
        normal behavior for other types.
#>
class ServerPermission : IComparable, System.IEquatable[Object]
{
    [DscProperty(Mandatory)]
    [ValidateSet('Grant', 'GrantWithGrant', 'Deny')]
    [System.String]
    $State

    [DscProperty(Mandatory)]
    [AllowEmptyCollection()]
    [ValidateSet(
        'AdministerBulkOperations',
        'AlterAnyServerAudit',
        'AlterAnyCredential',
        'AlterAnyConnection',
        'AlterAnyDatabase',
        'AlterAnyEventNotification',
        'AlterAnyEndpoint',
        'AlterAnyLogin',
        'AlterAnyLinkedServer',
        'AlterResources',
        'AlterServerState',
        'AlterSettings',
        'AlterTrace',
        'AuthenticateServer',
        'ControlServer',
        'ConnectSql',
        'CreateAnyDatabase',
        'CreateDdlEventNotification',
        'CreateEndpoint',
        'CreateTraceEventNotification',
        'Shutdown',
        'ViewAnyDefinition',
        'ViewAnyDatabase',
        'ViewServerState',
        'ExternalAccessAssembly',
        'UnsafeAssembly',
        'AlterAnyServerRole',
        'CreateServerRole',
        'AlterAnyAvailabilityGroup',
        'CreateAvailabilityGroup',
        'AlterAnyEventSession',
        'SelectAllUserSecurables',
        'ConnectAnyDatabase',
        'ImpersonateAnyLogin'
    )]
    [System.String[]]
    $Permission

    <#
        TODO: It was not possible to move this to a parent class. But since these are
              generic functions for DatabasePermission and ServerPermission we
              could make this a private function.
    #>
    [System.Boolean] Equals([System.Object] $object)
    {
        $isEqual = $false

        if ($object -is $this.GetType())
        {
            if ($this.Grant -eq $object.Grant)
            {
                if (-not (Compare-Object -ReferenceObject $this.Permission -DifferenceObject $object.Permission))
                {
                    $isEqual = $true
                }
            }
        }

        return $isEqual
    }

    <#
        TODO: It was not possible to move this to a parent class. But since these are
              generic functions for DatabasePermission and ServerPermission we
              could make this a private function.
    #>
    [System.Int32] CompareTo([Object] $object)
    {
        [System.Int32] $returnValue = 0

        if ($null -eq $object)
        {
            return 1
        }

        if ($object -is $this.GetType())
        {
            <#
                Less than zero    - The current instance precedes the object specified by the CompareTo
                                    method in the sort order.
                Zero              - This current instance occurs in the same position in the sort order
                                    as the object specified by the CompareTo method.
                Greater than zero - This current instance follows the object specified by the CompareTo
                                    method in the sort order.
            #>
            $returnValue = 0

            # Order objects in the order 'Grant', 'GrantWithGrant', 'Deny'.
            switch ($this.State)
            {
                'Grant'
                {
                    if ($object.State -in @('GrantWithGrant', 'Deny'))
                    {
                        # This current instance precedes $object
                        $returnValue = -1
                    }
                }

                'GrantWithGrant'
                {
                    if ($object.State -in @('Grant'))
                    {
                        # This current instance follows $object
                        $returnValue = 1
                    }

                    if ($object.State -in @('Deny'))
                    {
                        # This current instance precedes $object
                        $returnValue = -1
                    }
                }

                'Deny'
                {
                    if ($object.State -in @('Grant', 'GrantWithGrant'))
                    {
                        # This current instance follows $object
                        $returnValue = 1
                    }
                }
            }
        }
        else
        {
            $errorMessage = $script:localizedData.InvalidTypeForCompare -f @(
                $this.GetType().FullName,
                $object.GetType().FullName
            )

            New-InvalidArgumentException -ArgumentName 'Object' -Message $errorMessage
        }

        return $returnValue
    }
}
#EndRegion './Classes/002.ServerPermission.ps1' 183
#Region './Classes/010.ResourceBase.ps1' 0
<#
    .SYNOPSIS
        A class with methods that are equal for all class-based resources.

    .DESCRIPTION
        A class with methods that are equal for all class-based resources.

    .NOTES
        This class should be able to be inherited by all DSC resources. This class
        shall not contain any DSC properties, neither shall it contain anything
        specific to only a single resource.
#>

class ResourceBase
{
    # Property for holding localization strings
    hidden [System.Collections.Hashtable] $localizedData = @{}

    # Property for derived class to set properties that should not be enforced.
    hidden [System.String[]] $ExcludeDscProperties = @()

    # Default constructor
    ResourceBase()
    {
        <#
            TODO: When this fails, for example when the localized string file is missing
                  the LCM returns the error 'Failed to create an object of PowerShell
                  class SqlDatabasePermission' instead of the actual error that occurred.
        #>
        $this.localizedData = Get-LocalizedDataRecursive -ClassName ($this | Get-ClassName -Recurse)
    }

    [ResourceBase] Get()
    {
        $this.Assert()

        # Get all key properties.
        $keyProperty = $this | Get-DscProperty -Type 'Key'

        Write-Verbose -Message ($this.localizedData.GetCurrentState -f $this.GetType().Name, ($keyProperty | ConvertTo-Json -Compress))

        $getCurrentStateResult = $this.GetCurrentState($keyProperty)

        $dscResourceObject = [System.Activator]::CreateInstance($this.GetType())

        # Set values returned from the derived class' GetCurrentState().
        foreach ($propertyName in $this.PSObject.Properties.Name)
        {
            if ($propertyName -in @($getCurrentStateResult.Keys))
            {
                $dscResourceObject.$propertyName = $getCurrentStateResult.$propertyName
            }
        }

        $keyPropertyAddedToCurrentState = $false

        # Set key property values unless it was returned from the derived class' GetCurrentState().
        foreach ($propertyName in $keyProperty.Keys)
        {
            if ($propertyName -notin @($getCurrentStateResult.Keys))
            {
                # Add the key value to the instance to be returned.
                $dscResourceObject.$propertyName = $this.$propertyName

                $keyPropertyAddedToCurrentState = $true
            }
        }

        if (($this | Test-ResourceHasDscProperty -Name 'Ensure') -and -not $getCurrentStateResult.ContainsKey('Ensure'))
        {
            # Evaluate if we should set Ensure property.
            if ($keyPropertyAddedToCurrentState)
            {
                <#
                    A key property was added to the current state, assume its because
                    the object did not exist in the current state. Set Ensure to Absent.
                #>
                $dscResourceObject.Ensure = [Ensure]::Absent
                $getCurrentStateResult.Ensure = [Ensure]::Absent
            }
            else
            {
                $dscResourceObject.Ensure = [Ensure]::Present
                $getCurrentStateResult.Ensure = [Ensure]::Present
            }
        }

        <#
            Returns all enforced properties not in desires state, or $null if
            all enforced properties are in desired state.
        #>
        $propertiesNotInDesiredState = $this.Compare($getCurrentStateResult, @())

        <#
            Return the correct values for Reasons property if the derived DSC resource
            has such property and it hasn't been already set by GetCurrentState().
        #>
        if (($this | Test-ResourceHasDscProperty -Name 'Reasons') -and -not $getCurrentStateResult.ContainsKey('Reasons'))
        {
            # Always return an empty array if all properties are in desired state.
            $dscResourceObject.Reasons = $propertiesNotInDesiredState |
                ConvertTo-Reason -ResourceName $this.GetType().Name
        }

        # Return properties.
        return $dscResourceObject
    }

    [void] Set()
    {
        # Get all key properties.
        $keyProperty = $this | Get-DscProperty -Type 'Key'

        Write-Verbose -Message ($this.localizedData.SetDesiredState -f $this.GetType().Name, ($keyProperty | ConvertTo-Json -Compress))

        $this.Assert()

        <#
            Returns all enforced properties not in desires state, or $null if
            all enforced properties are in desired state.
        #>
        $propertiesNotInDesiredState = $this.Compare()

        if ($propertiesNotInDesiredState)
        {
            $propertiesToModify = $propertiesNotInDesiredState | ConvertFrom-CompareResult

            $propertiesToModify.Keys |
                ForEach-Object -Process {
                    Write-Verbose -Message ($this.localizedData.SetProperty -f $_, $propertiesToModify.$_)
                }

            <#
                Call the Modify() method with the properties that should be enforced
                and was not in desired state.
            #>
            $this.Modify($propertiesToModify)
        }
        else
        {
            Write-Verbose -Message $this.localizedData.NoPropertiesToSet
        }
    }

    [System.Boolean] Test()
    {
        # Get all key properties.
        $keyProperty = $this | Get-DscProperty -Type 'Key'

        Write-Verbose -Message ($this.localizedData.TestDesiredState -f $this.GetType().Name, ($keyProperty | ConvertTo-Json -Compress))

        $this.Assert()

        $isInDesiredState = $true

        <#
            Returns all enforced properties not in desires state, or $null if
            all enforced properties are in desired state.
        #>
        $propertiesNotInDesiredState = $this.Compare()

        if ($propertiesNotInDesiredState)
        {
            $isInDesiredState = $false
        }

        if ($isInDesiredState)
        {
            Write-Verbose $this.localizedData.InDesiredState
        }
        else
        {
            Write-Verbose $this.localizedData.NotInDesiredState
        }

        return $isInDesiredState
    }

    <#
        Returns a hashtable containing all properties that should be enforced and
        are not in desired state, or $null if all enforced properties are in
        desired state.

        This method should normally not be overridden.
    #>
    hidden [System.Collections.Hashtable[]] Compare()
    {
        # Get the current state, all properties except Read properties .
        $currentState = $this.Get() | Get-DscProperty -Type @('Key', 'Mandatory', 'Optional')

        return $this.Compare($currentState, @())
    }

    <#
        Returns a hashtable containing all properties that should be enforced and
        are not in desired state, or $null if all enforced properties are in
        desired state.

        This method should normally not be overridden.
    #>
    hidden [System.Collections.Hashtable[]] Compare([System.Collections.Hashtable] $currentState, [System.String[]] $excludeProperties)
    {
        # Get the desired state, all assigned properties that has an non-null value.
        $desiredState = $this | Get-DscProperty -Type @('Key', 'Mandatory', 'Optional') -HasValue

        $CompareDscParameterState = @{
            CurrentValues     = $currentState
            DesiredValues     = $desiredState
            Properties        = $desiredState.Keys
            ExcludeProperties = ($excludeProperties + $this.ExcludeDscProperties) | Select-Object -Unique
            IncludeValue      = $true
            # This is needed to sort complex types.
            SortArrayValues   = $true
        }

        <#
            Returns all enforced properties not in desires state, or $null if
            all enforced properties are in desired state.
        #>
        return (Compare-DscParameterState @CompareDscParameterState)
    }

    # This method should normally not be overridden.
    hidden [void] Assert()
    {
        # Get the properties that has a non-null value and is not of type Read.
        $desiredState = $this | Get-DscProperty -Type @('Key', 'Mandatory', 'Optional') -HasValue

        $this.AssertProperties($desiredState)
    }

    <#
        This method can be overridden if resource specific property asserts are
        needed. The parameter properties will contain the properties that was
        assigned a value.
    #>
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('AvoidEmptyNamedBlocks', '')]
    hidden [void] AssertProperties([System.Collections.Hashtable] $properties)
    {
    }

    <#
        This method must be overridden by a resource. The parameter properties will
        contain the properties that should be enforced and that are not in desired
        state.
    #>
    hidden [void] Modify([System.Collections.Hashtable] $properties)
    {
        throw $this.localizedData.ModifyMethodNotImplemented
    }

    <#
        This method must be overridden by a resource. The parameter properties will
        contain the key properties.
    #>
    hidden [System.Collections.Hashtable] GetCurrentState([System.Collections.Hashtable] $properties)
    {
        throw $this.localizedData.GetCurrentStateMethodNotImplemented
    }
}
#EndRegion './Classes/010.ResourceBase.ps1' 261
#Region './Classes/011.SqlResourceBase.ps1' 0
<#
    .SYNOPSIS
        The SqlResource base have generic properties and methods for the class-based
        resources.

    .PARAMETER InstanceName
        The name of the _SQL Server_ instance to be configured. Default value is
        `'MSSQLSERVER'`.

    .PARAMETER ServerName
        The host name of the _SQL Server_ to be configured. Default value is the
        current computer name.

    .PARAMETER Credential
        Specifies the credential to use to connect to the _SQL Server_ instance.

        If parameter **Credential'* is not provided then the resource instance is
        run using the credential that runs the configuration.

    .PARAMETER Reasons
        Returns the reason a property is not in desired state.
#>
class SqlResourceBase : ResourceBase
{
    <#
        Property for holding the server connection object.
        This should be an object of type [Microsoft.SqlServer.Management.Smo.Server]
        but using that type fails the build process currently.
        See issue https://github.com/dsccommunity/DscResource.DocGenerator/issues/121.
    #>
    hidden [System.Object] $SqlServerObject

    [DscProperty(Key)]
    [System.String]
    $InstanceName

    [DscProperty()]
    [System.String]
    $ServerName = (Get-ComputerName)

    [DscProperty()]
    [PSCredential]
    $Credential

    [DscProperty(NotConfigurable)]
    [Reason[]]
    $Reasons

    SqlResourceBase () : base ()
    {
        $this.SqlServerObject = $null
    }

    <#
        Returns and reuses the server connection object. If the server connection
        object does not exist a connection to the SQL Server instance will occur.

        This should return an object of type [Microsoft.SqlServer.Management.Smo.Server]
        but using that type fails the build process currently.
        See issue https://github.com/dsccommunity/DscResource.DocGenerator/issues/121.
    #>
    hidden [System.Object] GetServerObject()
    {
        if (-not $this.SqlServerObject)
        {
            $connectSqlDscDatabaseEngineParameters = @{
                ServerName   = $this.ServerName
                InstanceName = $this.InstanceName
            }

            if ($this.Credential)
            {
                $connectSqlDscDatabaseEngineParameters.Credential = $this.Credential
            }

            $this.SqlServerObject = Connect-SqlDscDatabaseEngine @connectSqlDscDatabaseEngineParameters
        }

        return $this.SqlServerObject
    }
}
#EndRegion './Classes/011.SqlResourceBase.ps1' 82
#Region './Classes/020.SqlAudit.ps1' 0
<#
    .SYNOPSIS
        The `SqlAudit` DSC resource is used to create, modify, or remove
        server audits.

    .DESCRIPTION
        The `SqlAudit` DSC resource is used to create, modify, or remove
        server audits.

        The built-in parameter **PSDscRunAsCredential** can be used to run the resource
        as another user. The resource will then authenticate to the SQL Server
        instance as that user. It also possible to instead use impersonation by the
        parameter **Credential**.

        ## Requirements

        * Target machine must be running Windows Server 2012 or later.
        * Target machine must be running SQL Server Database Engine 2012 or later.
        * Target machine must have access to the SQLPS PowerShell module or the SqlServer
          PowerShell module.

        ## Known issues

        All issues are not listed here, see [here for all open issues](https://github.com/dsccommunity/SqlServerDsc/issues?q=is%3Aissue+is%3Aopen+in%3Atitle+SqlAudit).

        ### Property **Reasons** does not work with **PSDscRunAsCredential**

        When using the built-in parameter **PSDscRunAsCredential** the read-only
        property **Reasons** will return empty values for the properties **Code**
        and **Phrase. The built-in property **PSDscRunAsCredential** does not work
        together with class-based resources that using advanced type like the parameter
        **Reasons** have.

        ### Using **Credential** property

        SQL Authentication and Group Managed Service Accounts is not supported as
        impersonation credentials. Currently only Windows Integrated Security is
        supported to use as credentials.

        For Windows Authentication the username must either be provided with the User
        Principal Name (UPN), e.g. `username@domain.local` or if using non-domain
        (for example a local Windows Server account) account the username must be
        provided without the NetBIOS name, e.g. `username`. Using the NetBIOS name, e.g
        using the format `DOMAIN\username` will not work.

        See more information in [Credential Overview](https://github.com/dsccommunity/SqlServerDsc/wiki/CredentialOverview).

    .PARAMETER Name
        The name of the audit.

    .PARAMETER LogType
        Specifies the to which log an audit logs to. Mutually exclusive to parameter
        **Path**.

    .PARAMETER Path
        Specifies the destination path for a file audit. Mutually exclusive to parameter
        **LogType**.

    .PARAMETER Filter
        Specifies the filter that should be used on the audit.

    .PARAMETER MaximumFiles
        Specifies the number of files on disk. Mutually exclusive to parameter
        **MaximumRolloverFiles**. Mutually exclusive to parameter **LogType**.

    .PARAMETER MaximumFileSize
        Specifies the maximum file size in units by parameter **MaximumFileSizeUnit**.
        If this is specified the parameter **MaximumFileSizeUnit** must also be
        specified. Mutually exclusive to parameter **LogType**. Minimum allowed value
        is 2 (MB). It also allowed to set the value to 0 which mean unlimited file
        size.

    .PARAMETER MaximumFileSizeUnit
        Specifies the unit that is used for the file size.
        If this is specified the parameter **MaximumFileSize** must also be
        specified. Mutually exclusive to parameter **LogType**.

    .PARAMETER MaximumRolloverFiles
        Specifies the amount of files on disk before SQL Server starts reusing
        the files. Mutually exclusive to parameter **MaximumFiles** and **LogType**.

    .PARAMETER OnFailure
        Specifies what should happen when writing events to the store fails.
        This can be `Continue`, `FailOperation`, or `Shutdown`.

    .PARAMETER QueueDelay
        Specifies the maximum delay before a event is written to the store.
        When set to low this could impact server performance.
        When set to high events could be missing when a server crashes.

    .PARAMETER ReserveDiskSpace
        Specifies if the needed file space should be reserved. only needed
        when writing to a file log. Mutually exclusive to parameter **LogType**.

    .PARAMETER Enabled
        Specifies if the audit should be enabled. Defaults to `$false`.

    .PARAMETER Ensure
        Specifies if the server audit should be present or absent. If set to `Present`
        the audit will be added if it does not exist, or updated if the audit exist.
        If `Absent` then the audit will be removed from the server. Defaults to
        `Present`.

    .PARAMETER Force
        Specifies if it is allowed to re-create the server audit if a current audit
        exist with the same name but of a different audit type. Defaults to `$false`
        not allowing server audits to be re-created.

    .EXAMPLE
        Invoke-DscResource -ModuleName SqlServerDsc -Name SqlAudit -Method Get -Property @{
            ServerName           = 'localhost'
            InstanceName         = 'SQL2017'
            Credential           = (Get-Credential -UserName 'myuser@company.local' -Message 'Password:')
            Name                 = 'Log1'
        }

        This example shows how to call the resource using Invoke-DscResource.
#>
[DscResource(RunAsCredential = 'Optional')]
class SqlAudit : SqlResourceBase
{
    [DscProperty(Key)]
    [System.String]
    $Name

    [DscProperty()]
    [ValidateSet('SecurityLog', 'ApplicationLog')]
    [System.String]
    $LogType

    # The Path is evaluated if exist in AssertProperties().
    [DscProperty()]
    [System.String]
    $Path

    [DscProperty()]
    [System.String]
    $AuditFilter

    [DscProperty()]
    [Nullable[System.UInt32]]
    $MaximumFiles

    [DscProperty()]
    # There is an extra evaluation in AssertProperties() for this range.
    [ValidateRange(0, 2147483647)]
    [Nullable[System.UInt32]]
    $MaximumFileSize

    [DscProperty()]
    [ValidateSet('Megabyte', 'Gigabyte', 'Terabyte')]
    [System.String]
    $MaximumFileSizeUnit

    [DscProperty()]
    [ValidateRange(0, 2147483647)]
    [Nullable[System.UInt32]]
    $MaximumRolloverFiles

    [DscProperty()]
    [ValidateSet('Continue', 'FailOperation', 'Shutdown')]
    [System.String]
    $OnFailure

    [DscProperty()]
    # There is an extra evaluation in AssertProperties() for this range.
    [ValidateRange(0, 2147483647)]
    [Nullable[System.UInt32]]
    $QueueDelay

    [DscProperty()]
    [ValidatePattern('^[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$')]
    [System.String]
    $AuditGuid

    [DscProperty()]
    [Nullable[System.Boolean]]
    $ReserveDiskSpace

    [DscProperty()]
    [Nullable[System.Boolean]]
    $Enabled

    [DscProperty()]
    [Ensure]
    $Ensure = [Ensure]::Present

    [DscProperty()]
    [Nullable[System.Boolean]]
    $Force

    SqlAudit () : base ()
    {
        # These properties will not be enforced.
        $this.ExcludeDscProperties = @(
            'ServerName'
            'InstanceName'
            'Name'
            'Credential'
            'Force'
        )
    }

    [SqlAudit] Get()
    {
        # Call the base method to return the properties.
        return ([ResourceBase] $this).Get()
    }

    [System.Boolean] Test()
    {
        # Call the base method to test all of the properties that should be enforced.
        return ([ResourceBase] $this).Test()
    }

    [void] Set()
    {
        # Call the base method to enforce the properties.
        ([ResourceBase] $this).Set()
    }

    <#
        Base method Get() call this method to get the current state as a hashtable.
        The parameter properties will contain the key properties.
    #>
    hidden [System.Collections.Hashtable] GetCurrentState([System.Collections.Hashtable] $properties)
    {
        Write-Verbose -Message (
            $this.localizedData.EvaluateServerAudit -f @(
                $properties.Name,
                $properties.InstanceName
            )
        )

        $currentStateCredential = $null

        if ($this.Credential)
        {
            <#
                This does not work, even if username is set, the method Get() will
                return an empty PSCredential-object. Kept it here so it at least
                return a Credential object.
            #>
            $currentStateCredential = [PSCredential]::new(
                $this.Credential.UserName,
                [SecureString]::new()
            )
        }

        <#
            Only set key property Name if the audit exist. Base class will set it
            and handle Ensure.
        #>
        $currentState = @{
            Credential   = $currentStateCredential
            InstanceName = $properties.InstanceName
            ServerName   = $this.ServerName
            Force        = $this.Force
        }

        $serverObject = $this.GetServerObject()

        $auditObject = $serverObject |
            Get-SqlDscAudit -Name $properties.Name -ErrorAction 'SilentlyContinue'

        if ($auditObject)
        {
            $currentState.Name = $properties.Name

            if ($auditObject.DestinationType -in @('ApplicationLog', 'SecurityLog'))
            {
                $currentState.LogType = $auditObject.DestinationType
            }

            if ($auditObject.FilePath)
            {
                # Remove trailing slash or backslash.
                $currentState.Path = $auditObject.FilePath -replace '[\\|/]*$'
            }

            $currentState.AuditFilter = $auditObject.Filter
            $currentState.MaximumFiles = [System.UInt32] $auditObject.MaximumFiles
            $currentState.MaximumFileSize = [System.UInt32] $auditObject.MaximumFileSize

            # The value of MaximumFileSizeUnit can be zero, so have to check against $null
            if ($null -ne $auditObject.MaximumFileSizeUnit)
            {
                $convertedMaximumFileSizeUnit = (
                    @{
                        0 = 'Megabyte'
                        1 = 'Gigabyte'
                        2 = 'Terabyte'
                    }
                ).($auditObject.MaximumFileSizeUnit.value__)

                $currentState.MaximumFileSizeUnit = $convertedMaximumFileSizeUnit
            }

            $currentState.MaximumRolloverFiles = [System.UInt32] $auditObject.MaximumRolloverFiles
            $currentState.OnFailure = $auditObject.OnFailure
            $currentState.QueueDelay = [System.UInt32] $auditObject.QueueDelay
            $currentState.AuditGuid = $auditObject.Guid
            $currentState.ReserveDiskSpace = $auditObject.ReserveDiskSpace
            $currentState.Enabled = $auditObject.Enabled
        }

        return $currentState
    }

    <#
        Base method Set() call this method with the properties that should be
        enforced are not in desired state. It is not called if all properties
        are in desired state. The variable $properties contain the properties
        that are not in desired state.
    #>
    hidden [void] Modify([System.Collections.Hashtable] $properties)
    {
        $serverObject = $this.GetServerObject()
        $auditObject = $null

        if ($properties.Keys -contains 'Ensure')
        {
            # Evaluate the desired state for property Ensure.
            switch ($properties.Ensure)
            {
                'Present'
                {
                    # Create the audit since it was missing. Always created disabled.
                    $auditObject = $this.CreateAudit()
                }

                'Absent'
                {
                    # Remove the audit since it was present
                    $serverObject | Remove-SqlDscAudit -Name $this.Name -Force
                }
            }
        }
        else
        {
            <#
                Update any properties not in desired state if the audit should be present.
                At this point it is assumed the audit exist since Ensure property was
                in desired state.

                If the desired state happens to be Absent then ignore any properties not
                in desired state (user have in that case wrongly added properties to an
                "absent configuration").
            #>
            if ($this.Ensure -eq [Ensure]::Present)
            {
                $auditObject = $serverObject |
                    Get-SqlDscAudit -Name $this.Name -ErrorAction 'Stop'

                if ($auditObject)
                {
                    $auditIsWrongType = (
                        # If $auditObject.DestinationType is not null.
                        $null -ne $auditObject.DestinationType -and (
                            # Path is not in desired state but the audit is not of type File.
                            $properties.ContainsKey('Path') -and $auditObject.DestinationType -ne 'File'
                        ) -or (
                            # LogType is not in desired state but the audit is of type File.
                            $properties.ContainsKey('LogType') -and $auditObject.DestinationType -eq 'File'
                        )
                    )

                    # Does the audit need to be re-created?
                    if ($auditIsWrongType)
                    {
                        if ($this.Force -eq $true)
                        {
                            $auditObject | Remove-SqlDscAudit -Force

                            $auditObject = $this.CreateAudit()
                        }
                        else
                        {
                            New-InvalidOperationException -Message $this.localizedData.AuditIsWrongType
                        }
                    }
                    else
                    {
                        <#
                            Should evaluate DestinationType so that is does not try to set a
                            File audit property when audit type is of a Log-type.
                        #>
                        if ($null -ne $auditObject.DestinationType -and $auditObject.DestinationType -ne 'File')
                        {
                            # Look for file audit properties not in desired state
                            $fileAuditProperty = $properties.Keys.Where({
                                $_ -in @(
                                    'Path'
                                    'MaximumFiles'
                                    'MaximumFileSize'
                                    'MaximumFileSizeUnit'
                                    'MaximumRolloverFiles'
                                    'ReserveDiskSpace'
                                )
                            })

                            # If a property was found, throw an exception.
                            if ($fileAuditProperty.Count -gt 0)
                            {
                                New-InvalidOperationException -Message ($this.localizedData.AuditOfWrongTypeForUseWithProperty -f $auditObject.DestinationType)
                            }
                        }

                        # Get all optional properties that has an assigned value.
                        $assignedOptionalDscProperties = $this | Get-DscProperty -HasValue -Type 'Optional' -ExcludeName @(
                            # Remove optional properties that is not an audit property.
                            'ServerName'
                            'Ensure'
                            'Force'
                            'Credential'

                            # Remove this audit property since it must be handled later.
                            'Enabled'
                        )

                        <#
                            Only call Set when there is a property to Set. The property
                            Enabled was ignored, so it could be the only one that was
                            not in desired state (Enabled is handled later).
                        #>
                        if ($assignedOptionalDscProperties.Count -gt 0)
                        {
                            <#
                                This calls Set-SqlDscAudit to set all the desired value
                                even if they were in desired state. Then the no logic is
                                needed to make sure we call using the correct parameter
                                set that Set-SqlDscAudit requires.
                            #>
                            $auditObject | Set-SqlDscAudit @assignedOptionalDscProperties -Force
                        }
                    }
                }
            }
        }

        <#
            If there is an audit object either from a newly created or fetched from
            current state, and if the desired state is Present, evaluate if the
            audit should be enable or disable.
        #>
        if ($auditObject -and $this.Ensure -eq [Ensure]::Present -and $properties.Keys -contains 'Enabled')
        {
            switch ($properties.Enabled)
            {
                $true
                {
                    $serverObject | Enable-SqlDscAudit -Name $this.Name -Force
                }

                $false
                {
                    $serverObject | Disable-SqlDscAudit -Name $this.Name -Force
                }
            }
        }
    }

    <#
        Base method Assert() call this method with the properties that was assigned
        a value.
    #>
    hidden [void] AssertProperties([System.Collections.Hashtable] $properties)
    {
        # The properties MaximumFiles and MaximumRolloverFiles are mutually exclusive.
        $assertBoundParameterParameters = @{
            BoundParameterList     = $properties
            MutuallyExclusiveList1 = @(
                'MaximumFiles'
            )
            MutuallyExclusiveList2 = @(
                'MaximumRolloverFiles'
            )
        }

        Assert-BoundParameter @assertBoundParameterParameters

        # LogType is mutually exclusive from any of the File audit properties.
        $assertBoundParameterParameters = @{
            BoundParameterList     = $properties
            MutuallyExclusiveList1 = @(
                'LogType'
            )
            MutuallyExclusiveList2 = @(
                'Path'
                'MaximumFiles'
                'MaximumFileSize'
                'MaximumFileSizeUnit'
                'MaximumRolloverFiles'
                'ReserveDiskSpace'
            )
        }

        Assert-BoundParameter @assertBoundParameterParameters

        # Get all assigned *FileSize properties.
        $assignedSizeProperty = $properties.Keys.Where({
                $_ -in @(
                    'MaximumFileSize',
                    'MaximumFileSizeUnit'
                )
            })

        <#
            Neither or both of the properties MaximumFileSize and MaximumFileSizeUnit
            must be assigned.
        #>
        if ($assignedSizeProperty.Count -eq 1)
        {
            $errorMessage = $this.localizedData.BothFileSizePropertiesMustBeSet

            New-InvalidArgumentException -ArgumentName 'MaximumFileSize, MaximumFileSizeUnit' -Message $errorMessage
        }

        <#
            Since we cannot use [ValidateScript()], and it is no possible to exclude
            a value in the [ValidateRange()], evaluate so 1 is not assigned.
        #>
        if ($properties.Keys -contains 'MaximumFileSize' -and $properties.MaximumFileSize -eq 1)
        {
            $errorMessage = $this.localizedData.MaximumFileSizeValueInvalid

            New-InvalidArgumentException -ArgumentName 'MaximumFileSize' -Message $errorMessage
        }

        <#
            Since we cannot use [ValidateScript()], and it is no possible to exclude
            a value in the [ValidateRange()], evaluate so 1-999 is not assigned.
        #>
        if ($properties.Keys -contains 'QueueDelay' -and $properties.QueueDelay -in 1..999)
        {
            $errorMessage = $this.localizedData.QueueDelayValueInvalid

            New-InvalidArgumentException -ArgumentName 'QueueDelay' -Message $errorMessage
        }

        # ReserveDiskSpace can only be used with MaximumFiles.
        if ($properties.Keys -contains 'ReserveDiskSpace' -and $properties.Keys -notcontains 'MaximumFiles')
        {
            $errorMessage = $this.localizedData.BothFileSizePropertiesMustBeSet

            New-InvalidArgumentException -ArgumentName 'ReserveDiskSpace' -Message $errorMessage
        }

        # Test so that the path exist.
        if ($properties.Keys -contains 'Path' -and -not (Test-Path -Path $properties.Path))
        {
            $errorMessage = $this.localizedData.PathInvalid -f $properties.Path

            New-InvalidArgumentException -ArgumentName 'Path' -Message $errorMessage
        }
    }

    <#
        Create and returns the desired audit object. Always created disabled.

        This should return an object of type [Microsoft.SqlServer.Management.Smo.Audit]
        but using that type fails the build process currently.
        See issue https://github.com/dsccommunity/DscResource.DocGenerator/issues/121.
    #>
    hidden [System.Object] CreateAudit()
    {
        # Get all properties that has an assigned value.
        $assignedDscProperties = $this | Get-DscProperty -HasValue -Type @(
            'Key'
            'Optional'
        ) -ExcludeName @(
            # Remove properties that is not an audit property.
            'InstanceName'
            'ServerName'
            'Ensure'
            'Force'
            'Credential'

            # Remove this audit property since it must be handled later.
            'Enabled'
        )

        if ($assignedDscProperties.Keys -notcontains 'LogType' -and $assignedDscProperties.Keys -notcontains 'Path')
        {
            New-InvalidOperationException -Message $this.localizedData.CannotCreateNewAudit
        }

        $serverObject = $this.GetServerObject()

        $auditObject = $serverObject | New-SqlDscAudit @assignedDscProperties -Force -PassThru

        return $auditObject
    }
}
#EndRegion './Classes/020.SqlAudit.ps1' 595
#Region './Classes/020.SqlDatabasePermission.ps1' 0
<#
    .SYNOPSIS
        The `SqlDatabasePermission` DSC resource is used to grant, deny or revoke
        permissions for a user in a database.

    .DESCRIPTION
        The `SqlDatabasePermission` DSC resource is used to grant, deny or revoke
        permissions for a user in a database. For more information about permissions,
        please read the article [Permissions (Database Engine)](https://docs.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine).

        >**Note:** When revoking permission with PermissionState 'GrantWithGrant', both the
        >grantee and _all the other users the grantee has granted the same permission to_,
        >will also get their permission revoked.

        ## Requirements

        * Target machine must be running Windows Server 2012 or later.
        * Target machine must be running SQL Server Database Engine 2012 or later.

        ## Known issues

        All issues are not listed here, see [here for all open issues](https://github.com/dsccommunity/SqlServerDsc/issues?q=is%3Aissue+is%3Aopen+in%3Atitle+SqlDatabasePermission).

        ### `PSDscRunAsCredential` not supported

        The built-in property `PSDscRunAsCredential` does not work with class-based
        resources that using advanced type like the parameters `Permission` and
        `Reasons` has. Use the parameter `Credential` instead of `PSDscRunAsCredential`.

        ### Using `Credential` property.

        SQL Authentication and Group Managed Service Accounts is not supported as
        impersonation credentials. Currently only Windows Integrated Security is
        supported to use as credentials.

        For Windows Authentication the username must either be provided with the User
        Principal Name (UPN), e.g. 'username@domain.local' or if using non-domain
        (for example a local Windows Server account) account the username must be
        provided without the NetBIOS name, e.g. 'username'. The format 'DOMAIN\username'
        will not work.

        See more information in [Credential Overview](https://github.com/dsccommunity/SqlServerDsc/wiki/CredentialOverview).

        ### Invalid values during compilation

        The parameter Permission is of type `[DatabasePermission]`. If a property
        in the type is set to an invalid value an error will occur, correct the
        values in the properties to valid values.
        This happens when the values are validated against the `[ValidateSet()]`
        of the resource. When there is an invalid value the following error will
        be thrown when the configuration is run (it will not show during compilation):

        ```plaintext
        Failed to create an object of PowerShell class SqlDatabasePermission.
            + CategoryInfo          : InvalidOperation: (root/Microsoft/...ConfigurationManager:String) [], CimException
            + FullyQualifiedErrorId : InstantiatePSClassObjectFailed
            + PSComputerName        : localhost
        ```

    .PARAMETER DatabaseName
        The name of the database.

    .PARAMETER Name
        The name of the user that should be granted or denied the permission.

    .PARAMETER Permission
        An array of database permissions to enforce. Any permission that is not
        part of the desired state will be revoked.

        Must provide all permission states (`Grant`, `Deny`, `GrantWithGrant`) with
        at least an empty string array for the advanced type `DatabasePermission`'s
        property `Permission`.

        Valid permission names can be found in the article [DatabasePermissionSet Class properties](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sqlserver.management.smo.databasepermissionset#properties).

        This is an array of CIM instances of advanced type `DatabasePermission` from
        the namespace `root/Microsoft/Windows/DesiredStateConfiguration`.

    .PARAMETER PermissionToInclude
        An array of database permissions to include to the current state. The
        current state will not be affected unless the current state contradict the
        desired state. For example if the desired state specifies a deny permissions
        but in the current state that permission is granted, that permission will
        be changed to be denied.

        Valid permission names can be found in the article [DatabasePermissionSet Class properties](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sqlserver.management.smo.databasepermissionset#properties).

        This is an array of CIM instances of advanced type `DatabasePermission` from
        the namespace `root/Microsoft/Windows/DesiredStateConfiguration`.

    .PARAMETER PermissionToExclude
        An array of database permissions to exclude (revoke) from the current state.

        Valid permission names can be found in the article [DatabasePermissionSet Class properties](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sqlserver.management.smo.databasepermissionset#properties).

        This is an array of CIM instances of advanced type `DatabasePermission` from
        the namespace `root/Microsoft/Windows/DesiredStateConfiguration`.

    .EXAMPLE
        Invoke-DscResource -ModuleName SqlServerDsc -Name SqlDatabasePermission -Method Get -Property @{
            ServerName           = 'localhost'
            InstanceName         = 'SQL2017'
            DatabaseName         = 'AdventureWorks'
            Credential           = (Get-Credential -UserName 'myuser@company.local' -Message 'Password:')
            Name                 = 'INSTANCE\SqlUser'
            Permission           = [Microsoft.Management.Infrastructure.CimInstance[]] @(
                (
                    New-CimInstance -ClientOnly -Namespace root/Microsoft/Windows/DesiredStateConfiguration -ClassName DatabasePermission -Property @{
                            State = 'Grant'
                            Permission = @('select')
                    }
                )
                (
                    New-CimInstance -ClientOnly -Namespace root/Microsoft/Windows/DesiredStateConfiguration -ClassName DatabasePermission -Property @{
                        State = 'GrantWithGrant'
                        Permission = [System.String[]] @()
                    }
                )
                (
                    New-CimInstance -ClientOnly -Namespace root/Microsoft/Windows/DesiredStateConfiguration -ClassName DatabasePermission -Property @{
                        State = 'Deny'
                        Permission = [System.String[]] @()
                    }
                )
            )
        }

        This example shows how to call the resource using Invoke-DscResource.

    .NOTES
        The built-in property `PsDscRunAsCredential` is not supported on this DSC
        resource as it uses a complex type (another class as the type for a DSC
        property). If the property `PsDscRunAsCredential` would be used, then the
        complex type will not return any values from Get(). This is most likely an
        issue (bug) with _PowerShell DSC_. Instead (as a workaround) the property
        `Credential` must be used to specify how to connect to the _SQL Server_
        instance.
#>

[DscResource(RunAsCredential = 'NotSupported')]
class SqlDatabasePermission : SqlResourceBase
{
    [DscProperty(Key)]
    [System.String]
    $DatabaseName

    [DscProperty(Key)]
    [System.String]
    $Name

    [DscProperty()]
    [DatabasePermission[]]
    $Permission

    [DscProperty()]
    [DatabasePermission[]]
    $PermissionToInclude

    [DscProperty()]
    [DatabasePermission[]]
    $PermissionToExclude

    SqlDatabasePermission() : base ()
    {
        # These properties will not be enforced.
        $this.ExcludeDscProperties = @(
            'ServerName'
            'InstanceName'
            'DatabaseName'
            'Name'
            'Credential'
        )
    }

    [SqlDatabasePermission] Get()
    {
        # Call the base method to return the properties.
        return ([ResourceBase] $this).Get()
    }

    [System.Boolean] Test()
    {
        # Call the base method to test all of the properties that should be enforced.
        return ([ResourceBase] $this).Test()
    }

    [void] Set()
    {
        # Call the base method to enforce the properties.
        ([ResourceBase] $this).Set()
    }

    <#
        Base method Get() call this method to get the current state as a hashtable.
        The parameter properties will contain the key properties.
    #>
    hidden [System.Collections.Hashtable] GetCurrentState([System.Collections.Hashtable] $properties)
    {
        $currentStateCredential = $null

        if ($this.Credential)
        {
            <#
                This does not work, even if username is set, the method Get() will
                return an empty PSCredential-object. Kept it here so it at least
                return a Credential object.
            #>
            $currentStateCredential = [PSCredential]::new(
                $this.Credential.UserName,
                [SecureString]::new()
            )
        }

        $currentState = @{
            Credential = $currentStateCredential
            Permission = [DatabasePermission[]] @()
        }

        Write-Verbose -Message (
            $this.localizedData.EvaluateDatabasePermissionForPrincipal -f @(
                $properties.Name,
                $properties.DatabaseName,
                $properties.InstanceName
            )
        )

        $serverObject = $this.GetServerObject()

        $databasePermissionInfo = $serverObject |
            Get-SqlDscDatabasePermission -DatabaseName $this.DatabaseName -Name $this.Name -ErrorAction 'SilentlyContinue'

        # If permissions was returned, build the current permission array of [DatabasePermission].
        if ($databasePermissionInfo)
        {
            [DatabasePermission[]] $currentState.Permission = $databasePermissionInfo | ConvertTo-SqlDscDatabasePermission
        }

        # Always return all State; 'Grant', 'GrantWithGrant', and 'Deny'.
        foreach ($currentPermissionState in @('Grant', 'GrantWithGrant', 'Deny'))
        {
            if ($currentState.Permission.State -notcontains $currentPermissionState)
            {
                [DatabasePermission[]] $currentState.Permission += [DatabasePermission] @{
                    State      = $currentPermissionState
                    Permission = @()
                }
            }
        }

        $isPropertyPermissionToIncludeAssigned = $this | Test-ResourceDscPropertyIsAssigned -Name 'PermissionToInclude'

        if ($isPropertyPermissionToIncludeAssigned)
        {
            $currentState.PermissionToInclude = [DatabasePermission[]] @()

            # Evaluate so that the desired state is present in the current state.
            foreach ($desiredIncludePermission in $this.PermissionToInclude)
            {
                <#
                    Current state will always have all possible states, so this
                    will always return one item.
                #>
                $currentStatePermissionForState = $currentState.Permission |
                    Where-Object -FilterScript {
                        $_.State -eq $desiredIncludePermission.State
                    }

                $currentStatePermissionToInclude = [DatabasePermission] @{
                    State      = $desiredIncludePermission.State
                    Permission = @()
                }

                foreach ($desiredIncludePermissionName in $desiredIncludePermission.Permission)
                {
                    if ($currentStatePermissionForState.Permission -contains $desiredIncludePermissionName)
                    {
                        <#
                            If the permission exist in the current state, add the
                            permission to $currentState.PermissionToInclude so that
                            the base class's method Compare() sees the property as
                            being in desired state (when the property PermissionToInclude
                            in the current state and desired state are equal).
                        #>
                        $currentStatePermissionToInclude.Permission += $desiredIncludePermissionName
                    }
                    else
                    {
                        Write-Verbose -Message (
                            $this.localizedData.DesiredPermissionAreAbsent -f @(
                                $desiredIncludePermissionName
                            )
                        )
                    }
                }

                [DatabasePermission[]] $currentState.PermissionToInclude += $currentStatePermissionToInclude
            }
        }

        $isPropertyPermissionToExcludeAssigned = $this | Test-ResourceDscPropertyIsAssigned -Name 'PermissionToExclude'

        if ($isPropertyPermissionToExcludeAssigned)
        {
            $currentState.PermissionToExclude = [DatabasePermission[]] @()

            # Evaluate so that the desired state is missing from the current state.
            foreach ($desiredExcludePermission in $this.PermissionToExclude)
            {
                <#
                    Current state will always have all possible states, so this
                    will always return one item.
                #>
                $currentStatePermissionForState = $currentState.Permission |
                    Where-Object -FilterScript {
                        $_.State -eq $desiredExcludePermission.State
                    }

                $currentStatePermissionToExclude = [DatabasePermission] @{
                    State      = $desiredExcludePermission.State
                    Permission = @()
                }

                foreach ($desiredExcludedPermissionName in $desiredExcludePermission.Permission)
                {
                    if ($currentStatePermissionForState.Permission -contains $desiredExcludedPermissionName)
                    {
                        Write-Verbose -Message (
                            $this.localizedData.DesiredAbsentPermissionArePresent -f @(
                                $desiredExcludedPermissionName
                            )
                        )
                    }
                    else
                    {
                        <#
                            If the permission does _not_ exist in the current state, add
                            the permission to $currentState.PermissionToExclude so that
                            the base class's method Compare() sees the property as being
                            in desired state (when the property PermissionToExclude in
                            the current state and desired state are equal).
                        #>
                        $currentStatePermissionToExclude.Permission += $desiredExcludedPermissionName
                    }
                }

                [DatabasePermission[]] $currentState.PermissionToExclude += $currentStatePermissionToExclude
            }
        }

        return $currentState
    }

    <#
        Base method Set() call this method with the properties that should be
        enforced are not in desired state. It is not called if all properties
        are in desired state. The variable $properties contain the properties
        that are not in desired state.
    #>
    hidden [void] Modify([System.Collections.Hashtable] $properties)
    {
        $serverObject = $this.GetServerObject()

        $testSqlDscIsDatabasePrincipalParameters = @{
            ServerObject      = $serverObject
            DatabaseName      = $this.DatabaseName
            Name              = $this.Name
            ExcludeFixedRoles = $true
        }

        # This will test wether the database and the principal exist.
        $isDatabasePrincipal = Test-SqlDscIsDatabasePrincipal @testSqlDscIsDatabasePrincipalParameters

        if (-not $isDatabasePrincipal)
        {
            $missingPrincipalMessage = $this.localizedData.NameIsMissing -f @(
                $this.Name,
                $this.DatabaseName,
                $this.InstanceName
            )

            New-InvalidOperationException -Message $missingPrincipalMessage
        }

        # This holds each state and their permissions to be revoked.
        [DatabasePermission[]] $permissionsToRevoke = @()
        [DatabasePermission[]] $permissionsToGrantOrDeny = @()

        if ($properties.ContainsKey('Permission'))
        {
            $keyProperty = $this | Get-DscProperty -Type 'Key'

            $currentState = $this.GetCurrentState($keyProperty)

            <#
                Evaluate if there are any permissions that should be revoked
                from the current state.
            #>
            foreach ($currentDesiredPermissionState in $properties.Permission)
            {
                $currentPermissionsForState = $currentState.Permission |
                    Where-Object -FilterScript {
                        $_.State -eq $currentDesiredPermissionState.State
                    }

                foreach ($permissionName in $currentPermissionsForState.Permission)
                {
                    if ($permissionName -notin $currentDesiredPermissionState.Permission)
                    {
                        # Look for an existing object in the array.
                        $updatePermissionToRevoke = $permissionsToRevoke |
                            Where-Object -FilterScript {
                                $_.State -eq $currentDesiredPermissionState.State
                            }

                        # Update the existing object in the array, or create a new object
                        if ($updatePermissionToRevoke)
                        {
                            $updatePermissionToRevoke.Permission += $permissionName
                        }
                        else
                        {
                            [DatabasePermission[]] $permissionsToRevoke += [DatabasePermission] @{
                                State      = $currentPermissionsForState.State
                                Permission = $permissionName
                            }
                        }
                    }
                }
            }

            <#
                At least one permission were missing or should have not be present
                in the current state. Grant or Deny all permission assigned to the
                property Permission regardless if they were already present or not.
            #>
            [DatabasePermission[]] $permissionsToGrantOrDeny = $properties.Permission
        }

        if ($properties.ContainsKey('PermissionToExclude'))
        {
            <#
                At least one permission were present in the current state. Revoke
                all permission assigned to the property PermissionToExclude
                regardless if they were already revoked or not.
            #>
            [DatabasePermission[]] $permissionsToRevoke = $properties.PermissionToExclude
        }

        if ($properties.ContainsKey('PermissionToInclude'))
        {
            <#
                At least one permission were missing or should have not be present
                in the current state. Grant or Deny all permission assigned to the
                property Permission regardless if they were already present or not.
            #>
            [DatabasePermission[]] $permissionsToGrantOrDeny = $properties.PermissionToInclude
        }

        # Revoke all the permissions set in $permissionsToRevoke
        if ($permissionsToRevoke)
        {
            foreach ($currentStateToRevoke in $permissionsToRevoke)
            {
                $revokePermissionSet = $currentStateToRevoke | ConvertFrom-SqlDscDatabasePermission

                $setSqlDscDatabasePermissionParameters = @{
                    ServerObject = $serverObject
                    DatabaseName = $this.DatabaseName
                    Name         = $this.Name
                    Permission   = $revokePermissionSet
                    State        = 'Revoke'
                    Force        = $true
                }

                if ($currentStateToRevoke.State -eq 'GrantWithGrant')
                {
                    $setSqlDscDatabasePermissionParameters.WithGrant = $true
                }

                try
                {
                    Set-SqlDscDatabasePermission @setSqlDscDatabasePermissionParameters
                }
                catch
                {
                    $errorMessage = $this.localizedData.FailedToRevokePermissionFromCurrentState -f @(
                        $this.Name,
                        $this.DatabaseName
                    )

                    New-InvalidOperationException -Message $errorMessage -ErrorRecord $_
                }
            }
        }

        if ($permissionsToGrantOrDeny)
        {
            foreach ($currentDesiredPermissionState in $permissionsToGrantOrDeny)
            {
                # If there is not an empty array, change permissions.
                if (-not [System.String]::IsNullOrEmpty($currentDesiredPermissionState.Permission))
                {
                    $permissionSet = $currentDesiredPermissionState | ConvertFrom-SqlDscDatabasePermission

                    $setSqlDscDatabasePermissionParameters = @{
                        ServerObject = $serverObject
                        DatabaseName = $this.DatabaseName
                        Name         = $this.Name
                        Permission   = $permissionSet
                        Force        = $true
                    }

                    try
                    {
                        switch ($currentDesiredPermissionState.State)
                        {
                            'GrantWithGrant'
                            {
                                Set-SqlDscDatabasePermission @setSqlDscDatabasePermissionParameters -State 'Grant' -WithGrant
                            }

                            default
                            {
                                Set-SqlDscDatabasePermission @setSqlDscDatabasePermissionParameters -State $currentDesiredPermissionState.State
                            }
                        }
                    }
                    catch
                    {
                        $errorMessage = $this.localizedData.FailedToSetPermission -f @(
                            $this.Name,
                            $this.DatabaseName
                        )

                        New-InvalidOperationException -Message $errorMessage -ErrorRecord $_
                    }
                }
            }
        }
    }

    <#
        Base method Assert() call this method with the properties that was assigned
        a value.
    #>
    hidden [void] AssertProperties([System.Collections.Hashtable] $properties)
    {
        # PermissionToInclude and PermissionToExclude should be mutually exclusive from Permission
        $assertBoundParameterParameters = @{
            BoundParameterList     = $properties
            MutuallyExclusiveList1 = @(
                'Permission'
            )
            MutuallyExclusiveList2 = @(
                'PermissionToInclude'
                'PermissionToExclude'
            )
        }

        Assert-BoundParameter @assertBoundParameterParameters

        # Get all assigned permission properties.
        $assignedPermissionProperty = $properties.Keys.Where({
                $_ -in @(
                    'Permission',
                    'PermissionToInclude',
                    'PermissionToExclude'
                )
            })

        # Must include either of the permission properties.
        if ([System.String]::IsNullOrEmpty($assignedPermissionProperty))
        {
            $errorMessage = $this.localizedData.MustAssignOnePermissionProperty

            New-InvalidArgumentException -ArgumentName 'Permission, PermissionToInclude, PermissionToExclude' -Message $errorMessage
        }

        foreach ($currentAssignedPermissionProperty in $assignedPermissionProperty)
        {
            # One State cannot exist several times in the same resource instance.
            $permissionStateGroupCount = @(
                $properties.$currentAssignedPermissionProperty |
                    Group-Object -NoElement -Property 'State' -CaseSensitive:$false |
                    Select-Object -ExpandProperty 'Count'
            )

            if ($permissionStateGroupCount -gt 1)
            {
                $errorMessage = $this.localizedData.DuplicatePermissionState

                New-InvalidArgumentException -ArgumentName $currentAssignedPermissionProperty -Message $errorMessage
            }

            # A specific permission must only exist in one permission state.
            $permissionGroupCount = $properties.$currentAssignedPermissionProperty.Permission |
                Group-Object -NoElement -CaseSensitive:$false |
                Select-Object -ExpandProperty 'Count'

            if ($permissionGroupCount -gt 1)
            {
                $errorMessage = $this.localizedData.DuplicatePermissionBetweenState

                New-InvalidArgumentException -ArgumentName $currentAssignedPermissionProperty -Message $errorMessage
            }
        }

        if ($properties.Keys -contains 'Permission')
        {
            # Each State must exist once.
            $missingPermissionState = (
                $properties.Permission.State -notcontains 'Grant' -or
                $properties.Permission.State -notcontains 'GrantWithGrant' -or
                $properties.Permission.State -notcontains 'Deny'
            )

            if ($missingPermissionState)
            {
                $errorMessage = $this.localizedData.MissingPermissionState

                New-InvalidArgumentException -ArgumentName 'Permission' -Message $errorMessage
            }
        }

        <#
            Each permission state in the properties PermissionToInclude and PermissionToExclude
            must have specified at minimum one permission.
        #>
        foreach ($currentAssignedPermissionProperty in @('PermissionToInclude', 'PermissionToExclude'))
        {
            if ($properties.Keys -contains $currentAssignedPermissionProperty)
            {
                foreach ($currentDatabasePermission in $properties.$currentAssignedPermissionProperty)
                {
                    if ($currentDatabasePermission.Permission.Count -eq 0)
                    {
                        $errorMessage = $this.localizedData.MustHaveMinimumOnePermissionInState -f $currentAssignedPermissionProperty

                        New-InvalidArgumentException -ArgumentName $currentAssignedPermissionProperty -Message $errorMessage
                    }
                }
            }
        }
    }
}
#EndRegion './Classes/020.SqlDatabasePermission.ps1' 646
#Region './Classes/020.SqlPermission.ps1' 0
<#
    .SYNOPSIS
        The `SqlPermission` DSC resource is used to grant, deny or revoke
        server permissions for a login.

    .DESCRIPTION
        The `SqlPermission` DSC resource is used to grant, deny or revoke
        Server permissions for a login. For more information about permissions,
        please read the article [Permissions (Database Engine)](https://docs.microsoft.com/en-us/sql/relational-databases/security/permissions-database-engine).

        >**Note:** When revoking permission with PermissionState 'GrantWithGrant', both the
        >grantee and _all the other users the grantee has granted the same permission to_,
        >will also get their permission revoked.

        ## Requirements

        * Target machine must be running Windows Server 2012 or later.
        * Target machine must be running SQL Server Database Engine 2012 or later.
        * Target machine must have access to the SQLPS PowerShell module or the SqlServer
          PowerShell module.

        ## Known issues

        All issues are not listed here, see [here for all open issues](https://github.com/dsccommunity/SqlServerDsc/issues?q=is%3Aissue+is%3Aopen+in%3Atitle+SqlPermission).

        ### `PSDscRunAsCredential` not supported

        The built-in property `PSDscRunAsCredential` does not work with class-based
        resources that using advanced type like the parameters `Permission` and
        `Reasons` has. Use the parameter `Credential` instead of `PSDscRunAsCredential`.

        ### Using `Credential` property.

        SQL Authentication and Group Managed Service Accounts is not supported as
        impersonation credentials. Currently only Windows Integrated Security is
        supported to use as credentials.

        For Windows Authentication the username must either be provided with the User
        Principal Name (UPN), e.g. 'username@domain.local' or if using non-domain
        (for example a local Windows Server account) account the username must be
        provided without the NetBIOS name, e.g. 'username'. The format 'DOMAIN\username'
        will not work.

        See more information in [Credential Overview](https://github.com/dsccommunity/SqlServerDsc/wiki/CredentialOverview).

        ### Invalid values during compilation

        The parameter Permission is of type `[ServerPermission]`. If a property
        in the type is set to an invalid value an error will occur, correct the
        values in the properties to valid values.
        This happens when the values are validated against the `[ValidateSet()]`
        of the resource. When there is an invalid value the following error will
        be thrown when the configuration is run (it will not show during compilation):

        ```plaintext
        Failed to create an object of PowerShell class SqlPermission.
            + CategoryInfo          : InvalidOperation: (root/Microsoft/...ConfigurationManager:String) [], CimException
            + FullyQualifiedErrorId : InstantiatePSClassObjectFailed
            + PSComputerName        : localhost
        ```

    .PARAMETER Name
        The name of the user that should be granted or denied the permission.

    .PARAMETER Permission
        An array of server permissions to enforce. Any permission that is not
        part of the desired state will be revoked.

        Must provide all permission states (`Grant`, `Deny`, `GrantWithGrant`) with
        at least an empty string array for the advanced type `ServerPermission`'s
        property `Permission`.

        Valid permission names can be found in the article [ServerPermissionSet Class properties](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sqlserver.management.smo.serverpermissionset#properties).

        This is an array of CIM instances of advanced type `ServerPermission` from
        the namespace `root/Microsoft/Windows/DesiredStateConfiguration`.

    .PARAMETER PermissionToInclude
        An array of server permissions to include to the current state. The
        current state will not be affected unless the current state contradict the
        desired state. For example if the desired state specifies a deny permissions
        but in the current state that permission is granted, that permission will
        be changed to be denied.

        Valid permission names can be found in the article [ServerPermissionSet Class properties](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sqlserver.management.smo.serverpermissionset#properties).

        This is an array of CIM instances of advanced type `ServerPermission` from
        the namespace `root/Microsoft/Windows/DesiredStateConfiguration`.

    .PARAMETER PermissionToExclude
        An array of server permissions to exclude (revoke) from the current state.

        Valid permission names can be found in the article [ServerPermissionSet Class properties](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sqlserver.management.smo.serverpermissionset#properties).

        This is an array of CIM instances of advanced type `ServerPermission` from
        the namespace `root/Microsoft/Windows/DesiredStateConfiguration`.

    .EXAMPLE
        Invoke-DscResource -ModuleName SqlServerDsc -Name SqlPermission -Method Get -Property @{
            ServerName           = 'localhost'
            InstanceName         = 'SQL2017'
            Credential           = (Get-Credential -UserName 'myuser@company.local' -Message 'Password:')
            Name                 = 'INSTANCE\SqlUser'
            Permission           = [Microsoft.Management.Infrastructure.CimInstance[]] @(
                (
                    New-CimInstance -ClientOnly -Namespace root/Microsoft/Windows/DesiredStateConfiguration -ClassName ServerPermission -Property @{
                            State = 'Grant'
                            Permission = @('select')
                    }
                )
                (
                    New-CimInstance -ClientOnly -Namespace root/Microsoft/Windows/DesiredStateConfiguration -ClassName ServerPermission -Property @{
                        State = 'GrantWithGrant'
                        Permission = [System.String[]] @()
                    }
                )
                (
                    New-CimInstance -ClientOnly -Namespace root/Microsoft/Windows/DesiredStateConfiguration -ClassName ServerPermission -Property @{
                        State = 'Deny'
                        Permission = [System.String[]] @()
                    }
                )
            )
        }

        This example shows how to call the resource using Invoke-DscResource.

    .NOTES
        The built-in property `PsDscRunAsCredential` is not supported on this DSC
        resource as it uses a complex type (another class as the type for a DSC
        property). If the property `PsDscRunAsCredential` would be used, then the
        complex type will not return any values from Get(). This is most likely an
        issue (bug) with _PowerShell DSC_. Instead (as a workaround) the property
        `Credential` must be used to specify how to connect to the SQL Server
        instance.
#>

[DscResource(RunAsCredential = 'NotSupported')]
class SqlPermission : SqlResourceBase
{
    [DscProperty(Key)]
    [System.String]
    $Name

    [DscProperty()]
    [ServerPermission[]]
    $Permission

    [DscProperty()]
    [ServerPermission[]]
    $PermissionToInclude

    [DscProperty()]
    [ServerPermission[]]
    $PermissionToExclude

    SqlPermission() : base ()
    {
        # These properties will not be enforced.
        $this.ExcludeDscProperties = @(
            'ServerName'
            'InstanceName'
            'Name'
            'Credential'
        )
    }

    [SqlPermission] Get()
    {
        # Call the base method to return the properties.
        return ([ResourceBase] $this).Get()
    }

    [System.Boolean] Test()
    {
        # Call the base method to test all of the properties that should be enforced.
        return ([ResourceBase] $this).Test()
    }

    [void] Set()
    {
        # Call the base method to enforce the properties.
        ([ResourceBase] $this).Set()
    }

    <#
        Base method Get() call this method to get the current state as a hashtable.
        The parameter properties will contain the key properties.
    #>
    hidden [System.Collections.Hashtable] GetCurrentState([System.Collections.Hashtable] $properties)
    {
        $currentStateCredential = $null

        if ($this.Credential)
        {
            <#
                This does not work, even if username is set, the method Get() will
                return an empty PSCredential-object. Kept it here so it at least
                return a Credential object.
            #>
            $currentStateCredential = [PSCredential]::new(
                $this.Credential.UserName,
                [SecureString]::new()
            )
        }

        $currentState = @{
            Credential = $currentStateCredential
            Permission = [ServerPermission[]] @()
        }

        Write-Verbose -Message (
            $this.localizedData.EvaluateServerPermissionForPrincipal -f @(
                $properties.Name,
                $properties.InstanceName
            )
        )

        $serverObject = $this.GetServerObject()

        $serverPermissionInfo = $serverObject |
            Get-SqlDscServerPermission -Name $this.Name -ErrorAction 'SilentlyContinue'

        # If permissions was returned, build the current permission array of [ServerPermission].
        if ($serverPermissionInfo)
        {
            [ServerPermission[]] $currentState.Permission = $serverPermissionInfo | ConvertTo-SqlDscServerPermission
        }

        # Always return all State; 'Grant', 'GrantWithGrant', and 'Deny'.
        foreach ($currentPermissionState in @('Grant', 'GrantWithGrant', 'Deny'))
        {
            if ($currentState.Permission.State -notcontains $currentPermissionState)
            {
                [ServerPermission[]] $currentState.Permission += [ServerPermission] @{
                    State      = $currentPermissionState
                    Permission = @()
                }
            }
        }

        $isPropertyPermissionToIncludeAssigned = $this | Test-ResourceDscPropertyIsAssigned -Name 'PermissionToInclude'

        if ($isPropertyPermissionToIncludeAssigned)
        {
            $currentState.PermissionToInclude = [ServerPermission[]] @()

            # Evaluate so that the desired state is present in the current state.
            foreach ($desiredIncludePermission in $this.PermissionToInclude)
            {
                <#
                    Current state will always have all possible states, so this
                    will always return one item.
                #>
                $currentStatePermissionForState = $currentState.Permission |
                    Where-Object -FilterScript {
                        $_.State -eq $desiredIncludePermission.State
                    }

                $currentStatePermissionToInclude = [ServerPermission] @{
                    State      = $desiredIncludePermission.State
                    Permission = @()
                }

                foreach ($desiredIncludePermissionName in $desiredIncludePermission.Permission)
                {
                    if ($currentStatePermissionForState.Permission -contains $desiredIncludePermissionName)
                    {
                        <#
                            If the permission exist in the current state, add the
                            permission to $currentState.PermissionToInclude so that
                            the base class's method Compare() sees the property as
                            being in desired state (when the property PermissionToInclude
                            in the current state and desired state are equal).
                        #>
                        $currentStatePermissionToInclude.Permission += $desiredIncludePermissionName
                    }
                    else
                    {
                        Write-Verbose -Message (
                            $this.localizedData.DesiredPermissionAreAbsent -f @(
                                $desiredIncludePermissionName
                            )
                        )
                    }
                }

                [ServerPermission[]] $currentState.PermissionToInclude += $currentStatePermissionToInclude
            }
        }

        $isPropertyPermissionToExcludeAssigned = $this | Test-ResourceDscPropertyIsAssigned -Name 'PermissionToExclude'

        if ($isPropertyPermissionToExcludeAssigned)
        {
            $currentState.PermissionToExclude = [ServerPermission[]] @()

            # Evaluate so that the desired state is missing from the current state.
            foreach ($desiredExcludePermission in $this.PermissionToExclude)
            {
                <#
                    Current state will always have all possible states, so this
                    will always return one item.
                #>
                $currentStatePermissionForState = $currentState.Permission |
                    Where-Object -FilterScript {
                        $_.State -eq $desiredExcludePermission.State
                    }

                $currentStatePermissionToExclude = [ServerPermission] @{
                    State      = $desiredExcludePermission.State
                    Permission = @()
                }

                foreach ($desiredExcludedPermissionName in $desiredExcludePermission.Permission)
                {
                    if ($currentStatePermissionForState.Permission -contains $desiredExcludedPermissionName)
                    {
                        Write-Verbose -Message (
                            $this.localizedData.DesiredAbsentPermissionArePresent -f @(
                                $desiredExcludedPermissionName
                            )
                        )
                    }
                    else
                    {
                        <#
                            If the permission does _not_ exist in the current state, add
                            the permission to $currentState.PermissionToExclude so that
                            the base class's method Compare() sees the property as being
                            in desired state (when the property PermissionToExclude in
                            the current state and desired state are equal).
                        #>
                        $currentStatePermissionToExclude.Permission += $desiredExcludedPermissionName
                    }
                }

                [ServerPermission[]] $currentState.PermissionToExclude += $currentStatePermissionToExclude
            }
        }

        return $currentState
    }

    <#
        Base method Set() call this method with the properties that should be
        enforced are not in desired state. It is not called if all properties
        are in desired state. The variable $properties contain the properties
        that are not in desired state.
    #>
    hidden [void] Modify([System.Collections.Hashtable] $properties)
    {
        $serverObject = $this.GetServerObject()

        $testSqlDscIsLoginParameters = @{
            ServerObject      = $serverObject
            Name              = $this.Name
        }

        # This will test wether the principal exist.
        $isLogin = Test-SqlDscIsLogin @testSqlDscIsLoginParameters

        if (-not $isLogin)
        {
            $missingPrincipalMessage = $this.localizedData.NameIsMissing -f @(
                $this.Name,
                $this.InstanceName
            )

            New-InvalidOperationException -Message $missingPrincipalMessage
        }

        # This holds each state and their permissions to be revoked.
        [ServerPermission[]] $permissionsToRevoke = @()
        [ServerPermission[]] $permissionsToGrantOrDeny = @()

        if ($properties.ContainsKey('Permission'))
        {
            $keyProperty = $this | Get-DscProperty -Type 'Key'

            $currentState = $this.GetCurrentState($keyProperty)

            <#
                Evaluate if there are any permissions that should be revoked
                from the current state.
            #>
            foreach ($currentDesiredPermissionState in $properties.Permission)
            {
                $currentPermissionsForState = $currentState.Permission |
                    Where-Object -FilterScript {
                        $_.State -eq $currentDesiredPermissionState.State
                    }

                foreach ($permissionName in $currentPermissionsForState.Permission)
                {
                    if ($permissionName -notin $currentDesiredPermissionState.Permission)
                    {
                        # Look for an existing object in the array.
                        $updatePermissionToRevoke = $permissionsToRevoke |
                            Where-Object -FilterScript {
                                $_.State -eq $currentDesiredPermissionState.State
                            }

                        # Update the existing object in the array, or create a new object
                        if ($updatePermissionToRevoke)
                        {
                            $updatePermissionToRevoke.Permission += $permissionName
                        }
                        else
                        {
                            [ServerPermission[]] $permissionsToRevoke += [ServerPermission] @{
                                State      = $currentPermissionsForState.State
                                Permission = $permissionName
                            }
                        }
                    }
                }
            }

            <#
                At least one permission were missing or should have not be present
                in the current state. Grant or Deny all permission assigned to the
                property Permission regardless if they were already present or not.
            #>
            [ServerPermission[]] $permissionsToGrantOrDeny = $properties.Permission
        }

        if ($properties.ContainsKey('PermissionToExclude'))
        {
            <#
                At least one permission were present in the current state. Revoke
                all permission assigned to the property PermissionToExclude
                regardless if they were already revoked or not.
            #>
            [ServerPermission[]] $permissionsToRevoke = $properties.PermissionToExclude
        }

        if ($properties.ContainsKey('PermissionToInclude'))
        {
            <#
                At least one permission were missing or should have not be present
                in the current state. Grant or Deny all permission assigned to the
                property Permission regardless if they were already present or not.
            #>
            [ServerPermission[]] $permissionsToGrantOrDeny = $properties.PermissionToInclude
        }

        # Revoke all the permissions set in $permissionsToRevoke
        if ($permissionsToRevoke)
        {
            <#
                TODO: Could verify with $sqlServerObject.EnumServerPermissions($Principal, $desiredPermissionSet)
                      which permissions are not already revoked.
            #>
            foreach ($currentStateToRevoke in $permissionsToRevoke)
            {
                $revokePermissionSet = $currentStateToRevoke | ConvertFrom-SqlDscServerPermission

                $setSqlDscServerPermissionParameters = @{
                    ServerObject = $serverObject
                    Name         = $this.Name
                    Permission   = $revokePermissionSet
                    State        = 'Revoke'
                    Force        = $true
                }

                if ($currentStateToRevoke.State -eq 'GrantWithGrant')
                {
                    $setSqlDscServerPermissionParameters.WithGrant = $true
                }

                try
                {
                    Set-SqlDscServerPermission @setSqlDscServerPermissionParameters
                }
                catch
                {
                    $errorMessage = $this.localizedData.FailedToRevokePermissionFromCurrentState -f @(
                        $this.Name
                    )

                    New-InvalidOperationException -Message $errorMessage -ErrorRecord $_
                }
            }
        }

        if ($permissionsToGrantOrDeny)
        {
            <#
                TODO: Could verify with $sqlServerObject.EnumServerPermissions($Principal, $desiredPermissionSet)
                      which permissions are not already set.
            #>
            foreach ($currentDesiredPermissionState in $permissionsToGrantOrDeny)
            {
                # If there is not an empty array, change permissions.
                if (-not [System.String]::IsNullOrEmpty($currentDesiredPermissionState.Permission))
                {
                    $permissionSet = $currentDesiredPermissionState | ConvertFrom-SqlDscServerPermission

                    $setSqlDscServerPermissionParameters = @{
                        ServerObject = $serverObject
                        Name         = $this.Name
                        Permission   = $permissionSet
                        Force        = $true
                    }

                    try
                    {
                        switch ($currentDesiredPermissionState.State)
                        {
                            'GrantWithGrant'
                            {
                                Set-SqlDscServerPermission @setSqlDscServerPermissionParameters -State 'Grant' -WithGrant
                            }

                            default
                            {
                                Set-SqlDscServerPermission @setSqlDscServerPermissionParameters -State $currentDesiredPermissionState.State
                            }
                        }
                    }
                    catch
                    {
                        $errorMessage = $this.localizedData.FailedToSetPermission -f @(
                            $this.Name
                        )

                        New-InvalidOperationException -Message $errorMessage -ErrorRecord $_
                    }
                }
            }
        }
    }

    <#
        Base method Assert() call this method with the properties that was assigned
        a value.
    #>
    hidden [void] AssertProperties([System.Collections.Hashtable] $properties)
    {
        # PermissionToInclude and PermissionToExclude should be mutually exclusive from Permission
        $assertBoundParameterParameters = @{
            BoundParameterList     = $properties
            MutuallyExclusiveList1 = @(
                'Permission'
            )
            MutuallyExclusiveList2 = @(
                'PermissionToInclude'
                'PermissionToExclude'
            )
        }

        Assert-BoundParameter @assertBoundParameterParameters

        # Get all assigned permission properties.
        $assignedPermissionProperty = $properties.Keys.Where({
                $_ -in @(
                    'Permission',
                    'PermissionToInclude',
                    'PermissionToExclude'
                )
            })

        # Must include either of the permission properties.
        if ([System.String]::IsNullOrEmpty($assignedPermissionProperty))
        {
            $errorMessage = $this.localizedData.MustAssignOnePermissionProperty

            New-InvalidArgumentException -ArgumentName 'Permission, PermissionToInclude, PermissionToExclude' -Message $errorMessage
        }

        foreach ($currentAssignedPermissionProperty in $assignedPermissionProperty)
        {
            # One State cannot exist several times in the same resource instance.
            $permissionStateGroupCount = @(
                $properties.$currentAssignedPermissionProperty |
                    Group-Object -NoElement -Property 'State' -CaseSensitive:$false |
                    Select-Object -ExpandProperty 'Count'
            )

            if ($permissionStateGroupCount -gt 1)
            {
                $errorMessage = $this.localizedData.DuplicatePermissionState

                New-InvalidArgumentException -ArgumentName $currentAssignedPermissionProperty -Message $errorMessage
            }

            # A specific permission must only exist in one permission state.
            $permissionGroupCount = $properties.$currentAssignedPermissionProperty.Permission |
                Group-Object -NoElement -CaseSensitive:$false |
                Select-Object -ExpandProperty 'Count'

            if ($permissionGroupCount -gt 1)
            {
                $errorMessage = $this.localizedData.DuplicatePermissionBetweenState

                New-InvalidArgumentException -ArgumentName $currentAssignedPermissionProperty -Message $errorMessage
            }
        }

        if ($properties.Keys -contains 'Permission')
        {
            # Each State must exist once.
            $missingPermissionState = (
                $properties.Permission.State -notcontains 'Grant' -or
                $properties.Permission.State -notcontains 'GrantWithGrant' -or
                $properties.Permission.State -notcontains 'Deny'
            )

            if ($missingPermissionState)
            {
                $errorMessage = $this.localizedData.MissingPermissionState

                New-InvalidArgumentException -ArgumentName 'Permission' -Message $errorMessage
            }
        }

        <#
            Each permission state in the properties PermissionToInclude and PermissionToExclude
            must have specified at minimum one permission.
        #>
        foreach ($currentAssignedPermissionProperty in @('PermissionToInclude', 'PermissionToExclude'))
        {
            if ($properties.Keys -contains $currentAssignedPermissionProperty)
            {
                foreach ($currentServerPermission in $properties.$currentAssignedPermissionProperty)
                {
                    if ($currentServerPermission.Permission.Count -eq 0)
                    {
                        $errorMessage = $this.localizedData.MustHaveMinimumOnePermissionInState -f $currentAssignedPermissionProperty

                        New-InvalidArgumentException -ArgumentName $currentAssignedPermissionProperty -Message $errorMessage
                    }
                }
            }
        }
    }
}
#EndRegion './Classes/020.SqlPermission.ps1' 639
#Region './Private/ConvertFrom-CompareResult.ps1' 0
<#
    .SYNOPSIS
        Returns a hashtable with property name and their expected value.

    .PARAMETER CompareResult
       The result from Compare-DscParameterState.

    .EXAMPLE
        ConvertFrom-CompareResult -CompareResult (Compare-DscParameterState)

        Returns a hashtable that contain all the properties not in desired state
        and their expected value.

    .OUTPUTS
        [System.Collections.Hashtable]
#>
function ConvertFrom-CompareResult
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [System.Collections.Hashtable[]]
        $CompareResult
    )

    begin
    {
        $returnHashtable = @{}
    }

    process
    {
        $CompareResult | ForEach-Object -Process {
            $returnHashtable[$_.Property] = $_.ExpectedValue
        }
    }

    end
    {
        return $returnHashtable
    }
}
#EndRegion './Private/ConvertFrom-CompareResult.ps1' 45
#Region './Private/ConvertTo-Reason.ps1' 0
<#
    .SYNOPSIS
        Returns a array of the type `[Reason]`.

    .DESCRIPTION
        This command converts the array of properties that is returned by the command
        `Compare-DscParameterState`. The result is an array of the type `[Reason]` that
        can be returned in a DSC resource's property **Reasons**.

    .PARAMETER Property
       The result from the command Compare-DscParameterState.

    .PARAMETER ResourceName
       The name of the resource. Will be used to populate the property Code with
       the correct value.

    .EXAMPLE
        ConvertTo-Reason -Property (Compare-DscParameterState) -ResourceName 'MyResource'

        Returns an array of `[Reason]` that contain all the properties not in desired
        state and why a specific property is not in desired state.

    .OUTPUTS
        [Reason[]]
#>
function ConvertTo-Reason
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when the output type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [CmdletBinding()]
    [OutputType([Reason[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowEmptyCollection()]
        [AllowNull()]
        [System.Collections.Hashtable[]]
        $Property,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceName
    )

    begin
    {
        # Always return an empty array if there are no properties to add.
        $reasons = [Reason[]] @()
    }

    process
    {
        foreach ($currentProperty in $Property)
        {
            if ($currentProperty.ExpectedValue -is [System.Enum])
            {
                # Return the string representation of the value (instead of the numeric value).
                $propertyExpectedValue = $currentProperty.ExpectedValue.ToString()
            }
            else
            {
                $propertyExpectedValue = $currentProperty.ExpectedValue
            }

            if ($property.ActualValue -is [System.Enum])
            {
                # Return the string representation of the value so that conversion to json is correct.
                $propertyActualValue = $currentProperty.ActualValue.ToString()
            }
            else
            {
                $propertyActualValue = $currentProperty.ActualValue
            }

            <#
                In PowerShell 7 the command ConvertTo-Json returns 'null' on null
                value, but not in Windows PowerShell. Switch to output empty string
                if value is null.
            #>
            if ($PSVersionTable.PSEdition -eq 'Desktop')
            {
                if ($null -eq $propertyExpectedValue)
                {
                    $propertyExpectedValue = ''
                }

                if ($null -eq $propertyActualValue)
                {
                    $propertyActualValue = ''
                }
            }

            # Convert the value to Json to be able to easily visualize complex types
            $propertyActualValueJson = $propertyActualValue | ConvertTo-Json -Compress
            $propertyExpectedValueJson = $propertyExpectedValue | ConvertTo-Json -Compress

            # If the property name contain the word Path, remove '\\' from path.
            if ($currentProperty.Property -match 'Path')
            {
                $propertyActualValueJson = $propertyActualValueJson -replace '\\\\', '\'
                $propertyExpectedValueJson = $propertyExpectedValueJson -replace '\\\\', '\'
            }

            $reasons += [Reason] @{
                Code   = '{0}:{0}:{1}' -f $ResourceName, $currentProperty.Property
                # Convert the object to JSON to handle complex types.
                Phrase = 'The property {0} should be {1}, but was {2}' -f @(
                    $currentProperty.Property,
                    $propertyExpectedValueJson,
                    $propertyActualValueJson
                )
            }
        }
    }

    end
    {
        return $reasons
    }
}
#EndRegion './Private/ConvertTo-Reason.ps1' 120
#Region './Private/Get-ClassName.ps1' 0
<#
    .SYNOPSIS
        Get the class name of the passed object, and optional an array with
        all inherited classes.

    .PARAMETER InputObject
       The object to be evaluated.

    .PARAMETER Recurse
       Specifies if the class name of inherited classes shall be returned. The
       recursive stops when the first object of the type `[System.Object]` is
       found.

    .EXAMPLE
        Get-ClassName -InputObject $this -Recurse

        Get the class name of the current instance and all the inherited (parent)
        classes.

    .OUTPUTS
        [System.String[]]
#>
function Get-ClassName
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '', Justification = 'Because the rule does not understands that the command returns [System.String[]] when using , (comma) in the return statement')]
    [CmdletBinding()]
    [OutputType([System.String[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSObject]
        $InputObject,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Recurse
    )

    # Create a list of the inherited class names
    $class = @($InputObject.GetType().FullName)

    if ($Recurse.IsPresent)
    {
        $parentClass = $InputObject.GetType().BaseType

        while ($parentClass -ne [System.Object])
        {
            $class += $parentClass.FullName

            $parentClass = $parentClass.BaseType
        }
    }

    return , [System.String[]] $class
}
#EndRegion './Private/Get-ClassName.ps1' 56
#Region './Private/Get-DscProperty.ps1' 0

<#
    .SYNOPSIS
        Returns DSC resource properties that is part of a class-based DSC resource.

    .DESCRIPTION
        Returns DSC resource properties that is part of a class-based DSC resource.
        The properties can be filtered using name, type, or has been assigned a value.

    .PARAMETER InputObject
        The object that contain one or more key properties.

    .PARAMETER Name
        Specifies one or more property names to return. If left out all properties
        are returned.

    .PARAMETER Type
        Specifies one or more property types to return. If left out all property
        types are returned.

    .PARAMETER HasValue
        Specifies to return only properties that has been assigned a non-null value.
        If left out all properties are returned regardless if there is a value
        assigned or not.

    .EXAMPLE
        Get-DscProperty -InputObject $this

        Returns all DSC resource properties of the DSC resource.

    .EXAMPLE
        Get-DscProperty -InputObject $this -Name @('MyProperty1', 'MyProperty2')

        Returns the specified DSC resource properties names of the DSC resource.

    .EXAMPLE
        Get-DscProperty -InputObject $this -Type @('Mandatory', 'Optional')

        Returns the specified DSC resource property types of the DSC resource.

    .EXAMPLE
        Get-DscProperty -InputObject $this -Type @('Optional') -HasValue

        Returns the specified DSC resource property types of the DSC resource,
        but only those properties that has been assigned a non-null value.

    .OUTPUTS
        [System.Collections.Hashtable]
#>
function Get-DscProperty
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSObject]
        $InputObject,

        [Parameter()]
        [System.String[]]
        $Name,

        [Parameter()]
        [System.String[]]
        $ExcludeName,

        [Parameter()]
        [ValidateSet('Key', 'Mandatory', 'NotConfigurable', 'Optional')]
        [System.String[]]
        $Type,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $HasValue
    )

    $property = $InputObject.PSObject.Properties.Name |
        Where-Object -FilterScript {
            <#
                Return all properties if $Name is not assigned, or if assigned
                just those properties.
            #>
            (-not $Name -or $_ -in $Name) -and

            <#
                Return all properties if $ExcludeName is not assigned. Skip
                property if it is included in $ExcludeName.
            #>
            (-not $ExcludeName -or ($_ -notin $ExcludeName)) -and

            # Only return the property if it is a DSC property.
            $InputObject.GetType().GetMember($_).CustomAttributes.Where(
                {
                    $_.AttributeType.Name -eq 'DscPropertyAttribute'
                }
            )
        }

    if (-not [System.String]::IsNullOrEmpty($property))
    {
        if ($PSBoundParameters.ContainsKey('Type'))
        {
            $propertiesOfType = @()

            $propertiesOfType += $property | Where-Object -FilterScript {
                $InputObject.GetType().GetMember($_).CustomAttributes.Where(
                    {
                        <#
                            To simplify the code, ignoring that this will compare
                            MemberNAme against type 'Optional' which does not exist.
                        #>
                        $_.NamedArguments.MemberName -in $Type
                    }
                ).NamedArguments.TypedValue.Value -eq $true
            }

            # Include all optional parameter if it was requested.
            if ($Type -contains 'Optional')
            {
                $propertiesOfType += $property | Where-Object -FilterScript {
                    $InputObject.GetType().GetMember($_).CustomAttributes.Where(
                        {
                            $_.NamedArguments.MemberName -notin @('Key', 'Mandatory', 'NotConfigurable')
                        }
                    )
                }
            }

            $property = $propertiesOfType
        }
    }

    # Return a hashtable containing each key property and its value.
    $getPropertyResult = @{}

    foreach ($currentProperty in $property)
    {
        if ($HasValue.IsPresent)
        {
            $isAssigned = Test-ResourceDscPropertyIsAssigned -Name $currentProperty -InputObject $InputObject

            if (-not $isAssigned)
            {
                continue
            }
        }

        $getPropertyResult.$currentProperty = $InputObject.$currentProperty
    }

    return $getPropertyResult
}
#EndRegion './Private/Get-DscProperty.ps1' 154
#Region './Private/Get-LocalizedDataRecursive.ps1' 0
<#
    .SYNOPSIS
        Get the localization strings data from one or more localization string files.
        This can be used in classes to be able to inherit localization strings
        from one or more parent (base) classes.

        The order of class names passed to parameter `ClassName` determines the order
        of importing localization string files. First entry's localization string file
        will be imported first, then next entry's localization string file, and so on.
        If the second (or any consecutive) entry's localization string file contain a
        localization string key that existed in a previous imported localization string
        file that localization string key will be ignored. Making it possible for a
        child class to override localization strings from one or more parent (base)
        classes.

    .PARAMETER ClassName
        An array of class names, normally provided by `Get-ClassName -Recurse`.

    .EXAMPLE
        Get-LocalizedDataRecursive -ClassName $InputObject.GetType().FullName

        Returns a hashtable containing all the localized strings for the current
        instance.

    .EXAMPLE
        Get-LocalizedDataRecursive -ClassName (Get-ClassNamn -InputObject $this -Recurse)

        Returns a hashtable containing all the localized strings for the current
        instance and any inherited (parent) classes.

    .OUTPUTS
        [System.Collections.Hashtable]
#>
function Get-LocalizedDataRecursive
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [System.String[]]
        $ClassName
    )

    begin
    {
        $localizedData = @{}
    }

    process
    {
        foreach ($name in $ClassName)
        {
            if ($name -match '\.psd1')
            {
                # Assume we got full file name.
                $localizationFileName = $name
            }
            else
            {
                # Assume we only got class name.
                $localizationFileName = '{0}.strings.psd1' -f $name
            }

            Write-Debug -Message ('Importing localization data from {0}' -f $localizationFileName)

            # Get localized data for the class
            $classLocalizationStrings = Get-LocalizedData -DefaultUICulture 'en-US' -FileName $localizationFileName -ErrorAction 'Stop'

            # Append only previously unspecified keys in the localization data
            foreach ($key in $classLocalizationStrings.Keys)
            {
                if (-not $localizedData.ContainsKey($key))
                {
                    $localizedData[$key] = $classLocalizationStrings[$key]
                }
            }
        }
    }

    end
    {
        Write-Debug -Message ('Localization data: {0}' -f ($localizedData | ConvertTo-JSON))

        return $localizedData
    }
}
#EndRegion './Private/Get-LocalizedDataRecursive.ps1' 88
#Region './Private/Test-ResourceDscPropertyIsAssigned.ps1' 0
<#
    .SYNOPSIS
        Tests whether the class-based resource property is assigned a non-null value.

    .DESCRIPTION
        Tests whether the class-based resource property is assigned a non-null value.

    .PARAMETER InputObject
        Specifies the object that contain the property.

    .PARAMETER Name
        Specifies the name of the property.

    .EXAMPLE
        Test-ResourceDscPropertyIsAssigned -InputObject $this -Name 'MyDscProperty'

        Returns $true or $false whether the property is assigned or not.

    .OUTPUTS
        [System.Boolean]
#>
function Test-ResourceDscPropertyIsAssigned
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSObject]
        $InputObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name
    )

    $isAssigned = -not ($null -eq $InputObject.$Name)

    return $isAssigned
}
#EndRegion './Private/Test-ResourceDscPropertyIsAssigned.ps1' 41
#Region './Private/Test-ResourceHasDscProperty.ps1' 0
<#
    .SYNOPSIS
        Tests whether the class-based resource has the specified property.

    .DESCRIPTION
        Tests whether the class-based resource has the specified property.

    .PARAMETER InputObject
        Specifies the object that should be tested for existens of the specified
        property.

    .PARAMETER Name
        Specifies the name of the property.

    .PARAMETER HasValue
        Specifies if the property should be evaluated to have a non-value. If
        the property exist but is assigned `$null` the command returns `$false`.

    .EXAMPLE
        Test-ResourceHasDscProperty -InputObject $this -Name 'MyDscProperty'

        Returns $true or $false whether the property exist or not.

    .EXAMPLE
        Test-ResourceHasDscProperty -InputObject $this -Name 'MyDscProperty' -HasValue

        Returns $true if the property exist and is assigned a non-null value, if not
        $false is returned.

    .OUTPUTS
        [System.Boolean]
#>
function Test-ResourceHasDscProperty
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [PSObject]
        $InputObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $HasValue
    )

    $hasProperty = $false

    $isDscProperty = (Get-DscProperty @PSBoundParameters).ContainsKey($Name)

    if ($isDscProperty)
    {
        $hasProperty = $true
    }

    return $hasProperty
}
#EndRegion './Private/Test-ResourceHasDscProperty.ps1' 63
#Region './Public/Connect-SqlDscDatabaseEngine.ps1' 0
<#
    .SYNOPSIS
        Connect to a SQL Server Database Engine and return the server object.

    .PARAMETER ServerName
        String containing the host name of the SQL Server to connect to.
        Default value is the current computer name.

    .PARAMETER InstanceName
        String containing the SQL Server Database Engine instance to connect to.
        Default value is 'MSSQLSERVER'.

    .PARAMETER Credential
        The credentials to use to impersonate a user when connecting to the
        SQL Server Database Engine instance. If this parameter is left out, then
        the current user will be used to connect to the SQL Server Database Engine
        instance using Windows Integrated authentication.

    .PARAMETER LoginType
        Specifies which type of logon credential should be used. The valid types
        are 'WindowsUser' or 'SqlLogin'. Default value is 'WindowsUser'
        If set to 'WindowsUser' then the it will impersonate using the Windows
        login specified in the parameter Credential.
        If set to 'WindowsUser' then the it will impersonate using the native SQL
        login specified in the parameter Credential.

    .PARAMETER StatementTimeout
        Set the query StatementTimeout in seconds. Default 600 seconds (10 minutes).

    .EXAMPLE
        Connect-SqlDscDatabaseEngine

        Connects to the default instance on the local server.

    .EXAMPLE
        Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'

        Connects to the instance 'MyInstance' on the local server.

    .EXAMPLE
        Connect-SqlDscDatabaseEngine -ServerName 'sql.company.local' -InstanceName 'MyInstance'

        Connects to the instance 'MyInstance' on the server 'sql.company.local'.

    .OUTPUTS
        None.
#>
function Connect-SqlDscDatabaseEngine
{
    [CmdletBinding(DefaultParameterSetName = 'SqlServer')]
    param
    (
        [Parameter(ParameterSetName = 'SqlServer')]
        [Parameter(ParameterSetName = 'SqlServerWithCredential')]
        [ValidateNotNull()]
        [System.String]
        $ServerName = (Get-ComputerName),

        [Parameter(ParameterSetName = 'SqlServer')]
        [Parameter(ParameterSetName = 'SqlServerWithCredential')]
        [ValidateNotNull()]
        [System.String]
        $InstanceName = 'MSSQLSERVER',

        [Parameter(ParameterSetName = 'SqlServerWithCredential', Mandatory = $true)]
        [ValidateNotNull()]
        [Alias('SetupCredential', 'DatabaseCredential')]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter(ParameterSetName = 'SqlServerWithCredential')]
        [ValidateSet('WindowsUser', 'SqlLogin')]
        [System.String]
        $LoginType = 'WindowsUser',

        [Parameter()]
        [ValidateNotNull()]
        [System.Int32]
        $StatementTimeout = 600
    )

    # Call the private function.
    return (Connect-Sql @PSBoundParameters)
}
#EndRegion './Public/Connect-SqlDscDatabaseEngine.ps1' 85
#Region './Public/ConvertFrom-SqlDscDatabasePermission.ps1' 0
<#
    .SYNOPSIS
        Converts a DatabasePermission object into an object of the type
        Microsoft.SqlServer.Management.Smo.DatabasePermissionSet.

    .PARAMETER Permission
        Specifies a DatabasePermission object.

    .EXAMPLE
        [DatabasePermission] @{
            State = 'Grant'
            Permission = 'Connect'
        } | ConvertFrom-SqlDscDatabasePermission

        Returns an object of `[Microsoft.SqlServer.Management.Smo.DatabasePermissionSet]`
        with all the permissions set to $true that was part of the `[DatabasePermission]`.

    .OUTPUTS
        [Microsoft.SqlServer.Management.Smo.DatabasePermissionSet]
#>
function ConvertFrom-SqlDscDatabasePermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when the output type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [CmdletBinding()]
    [OutputType([Microsoft.SqlServer.Management.Smo.DatabasePermissionSet])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [DatabasePermission]
        $Permission
    )

    begin
    {
        $permissionSet = New-Object -TypeName 'Microsoft.SqlServer.Management.Smo.DatabasePermissionSet'
    }

    process
    {
        foreach ($permissionName in $Permission.Permission)
        {
            $permissionSet.$permissionName = $true
        }
    }

    end
    {
        return $permissionSet
    }
}
#EndRegion './Public/ConvertFrom-SqlDscDatabasePermission.ps1' 51
#Region './Public/ConvertFrom-SqlDscServerPermission.ps1' 0
<#
    .SYNOPSIS
        Converts a ServerPermission object into an object of the type
        Microsoft.SqlServer.Management.Smo.ServerPermissionSet.

    .PARAMETER Permission
        Specifies a ServerPermission object.

    .EXAMPLE
        [ServerPermission] @{
            State = 'Grant'
            Permission = 'Connect'
        } | ConvertFrom-SqlDscServerPermission

        Returns an object of `[Microsoft.SqlServer.Management.Smo.ServerPermissionSet]`
        with all the permissions set to $true that was part of the `[ServerPermission]`.

    .OUTPUTS
        [Microsoft.SqlServer.Management.Smo.ServerPermissionSet]
#>
function ConvertFrom-SqlDscServerPermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when the output type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [CmdletBinding()]
    [OutputType([Microsoft.SqlServer.Management.Smo.ServerPermissionSet])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ServerPermission]
        $Permission
    )

    begin
    {
        $permissionSet = New-Object -TypeName 'Microsoft.SqlServer.Management.Smo.ServerPermissionSet'
    }

    process
    {
        foreach ($permissionName in $Permission.Permission)
        {
            $permissionSet.$permissionName = $true
        }
    }

    end
    {
        return $permissionSet
    }
}
#EndRegion './Public/ConvertFrom-SqlDscServerPermission.ps1' 51
#Region './Public/ConvertTo-SqlDscDatabasePermission.ps1' 0
<#
    .SYNOPSIS
        Converts a collection of Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo
        objects into an array of DatabasePermission objects.

    .PARAMETER DatabasePermissionInfo
        Specifies a collection of Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo
        objects.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        $databasePermissionInfo = Get-SqlDscDatabasePermission -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal'
        ConvertTo-SqlDscDatabasePermission -DatabasePermissionInfo $databasePermissionInfo

        Get all permissions for the principal 'MyPrincipal' and converts the permissions
        into an array of `[DatabasePermission[]]`.

    .OUTPUTS
        [DatabasePermission[]]
#>
function ConvertTo-SqlDscDatabasePermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when the output type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [CmdletBinding()]
    [OutputType([DatabasePermission[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowEmptyCollection()]
        [Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo[]]
        $DatabasePermissionInfo
    )

    begin
    {
        [DatabasePermission[]] $permissions = @()
    }

    process
    {
        $permissionState = foreach ($currentDatabasePermissionInfo in $DatabasePermissionInfo)
        {
            # Convert from the type PermissionState to String.
            [System.String] $currentDatabasePermissionInfo.PermissionState
        }

        $permissionState = $permissionState | Select-Object -Unique

        foreach ($currentPermissionState in $permissionState)
        {
            $filteredDatabasePermission = $DatabasePermissionInfo |
                Where-Object -FilterScript {
                    $_.PermissionState -eq $currentPermissionState
                }

            $databasePermissionStateExist = $permissions.Where({
                    $_.State -contains $currentPermissionState
                }) |
                Select-Object -First 1

            if ($databasePermissionStateExist)
            {
                $databasePermission = $databasePermissionStateExist
            }
            else
            {
                $databasePermission = [DatabasePermission] @{
                    State      = $currentPermissionState
                    Permission = [System.String[]] @()
                }
            }

            foreach ($currentPermission in $filteredDatabasePermission)
            {
                # Get the permission names that is set to $true
                $permissionProperty = $currentPermission.PermissionType |
                    Get-Member -MemberType 'Property' |
                    Select-Object -ExpandProperty 'Name' -Unique |
                    Where-Object -FilterScript {
                        $currentPermission.PermissionType.$_
                    }


                foreach ($currentPermissionProperty in $permissionProperty)
                {
                    $databasePermission.Permission += $currentPermissionProperty
                }
            }

            # Only add the object if it was created.
            if (-not $databasePermissionStateExist)
            {
                $permissions += $databasePermission
            }
        }
    }

    end
    {
        return $permissions
    }
}
#EndRegion './Public/ConvertTo-SqlDscDatabasePermission.ps1' 103
#Region './Public/ConvertTo-SqlDscServerPermission.ps1' 0
<#
    .SYNOPSIS
        Converts a collection of Microsoft.SqlServer.Management.Smo.ServerPermissionInfo
        objects into an array of ServerPermission objects.

    .PARAMETER ServerPermissionInfo
        Specifies a collection of Microsoft.SqlServer.Management.Smo.ServerPermissionInfo
        objects.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        $serverPermissionInfo = Get-SqlDscServerPermission -ServerObject $serverInstance -Name 'MyPrincipal'
        ConvertTo-SqlDscServerPermission -ServerPermissionInfo $serverPermissionInfo

        Get all permissions for the principal 'MyPrincipal' and converts the permissions
        into an array of `[ServerPermission[]]`.

    .OUTPUTS
        [ServerPermission[]]
#>
function ConvertTo-SqlDscServerPermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when the output type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [CmdletBinding()]
    [OutputType([ServerPermission[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowEmptyCollection()]
        [Microsoft.SqlServer.Management.Smo.ServerPermissionInfo[]]
        $ServerPermissionInfo
    )

    begin
    {
        [ServerPermission[]] $permissions = @()
    }

    process
    {
        $permissionState = foreach ($currentServerPermissionInfo in $ServerPermissionInfo)
        {
            # Convert from the type PermissionState to String.
            [System.String] $currentServerPermissionInfo.PermissionState
        }

        $permissionState = $permissionState | Select-Object -Unique

        foreach ($currentPermissionState in $permissionState)
        {
            $filteredServerPermission = $ServerPermissionInfo |
                Where-Object -FilterScript {
                    $_.PermissionState -eq $currentPermissionState
                }

            $serverPermissionStateExist = $permissions.Where({
                    $_.State -contains $currentPermissionState
                }) |
                Select-Object -First 1

            if ($serverPermissionStateExist)
            {
                $serverPermission = $serverPermissionStateExist
            }
            else
            {
                $serverPermission = [ServerPermission] @{
                    State      = $currentPermissionState
                    Permission = [System.String[]] @()
                }
            }

            foreach ($currentPermission in $filteredServerPermission)
            {
                # Get the permission names that is set to $true
                $permissionProperty = $currentPermission.PermissionType |
                    Get-Member -MemberType 'Property' |
                    Select-Object -ExpandProperty 'Name' -Unique |
                    Where-Object -FilterScript {
                        $currentPermission.PermissionType.$_
                    }


                foreach ($currentPermissionProperty in $permissionProperty)
                {
                    $serverPermission.Permission += $currentPermissionProperty
                }
            }

            # Only add the object if it was created.
            if (-not $serverPermissionStateExist)
            {
                $permissions += $serverPermission
            }
        }
    }

    end
    {
        return $permissions
    }
}
#EndRegion './Public/ConvertTo-SqlDscServerPermission.ps1' 103
#Region './Public/Disable-SqlDscAudit.ps1' 0
<#
    .SYNOPSIS
        Disables a server audit.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER AuditObject
        Specifies an audit object to disable.

    .PARAMETER Name
        Specifies the name of the server audit to be disabled.

    .PARAMETER Force
        Specifies that the audit should be disabled with out any confirmation.

    .PARAMETER Refresh
        Specifies that the **ServerObject**'s audits should be refreshed before
        trying to disable the audit object. This is helpful when audits could have
        been modified outside of the **ServerObject**, for example through T-SQL.
        But on instances with a large amount of audits it might be better to make
        sure the **ServerObject** is recent enough, or pass in **AuditObject**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $auditObject = $sqlServerObject | Get-SqlDscAudit -Name 'MyFileAudit'
        $auditObject | Disable-SqlDscAudit

        Disables the audit named **MyFileAudit**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | Disable-SqlDscAudit -Name 'MyFileAudit'

        Disables the audit named **MyFileAudit**.

    .OUTPUTS
        None.
#>
function Disable-SqlDscAudit
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [OutputType()]
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param
    (
        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(ParameterSetName = 'AuditObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Audit]
        $AuditObject,

        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force,

        [Parameter(ParameterSetName = 'ServerObject')]
        [System.Management.Automation.SwitchParameter]
        $Refresh
    )

    if ($Force.IsPresent)
    {
        $ConfirmPreference = 'None'
    }

    if ($PSCmdlet.ParameterSetName -eq 'ServerObject')
    {
        $getSqlDscAuditParameters = @{
            ServerObject = $ServerObject
            Name = $Name
            Refresh = $Refresh
            ErrorAction = 'Stop'
        }

        # If this command does not find the audit it will throw an exception.
        $AuditObject = Get-SqlDscAudit @getSqlDscAuditParameters
    }

    $verboseDescriptionMessage = $script:localizedData.Audit_Disable_ShouldProcessVerboseDescription -f $AuditObject.Name, $AuditObject.Parent.InstanceName
    $verboseWarningMessage = $script:localizedData.Audit_Disable_ShouldProcessVerboseWarning -f $AuditObject.Name
    $captionMessage = $script:localizedData.Audit_Disable_ShouldProcessCaption

    if ($PSCmdlet.ShouldProcess($verboseDescriptionMessage, $verboseWarningMessage, $captionMessage))
    {
        $AuditObject.Disable()
    }
}
#EndRegion './Public/Disable-SqlDscAudit.ps1' 95
#Region './Public/Enable-SqlDscAudit.ps1' 0
<#
    .SYNOPSIS
        Enables a server audit.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER AuditObject
        Specifies an audit object to enable.

    .PARAMETER Name
        Specifies the name of the server audit to be enabled.

    .PARAMETER Force
        Specifies that the audit should be enabled with out any confirmation.

    .PARAMETER Refresh
        Specifies that the **ServerObject**'s audits should be refreshed before
        trying to enable the audit object. This is helpful when audits could have
        been modified outside of the **ServerObject**, for example through T-SQL.
        But on instances with a large amount of audits it might be better to make
        sure the **ServerObject** is recent enough, or pass in **AuditObject**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $auditObject = $sqlServerObject | Get-SqlDscAudit -Name 'MyFileAudit'
        $auditObject | Enable-SqlDscAudit

        Enables the audit named **MyFileAudit**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | Enable-SqlDscAudit -Name 'MyFileAudit'

        Enables the audit named **MyFileAudit**.

    .OUTPUTS
        None.
#>
function Enable-SqlDscAudit
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [OutputType()]
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param
    (
        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(ParameterSetName = 'AuditObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Audit]
        $AuditObject,

        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force,

        [Parameter(ParameterSetName = 'ServerObject')]
        [System.Management.Automation.SwitchParameter]
        $Refresh
    )

    if ($Force.IsPresent)
    {
        $ConfirmPreference = 'None'
    }

    if ($PSCmdlet.ParameterSetName -eq 'ServerObject')
    {
        $getSqlDscAuditParameters = @{
            ServerObject = $ServerObject
            Name = $Name
            Refresh = $Refresh
            ErrorAction = 'Stop'
        }

        # If this command does not find the audit it will throw an exception.
        $AuditObject = Get-SqlDscAudit @getSqlDscAuditParameters
    }

    $verboseDescriptionMessage = $script:localizedData.Audit_Enable_ShouldProcessVerboseDescription -f $AuditObject.Name, $AuditObject.Parent.InstanceName
    $verboseWarningMessage = $script:localizedData.Audit_Enable_ShouldProcessVerboseWarning -f $AuditObject.Name
    $captionMessage = $script:localizedData.Audit_Enable_ShouldProcessCaption

    if ($PSCmdlet.ShouldProcess($verboseDescriptionMessage, $verboseWarningMessage, $captionMessage))
    {
        $AuditObject.Enable()
    }
}
#EndRegion './Public/Enable-SqlDscAudit.ps1' 95
#Region './Public/Get-SqlDscAudit.ps1' 0
<#
    .SYNOPSIS
        Get server audit.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER Name
        Specifies the name of the server audit to get.

    .PARAMETER Refresh
        Specifies that the **ServerObject**'s audits should be refreshed before
        trying get the audit object. This is helpful when audits could have been
        modified outside of the **ServerObject**, for example through T-SQL. But
        on instances with a large amount of audits it might be better to make
        sure the **ServerObject** is recent enough, or pass in **AuditObject**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | Get-SqlDscAudit -Name 'MyFileAudit'

        Get the audit named **MyFileAudit**.

    .OUTPUTS
        `[Microsoft.SqlServer.Management.Smo.Audit]`.
#>
function Get-SqlDscAudit
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [OutputType([Microsoft.SqlServer.Management.Smo.Audit])]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Refresh
    )

    if ($Refresh.IsPresent)
    {
        # Make sure the audits are up-to-date to get any newly created audits.
        $ServerObject.Audits.Refresh()
    }

    $auditObject = $ServerObject.Audits[$Name]

    if (-not $AuditObject)
    {
        $missingAuditMessage = $script:localizedData.Audit_Missing -f $Name

        $writeErrorParameters = @{
            Message = $missingAuditMessage
            Category = 'InvalidOperation'
            ErrorId = 'GSDA0001' # cspell: disable-line
            TargetObject = $Name
        }

        Write-Error @writeErrorParameters
    }

    return $auditObject
}
#EndRegion './Public/Get-SqlDscAudit.ps1' 71
#Region './Public/Get-SqlDscDatabasePermission.ps1' 0
<#
    .SYNOPSIS
        Returns the current permissions for the database principal.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER DatabaseName
        Specifies the database name.

    .PARAMETER Name
        Specifies the name of the database principal for which the permissions are
        returned.

    .OUTPUTS
        [Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo[]]

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Get-SqlDscDatabasePermission -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal'

        Get the permissions for the principal 'MyPrincipal'.

    .NOTES
        This command excludes fixed roles like _db_datareader_ by default, and will
        always return `$null` if a fixed role is specified as **Name**.

        If specifying `-ErrorAction 'SilentlyContinue'` then the command will silently
        ignore if the database (parameter **DatabaseName**) is not present or the
        database principal is not present. In such case the command will return `$null`.
        If specifying `-ErrorAction 'Stop'` the command will throw an error if the
        database or database principal is missing.
#>
function Get-SqlDscDatabasePermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '', Justification = 'Because the rule does not understands that the command returns [System.String[]] when using , (comma) in the return statement')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('AvoidThrowOutsideOfTry', '', Justification = 'Because the code throws based on an prior expression')]
    [CmdletBinding()]
    [OutputType([Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DatabaseName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name
    )

    $getSqlDscDatabasePermissionResult = $null

    $sqlDatabaseObject = $null

    if ($ServerObject.Databases)
    {
        $sqlDatabaseObject = $ServerObject.Databases[$DatabaseName]
    }

    if ($sqlDatabaseObject)
    {
        $testSqlDscIsDatabasePrincipalParameters = @{
            ServerObject      = $ServerObject
            DatabaseName      = $DatabaseName
            Name              = $Name
            ExcludeFixedRoles = $true
        }

        $isDatabasePrincipal = Test-SqlDscIsDatabasePrincipal @testSqlDscIsDatabasePrincipalParameters

        if ($isDatabasePrincipal)
        {
            $getSqlDscDatabasePermissionResult = $sqlDatabaseObject.EnumDatabasePermissions($Name)
        }
        else
        {
            $missingPrincipalMessage = $script:localizedData.DatabasePermission_MissingPrincipal -f $Name, $DatabaseName

            Write-Error -Message $missingPrincipalMessage -Category 'InvalidOperation' -ErrorId 'GSDDP0001' -TargetObject $Name
        }
    }
    else
    {
        $missingDatabaseMessage = $script:localizedData.DatabasePermission_MissingDatabase -f $DatabaseName

        Write-Error -Message $missingDatabaseMessage -Category 'InvalidOperation' -ErrorId 'GSDDP0002' -TargetObject $DatabaseName
    }

    return , [Microsoft.SqlServer.Management.Smo.DatabasePermissionInfo[]] $getSqlDscDatabasePermissionResult
}
#EndRegion './Public/Get-SqlDscDatabasePermission.ps1' 96
#Region './Public/Get-SqlDscServerPermission.ps1' 0
<#
    .SYNOPSIS
        Returns the current permissions for the principal.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER Name
        Specifies the name of the principal for which the permissions are
        returned.

    .OUTPUTS
        [Microsoft.SqlServer.Management.Smo.ServerPermissionInfo[]]

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Get-SqlDscServerPermission -ServerObject $serverInstance -Name 'MyPrincipal'

        Get the permissions for the principal 'MyPrincipal'.

    .NOTES
        If specifying `-ErrorAction 'SilentlyContinue'` then the command will silently
        ignore if the principal (parameter **Name**) is not present. In such case the
        command will return `$null`. If specifying `-ErrorAction 'Stop'` the command
        will throw an error if the principal is missing.
#>
function Get-SqlDscServerPermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '', Justification = 'Because the rule does not understands that the command returns [System.String[]] when using , (comma) in the return statement')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('AvoidThrowOutsideOfTry', '', Justification = 'Because the code throws based on an prior expression')]
    [CmdletBinding()]
    [OutputType([Microsoft.SqlServer.Management.Smo.ServerPermissionInfo[]])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name
    )

    $getSqlDscServerPermissionResult = $null

    $testSqlDscIsLoginParameters = @{
        ServerObject      = $ServerObject
        Name              = $Name
    }

    $isLogin = Test-SqlDscIsLogin @testSqlDscIsLoginParameters

    if ($isLogin)
    {
        $getSqlDscServerPermissionResult = $ServerObject.EnumServerPermissions($Name)
    }
    else
    {
        $missingPrincipalMessage = $script:localizedData.ServerPermission_MissingPrincipal -f $Name, $ServerObject.InstanceName

        Write-Error -Message $missingPrincipalMessage -Category 'InvalidOperation' -ErrorId 'GSDSP0001' -TargetObject $Name
    }

    return , [Microsoft.SqlServer.Management.Smo.ServerPermissionInfo[]] $getSqlDscServerPermissionResult
}
#EndRegion './Public/Get-SqlDscServerPermission.ps1' 67
#Region './Public/Invoke-SqlDscQuery.ps1' 0
<#
    .SYNOPSIS
        Executes a query on the specified database.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER DatabaseName
        Specify the name of the database to execute the query on.

    .PARAMETER Query
        The query string to execute.

    .PARAMETER PassThru
        Specifies if the command should return any result the query might return.

    .PARAMETER StatementTimeout
        Set the query StatementTimeout in seconds. Default 600 seconds (10 minutes).

    .PARAMETER RedactText
        One or more strings to redact from the query when verbose messages are
        written to the console. Strings here will be escaped so they will not
        be interpreted as regular expressions (RegEx).

    .OUTPUTS
        `[System.Data.DataSet]` when passing parameter **PassThru**, otherwise
        outputs none.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Invoke-SqlDscQuery -ServerObject $serverInstance -Database master `
            -Query 'SELECT name FROM sys.databases' -PassThru

        Runs the query and returns all the database names in the instance.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Invoke-SqlDscQuery -ServerObject $serverInstance -Database master `
            -Query 'RESTORE DATABASE [NorthWinds] WITH RECOVERY'

        Runs the query to restores the database NorthWinds.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Invoke-SqlDscQuery -ServerObject $serverInstance -Database master `
            -Query "select * from MyTable where password = 'PlaceholderPa\ssw0rd1' and password = 'placeholder secret passphrase'" `
            -PassThru -RedactText @('PlaceholderPa\sSw0rd1','Placeholder Secret PassPhrase') `
            -Verbose

        Shows how to redact sensitive information in the query when the query string
        is output as verbose information when the parameter Verbose is used.

    .NOTES
        This is a wrapper for private function Invoke-Query, until it move into
        this public function.
#>
function Invoke-SqlDscQuery
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [OutputType([System.Data.DataSet])]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DatabaseName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Query,

        [Parameter()]
        [Switch]
        $PassThru,

        [Parameter()]
        [ValidateNotNull()]
        [System.Int32]
        $StatementTimeout = 600,

        [Parameter()]
        [System.String[]]
        $RedactText
    )

    $invokeQueryParameters = @{
        SqlServerObject  = $ServerObject
        Database         = $DatabaseName
        Query            = $Query
    }

    if ($PSBoundParameters.ContainsKey('PassThru'))
    {
        $invokeQueryParameters.WithResults = $PassThru
    }

    if ($PSBoundParameters.ContainsKey('StatementTimeout'))
    {
        $invokeQueryParameters.StatementTimeout = $StatementTimeout
    }

    if ($PSBoundParameters.ContainsKey('RedactText'))
    {
        $invokeQueryParameters.RedactText = $RedactText
    }

    return (Invoke-Query @invokeQueryParameters)
}
#EndRegion './Public/Invoke-SqlDscQuery.ps1' 113
#Region './Public/New-SqlDscAudit.ps1' 0
<#
    .SYNOPSIS
        Creates a server audit.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER Name
        Specifies the name of the server audit to be added.

    .PARAMETER Filter
        Specifies the filter that should be used on the audit. See [predicate expression](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-server-audit-transact-sql)
        how to write the syntax for the filter.

    .PARAMETER OnFailure
        Specifies what should happen when writing events to the store fails.
        This can be 'Continue', 'FailOperation', or 'Shutdown'.

    .PARAMETER QueueDelay
        Specifies the maximum delay before a event is written to the store.
        When set to low this could impact server performance.
        When set to high events could be missing when a server crashes.

    .PARAMETER AuditGuid
        Specifies the GUID found in the mirrored database. To support scenarios such
        as database mirroring an audit needs a specific GUID.

    .PARAMETER Force
        Specifies that the audit should be created with out any confirmation.

    .PARAMETER Refresh
        Specifies that the **ServerObject**'s audits should be refreshed before
        creating the audit object. This is helpful when audits could have been
        modified outside of the **ServerObject**, for example through T-SQL. But
        on instances with a large amount of audits it might be better to make
        sure the ServerObject is recent enough.

    .PARAMETER LogType
        Specifies the log location where the audit should write to.
        This can be SecurityLog or ApplicationLog.

    .PARAMETER FilePath
        Specifies the location where te log files wil be placed.

    .PARAMETER ReserveDiskSpace
        Specifies if the needed file space should be reserved. To use this parameter
        the parameter **MaximumFiles** must also be used.

    .PARAMETER MaximumFiles
        Specifies the number of files on disk.

    .PARAMETER MaximumFileSize
        Specifies the maximum file size in units by parameter MaximumFileSizeUnit.

    .PARAMETER MaximumFileSizeUnit
        Specifies the unit that is used for the file size. This can be set to `Megabyte`,
        `Gigabyte`, or `Terabyte`.

    .PARAMETER MaximumRolloverFiles
        Specifies the amount of files on disk before SQL Server starts reusing
        the files. If not specified then it is set to unlimited.

    .OUTPUTS
        `[Microsoft.SqlServer.Management.Smo.Audit]` is passing parameter **PassThru**,
         otherwise none.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | New-SqlDscAudit -Name 'MyFileAudit' -Path 'E:\auditFolder'

        Create a new file audit named **MyFileAudit**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | New-SqlDscAudit -Name 'MyAppLogAudit' -LogType 'ApplicationLog'

        Create a new application log audit named **MyAppLogAudit**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | New-SqlDscAudit -Name 'MyFileAudit' -Path 'E:\auditFolder' -PassThru

        Create a new file audit named **MyFileAudit** and returns the Audit object.

    .NOTES
        This command has the confirm impact level set to medium since an audit is
        created but by default is is not enabled.

        See the SQL Server documentation for more information for the possible
        parameter values to pass to this command: https://docs.microsoft.com/en-us/sql/t-sql/statements/create-server-audit-transact-sql
#>
function New-SqlDscAudit
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [OutputType([Microsoft.SqlServer.Management.Smo.Audit])]
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param
    (
        [Parameter(ParameterSetName = 'Log', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'File', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'FileWithSize', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'FileWithMaxFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'FileWithMaxRolloverFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxRolloverFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $AuditFilter,

        [Parameter()]
        [ValidateSet('Continue', 'FailOperation', 'Shutdown')]
        [System.String]
        $OnFailure,

        [Parameter()]
        [ValidateRange(1000, 2147483647)]
        [System.UInt32]
        $QueueDelay,

        [Parameter()]
        [ValidatePattern('^[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$')]
        [System.String]
        $AuditGuid,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Refresh,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $PassThru,

        [Parameter(ParameterSetName = 'Log', Mandatory = $true)]
        [ValidateSet('SecurityLog', 'ApplicationLog')]
        [System.String]
        $LogType,

        [Parameter(ParameterSetName = 'File', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [ValidateScript({
                if (-not (Test-Path -Path $_))
                {
                    throw ($script:localizedData.Audit_PathParameterValueInvalid -f $_)
                }

                return $true
            })]
        [System.String]
        $Path,

        [Parameter(ParameterSetName = 'FileWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [ValidateRange(2, 2147483647)]
        [System.UInt32]
        $MaximumFileSize,

        [Parameter(ParameterSetName = 'FileWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [ValidateSet('Megabyte', 'Gigabyte', 'Terabyte')]
        [System.String]
        $MaximumFileSizeUnit,

        [Parameter(ParameterSetName = 'FileWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithMaxFiles', Mandatory = $true)]
        [System.UInt32]
        $MaximumFiles,

        [Parameter(ParameterSetName = 'FileWithMaxFiles')]
        [Parameter(ParameterSetName = 'FileWithSizeAndMaxFiles')]
        [System.Management.Automation.SwitchParameter]
        $ReserveDiskSpace,

        [Parameter(ParameterSetName = 'FileWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'FileWithMaxRolloverFiles', Mandatory = $true)]
        [ValidateRange(0, 2147483647)]
        [System.UInt32]
        $MaximumRolloverFiles
    )

    if ($Force.IsPresent)
    {
        $ConfirmPreference = 'None'
    }

    $getSqlDscAuditParameters = @{
        ServerObject = $ServerObject
        Name = $Name
        Refresh = $Refresh
        ErrorAction = 'SilentlyContinue'
    }

    $auditObject = Get-SqlDscAudit @getSqlDscAuditParameters

    if ($auditObject)
    {
        $auditAlreadyPresentMessage = $script:localizedData.Audit_AlreadyPresent -f $Name

        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                $auditAlreadyPresentMessage,
                'NSDA0001', # cspell: disable-line
                [System.Management.Automation.ErrorCategory]::InvalidOperation,
                $DatabaseName
            )
        )
    }

    $auditObject = New-Object -TypeName 'Microsoft.SqlServer.Management.Smo.Audit' -ArgumentList @($ServerObject, $Name)

    $queryType = switch ($PSCmdlet.ParameterSetName)
    {
        'Log'
        {
            $LogType
        }

        default
        {
            'File'
        }
    }

    $auditObject.DestinationType = $queryType

    if ($PSCmdlet.ParameterSetName -match 'File')
    {
        $auditObject.FilePath = $Path

        if ($PSCmdlet.ParameterSetName -match 'FileWithSize')
        {
            $convertedMaximumFileSizeUnit = (
                @{
                    Megabyte = 'MB'
                    Gigabyte = 'GB'
                    Terabyte = 'TB'
                }
            ).$MaximumFileSizeUnit

            $auditObject.MaximumFileSize = $MaximumFileSize
            $auditObject.MaximumFileSizeUnit = $convertedMaximumFileSizeUnit
        }

        if ($PSCmdlet.ParameterSetName -in @('FileWithMaxFiles', 'FileWithSizeAndMaxFiles'))
        {
            $auditObject.MaximumFiles = $MaximumFiles

            if ($PSBoundParameters.ContainsKey('ReserveDiskSpace'))
            {
                $auditObject.ReserveDiskSpace = $ReserveDiskSpace.IsPresent
            }
        }

        if ($PSCmdlet.ParameterSetName -in @('FileWithMaxRolloverFiles', 'FileWithSizeAndMaxRolloverFiles'))
        {
            $auditObject.MaximumRolloverFiles = $MaximumRolloverFiles
        }
    }

    if ($PSBoundParameters.ContainsKey('OnFailure'))
    {
        $auditObject.OnFailure = $OnFailure
    }

    if ($PSBoundParameters.ContainsKey('QueueDelay'))
    {
        $auditObject.QueueDelay = $QueueDelay
    }

    if ($PSBoundParameters.ContainsKey('AuditGuid'))
    {
        $auditObject.Guid = $AuditGuid
    }

    if ($PSBoundParameters.ContainsKey('AuditFilter'))
    {
        $auditObject.Filter = $AuditFilter
    }

    $verboseDescriptionMessage = $script:localizedData.Audit_Add_ShouldProcessVerboseDescription -f $Name, $ServerObject.InstanceName
    $verboseWarningMessage = $script:localizedData.Audit_Add_ShouldProcessVerboseWarning -f $Name
    $captionMessage = $script:localizedData.Audit_Add_ShouldProcessCaption

    if ($PSCmdlet.ShouldProcess($verboseDescriptionMessage, $verboseWarningMessage, $captionMessage))
    {
        $auditObject.Create()

        if ($PassThru.IsPresent)
        {
            return $auditObject
        }
    }
}
#EndRegion './Public/New-SqlDscAudit.ps1' 310
#Region './Public/Remove-SqlDscAudit.ps1' 0
<#
    .SYNOPSIS
        Removes a server audit.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER AuditObject
        Specifies an audit object to remove.

    .PARAMETER Name
        Specifies the name of the server audit to be removed.

    .PARAMETER Force
        Specifies that the audit should be removed with out any confirmation.

    .PARAMETER Refresh
        Specifies that the **ServerObject**'s audits should be refreshed before
        trying removing the audit object. This is helpful when audits could have
        been modified outside of the **ServerObject**, for example through T-SQL.
        But on instances with a large amount of audits it might be better to make
        sure the **ServerObject** is recent enough, or pass in **AuditObject**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $auditObject = $sqlServerObject | Get-SqlDscAudit -Name 'MyFileAudit'
        $auditObject | Remove-SqlDscAudit

        Removes the audit named **MyFileAudit**.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | Remove-SqlDscAudit -Name 'MyFileAudit'

        Removes the audit named **MyFileAudit**.

    .OUTPUTS
        None.
#>
function Remove-SqlDscAudit
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [OutputType()]
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param
    (
        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(ParameterSetName = 'AuditObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Audit]
        $AuditObject,

        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force,

        [Parameter(ParameterSetName = 'ServerObject')]
        [System.Management.Automation.SwitchParameter]
        $Refresh
    )

    if ($Force.IsPresent)
    {
        $ConfirmPreference = 'None'
    }

    if ($PSCmdlet.ParameterSetName -eq 'ServerObject')
    {
        $getSqlDscAuditParameters = @{
            ServerObject = $ServerObject
            Name = $Name
            Refresh = $Refresh
            ErrorAction = 'Stop'
        }

        # If this command does not find the audit it will throw an exception.
        $AuditObject = Get-SqlDscAudit @getSqlDscAuditParameters
    }

    $verboseDescriptionMessage = $script:localizedData.Audit_Remove_ShouldProcessVerboseDescription -f $AuditObject.Name, $AuditObject.Parent.InstanceName
    $verboseWarningMessage = $script:localizedData.Audit_Remove_ShouldProcessVerboseWarning -f $AuditObject.Name
    $captionMessage = $script:localizedData.Audit_Remove_ShouldProcessCaption

    if ($PSCmdlet.ShouldProcess($verboseDescriptionMessage, $verboseWarningMessage, $captionMessage))
    {
        <#
            If the passed audit object has already been dropped, then we silently
            do nothing, using the method DropIfExist(), since the job is done.
        #>
        $AuditObject.DropIfExists()
    }
}
#EndRegion './Public/Remove-SqlDscAudit.ps1' 99
#Region './Public/Set-SqlDscAudit.ps1' 0
<#
    .SYNOPSIS
        Updates a server audit.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER AuditObject
        Specifies an audit object to update.

    .PARAMETER Name
        Specifies the name of the server audit to be updated.

    .PARAMETER Filter
        Specifies the filter that should be used on the audit. See [predicate expression](https://docs.microsoft.com/en-us/sql/t-sql/statements/create-server-audit-transact-sql)
        how to write the syntax for the filter.

    .PARAMETER OnFailure
        Specifies what should happen when writing events to the store fails.
        This can be 'Continue', 'FailOperation', or 'Shutdown'.

    .PARAMETER QueueDelay
        Specifies the maximum delay before a event is written to the store.
        When set to low this could impact server performance.
        When set to high events could be missing when a server crashes.

    .PARAMETER AuditGuid
        Specifies the GUID found in the mirrored database. To support scenarios such
        as database mirroring an audit needs a specific GUID.

    .PARAMETER Force
        Specifies that the audit should be updated with out any confirmation.

    .PARAMETER Refresh
        Specifies that the audit object should be refreshed before updating. This
        is helpful when audits could have been modified outside of the **ServerObject**,
        for example through T-SQL. But on instances with a large amount of audits
        it might be better to make sure the ServerObject is recent enough.

    .PARAMETER FilePath
        Specifies the location where te log files wil be placed.

    .PARAMETER ReserveDiskSpace
        Specifies if the needed file space should be reserved. To use this parameter
        the parameter **MaximumFiles** must also be used.

    .PARAMETER MaximumFiles
        Specifies the number of files on disk.

    .PARAMETER MaximumFileSize
        Specifies the maximum file size in units by parameter MaximumFileSizeUnit.
        Minimum allowed value is 2 (MB). It also allowed to set the value to 0 which
        mean unlimited file size.

    .PARAMETER MaximumFileSizeUnit
        Specifies the unit that is used for the file size. this can be KB, MB or GB.

    .PARAMETER MaximumRolloverFiles
        Specifies the amount of files on disk before SQL Server starts reusing
        the files. If not specified then it is set to unlimited.

    .OUTPUTS
        `[Microsoft.SqlServer.Management.Smo.Audit]` is passing parameter **PassThru**,
         otherwise none.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | Set-SqlDscAudit -Name 'MyFileAudit' -Path 'E:\auditFolder' -QueueDelay 1000

        Updates the file audit named **MyFileAudit** by setting the path to ''E:\auditFolder'
        and the queue delay to 1000.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | New-SqlDscAudit -Name 'MyAppLogAudit' -QueueDelay 1000

        Updates the application log audit named **MyAppLogAudit** by setting the
        queue delay to 1000.

    .EXAMPLE
        $serverObject = Connect-SqlDscDatabaseEngine -InstanceName 'MyInstance'
        $sqlServerObject | Set-SqlDscAudit -Name 'MyFileAudit' -Path 'E:\auditFolder' -QueueDelay 1000 -PassThru

        Updates the file audit named **MyFileAudit** by setting the path to ''E:\auditFolder'
        and the queue delay to 1000, and returns the Audit object.

    .NOTES
        This command has the confirm impact level set to high since an audit is
        unknown to be enable at the point when the command is issued.

        See the SQL Server documentation for more information for the possible
        parameter values to pass to this command: https://docs.microsoft.com/en-us/sql/t-sql/statements/create-server-audit-transact-sql
#>
function Set-SqlDscAudit
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [OutputType([Microsoft.SqlServer.Management.Smo.Audit])]
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param
    (
        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSize', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithMaxFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithMaxRolloverFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxRolloverFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(ParameterSetName = 'AuditObject', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSize', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithMaxFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithMaxRolloverFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxRolloverFiles', Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Audit]
        $AuditObject,

        [Parameter(ParameterSetName = 'ServerObject', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.String]
        $AuditFilter,

        [Parameter()]
        [ValidateSet('Continue', 'FailOperation', 'Shutdown')]
        [System.String]
        $OnFailure,

        [Parameter()]
        [ValidateScript({
            if ($_ -in 1..999 -or $_ -gt 2147483647)
            {
                throw ($script:localizedData.Audit_QueueDelayParameterValueInvalid -f $_)
            }

            return $true
        })]
        [System.UInt32]
        $QueueDelay,

        [Parameter()]
        [ValidatePattern('^[0-9a-fA-F]{8}-(?:[0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$')]
        [System.String]
        $AuditGuid,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Refresh,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $PassThru,

        [Parameter(ParameterSetName = 'ServerObject')]
        [Parameter(ParameterSetName = 'ServerObjectWithSize')]
        [Parameter(ParameterSetName = 'ServerObjectWithMaxFiles')]
        [Parameter(ParameterSetName = 'ServerObjectWithMaxRolloverFiles')]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxFiles')]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxRolloverFiles')]
        [Parameter(ParameterSetName = 'AuditObject')]
        [Parameter(ParameterSetName = 'AuditObjectWithSize')]
        [Parameter(ParameterSetName = 'AuditObjectWithMaxFiles')]
        [Parameter(ParameterSetName = 'AuditObjectWithMaxRolloverFiles')]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxFiles')]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxRolloverFiles')]
        [ValidateScript({
                if (-not (Test-Path -Path $_))
                {
                    throw ($script:localizedData.Audit_PathParameterValueInvalid -f $_)
                }

                return $true
            })]
        [System.String]
        $Path,

        [Parameter(ParameterSetName = 'ServerObjectWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [ValidateScript({
            if ($_ -eq 1 -or $_ -gt 2147483647)
            {
                throw ($script:localizedData.Audit_MaximumFileSizeParameterValueInvalid -f $_)
            }

            return $true
        })]
        [System.UInt32]
        $MaximumFileSize,

        [Parameter(ParameterSetName = 'ServerObjectWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSize', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [ValidateSet('Megabyte', 'Gigabyte', 'Terabyte')]
        [System.String]
        $MaximumFileSizeUnit,

        [Parameter(ParameterSetName = 'ServerObjectWithMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithMaxFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxFiles', Mandatory = $true)]
        [System.UInt32]
        $MaximumFiles,

        [Parameter(ParameterSetName = 'ServerObjectWithMaxFiles')]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxFiles')]
        [Parameter(ParameterSetName = 'AuditObjectWithMaxFiles')]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxFiles')]
        [System.Management.Automation.SwitchParameter]
        $ReserveDiskSpace,

        [Parameter(ParameterSetName = 'ServerObjectWithMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'ServerObjectWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithMaxRolloverFiles', Mandatory = $true)]
        [Parameter(ParameterSetName = 'AuditObjectWithSizeAndMaxRolloverFiles', Mandatory = $true)]
        [ValidateRange(0, 2147483647)]
        [System.UInt32]
        $MaximumRolloverFiles
    )

    if ($Force.IsPresent)
    {
        $ConfirmPreference = 'None'
    }

    if ($PSCmdlet.ParameterSetName -eq 'ServerObject')
    {
        $getSqlDscAuditParameters = @{
            ServerObject = $ServerObject
            Name = $Name
            Refresh = $Refresh
            ErrorAction = 'Stop'
        }

        $AuditObject = Get-SqlDscAudit @getSqlDscAuditParameters
    }

    if ($Refresh.IsPresent)
    {
        $AuditObject.Refresh()
    }

    $verboseDescriptionMessage = $script:localizedData.Audit_Update_ShouldProcessVerboseDescription -f $AuditObject.Name, $AuditObject.Parent.InstanceName
    $verboseWarningMessage = $script:localizedData.Audit_Update_ShouldProcessVerboseWarning -f $AuditObject.Name
    $captionMessage = $script:localizedData.Audit_Update_ShouldProcessCaption

    if ($PSCmdlet.ShouldProcess($verboseDescriptionMessage, $verboseWarningMessage, $captionMessage))
    {
        if ($PSBoundParameters.ContainsKey('Path'))
        {
            $AuditObject.FilePath = $Path
        }

        if ($PSCmdlet.ParameterSetName -match 'WithSize')
        {
            $queryMaximumFileSizeUnit = (
                @{
                    Megabyte = 'MB'
                    Gigabyte = 'GB'
                    Terabyte = 'TB'
                }
            ).$MaximumFileSizeUnit

            $AuditObject.MaximumFileSize = $MaximumFileSize
            $AuditObject.MaximumFileSizeUnit = $queryMaximumFileSizeUnit
        }

        if ($PSCmdlet.ParameterSetName -match 'MaxFiles')
        {
            if ($AuditObject.MaximumRolloverFiles)
            {
                # Switching to MaximumFiles instead of MaximumRolloverFiles.
                $AuditObject.MaximumRolloverFiles = 0

                # Must run method Alter() before setting MaximumFiles.
                $AuditObject.Alter()
            }

            $AuditObject.MaximumFiles = $MaximumFiles

            if ($PSBoundParameters.ContainsKey('ReserveDiskSpace'))
            {
                $AuditObject.ReserveDiskSpace = $ReserveDiskSpace.IsPresent
            }
        }

        if ($PSCmdlet.ParameterSetName -match 'MaxRolloverFiles')
        {
            if ($AuditObject.MaximumFiles)
            {
                # Switching to MaximumRolloverFiles instead of MaximumFiles.
                $AuditObject.MaximumFiles = 0

                # Must run method Alter() before setting MaximumRolloverFiles.
                $AuditObject.Alter()
            }

            $AuditObject.MaximumRolloverFiles = $MaximumRolloverFiles
        }

        if ($PSBoundParameters.ContainsKey('OnFailure'))
        {
            $AuditObject.OnFailure = $OnFailure
        }

        if ($PSBoundParameters.ContainsKey('QueueDelay'))
        {
            $AuditObject.QueueDelay = $QueueDelay
        }

        if ($PSBoundParameters.ContainsKey('AuditGuid'))
        {
            $AuditObject.Guid = $AuditGuid
        }

        if ($PSBoundParameters.ContainsKey('AuditFilter'))
        {
            $AuditObject.Filter = $AuditFilter
        }

        $AuditObject.Alter()

        if ($PassThru.IsPresent)
        {
            return $AuditObject
        }
    }
}
#EndRegion './Public/Set-SqlDscAudit.ps1' 347
#Region './Public/Set-SqlDscDatabasePermission.ps1' 0
<#
    .SYNOPSIS
        Set permission for a database principal.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER DatabaseName
        Specifies the database name.

    .PARAMETER Name
        Specifies the name of the database principal for which the permissions are
        set.

    .PARAMETER State
        Specifies the state of the permission.

    .PARAMETER Permission
        Specifies the permissions.

    .PARAMETER WithGrant
        Specifies that the principal should also be granted the right to grant
        other principals the same permission. This parameter is only valid when
        parameter **State** is set to `Grant` or `Revoke`. When the parameter
        **State** is set to `Revoke` the right to grant will also be revoked,
        and the revocation will cascade.

    .PARAMETER Force
        Specifies that the permissions should be set with out any confirmation.

    .OUTPUTS
        None.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine

        $setPermission = [Microsoft.SqlServer.Management.Smo.DatabasePermissionSet] @{
            Connect = $true
            Update = $true
        }

        Set-SqlDscDatabasePermission -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal' -State 'Grant' -Permission $setPermission

        Sets the permissions for the principal 'MyPrincipal'.

    .NOTES
        This command excludes fixed roles like _db_datareader_ by default, and will
        always throw a non-terminating error if a fixed role is specified as **Name**.

        If specifying `-ErrorAction 'SilentlyContinue'` then the command will silently
        ignore if the database (parameter **DatabaseName**) is not present or the
        database principal is not present. If specifying `-ErrorAction 'Stop'` the
        command will throw an error if the database or database principal is missing.
#>
function Set-SqlDscDatabasePermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('AvoidThrowOutsideOfTry', '', Justification = 'Because the code throws based on an prior expression')]
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    [OutputType()]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DatabaseName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Grant', 'Deny', 'Revoke')]
        [System.String]
        $State,

        [Parameter(Mandatory = $true)]
        [Microsoft.SqlServer.Management.Smo.DatabasePermissionSet]
        $Permission,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $WithGrant,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force
    )

    if ($State -eq 'Deny' -and $WithGrant.IsPresent)
    {
        Write-Warning -Message $script:localizedData.DatabasePermission_IgnoreWithGrantForStateDeny
    }

    if ($Force.IsPresent)
    {
        $ConfirmPreference = 'None'
    }

    $sqlDatabaseObject = $null

    if ($ServerObject.Databases)
    {
        $sqlDatabaseObject = $ServerObject.Databases[$DatabaseName]
    }

    if ($sqlDatabaseObject)
    {
        $testSqlDscIsDatabasePrincipalParameters = @{
            ServerObject      = $ServerObject
            DatabaseName      = $DatabaseName
            Name              = $Name
            ExcludeFixedRoles = $true
        }

        $isDatabasePrincipal = Test-SqlDscIsDatabasePrincipal @testSqlDscIsDatabasePrincipalParameters

        if ($isDatabasePrincipal)
        {
            # Get the permissions names that are set to $true in the DatabasePermissionSet.
            $permissionName = $Permission |
                Get-Member -MemberType 'Property' |
                Select-Object -ExpandProperty 'Name' |
                Where-Object -FilterScript {
                    $Permission.$_
                }

            $verboseDescriptionMessage = $script:localizedData.DatabasePermission_ChangePermissionShouldProcessVerboseDescription -f $Name, $DatabaseName, $ServerObject.InstanceName
            $verboseWarningMessage = $script:localizedData.DatabasePermission_ChangePermissionShouldProcessVerboseWarning -f $Name
            $captionMessage = $script:localizedData.DatabasePermission_ChangePermissionShouldProcessCaption

            if (-not $PSCmdlet.ShouldProcess($verboseDescriptionMessage, $verboseWarningMessage, $captionMessage))
            {
                # Return without doing anything if the user did not want to continue processing.
                return
            }

            switch ($State)
            {
                'Grant'
                {
                    Write-Verbose -Message (
                        $script:localizedData.DatabasePermission_GrantPermission -f ($permissionName -join ','), $Name
                    )

                    if ($WithGrant.IsPresent)
                    {
                        $sqlDatabaseObject.Grant($Permission, $Name, $true)
                    }
                    else
                    {
                        $sqlDatabaseObject.Grant($Permission, $Name)
                    }
                }

                'Deny'
                {
                    Write-Verbose -Message (
                        $script:localizedData.DatabasePermission_DenyPermission -f ($permissionName -join ','), $Name
                    )

                    $sqlDatabaseObject.Deny($Permission, $Name)
                }

                'Revoke'
                {
                    Write-Verbose -Message (
                        $script:localizedData.DatabasePermission_RevokePermission -f ($permissionName -join ','), $Name
                    )

                    if ($WithGrant.IsPresent)
                    {
                        $sqlDatabaseObject.Revoke($Permission, $Name, $false, $true)
                    }
                    else
                    {
                        $sqlDatabaseObject.Revoke($Permission, $Name)
                    }
                }
            }
        }
        else
        {
            $missingPrincipalMessage = $script:localizedData.DatabasePermission_MissingPrincipal -f $Name, $DatabaseName

            $PSCmdlet.ThrowTerminatingError(
                [System.Management.Automation.ErrorRecord]::new(
                    $missingPrincipalMessage,
                    'GSDDP0001',
                    [System.Management.Automation.ErrorCategory]::InvalidOperation,
                    $Name
                )
            )
        }
    }
    else
    {
        $missingDatabaseMessage = $script:localizedData.DatabasePermission_MissingDatabase -f $DatabaseName

        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                $missingDatabaseMessage,
                'GSDDP0002',
                [System.Management.Automation.ErrorCategory]::InvalidOperation,
                $DatabaseName
            )
        )
    }
}
#EndRegion './Public/Set-SqlDscDatabasePermission.ps1' 213
#Region './Public/Set-SqlDscServerPermission.ps1' 0
<#
    .SYNOPSIS
        Set permission for a login.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER Name
        Specifies the name of the principal for which the permissions are set.

    .PARAMETER State
        Specifies the state of the permission.

    .PARAMETER Permission
        Specifies the permissions.

    .PARAMETER WithGrant
        Specifies that the principal should also be granted the right to grant
        other principals the same permission. This parameter is only valid when
        parameter **State** is set to `Grant` or `Revoke`. When the parameter
        **State** is set to `Revoke` the right to grant will also be revoked,
        and the revocation will cascade.

    .PARAMETER Force
        Specifies that the permissions should be set with out any confirmation.

    .OUTPUTS
        None.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine

        $setPermission = [Microsoft.SqlServer.Management.Smo.ServerPermissionSet] @{
            Connect = $true
            Update = $true
        }

        Set-SqlDscServerPermission -ServerObject $serverInstance -Name 'MyPrincipal' -State 'Grant' -Permission $setPermission

        Sets the permissions for the principal 'MyPrincipal'.

    .NOTES
        If specifying `-ErrorAction 'SilentlyContinue'` then the command will silently
        ignore if the principal is not present. If specifying `-ErrorAction 'Stop'` the
        command will throw an error if the principal is missing.
#>
function Set-SqlDscServerPermission
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('AvoidThrowOutsideOfTry', '', Justification = 'Because the code throws based on an prior expression')]
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    [OutputType()]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter(Mandatory = $true)]
        [ValidateSet('Grant', 'Deny', 'Revoke')]
        [System.String]
        $State,

        [Parameter(Mandatory = $true)]
        [Microsoft.SqlServer.Management.Smo.ServerPermissionSet]
        $Permission,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $WithGrant,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $Force
    )

    if ($State -eq 'Deny' -and $WithGrant.IsPresent)
    {
        Write-Warning -Message $script:localizedData.ServerPermission_IgnoreWithGrantForStateDeny
    }

    if ($Force.IsPresent)
    {
        $ConfirmPreference = 'None'
    }

    $testSqlDscIsLoginParameters = @{
        ServerObject      = $ServerObject
        Name              = $Name
    }

    $isLogin = Test-SqlDscIsLogin @testSqlDscIsLoginParameters

    if ($isLogin)
    {
        # Get the permissions names that are set to $true in the ServerPermissionSet.
        $permissionName = $Permission |
            Get-Member -MemberType 'Property' |
            Select-Object -ExpandProperty 'Name' |
            Where-Object -FilterScript {
                $Permission.$_
            }

        $verboseDescriptionMessage = $script:localizedData.ServerPermission_ChangePermissionShouldProcessVerboseDescription -f $Name, $ServerObject.InstanceName
        $verboseWarningMessage = $script:localizedData.ServerPermission_ChangePermissionShouldProcessVerboseWarning -f $Name
        $captionMessage = $script:localizedData.ServerPermission_ChangePermissionShouldProcessCaption

        if (-not $PSCmdlet.ShouldProcess($verboseDescriptionMessage, $verboseWarningMessage, $captionMessage))
        {
            # Return without doing anything if the user did not want to continue processing.
            return
        }

        switch ($State)
        {
            'Grant'
            {
                Write-Verbose -Message (
                    $script:localizedData.ServerPermission_GrantPermission -f ($permissionName -join ','), $Name
                )

                if ($WithGrant.IsPresent)
                {
                    $ServerObject.Grant($Permission, $Name, $true)
                }
                else
                {
                    $ServerObject.Grant($Permission, $Name)
                }
            }

            'Deny'
            {
                Write-Verbose -Message (
                    $script:localizedData.ServerPermission_DenyPermission -f ($permissionName -join ','), $Name
                )

                $ServerObject.Deny($Permission, $Name)
            }

            'Revoke'
            {
                Write-Verbose -Message (
                    $script:localizedData.ServerPermission_RevokePermission -f ($permissionName -join ','), $Name
                )

                if ($WithGrant.IsPresent)
                {
                    $ServerObject.Revoke($Permission, $Name, $false, $true)
                }
                else
                {
                    $ServerObject.Revoke($Permission, $Name)
                }
            }
        }
    }
    else
    {
        $missingPrincipalMessage = $script:localizedData.ServerPermission_MissingPrincipal -f $Name, $ServerObject.InstanceName

        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                $missingPrincipalMessage,
                'GSDDP0001',
                [System.Management.Automation.ErrorCategory]::InvalidOperation,
                $Name
            )
        )
    }
}
#EndRegion './Public/Set-SqlDscServerPermission.ps1' 176
#Region './Public/Test-SqlDscIsDatabasePrincipal.ps1' 0
<#
    .SYNOPSIS
        Returns whether the database principal exist.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER DatabaseName
        Specifies the SQL database name.

    .PARAMETER Name
        Specifies the name of the database principal.

    .PARAMETER ExcludeUsers
        Specifies that database users should not be evaluated.

    .PARAMETER ExcludeRoles
        Specifies that database roles should not be evaluated for the specified
        name. This will also exclude fixed roles.

    .PARAMETER ExcludeFixedRoles
        Specifies that fixed roles should not be evaluated for the specified name.

    .PARAMETER ExcludeApplicationRoles
        Specifies that fixed application roles should not be evaluated for the
        specified name.

    .OUTPUTS
        [System.Boolean]

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Test-SqlDscIsDatabasePrincipal -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal'

        Returns $true if the principal exist in the database, if not $false is returned.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Test-SqlDscIsDatabasePrincipal -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal' -ExcludeUsers

        Returns $true if the principal exist in the database and is not a user, if not $false is returned.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Test-SqlDscIsDatabasePrincipal -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal' -ExcludeRoles

        Returns $true if the principal exist in the database and is not a role, if not $false is returned.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Test-SqlDscIsDatabasePrincipal -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal' -ExcludeFixedRoles

        Returns $true if the principal exist in the database and is not a fixed role, if not $false is returned.

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Test-SqlDscIsDatabasePrincipal -ServerObject $serverInstance -DatabaseName 'MyDatabase' -Name 'MyPrincipal' -ExcludeApplicationRoles

        Returns $true if the principal exist in the database and is not a application role, if not $false is returned.
#>
function Test-SqlDscIsDatabasePrincipal
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DatabaseName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $ExcludeUsers,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $ExcludeRoles,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $ExcludeFixedRoles,

        [Parameter()]
        [System.Management.Automation.SwitchParameter]
        $ExcludeApplicationRoles
    )

    $principalExist = $false

    $sqlDatabaseObject = $ServerObject.Databases[$DatabaseName]

    if (-not $sqlDatabaseObject)
    {
        $PSCmdlet.ThrowTerminatingError(
            [System.Management.Automation.ErrorRecord]::new(
                ($script:localizedData.IsDatabasePrincipal_DatabaseMissing -f $DatabaseName),
                'TSDISO0001',
                [System.Management.Automation.ErrorCategory]::InvalidOperation,
                $DatabaseName
            )
        )
    }

    if (-not $ExcludeUsers.IsPresent -and $sqlDatabaseObject.Users[$Name])
    {
        $principalExist = $true
    }

    if (-not $ExcludeRoles.IsPresent)
    {
        $userDefinedRole = if ($ExcludeFixedRoles.IsPresent)
        {
            # Skip fixed roles like db_datareader.
            $sqlDatabaseObject.Roles | Where-Object -FilterScript {
                -not $_.IsFixedRole -and $_.Name -eq $Name
            }
        }
        else
        {
            $sqlDatabaseObject.Roles[$Name]
        }

        if ($userDefinedRole)
        {
            $principalExist = $true
        }
    }

    if (-not $ExcludeApplicationRoles.IsPresent -and $sqlDatabaseObject.ApplicationRoles[$Name])
    {
        $principalExist = $true
    }

    return $principalExist
}
#EndRegion './Public/Test-SqlDscIsDatabasePrincipal.ps1' 145
#Region './Public/Test-SqlDscIsLogin.ps1' 0
<#
    .SYNOPSIS
        Returns whether the database principal exist.

    .PARAMETER ServerObject
        Specifies current server connection object.

    .PARAMETER Name
        Specifies the name of the database principal.

    .OUTPUTS
        [System.Boolean]

    .EXAMPLE
        $serverInstance = Connect-SqlDscDatabaseEngine
        Test-SqlDscIsLogin -ServerObject $serverInstance -Name 'MyPrincipal'

        Returns $true if the principal exist as a login, if not $false is returned.
#>
function Test-SqlDscIsLogin
{
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseSyntacticallyCorrectExamples', '', Justification = 'Because the rule does not yet support parsing the code when a parameter type is not available. The ScriptAnalyzer rule UseSyntacticallyCorrectExamples will always error in the editor due to https://github.com/indented-automation/Indented.ScriptAnalyzerRules/issues/8.')]
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Microsoft.SqlServer.Management.Smo.Server]
        $ServerObject,

        [Parameter(Mandatory = $true)]
        [System.String]
        $Name
    )

    $loginExist = $false

    if ($ServerObject.Logins[$Name])
    {
        $loginExist = $true
    }

    return $loginExist
}
#EndRegion './Public/Test-SqlDscIsLogin.ps1' 45
