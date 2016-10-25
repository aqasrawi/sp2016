<#
.EXAMPLE
    This example shows how a basic SharePoint farm can be created. The database server and names
    are specified, and the accounts to run the setup as, the farm account and the passphrase are
    all passed in to the configuration to be applied. By default the central admin site in this
    example is provisioned to port 9999 using NTLM authentication.
#>
#
#Save-Module -Name xComputerManagement -Path C:\Users\aqasrawi\Documents\GitHub\sp2016\dsc\ConfigureSharePointServer.ps1

    Configuration ConfigureSharePointServer 
    {
        param(
            [Parameter(Mandatory = $true)]
            [PSCredential]
            $FarmAccount,

            [Parameter(Mandatory = $true)]
            [PSCredential]
            $SetupAccount,

            [Parameter(Mandatory = $true)]
            [PSCredential]
            $Passphrase
        )
        Import-DscResource -ModuleName SharePointDsc, xComputerManagement

        node localhost {
            SPCreateFarm CreateFarm
            {
                DatabaseServer            = "SPFARM2016V-SQL"
                FarmConfigDatabaseName    = "SP_Config"
                AdminContentDatabaseName  = "SP_AdminContent"
                Passphrase                = $Passphrase
                FarmAccount               = $FarmAccount
                PsDscRunAsCredential      = $SetupAccount
            }
        }
    }
