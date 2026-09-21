Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098042CB08
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023251; cv=none; b=CXEmUdbGFCSYXCMtUkA1IkjYXoe18tMpaLJlfkYKzx58HmfaO9m0nUHnXlsDbQ2smlhuYlw6hV/9pyEWq70ut7szWCAk9TcpC70hHGBBlCxsGtIdVPErRb7nai3AqNu0tQeZ6A5L1pTrEAEvrWRoicVwhIRkaBc4m4i1Cjsupuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023251; c=relaxed/simple;
	bh=qaoZcACRWzU347wXqzAc90n72b9/pJ4Hi3Bz4ChWzrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0VPVrCFv29QGDdPMFm61p5itsO0Shh9pTLJAcmfCHPD2YaHMOPJJ39xBYiRlBoTjofpeWptPkWzPrzYQZRqMJRyVYrYSQXJ/rIpwKyh1NRrqOlji1QU+fK2rue6zRk5i76d+u3CmwNVqxm0iCsziy73SbNxFTc0pWhgz9wcg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPsrrIjC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPsrrIjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790023250; x=1821559250;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qaoZcACRWzU347wXqzAc90n72b9/pJ4Hi3Bz4ChWzrI=;
  b=EPsrrIjC9HW1YlT5QVY2IaJmxBZvFPCzmXlmritQJQATCmSucvQkbmwA
   zpSdQATFGoSuhy7E2z0n01Qz5emet6Acce43s2/SUS11OR7U/quZQ9z/8
   N0mmtgS7AFRztrQAGdzM4GPeMfkXZbrcbA5o37dO69+DFsj5uFITZ3Jb3
   5UGqg0T2VDEEZ8TmaKEV+SGmlzr2hvJiHfdFah+otRPmwIFESunh+ts7v
   ZbMQscsgRuOKGyrvp+f5OEBhz7+baBB6VCDjqXzJ4Jzn7wqPr6iIJB6oF
   xQUtBImwP2bULfQ50htoM4iyqPUMMzURuINtpT6+Hc+lwCC6CofIHt0bH
   A==;
X-CSE-ConnectionGUID: mVmailU5RVe4LDgqmshuGA==
X-CSE-MsgGUID: LPi8DtqpSe6OcDXIV8uXLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="78128957"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="78128957"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 13:40:49 -0700
X-CSE-ConnectionGUID: KWdawIiSQg+uP0QRroMmyw==
X-CSE-MsgGUID: DMnPQ5VjRjuGInfhOXMKdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="271343911"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 13:40:49 -0700
Message-ID: <b0570049-7166-4f20-b104-fedadba89f88@linux.intel.com>
Date: Mon, 21 Sep 2026 13:40:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/5] PCI/ACPI: Centralize pcie_ports_native checking
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919163917.36DC41F000FF@smtp.kernel.org>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260919163917.36DC41F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/19/2026 9:39 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] pci: implicit system-wide DPC binding contradicts commit message
> --
> 
> commit 07669185337d665d35c6cf7148608c57752e5ecb
> Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> PCI/ACPI: Centralize pcie_ports_native checking
> 
> This commit centralizes the testing of pcie_ports_native in 
> acpi_pci_root_create() by folding it into the _OSC control mask. It allows 
> other subsystems to simply check the host_bridge->native_X flags instead of 
> using scattered pcie_ports_native tests.
> 
> Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> 
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index 756dc2f055f51..2494811dd69b2 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
> [ ... ]
>> @@ -1039,6 +1052,21 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>  	ctrl = root->osc_control_set;
>>  	ext_ctrl = root->osc_ext_control_set;
>>  
>> +	/*
>> +	 * If the user specified "pcie_ports=native", use the PCIe port
>> +	 * services regardless of what _OSC says, i.e., proceed as though the
>> +	 * platform had granted us control of them.  This may conflict with
>> +	 * firmware that expects to own those features.
>> +	 */
>> +	if (pcie_ports_native) {
>> +		u32 override = OSC_PCIE_PORT_SERVICE_CONTROLS & ~ctrl;
>> +
>> +		if (override)
>> +			decode_osc_control(root, "OS forcing control (\"pcie_ports=native\") of",
>> +					   override);
>> +		ctrl |= override;
>> +	}
>> +
>>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
>>  		  host_bridge->native_pcie_hotplug);
>>  	OSC_OWNER(ctrl, OSC_PCI_SHPC_NATIVE_HP_CONTROL,
>> @@ -1051,6 +1079,14 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
>>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_pme);
>>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_ltr);
>>  	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_dpc);
> 
> [Severity: Medium]
> The commit message states that extending "pcie_ports=native" to DPC has a
> "narrow" effect, only impacting pci_dpc_recovered(). However, does this
> unintentionally enable the DPC port driver system-wide?
> 
> Because pcie_ports=native now forces host_bridge->native_aer to true via the
> OSC_PCI_EXPRESS_AER_CONTROL bit override, this impacts the DPC port service
> binding in get_port_device_capability():
> 
> drivers/pci/pcie/portdrv.c:get_port_device_capability() {
>         ...
>         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>             pci_aer_available() &&
>             (pcie_ports_dpc_native || host->native_aer))
>                 services |= PCIE_PORT_SERVICE_DPC;
>         ...
> }
> 
> Since host->native_aer evaluates to true when the pcie_ports=native parameter
> is provided, the DPC capability check will now unconditionally pass. Could
> this break the assumption that the effect on DPC was isolated?

You are right, the commit log is a bit misleading here.  The narrow effect
we talked about is the impact of the native_dpc flag change.  Enabling of
the DPC port service is currently controlled by native_aer, and this patch
enables it intentionally when "pcie_ports=native" is used.

I'll clarify it in v14:

  Forcing host_bridge->native_aer also restores DPC service binding under
  "pcie_ports=native", which regressed in 97ca178c899d ("PCI/DPC: Allow
  DPC on all Downstream Ports when OS controls AER").  That commit
  replaced the AER service test in get_port_device_capability() with
  host->native_aer, so DPC stayed off when host_bridge->native_aer was
  not set.

  This also extends "pcie_ports=native" to host_bridge->native_dpc, which
  had no pcie_ports_native fallback before.  That effect is narrow.
  native_dpc is only consumed by pci_dpc_recovered(), where with
  CONFIG_PCIE_EDR=n it previously gave up immediately and now lets pciehp
  wait for DPC recovery before treating a Link Down as a hotplug event.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

