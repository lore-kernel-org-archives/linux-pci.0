Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816410;
	b=xvBEB/TVKZp+nUWESKYUZ2d61cyR6c2TYl+r3ze6QDd1j2lJbvDyQRgGgOG99hrEewuR
	 FbKW9mSEYmqPATnVWaKOohUY5S9XlN7ljzFe2b6wzjyPk01vUnnUUJyVMxCpTWzpyqaGn
	 6+dIuXreCu7UFDAkGhNffZsSCDQYL/2MvZa04YY/w91rD7EKRVRWOo49tYWWhlvtm5Se7
	 U0ijccEXSKoyG9g10K0BARPFHKscloVSEgUAOgW3tM8MdUnQesdMRsLWGQXLoJZBXZX3i
	 BTKOJEZFvONOmVddXhsZO7n05jn35quqo1Yo3vp24lzMobOZ4Q1K8WjeqeDY83pypUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816410;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=P+ya1kH/+sexEYoEDLv1BZhv3DQf4yDiGOCzH+XfeVQ=;
	b=A1h+P+CeYOUU+AZHGrE3XvNdg3zJTchI/5FhBU3tVd/CFoko/Age+68+Wm36VO4GkqfK
	 vg7ws2CJNA7xILfZQPZ6GnHAzvRglUMcupa9+Gw9IAE1JmkIUw6n3HCpIvX9L6FlrsWfg
	 8FFtgCRxyvyUnwiEJ8WLiFGvmiKboTdHxXzVRZ4NrBIjqN1MsTQgOBXlkZHcxkQ/2cbX7
	 x7yscnLr4YgTOBdv2rfZeASWMbXcFT11TxtO8Dt8HBdm0I/GiZTJNsXriGmLueD+ffF4z
	 MLhh9DERV5nMRarNSeMoyGyEwohShB8vABxFSDI2kpNz3WJPbpxFktEX8Dt3s7qC3Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVW9y0xM;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328ED606A31B;
	Wed,  4 Nov 2026 18:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 328ED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CVW9y0xM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793816409; x=1825352409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lfKZg9M90AIkPnicnAbt5NUszbJFDNNp6VP3Ytth0hg=;
  b=CVW9y0xMKB5Cc5KHT8+htKGjOsUa601+EYC4Gu67UTdlYpaBr1HZ1hCs
   or9VQSuQS5/Y1J2+azz4n3rW52cTb+N8epjg8hi0Qt/lT8SV03+6owg51
   ByGIcYsWDuuUjLsu6ntYCrMdWyQVGvTqdZxzd6AENUL99r6Hc5/JCPiv/
   O5QXZYn4R3tygKnGaeKTrWzsMR26AgZxsW9llNUPtRO/tm6BAJ6NdHIQB
   rmWT6UVR8A807Ra95r5HdKh7Yj/r0LtGwueL29iLXSVmH5QAWHnWBFKeM
   TY4+8ViIN9ErrMHrOX24EeNLQopcd/CJs4q5TWCtKicmOzRLtIrnHtyM1
   Q==;
