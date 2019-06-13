



	$target = "localhost"
    $Date = Get-Date
	
    $ComputerSystem = Get-WmiObject -computername $Target Win32_ComputerSystem
	switch ($ComputerSystem.DomainRole)
	{
		0 { $ComputerRole = "Standalone Workstation" }
		1 { $ComputerRole = "Member Workstation" }
		2 { $ComputerRole = "Standalone Server" }
		3 { $ComputerRole = "Member Server" }
		4 { $ComputerRole = "Domain Controller" }
		5 { $ComputerRole = "Domain Controller" }
		default { $ComputerRole = "Information not available" }
	}
	
	$ComputerSystem.Name 
	$ComputerSystem.Domain
    $ComputerSystem.Manufacturer
    $ComputerSystem.Model 
    $ComputerSystem.NumberOfProcessors
    $ComputerSystem.TotalPhysicalMemory
    $ComputerSystem.PrimaryOwnerName

    $OperatingSystems = Get-WmiObject -computername $Target Win32_OperatingSystem
    $OperatingSystems.Caption 
    $OperatingSystems.CSDVersion
    $OperatingSystems.SystemDrive
    $OperatingSystems.Organization
    $OperatingSystems.ConvertToDateTime($OperatingSystems.Lastbootuptime)

    Get-WmiObject -computername $Target Win32_Timezone

	$Keyboards = Get-WmiObject -computername $Target Win32_Keyboard
	$Keyboards.Layout


	Get-WmiObject -computername $Target Win32_ScheduledJob
	Get-WmiObject -computername $Target Win32_OSRecoveryConfiguration
	
	
	
	$colQuickFixes = Get-WmiObject Win32_QuickFixEngineering
	ForEach ($objQuickFix in $colQuickFixes)
	{
		if ($objQuickFix.HotFixID -ne "File 1")
		{
			$objQuickFix.HotFixID 
            $objQuickFix.Description 
		}
	}
	
	
		
	$colDisks = Get-WmiObject -ComputerName $Target Win32_LogicalDisk
	Foreach ($objDisk in $colDisks)
	{
		if ($objDisk.DriveType -eq 3)
		{
			$objDisk.DeviceID
            $objDisk.VolumeName
            $objDisk.FileSystem
			$disksize = [math]::round(($objDisk.size / 1048576))

			$freespace = [math]::round(($objDisk.FreeSpace / 1048576))
			
			$percFreespace=[math]::round(((($objDisk.FreeSpace / 1048576)/($objDisk.Size / 1048676)) * 100),0)
			
        }

	}


	$colAdapters = Get-WmiObject -ComputerName $Target Win32_NetworkAdapterConfiguration
	Foreach ($objAdapter in $colAdapters)
	{
		if ($objAdapter.IPEnabled -eq "True")
		{
			
			$objAdapter.Description 
            $objAdapter.MACaddress

		If ($objAdapter.IPAddress -ne $Null)
		{
            $objAdapter.IPAddress
            $objAdapter.IPSubnet 
            $objAdapter.DefaultIPGateway 
            $objAdapter.DHCPEnabled
		}
		If ($objAdapter.DNSServerSearchOrder -ne $Null)
		{
			$objAdapter.DNSServerSearchOrder 
		}
		$objAdapter.WINSPrimaryServer 
		$objAdapter.WINSSecondaryServer 

		}
	}
	
	
	if ((get-wmiobject -namespace "root/cimv2" -list) | ? {$_.name -match "Win32_Product"})
	{
		$colShares = get-wmiobject -ComputerName $Target Win32_Product | select Name,Version,Vendor,InstallDate
		Foreach ($objShare in $colShares)
		{
			$objShare.Name 
			$objShare.Version 
			$objShare.Vendor 
			$objShare.InstallDate 
		}
	}	

	
	$colShares = Get-wmiobject -ComputerName $Target Win32_Share
	Foreach ($objShare in $colShares)
	{
		$objShare.Name 
		$objShare.Path 
		$objShare.Caption 
	}
	
	
	
	
	$colInstalledPrinters =  Get-WmiObject -ComputerName $Target Win32_Printer
	Foreach ($objPrinter in $colInstalledPrinters)
	{
			$objPrinter.Name 
			$objPrinter.Location 
			$objPrinter.Default 
			$objPrinter.Portname
	}


	$colListOfServices = Get-WmiObject -ComputerName $Target Win32_Service
	Foreach ($objService in $colListOfServices)
	{
		$objService.Caption
		$objService.Startname
		$objService.StartMode
		$objService.State 
	}
	


	
	$colLogFiles = Get-WmiObject -ComputerName $Target Win32_NTEventLogFile
	ForEach ($objLogFile in $colLogfiles)	
	{
		$objLogFile.LogFileName
		$objLogfile.OverWriteOutdated
		(($objLogfile.MaxFileSize)/1024) 
	}	