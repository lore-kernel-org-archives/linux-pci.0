Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856548B386;
	Mon,  5 Oct 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212119; cv=none; b=L4R+QwCX2tXvqMAyrwUD5rPs+TTeD7ZWgMETuehiLsJYGJ9XCF6c7Cq29k1tiSAoaC0tmB74YMwaQ6E592Rn3Xzw7lLaAYNa6rV+JUWazFMGHBK7ARaJCnL7h5zB4wsXokhIH8nVZVoYYXcN5Sm64z+Ud5XFlXFE/XtMydTklM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212119; c=relaxed/simple;
	bh=wkNdmorawwoFAHdJAHdzMDu5tZxmxU4H1yRd2gvj2jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7O0j8Szn9k27Yyfv71ZMjzF3Gd+TwyKA4qWzJFk1MYZKEtlxhAaNr1RKoH+Plzq1HrkCA+x6XpCv51inaNy3GS+my/kOa76Nf3cZ1WsI3jeTNmhMADqC79y4uenrZQM0LbTam4FOVv9SzN6uoTLk++aQqiZVnDZ6zLmO15U2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQDOI8nl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQDOI8nl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503DC1F00898;
	Mon,  5 Oct 2026 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212115;
	bh=0pDITv/g0LRTGIDS8ucfGtN9ZceNhd2q7WnJ2mDYUPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KQDOI8nlH+ExOhlXBr5Y0Gd+8ziG0Q2vcx3Oba42c5owBOesvK++W8k9P+qPCSnAf
	 pJyNV6Ub3ce91O44ZpKOLqT9batwa0sW0NsSW3+OpsaD1O7Un9UlpjdVyx4aydreb5
	 geetBm9Odyxj9Pu3y3kbLfx3/cN88Zx1WwY699on0vrH9Dd3cdCx2EgGby1cfg/7d/
	 LOVewh3SOzhd0HVZGti7gaoXw7rHcfnpQnebwbhJghIGnPEg/O6HpHBex3b4mupptk
	 Bsi3Ww8+lMzMcHJbCNgGc7IsdSnX1hFKj40r9ngpb2CVvrK1FSbu/cCgdBtBmiu0oA
	 zj0JVsQyF5ExA==
Message-ID: <595ca63d-5768-48ca-bc2e-aebb1fafd0d6@kernel.org>
Date: Mon, 5 Oct 2026 17:55:12 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] PCI: rzg3s-host: Add bridge::reset_root_port()
To: sashiko-reviews@lists.linux.dev
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-10-claudiu.beznea@kernel.org>
 <20261002112518.9DD401F000FF@smtp.kernel.org>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <20261002112518.9DD401F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/26 14:25, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] pci: rzg3s: INTx/MSI mask state loss due to stale register snapshot
> - [High] pci: rzg3s: fatal unpowered MMIO access in PM notifier after reset failure
> - [High] pci: rzg3s: lockless iteration over bus->devices causes list corruption
> - [Medium] pci: rzg3s: missing I/O flush allows IRQs to fire after synchronize_irq
> --
> 
> commit c5ffdc83b56df877b7b137c1229cfe9487c3fb34
> Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Subject: PCI: rzg3s-host: Add bridge::reset_root_port()
> 
> This commit adds a reset_root_port() callback for the rzg3s-host bridge.
> It introduces the started boolean to track the controller state and prevents
> double start/stop from breaking reference counters. It also updates the link
> event and power management notifier paths to handle the interrupts correctly.
> 
>> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
>> index 78e783928b9dc..eea215818633b 100644
>> --- a/drivers/pci/controller/pcie-rzg3s-host.c
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> [ ... ]
>> @@ -1115,6 +1117,11 @@ static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host)
>>   
>>   		dev_info(host->dev, "PCIe link down, removing devices\n");
>>   
>> +		for_each_pci_bridge(dev, bridge->bus) {
>> +			if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
>> +				pci_host_handle_link_down(dev);
>> +		}
>> +
>>   		pci_lock_rescan_remove();
> 
> [Severity: High]
> Is it safe to iterate over bus->devices without holding the PCI
> rescan/remove lock?

Doing this will lead to deadlock on the following calls:
pci_host_handle_link_down() ->
   pcie_do_recovery() ->
     pci_host_reset_root_port() ->
       pci_lock_rescan_remove()

