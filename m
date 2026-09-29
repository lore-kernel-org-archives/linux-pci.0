Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4B2BE655
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715707; cv=none; b=PURbWDxT6IxiC1Ul25YZCAWFhJKM11i2L2e3rIVCWVH9JfmMi0lkH9icyHv+O1xMmVcM4toA5oMcoNEdM6jn8iP5nu1JAEYX36f7g73Y94LOkO5ulzAaXxsWo0PLbT48d1LY46cWm4Aa2tE3X2Nd74CTsYGVPU8gx1d8m7aO/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715707; c=relaxed/simple;
	bh=Wn6TKken5cvfESdJlcWqAvv6xpMyhnoxVICl5ryM5ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjDf3Zk3bifGTdaBF/4EGnVl3eCni/ldliBpMfZYntFuLDl6glabo+StvPEnx7xaanuS9KONTBv2rpizmhZSgzDpXWRy7MvkeG2UUsP6bjQZoPNHxC3lr3yH2OQpNtZzzzd1rR7uhHpEPOAxng3/nkjt4w1HfRT1dBQEfbZNo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3zu8IOj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3zu8IOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790715705; x=1822251705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wn6TKken5cvfESdJlcWqAvv6xpMyhnoxVICl5ryM5ss=;
  b=T3zu8IOjsu0j4CKjHrV2jm4ZB4oUAV/0Qw8WUJTZYe0m3wco2h6gRvec
   AkyRYS4me5b7BJ0VKgi8dmP3SN4Un78y17ypBQ+ko4lQksYDx+cUFY+a4
   E5Vg+zt8S193VbOsP6lI/6CUAQKH4EHle31U7faXCY6cJ2j2/YTRKQaFP
   K55gnh3F+EsY4p4hCtvvt9vuDKmDY6rL+ayql1eOqcxf6t1mA+TqbULpk
   rOmnUrhSBj1suC7Fl6ryvpfAuSZoOja60jQqWmlqQn0Ko+1gOFGIWdKX8
   JxzTIE9l4FfWuTezGZRX1ZlXX0U7qRiuQYYnOHhx191kZfgOJop9gYWyU
   w==;
X-CSE-ConnectionGUID: YAazDiL6Ssa5WNF9qBiYCA==
X-CSE-MsgGUID: kMYEytqiTnu4QLVVlIByjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="93933468"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="93933468"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 14:01:44 -0700
X-CSE-ConnectionGUID: 3xLeAtu9RMWUp+erNACWxQ==
X-CSE-MsgGUID: ryHINqvkQdeiKTK50OnShw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275028824"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 14:01:45 -0700
Message-ID: <510d0d71-f7b3-4988-befa-34ca91d92e77@linux.intel.com>
Date: Tue, 29 Sep 2026 14:01:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] PCI/AER: Enable baseline capability error reporting
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>,
 linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
References: <cover.1790531238.git.lukas@wunner.de>
 <42a76bec58f9a844ef8d8405abafd6680b7f2ecc.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <42a76bec58f9a844ef8d8405abafd6680b7f2ecc.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> PCIe r7.1 sec 6.2.1 defines two error reporting paradigms:  Baseline