X-CSE-ConnectionGUID: Gn8R7GvoT2uIV0ubvUBqYA==
X-CSE-MsgGUID: FR6j9s4gQh+gja+ch/gdww==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2599762"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2599762"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:20:08 -0800
X-CSE-ConnectionGUID: t5TinnbJSL6gUjGTmi8N1w==
X-CSE-MsgGUID: 7IQfKhRWTFedITTWe2RiDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6933307"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:20:08 -0800
Message-ID: <67532a6c-00e8-42b9-b6bd-c2d3f4ea2704@linux.intel.com>
Date: Wed, 4 Nov 2026 10:20:07 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] PCI/EDR: Remove CONFIG_PCIE_EDR
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261103204617.GC314988@yaz-khff2.amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261103204617.GC314988@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/3/2026 12:46 PM, Yazen Ghannam wrote:
> On Tue, Oct 20, 2026 at 11:19:20AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Error Disconnect Recover (EDR) is the ACPI half of the hybrid DPC model,
>> where firmware owns DPC and notifies the OS of containment events.
>>
>> CONFIG_PCIE_EDR made EDR optional on top of CONFIG_PCIE_DPC.  This adds
>> another knob to the decision to request DPC control in _OSC.  The OS
>> requests DPC control only if it also supports EDR, so with
>> CONFIG_PCIE_EDR=n it never requests DPC control.  There is little reason
>> to build DPC without EDR on ACPI systems.
>>
>> Remove the option and build edr.c whenever CONFIG_PCIE_DPC and
>> CONFIG_ACPI are both enabled.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  drivers/acpi/pci_root.c   | 6 +++---
>>  drivers/pci/pcie/Kconfig  | 9 ---------
>>  drivers/pci/pcie/Makefile | 5 ++++-
>>  drivers/pci/pcie/dpc.c    | 5 +++--
>>  include/linux/pci-acpi.h  | 4 ++--
>>  5 files changed, 12 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index a1a9c06012f8..b0e0b33e3254 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -438,7 +438,7 @@ static u32 calculate_support(void)
>>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>>  	if (pci_msi_enabled())
>>  		support |= OSC_PCI_MSI_SUPPORT;
>> -	if (IS_ENABLED(CONFIG_PCIE_EDR))
>> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
>>  		support |= OSC_PCI_EDR_SUPPORT;
>>  
>>  	return support;
>> @@ -515,9 +515,9 @@ static u32 calculate_control(void)
>>  	 * Per the Downstream Port Containment Related Enhancements ECN to
>>  	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>>  	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
>> -	 * and EDR.
>> +	 * and EDR.  EDR is always built with DPC on ACPI systems.
>>  	 */
>> -	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
>> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
>>  		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
>>  
>>  	return control;
>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>> index 207c2deae35f..de4ea33b4524 100644
>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -137,12 +137,3 @@ config PCIE_PTM
>>  	  This is only useful if you have devices that support PTM, but it
>>  	  is safe to enable even if you don't.
>>  
>> -config PCIE_EDR
>> -	bool "PCI Express Error Disconnect Recover support"
>> -	depends on PCIE_DPC && ACPI
>> -	help
>> -	  This option adds Error Disconnect Recover support as specified
>> -	  in the Downstream Port Containment Related Enhancements ECN to
>> -	  the PCI Firmware Specification r3.2.  Enable this if you want to
>> -	  support hybrid DPC model which uses both firmware and OS to
>> -	  implement DPC.
> 
> What about keeping 'PCIE_EDR' and using it like 'PCIE_PME'?
> 
> IOW, remove the user-visible parts have it default to (PCIE_DPC &&
> ACPI)?
> 
> I understand EDR as its own feature on top of DPC. So I think there's
> value in having the EDR bits clearly distinct from the DPC bits.
> 
> Also, it would reduce the changes in this patch.

Good idea.  I'll make PCIE_EDR a def_bool that depends on PCIE_DPC &&
ACPI in v3.  That still removes the user-visible knob and keeps the
rest of the code as is.

> 
>> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
>> index b0b43a18c304..46b24311f659 100644
>> --- a/drivers/pci/pcie/Makefile
>> +++ b/drivers/pci/pcie/Makefile
>> @@ -13,4 +13,7 @@ obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
>>  obj-$(CONFIG_PCIE_PTM)		+= ptm.o
>> -obj-$(CONFIG_PCIE_EDR)		+= edr.o
>> +
>> +ifdef CONFIG_ACPI
>> +obj-$(CONFIG_PCIE_DPC)		+= edr.o
>> +endif
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 104ff2b91f1f..71adc0e94bca 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -109,10 +109,11 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>>  
>>  	/*
>>  	 * Synchronization between hotplug and DPC is not supported
>> -	 * if DPC is owned by firmware and EDR is not enabled.
>> +	 * if DPC is owned by firmware and there is no EDR, i.e., on
>> +	 * non-ACPI systems.
>>  	 */
>>  	host = pci_find_host_bridge(pdev->bus);
>> -	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
>> +	if (!host->native_dpc && !IS_ENABLED(CONFIG_ACPI))
>>  		return false;
>>  
> 
> This seems like dead code, and it was deleted in an older version.
> 
> The conditions seem to be mutually exclusive.
> 
> Maybe it should just be removed in a pre-patch?

Agreed that it is dead, but only after this patch.  Before it, the
check is still reachable with CONFIG_ACPI=y, CONFIG_PCIE_EDR=n and
firmware-owned DPC.  Once EDR is always built with DPC on ACPI,
native_dpc can only be cleared on ACPI systems, where EDR is present.
So I'll remove the check in this patch.

Thanks for the review.

> 
> Thanks,
> Yazen

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

