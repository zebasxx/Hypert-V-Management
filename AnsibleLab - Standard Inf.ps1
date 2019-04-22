<#
Description of elemnts in the multidimentional array
("VM Name", "'Memoy'mb", "Viryual Switch Name", "VCPU", "Nested Virtualiz, $true or $false", "VHD Parent Path", "VHD Path\VHD Mame")
#>
Clear-Host

$VMs =  @(
    [pscustomobject]@{
        VMName = "WinSrv2019C - DC01";                                          #VMName Example
        VMMemory=4096MB;                                                            #Ammount of RAM, without quitation
        VMVSwitch="192.168.0.0/24";                                                 #Name of the Virtual Switch to use.
        VMVCore=2;                                                                  #Number of cores
        VMNV=$true;                                                                 #Nested Virtualization? Allo you to install Hyper-V on a VM
        VHDxParentPath="C:\Base Images\WinSrv2019C - Base Image.vhdx";              #Path Parent VHDx
        VMVHDxPath="D:\VMs\VHDs\AnsibleLab\WinSrv2019D - DC01.vhdx"             #Path to New VHDx location
    },
    [pscustomobject]@{
        VMName = "WinSrv2019D - ProdSrv01";
        VMMemory=4096MB;
        VMVSwitch="192.168.0.0/24";
        VMVCore=2;
        VMNV=$true;
        VHDxParentPath="C:\Base Images\WinSrv2019D - Base Image.vhdx";
        VMVHDxPath="D:\VMs\VHDs\AnsibleLab\WinSrv2019D - ProdSrv01.vhdx"
    },
    [pscustomobject]@{
        VMName = "WinSrv2019D - ProdSrv02";
        VMMemory=4096MB;
        VMVSwitch="192.168.0.0/24";
        VMVCore=2;
        VMNV=$true;
        VHDxParentPath="C:\Base Images\WinSrv2019D - Base Image.vhdx";
        VMVHDxPath="D:\VMs\VHDs\AnsibleLab\WinSrv2019D - ProdSrv02.vhdx"
    }
)

foreach ($VM in $VMs){
    New-VHD -ParentPath $VM.VHDxParentPath -Path $VM.VMVHDxPath -Differencing
    New-VM -Name $VM.VMName -MemoryStartupBytes $VM.VMMemory -BootDevice VHD -VHDPath $VM.VMVHDxPath -Generation 1 -Switch $VM.VMVSwitch
    Set-VMProcessor $VM.VMName -Count $VM.VMVCore -ExposeVirtualizationExtensions $VM.VMNV
}