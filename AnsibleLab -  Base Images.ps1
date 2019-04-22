<#
Description of elemnts in the multidimentional array
("VM Name", "'Memoy'mb", "Viryual Switch Name", "VCPU", "Nested Virtualiz, $true or $false", "ISO Path", "VHD Path\VHD Mame", "VHD Size")
#>
Clear-Host

$VMs =  @(
    [pscustomobject]@{
        VMName = "WinSrv2019D - Base Image";
        VMMemory=4096MB;
        VMVSwitch="192.168.0.0/24";
        VMVCore=2;
        VMNV=$true;
        VMISOPath="C:\Base Images\ISO\Windows Server\WinSrv2019\17763.379.190312-0539.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso";
        VMVHDxPath="D:\VMs\VHDs\AnsibleLab\WinSrv2019D - Base Image.vhdx";
        VMVHDxSize=40GB
    },
    [pscustomobject]@{
        VMName = "WinSrv2019C - Base Image";
        VMMemory=4096MB;
        VMVSwitch="192.168.0.0/24";
        VMVCore=2;
        VMNV=$true;
        VMISOPath="C:\Base Images\ISO\Windows Server\WinSrv2019\17763.379.190312-0539.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso";
        VMVHDxPath="D:\VMs\VHDs\AnsibleLab\WinSrv2019C - Base Image.vhdx";
        VMVHDxSize=40GB
    }
)

foreach ($VM in $VMs){
    New-VHD -Path $VM.VMVHDxPath $VM.VMVHDxSize
    New-VM -Name $VM.VMName -MemoryStartupBytes $VM.VMMemory -BootDevice VHD -VHDPath $VM.VMVHDxPath -Generation 1 -Switch $VM.VMVSwitch
    Set-VMProcessor $VM.VMName -Count $VM.VMVCore -ExposeVirtualizationExtensions $VM.VMNV
    Set-VMDvdDrive -VMName $VM.VMName -Path $VM.VMISOPath
}
