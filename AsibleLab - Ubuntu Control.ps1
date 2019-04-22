<#
Description of elemnts in the multidimentional array
("VM Name", "'Memoy'mb", "Viryual Switch Name", "VCPU", "Nested Virtualiz, $true or $false", "ISO Path", "VHD Path\VHD Mame", "VHD Size")
#>
Clear-Host
$VMs =  @(
            [pscustomobject]@{
                VMName = "Ubuntu1804 - Control";
                VMMemory=2048MB;
                VMVSwitch="192.168.0.0/24";
                VMVCore=2;
                VMNV=$true;
                VMISOPath="C:\Base Images\ISO\Linux\ubuntu-18.04.2-live-server-amd64.iso";
                VMVHDxPath="D:\VMs\VHDs\AnsibleLab\Ubuntu1804 - Control.vhdx";
                VMVHDxSize=30GB
            }
        )

foreach ($VM in $VMs){
    New-VHD -Path $VM.VMVHDxPath $VM.VMVHDxSize
    New-VM -Name $VM.VMName -MemoryStartupBytes $VM.VMMemory -BootDevice VHD -VHDPath $VM.VMVHDxPath -Generation 1 -Switch $VM.VMVSwitch
    Set-VMProcessor $VM.VMName -Count $VM.VMVCore -ExposeVirtualizationExtensions $VM.VMNV
    Set-VMDvdDrive -VMName $VM.VMName -Path $VM.VMISOPath
}
