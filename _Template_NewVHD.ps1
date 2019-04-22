<#
Description of elemnts in the multidimentional array
("VM Name", "'Memoy'mb", "Viryual Switch Name", "VCPU", "Nested Virtualiz, $true or $false", "ISO Path", "VHD Path\VHD Mame", "VHD Size")
#>
Clear-Host
$VMs =  @(
            "Ubuntu1804 - Base Image",  #VMName Example
            4096MB,                     #Ammount of RAM, without quitation
            "192.168.0.0/24",           #Name of the Virtual Switch to use.
            2,                          #Number of cores
            $true,                      #Nested Virtualization? Allo you to install Hyper-V on a VM
            "C:\Base Images\ISO\Linux\ubuntu-18.04.2-live-server-amd64.iso",    #Path to ISO to install the OS
            "D:\VMs\VHDs\AnsibleLab\Ubuntu1804 - Base Image.vhdx",              #Path to the location of the VHDX
            30GB                        #Size of VM
        ), 
        @(
            "WinSrv2019D - Base Image", 
            4096MB,
            "192.168.0.0/24",
            2,
            $true,
            "C:\Base Images\ISO\Windows Server\WinSrv2019\17763.379.190312-0539.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso",
            "D:\VMs\VHDs\AnsibleLab\WinSrv2019D - Base Image.vhdx",
            40GB
        )

foreach ($VM in $VMs){
    New-VHD -Path $VM[6] $VM[7]
    New-VM -Name $VM[0] -MemoryStartupBytes $VM[1] -BootDevice VHD -VHDPath $VM[6] -Generation 1 -Switch $VM[2]
    Set-VMProcessor $VM[0] -Count $VM[3] -ExposeVirtualizationExtensions $VM[4]
    Set-VMDvdDrive -VMName $VM[0] -Path $VM[5]
}