> 
> It looks like concurrent modifications to the list from sysfs rescan or
> hotplug events could cause list corruption or a use-after-free. The
> necessary lock is correctly taken immediately after this loop for the removal
> step, but appears to be omitted for this iteration.

I kept it as is to align with the current usage of pci_host_handle_link_down() 
in other drivers.

> 
> [ ... ]
>> @@ -1956,6 +1974,64 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
>>   	return ret;
>>   }
>>   
>> +static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridge,
>> +					   struct pci_dev *pdev)
>> +{
>> +	struct rzg3s_pcie_host *host = pci_host_bridge_priv(bridge);
>> +	unsigned long flags;
>> +	u32 irqs;
>> +	int ret;
>> +
>> +	/* Mask link up/down interrupts. */
>> +	writel(0, host->axi + RZG3S_PCI_PEIE0);
>> +
>> +	/* Mask INTx and MSI interrupts. */
>> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
>> +	irqs = readl(host->axi + RZG3S_PCI_PINTRCVIE);
>> +	writel(0, host->axi + RZG3S_PCI_PINTRCVIE);
>> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
>> +
>> +	/*
>> +	 * Make sure the next operations are not disturbed by any pending
>> +	 * IRQs.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		synchronize_irq(host->msi.irq);
> 
> [Severity: Medium]
> Does the posted write to the interrupt mask register need to be flushed
> with a dummy read before calling synchronize_irq()?

OK

> 
> Without a read-back to ensure the mask has reached the physical hardware, the
> controller might still emit an interrupt while synchronize_irq() runs,
> potentially creating a race window where the handler crashes when the
> controller clocks are subsequently cut in rzg3s_pcie_host_stop().
> 
>> +	for (unsigned int i = 0; i < PCI_NUM_INTX; i++)
>> +		synchronize_irq(host->intx_irqs[i]);
>> +
>> +	ret = rzg3s_pcie_host_stop(host);
>> +	if (ret) {
>> +		dev_err(host->dev, "Failed to stop the host!\n");
>> +		goto unmask_irqs;
>> +	}
>> +
>> +	ret = rzg3s_pcie_host_start(host, false);
>> +	if (ret) {
>> +		dev_err(host->dev, "Failed to start the host!\n");
>> +
>> +		/*
>> +		 * Don't unmask IRQs. We are in a bad state here and we
>> +		 * can recover only through a suspend/resume cycle. Just
>> +		 * return and preserve the stop state.
>> +		 */
>> +		return ret;
>> +	}
>> +
>> +unmask_irqs:
>> +	/* Unmask INTx and MSI interrupts. */
>> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
>> +	writel_relaxed(irqs, host->axi + RZG3S_PCI_PINTRCVIE);
>> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> 
> [Severity: High]
> Could this unconditional restore overwrite mask changes made by concurrent
> INTx mask/unmask operations?
> 
> Since hw_lock was dropped earlier to wait for IRQs and execute the
> controller stop/start sequence, any intermediate updates to the register by
> other drivers dynamically masking or unmasking their IRQs might be
> permanently lost here when the old snapshot is restored.

[1] had the mechanism to avoid this. It was discussed (not exactly on this 
particular use case) to drop it.

[1] 
https://lore.kernel.org/all/n7cafny3y6rr63tx6rkt5umxl3f4rsxpu2ojze7luudzzr4flb@egj7dru2bnhq

> 
>> +
>> +	/* Unmask link up/down interrupts. */
>> +	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
>> +
>> +	host->started = true;
>> +
>> +	return ret;
>> +}
> [ ... ]
>> @@ -2036,6 +2112,7 @@ static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
>>   	case PM_SUSPEND_PREPARE:
>>   		/* Disable link up/down interrupts. */
>>   		disable_irq(host->event_irq);
>> +		writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
> 
> [Severity: High]
> Could this write cause a synchronous external abort if the controller is
> currently unpowered?
> 
> If rzg3s_pcie_host_start() fails inside rzg3s_pcie_host_reset_root_port(),
> the function intentionally returns early, leaving host->started false and
> the controller in reset with clocks disabled. A subsequent system suspend
> would unconditionally hit this AXI write, which might hang the bus since
> the target peripheral is held in reset.

Will update to take into account the host->started in both PM_SUSPEND_PREPARE 
and PM_POST_SUSPEND.

> 
>>   		break;
>>   
>>   	case PM_POST_SUSPEND:
> 

