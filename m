Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86037C119;
	Tue,  6 Oct 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791311938; cv=none; b=SLH6UnofbWYIn7n63/wg3Zr8cAFgKGlP5BwKqFR8cjOEXoWyjH3UclOaqtgys6dMKXXAzkI6u03l1/bQIfeApESJ4ZI3UnLHIcRUliYPjWtvc393Qr0qpGxlL16U9duMlsWWS+YG54m65+fpSInOCZy273G4HAnfQY0QuQxRUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791311938; c=relaxed/simple;
	bh=TyYf3EzK7sY1y1ad2dQjjY/1dF1vcwiNqCIEmpIw8iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWnLrWcDKs7KedTUL92AEjNzcx5zPkknZmTQ66omjCOWOQx/0sYlfJ0z7gCvtS0s8RDg9/JHJtZYzkjyn0f3wcHVx+NiMkJ9MNSKPoECotm5Fr6eP03gGni29RL36k/ap6woSwki99ztYHm5ysq77JbYqZAyfxTNlUcptwaXQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TF88qEH0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TF88qEH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791311937; x=1822847937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TyYf3EzK7sY1y1ad2dQjjY/1dF1vcwiNqCIEmpIw8iU=;
  b=TF88qEH0r1BM8jbitLG3RL0MinRo/aSlsfcImN7V+0u0UwaUe1FiwsK/
   QkASeeFehiKSP/6IpAnIU9E43dQhsrjtUY18vegmHIGex0Hyu2iO533yN
   qiZeEe0FrwMyorx0s99kaoMMQhrp4Ay8LDz4RPBpGKvO82mJ+Wq/1pUAd
   uo3Ik885BaJ/twC5QafhgDS48RY4XjtCU0Ir6gOgr83sDwnnEyMy+FZtf
   YgvLUyOPpwxOHkFa9EjzNzVOOQZjspNJqbv5zdaGHzWvnyafzw0cWmTGg
   l8nSJ7AaKo4W9up9kVuRdxoG3eu+2FmXRPxZ+4BnmIit6hYlJieVbDcyx
   w==;
X-CSE-ConnectionGUID: lwdO/McYR8uZwzUyZP18KA==
X-CSE-MsgGUID: qkDExm35TX+O+XqvAbeFKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="69214"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="69214"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 11:38:56 -0700
X-CSE-ConnectionGUID: qqAJ+EmmTfKKHAXe/R7oWg==
X-CSE-MsgGUID: 87Po+9FmQBW5J2xAfRmiVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1245081"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 11:38:56 -0700
Message-ID: <8e8b494e-4dcd-4313-9658-b1fbb0ea2b9e@linux.intel.com>
Date: Tue, 6 Oct 2026 11:38:55 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/4] Simplify PCIe native ownership
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org,
 lukas@wunner.de, terry.bowman@amd.com, kanie@linux.alibaba.com,
 olof@lixom.net
References: <20261006175118.GA695965@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261006175118.GA695965@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 10/6/2026 10:51 AM, Bjorn Helgaas wrote:
> On Fri, Oct 02, 2026 at 02:18:24PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> This revives Bjorn's v12 from November 2020, rebased onto v7.3-rc3.
>>
>>   https://lore.kernel.org/all/20201126011816.711106-1-helgaas@kernel.org/
>>
>> The goal is unchanged.  Decide who owns each PCIe port service in one
>> place, when we interpret the _OSC results in acpi_pci_root_create(), so
>> that everywhere else only has to look at host_bridge->native_X.  For AER
>> specifically, host_bridge->native_aer becomes the single answer to the
>> question "may Linux touch the AER Capability?".  Today callers each have
>> to remember to also test pcie_ports_native and pci_aer_available().
>>
>> I posted v11.  Bjorn took it over at v12, split the _OSC changes in two
>> and deferred the "pcie_ports=dpc-native" work.  The v12 review comments
>> were agreed but never respun, and the series stalled.  v13 was that
>> respin.
>>
>>   https://lore.kernel.org/r/cover.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com [v11]
>>
>> Bjorn suggested reviving it in response to Guixin Liu's report that
>> "pcie_ports=native" no longer enables DPC.  The DPC service binds on
>> host_bridge->native_aer, and that flag did not reflect the command line,
>> so DPC stayed off when firmware retained AER control.  Patch 3 fixes it
>> by making the flag reflect it.
>>
>>   https://lore.kernel.org/linux-pci/20260901064554.2178688-1-kanie@linux.alibaba.com/
>>
>> Patch 3 has a side effect worth calling out.  drivers/cxl/core/ras.c did
>> not exist in 2020 and tests host_bridge->native_aer with no
>> pcie_ports_native fallback, so it has been quietly ignoring
>> "pcie_ports=native".  Centralizing the check fixes that.
>>
>> Binding the DPC service on host_bridge->native_dpc, rather than on
>> native_aer, is left for a separate patch on top of Lukas's series that
>> removes the DPC/AER dependency, as agreed with Bjorn.  That change
>> alters behavior, so it does not belong in this cleanup.
>>
>>   https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
>>   https://lore.kernel.org/r/20261001221408.GA2731929@bhelgaas
>>
>> Changes since v14:
>>   * Patch 3: fold "pcie_ports=dpc-native" into the _OSC control mask as
>>     well, so host_bridge->native_dpc and the "OS native features" line
>>     reflect it (Bjorn).
>>   * Picked up Guixin's Reviewed-by on patch 3.
>>
>> v14 posting
>> https://lore.kernel.org/r/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com
>>
>> Changes since v13:
>>   * Lukas suggested dropping AER cap check fix (patch 1 of v13). He has
>>     a series underway to fix it cleanly (removing DPC/AER dependency).
>>     So dropped the patch as suggested.
>>     https://lore.kernel.org/r/aq95LGUHL-pnmTlr@wunner.de
>>   * Addressed use of IS_ENABLED(CONFIG_PCIEPORTBUS) instead of #ifdef
>>     (Lukas).
>>   * Added Fixes tag in patch 3 (Guixin Liu).
>>   * Added Acks from Rafael.
>>
>> v13 posting
>> https://lore.kernel.org/r/20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com
>>
>> Bjorn Helgaas (1):
>>   PCI: Centralize pci_aer_available() checking
>>
>> Kuppuswamy Sathyanarayanan (3):
>>   PCI: Assume control of portdrv-related features only when portdrv
>>     enabled
>>   PCI/ACPI: Tidy _OSC control bit checking
>>   PCI/ACPI: Centralize pcie_ports_native checking
>>
>>  drivers/acpi/pci_root.c           | 78 +++++++++++++++++++++++++------
>>  drivers/pci/hotplug/pciehp_core.c |  2 +-
>>  drivers/pci/pci-acpi.c            |  3 --
>>  drivers/pci/pcie/aer.c            |  6 +--
>>  drivers/pci/pcie/aer_cxl_rch.c    |  2 +-
>>  drivers/pci/pcie/err.c            |  2 +-
>>  drivers/pci/pcie/portdrv.c        |  7 ++-
>>  drivers/pci/pcie/portdrv.h        |  2 -
>>  drivers/pci/probe.c               | 10 ++--
>>  include/linux/pci.h               |  2 +
>>  10 files changed, 80 insertions(+), 34 deletions(-)
> 
> I put the first three patches on pci/portdrv for v7.4, thanks!
> 
> I deferred the last ("PCI: Centralize pci_aer_available() checking")
> while we sort out the MSI/AER question, but I want to make sure we get
> the rest in v7.4.

Thanks for picking it up.
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

