<#
Description of elemnts in the multidimentional array
("VM Name", "'Memoy'mb", "Viryual Switch Name", "VCPU", "Nested Virtualiz, $true or $false", "VHD Parent Path", "VHD Path\VHD Mame")
#>
Clear-Host

$VMs =  @("VM Name", "'Memoy'mb", "Viryual Switch Name", "VCPU", "Nested Virtualiz, $true or $false", "VHD Parent Path", "VHD Path\VHD Mame"), 
        @("Second VM"), 
        @("Third VM and so on")


#New-VHD -ParentPath "C:\Base Images\WinSrv2016C- LTS - Base.vhdx" -Path "D:\VMs\VHDs\SwarmLab\SLWNode01.vhdx" -Differencing;New-VM -Name SLWNod01 -MemoryStartupBytes 4096mb -BootDevice VHD -VHDPath "D:\VMs\VHDs\SwarmLab\SLWNode01.vhdx" -Generation 1 -Switch "192.168.0.0/24";Set-VMProcessor SLWNod01 -Count 2 -ExposeVirtualizationExtensions $true

foreach ($VM in $VMs){

    Write-Output $VM

}

Start-Sleep -Seconds 5

