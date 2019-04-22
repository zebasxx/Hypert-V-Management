<#
Description of elemnts in the multidimentional array
("VM Name", "'Memoy'mb", "Viryual Switch Name", "VCPU", "Nested Virtualiz, $true or $false", "ISO Path", "VHD Path\VHD Mame", "VHD Size")
#>
Clear-Host
$VMs =  @(  "Ubuntu1804 - Control",                                             
            2048MB,                                                             
            "192.168.0.0/24",                                                   
            2,                                                                  
            $true,                                                              
            "C:\Base Images\ISO\Linux\ubuntu-18.04.2-live-server-amd64.iso",    
            "D:\VMs\VHDs\AnsibleLab\Ubuntu1804 - Base Image.vhdx",              
            30GB)

foreach ($VM in $VMs){
    New-VHD -Path $VM[6] $VM[7]
    New-VM -Name $VM[0] -MemoryStartupBytes $VM[1] -BootDevice VHD -VHDPath $VM[6] -Generation 1 -Switch $VM[2]
    Set-VMProcessor $VM[0] -Count $VM[3] -ExposeVirtualizationExtensions $VM[4]
    Set-VMDvdDrive -VMName $VM[0] -Path $VM[5]
}
