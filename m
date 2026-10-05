Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A15489FBC;
	Mon,  5 Oct 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208221; cv=none; b=sShrxyP/5+X4f/B2XGNQ+fZPUc5JRex3Pph7dRnfmit2CwKUs1g6RwTEKggXP2y9LzWAARFT4F8qrDMUmbXL3GQ4Y6BeIjQGtxfouKULiJ3FR5DnBHMUoM5NIomMD2NyOzi7r4SKW+Esfa57Y9isLIGgYhn+FldvgTVfEfg4QrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208221; c=relaxed/simple;
	bh=KAF0mqBkm1MJkTKpXFoxayuFG+fjQ7NhTfOvUk3j+CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5ustYeyqdw1rkmIbz6abgpApALT0BsRhpLteZkby5w3c9i7Ejyf91FjJ30C6x3JXP0gaMwisQDS4g85oO38M5rUWtS0oTNYRjWvrgqH0LMbNAwiePbDxyT+8i0o6DGBMA9DY9/hFsT0kS5Lym69eLolmTL/2Yc7QoZVXOF08NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpl45RMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpl45RMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AEA1F000FF;
	Mon,  5 Oct 2026 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208218;
	bh=zxskwQj+IRAHV+Byj+TN6+uofwLjQQPlJVRyyQu77iQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dpl45RMecHihKXarc63chFVjEXSpU6OLmXT453T7CZWX2Gg9gNIgZrcg7Jq6XsT6i
	 8TsGBljFSi9s5yDi0rUCUhn5abv+mzT23JoFbHYIyIetaz9q6u2COsrFxFrU53VwMo
	 dWhKPR4FaO4tj209glKxSSVUm6Q8evmftaQ/Kn4A/Z87GLNwLIHKlC7BFwv73L+Y1l
	 rdBSUJ+waymn8bxfKly3CvRMM78nvZc+BoN0GXyQL6X1GQw4d2FJSFHlJmRq8Sf4vS
	 ip1MrsIxuObhTVBP2820KyrmF1hEFHE6Q+PaPztjdQZ+WjsDvCEx1uQszXTKOOefbF
	 w+0gZK9SExU3g==
Message-ID: <a6279445-3a48-4a2a-975e-545fad3f5733@kernel.org>
Date: Mon, 5 Oct 2026 16:50:15 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-9-claudiu.beznea@kernel.org>
 <20261002112519.6082F1F00893@smtp.kernel.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20261002112519.6082F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/26 14:25, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] PCI: deadlock during hibernation due to unhandled PM notifiers
> - [High] PCI: probe succeeds with uninitialized controller on DT error
> - [High] PCI: NULL pointer dereference if event IRQ fires before root bus creation
> - [Medium] PCI: ghost devices left on bus if link bounces during suspend
> --
> 
> commit e916ae87086b955078f323f09316792067184bfe
> Author: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes
> 
> This commit adds support for reacting to link-state changes by handling
> the DL_UpDown signal on RZ/G3 and RZ/V2 PCIe controllers. It introduces
> a link event interrupt, hotplug-like logic, and PM notifiers to serialize
> with device suspend/resume.
> 
>> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
>> index 3b62b1be5b2a1..78e783928b9dc 100644
>> --- a/drivers/pci/controller/pcie-rzg3s-host.c
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> [ ... ]
>> @@ -1095,6 +1103,98 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
>>   	return ret;
>>   }
>>   
>> +static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host)
>> +{
>> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>> +	struct pci_bus *bus = bridge->bus;
>> +	u32 val;
>> +
>> +	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
>> +	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
>> +		struct pci_dev *dev, *tmp;
>> +
>> +		dev_info(host->dev, "PCIe link down, removing devices\n");
>> +
>> +		pci_lock_rescan_remove();
>> +		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
> 
> [Severity: High]
> The event IRQ is requested and enabled in rzg3s_pcie_host_setup() before
> bridge->bus is allocated by pci_host_probe().
> 
> If the hardware generates a spurious interrupt during this narrow window,
> bridge->bus could be NULL when this handler runs.
> 
> Will this dereference a NULL pointer?

That shouldn't happen. The initialization masks the link interrupt at controller 
level. The interrupt is unmasked at the controller level only at the end of the 
probe, after bridge->bus becomes valid.

> 
>> +						 bus_list)
>> +			pci_stop_and_remove_bus_device(dev);
>> +		pci_unlock_rescan_remove();
>> +	} else {
>> +		struct pci_bus *child;
>> +		int ret;
>> +
>> +		dev_info(host->dev, "PCIe link up, rescanning bus\n");
> 
> [Severity: Medium]
> On resume, the PM notifier wakes the IRQ thread.
> 
> If the link is currently up, it seems this branch is taken and rescans the bus
> without removing the old devices that might have been hot-swapped while the
> link was down.
> 
> Could this leave ghost devices on the bus if the link goes down and comes back
> up while the system is suspended?

Yes, it could. I'll update it in a similar way it is done in pciehp_core.c


> 
> [ ... ]
>> @@ -1723,8 +1838,14 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
>>   
>>   	ret = rzg3s_pcie_host_init(host);
>>   	if (ret) {
>> -		dev_err_probe(dev, ret, "Failed to initialize the HW!\n");
>> -		goto teardown_irqdomain;
>> +		if (ret != -ENODEV) {
>> +			dev_err_probe(dev, ret,
>> +				      "Failed to initialize the HW!\n");
>> +			goto teardown_irqdomain;
>> +		}
>> +
>> +		/* Link is down: hotplug via DL_UpDown will recover. */
>> +		return 0;
> 
> [Severity: High]
> If a mandatory resource is missing, such as resource_list_first_type()
> returning NULL in rzg3s_pcie_config_init(), it returns -ENODEV.
> 
> This would be caught here as a safe link-down state and return success,
> potentially leaving the controller uninitialized.
> 
> Does this pattern mask genuine configuration errors?


That is valid. I'll update it.

> 
> [ ... ]
>> @@ -1905,6 +2026,31 @@ static void rzv2h_pcie_release_lanes(void *data)
>>   	rzv2h_num_total_lanes -= host->num_lanes;
>>   }
>>   
>> +static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
>> +				  unsigned long action, void *data)
>> +{
>> +	struct rzg3s_pcie_host *host = container_of(nb, struct rzg3s_pcie_host,
>> +						    pm_nb);
>> +
>> +	switch (action) {
>> +	case PM_SUSPEND_PREPARE:
>> +		/* Disable link up/down interrupts. */
>> +		disable_irq(host->event_irq);
>> +		break;
> 
> [Severity: High]
> The switch statement only handles PM_SUSPEND_PREPARE and PM_POST_SUSPEND,
> completely omitting PM_HIBERNATION_PREPARE and PM_RESTORE_PREPARE.
> 
> If a link event occurs during hibernation transitions, the threaded interrupt
> could attempt to acquire the same lock the PM core is holding.
> 
> Can this missing hibernation support open a window for a deadlock?

The hibernation wasn't treated since it is currently unavailable on any of the 
SoCs supporting this driver.

> 
>> +
>> +	case PM_POST_SUSPEND:
>> +		/* Enable link up/down interrupts and force link re-scan. */
>> +		writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
>> +			       host->axi + RZG3S_PCI_PEIE0);
>> +		WRITE_ONCE(host->link_rescan, true);
>> +		enable_irq(host->event_irq);
>> +		irq_wake_thread(host->event_irq, host);
>> +		break;
>> +	}
>> +
>> +	return NOTIFY_DONE;
>> +}
> 