> capability and Advanced Error Reporting Extended Capability (AER).
> 
> So far the kernel only supports the AER paradigm.  Enable the baseline
> capability paradigm to complete the kernel's support for error reporting.
> 
> Baseline capability (solely) relies on the error enable/status bits in the
> Device Control and Device Status registers, which exist on every PCIe
> device.  One difference between baseline capability and AER is that the
> severity of Uncorrectable Errors cannot be controlled.  Another difference
> is that Advisory Non-Fatal Errors are not reported at all (PCIe r7.1 sec
> 6.2.5).
> 
> But the main difference to AER is that no detailed error information is
> available:  It is only known that an error occurred and which severity it
> had, but not its type or the Prefix / Header of the TLP that caused it.
> An exception are Unsupported Request Errors which are signaled with a
> dedicated bit in the Device Status register.  Report these as if the
> Unsupported Request Error Status bit in the Uncorrectable Error Status
> register was set, for consistency with the AER paradigm.
> 
> Error recovery works the same for baseline capability as it already does
> for AER:  Drivers are informed about errors through the pci_error_handlers
> callbacks.  Recovery from Fatal Errors (and from Non-Fatal Errors, if
> chosen by drivers) is attempted through a Secondary Bus Reset.
> 
> Similarly to commit f26e58bf6f54 ("PCI/AER: Enable error reporting when
> AER is native"), which universally enabled error reporting on AER-capable
> devices, the present commit is invasive because it universally enables
> error reporting on non-AER-capable devices.  Previously those errors were
> neither reported nor recovered.  It may be necessary to amend more drivers
> with pci_error_handlers callbacks to recover from newly reported errors.
> 
> Baseline capability is only enabled if firmware grants AER control to the
> operating system.  Otherwise firmware owns the error enable/status bits in
> the Device Control and Device Status registers (PCI Firmware r3.3 table
> 4-6 bit 3).
> 
> Baseline capability support is initially only implemented for native error
> handling, not Firmware First error handling:  ghes_handle_aer() would have
> to be amended to pass the Device Control and Device Status registers to
> aer_recover_queue(), and to only pass an AER capability structure if it is
> present in the CPER record.  It's not clear whether any firmware actually
> generates such CPER records and whether implementing support for it is
> worthwhile, so postpone that for now.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20260826212619.GA1566339@bhelgaas/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  .../ABI/testing/sysfs-bus-pci-devices-aer     | 26 ++++++++----
>  Documentation/PCI/pcieaer-howto.rst           |  9 ++--
>  drivers/pci/pcie/aer.c                        | 42 ++++++++++++-------
>  drivers/pci/pcie/dpc.c                        |  2 +-
>  4 files changed, 50 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> index 5ed284523956..9e772e1ed9b3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> @@ -1,9 +1,9 @@
>  PCIe Device AER statistics
>  --------------------------
>  
> -These attributes show up under all the devices that are AER capable. These
> +These attributes show up under all PCIe devices (AER capable or not). These
>  statistical counters indicate the errors "as seen/reported by the device".
> -Note that this may mean that if an endpoint is causing problems, the AER
> +Note that this may mean that if an endpoint is causing problems, the error
>  counters may increment at its link partner (e.g. root port) because the
>  errors may be "seen" / reported by the link partner and not the
>  problematic endpoint itself (which may report all counters as 0 as it never
> @@ -17,7 +17,10 @@ Description:	List of correctable errors seen and reported by this
>  		PCI device using ERR_COR. Note that since multiple errors may
>  		be reported using a single ERR_COR message, thus
>  		TOTAL_ERR_COR at the end of the file may not match the actual
> -		total of all the errors in the file. Sample output::
> +		total of all the errors in the file.
> +		For PCIe devices without AER Extended Capability, only the
> +		total counter is meaningful while all other counters remain 0.
> +		Sample output::
>  
>  		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_correctable
>  		    Receiver Error 2
> @@ -38,7 +41,10 @@ Description:	List of uncorrectable fatal errors seen and reported by this
>  		PCI device using ERR_FATAL. Note that since multiple errors may
>  		be reported using a single ERR_FATAL message, thus
>  		TOTAL_ERR_FATAL at the end of the file may not match the actual
> -		total of all the errors in the file. Sample output::
> +		total of all the errors in the file.
> +		For PCIe devices without AER Extended Capability, only the
> +		total counter is meaningful while all other counters remain 0.
> +		Sample output::
>  
>  		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_fatal
>  		    Undefined 0
> @@ -68,7 +74,11 @@ Description:	List of uncorrectable nonfatal errors seen and reported by this
>  		PCI device using ERR_NONFATAL. Note that since multiple errors
>  		may be reported using a single ERR_FATAL message, thus
>  		TOTAL_ERR_NONFATAL at the end of the file may not match the
> -		actual total of all the errors in the file. Sample output::
> +		actual total of all the errors in the file.
> +		For PCIe devices without AER Extended Capability, only the
> +		total counter and the Unsupported Request counter is meaningful
> +		while all other counters remain 0.
> +		Sample output::
>  
>  		    localhost /sys/devices/pci0000:00/0000:00:1c.0 # cat aer_dev_nonfatal
>  		    Undefined 0
> @@ -121,7 +131,7 @@ Description:	Total number of ERR_NONFATAL messages reported to rootport.
>  PCIe AER ratelimits
>  -------------------
>  
> -These attributes show up under all the devices that are AER capable.
> +These attributes show up under all PCIe devices (AER capable or not).
>  They represent configurable ratelimits of logs per error type.
>  
>  See Documentation/PCI/pcieaer-howto.rst for more info on ratelimits.
> @@ -130,7 +140,7 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
>  Date:		May 2025
>  KernelVersion:	6.16.0
>  Contact:	linux-pci@vger.kernel.org
> -Description:	Writing 0 disables AER correctable error log ratelimiting.
> +Description:	Writing 0 disables Correctable Error log ratelimiting.
>  		Writing a positive value sets the ratelimit interval in ms.
>  		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
>  
> @@ -147,7 +157,7 @@ What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
>  Date:		May 2025
>  KernelVersion:	6.16.0
>  Contact:	linux-pci@vger.kernel.org
> -Description:	Writing 0 disables AER non-fatal uncorrectable error log
> +Description:	Writing 0 disables Non-Fatal Uncorrectable Error log
>  		ratelimiting. Writing a positive value sets the ratelimit
>  		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
>  		(5000 ms).
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 90fdfddd3ae5..e969e563b61d 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -34,9 +34,8 @@ set of error reporting requirements. Advanced Error Reporting
>  capability is implemented with a PCIe Advanced Error Reporting
>  extended capability structure providing more robust error reporting.
>  
> -The PCIe AER driver provides the infrastructure to support PCIe Advanced
> -Error Reporting capability. The PCIe AER driver provides three basic
> -functions:
> +The PCIe AER driver provides the infrastructure to support both paradigms.
> +It provides three basic functions:
>  
>    - Gathers the comprehensive error information if errors occurred.
>    - Reports error to the users.
> @@ -69,7 +68,7 @@ Specification for details regarding _OSC usage.
>  AER error output
>  ----------------
>  
> -When a PCIe AER error is captured, an error message will be output to
> +When a PCIe error is captured, an error message will be output to
>  console. If it's a correctable error, it is output as a warning message.
>  Otherwise, it is printed as an error. So users could choose different
>  log level to filter out correctable error messages.
> @@ -113,7 +112,7 @@ See Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
>  AER Statistics / Counters
>  -------------------------
>  
> -When PCIe AER errors are captured, the counters / statistics are also exposed
> +When PCIe errors are captured, the counters / statistics are also exposed
>  in the form of sysfs attributes which are documented at
>  Documentation/ABI/testing/sysfs-bus-pci-devices-aer.
>  
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6bc843ab9b37..62376aab4b6f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -397,21 +397,22 @@ void pci_aer_init(struct pci_dev *dev)
>  {
>  	int n;
>  
> -	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> -	if (!dev->aer_cap)
> +	if (!pci_is_pcie(dev))
>  		return;
>  
>  	dev->aer_info = kzalloc_obj(*dev->aer_info);
> -	if (!dev->aer_info) {
> -		dev->aer_cap = 0;
> +	if (!dev->aer_info)
>  		return;
> -	}
>  
>  	ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
>  			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
>  	ratelimit_state_init(&dev->aer_info->nonfatal_ratelimit,
>  			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
>  
> +	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!dev->aer_cap)
> +		goto enable;
> +
>  	/*
>  	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>  	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> @@ -431,6 +432,9 @@ void pci_aer_init(struct pci_dev *dev)
>  					       PCI_ERR_COR_ADV_NFAT, 0);
>  
>  	pci_aer_clear_status(dev);
> +enable:
> +	if (pcie_aer_is_native(dev))
> +		pcie_clear_device_status(dev);
>  
>  	if (pci_aer_available())
>  		pci_enable_pcie_error_reporting(dev);

This also enables error reporting below AER-incapable Root Ports, where
no AER service handles the ERR_* Messages.  The Root Control System
Error enable bits are only cleared by aer_enable_rootport(), which
doesn't run on such ports.  If firmware left them set, the newly
enabled Messages could result in System Errors.

Should reporting be enabled only if an AER service (or DPC) is above
the device?  Or alternatively, clear the Root Control System Error
enable bits on AER-incapable Root Ports?

> @@ -980,15 +984,12 @@ void aer_print_error(struct aer_err_info *info, int i)
>  	if (!info->ratelimit_print[i])
>  		goto anfe;
>  
> -	if (!info->status) {
> -		pci_err(dev, "%s Bus Error: severity=%s (Inaccessible)\n",
> -			bus_type, aer_error_severity_string[info->severity]);
> -		return;
> -	}
> -
>  	aer_printk(level, dev, "%s Bus Error: severity=%s\n",
>  		   bus_type, aer_error_severity_string[info->severity]);
>  
> +	if (!info->status)
> +		return;

For AER-capable devices, info->status == 0 mostly means ERR_FATAL on an
Endpoint or Upstream Port whose registers we deliberately didn't read.
"(Inaccessible)" explained why no details follow; maybe keep it for
dev->aer_cap, or print "(no details available)" in both cases?

> +
>  	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>  		   dev->vendor, dev->device, info->status, info->mask);
>  
> @@ -1182,8 +1183,11 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
>  	if (!(reg16 & PCI_EXP_AER_FLAGS))
>  		return false;
>  
> -	if (!aer)
> -		return false;
> +	if (!aer) {
> +		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> +		return reg16 & BIT(e_info->severity) &&
> +		       !PCI_POSSIBLE_ERROR(reg16);
> +	}
>  
>  	/* Check if error is recorded */
>  	if (e_info->severity == AER_CORRECTABLE) {
> @@ -1455,6 +1459,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  {
>  	struct pci_dev *dev;
>  	int type, aer;
> +	u16 devsta;
>  
>  	if (i >= AER_MAX_MULTI_ERR_DEVICES)
>  		return 0;
> @@ -1470,8 +1475,15 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  	info->is_cxl = pcie_is_cxl(dev);
>  
>  	/* The device might not support AER */
> -	if (!aer)
> -		return 0;
> +	if (!aer) {
> +		if (info->severity != AER_CORRECTABLE) {
> +			pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> +			if (devsta & PCI_EXP_DEVSTA_URD &&
> +			    !PCI_POSSIBLE_ERROR(devsta))
> +				info->status = PCI_ERR_UNC_UNSUP;
> +		}
> +		return 1;

I think info->mask needs to be reset here to 0.

> +	}
>  
>  	if (info->severity == AER_CORRECTABLE) {
>  		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 104ff2b91f1f..fdea3db61a4a 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -269,7 +269,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
>  			 status);
>  		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
> -		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
> +		    aer_get_device_error_info(&info, 0)) {
>  			aer_print_error(&info, 0);
>  			pci_aer_clear_nonfatal_status(pdev);
>  			pci_aer_clear_fatal_status(pdev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

