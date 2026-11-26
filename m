Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717659;
	b=ufPW/+AAuLpQCrNREniCa8931MJjU+fDvzAEF+fGq/TbEtfX7FcOxEi3cMDuaa5LqZBP
	 WPiBM4pWdAfbVCYi17O1bwKUnbTAd/mmfesc9leApsHKoLnfZu5ISJh9NOCiHcG9NgiIC
	 9gRFeO099TQygdou6q8Z0eMcI1c0xFWEBqknOrkwCQ2+92CCnpY4kRfApM2mAz0f/26Qc
	 ENXeT2UM4VJnXsv/MOIAvjT5vNs9VepauSLOgT+wYie71qOyeP1QvmZcSGwzf11pgsD4e
	 L1yKChYXsUPuumWgr3DflIshrrUU29Yd7t1F4bi4VVQj3W+Hwg3WLjjD0U/13QG/Xdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717659;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZNitZBy5gD/hg02wP8dPEWrTALhV3jFaZJaK1EslWmA=;
	b=N1L1Ie0wi4CqRSPT7d+5G2Nc3mTtlc1Xfndwd8xudqpXMHqcwc2P6jhThrtlSlkiIZbD
	 DlmSQFmoHVNkmOw4ml1/+BAiPDicLNZ0i9q+GiHVIcMPR2gEJh91K77eBrzBqj9xwE5PL
	 rhQsb+fYLbPnh5z16YaxE+jPMbmy2ztbDe3/kBtQ7Uhee2G9is8Dm7X8BsujTfSktHx9g
	 ZN7R2ZZDi0tQXM6tvcw1aOM6JGjKfu3M7lBGvQJWBcBUNkirERYprwjOwy5j/Zgf0hhFE
	 PBs+W8H6kZQ+sZxYLt6WPA8ElO5i3lblPhe5q+1sQYBOoEWflPUR9deuJrNSAadE1vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsXQ6WU+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD60606A31C;
	Thu, 26 Nov 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DsXQ6WU+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B101F000C4;
	Thu, 26 Nov 2026 18:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795717658;
	bh=ZNitZBy5gD/hg02wP8dPEWrTALhV3jFaZJaK1EslWmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DsXQ6WU+9NO9YuZX2nBf1KxugOLLz7dYAlE/3h73Dy/df9uXr1+zWFguMP7lSSh1M
	 Bd/rnaRsmenHV/ImbAQ9FscLUBwRHum3lgzjymDOl+Z9uNZO3M25T5Mt3Ks9IW9OLJ
	 TOqacSGg+7sNGTmI06nOW8HWMOsnT8s3cS93ZmR5KSLrLo+dEdIaMCncYjSquqKVJ3
	 tSTBAI5O3EXU8CUr6Muau7bsNEDVUE5edR7H+BiwHEdl7AU1iRWoYlzHDOvq/gGNu1
	 vqYinNHGLnkFYm7LLnF2z0F4H7ZrYrKyq+XzCBgX4d78x6AZ4yfnD0b41KcWMZBMBs
	 5kLi5WhvY2CQA==
Message-ID: <b4be5ad9-a2fc-49f1-a2ce-9281b0fd4763@kernel.org>
Date: Thu, 26 Nov 2026 20:27:34 +0200
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
Subject: Re: [PATCH v7 14/14] PCI: rzg3s-host: Add bridge::reset_root_port()
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-15-claudiu.beznea@kernel.org>
 <179562857756.5580.4122801140919209882.b4-reply@b4>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@kernel.org>
In-Reply-To: <179562857756.5580.4122801140919209882.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/25/26 19:42, Manivannan Sadhasivam wrote:
> On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add bridge::reset_root_port(). This allows, on some devices, performing
>> reads and writes to an NVMe endpoint after a link down/link up cycle
>> without failures.
>>
>> The implementation of struct pci_host_bridge::reset_root_port() masks all
>> enabled interrupts and synchronizes them before resetting the controller
>> to prevent asynchronous events from interfering with the reset operation.
>>
>> The struct rzg3s_pcie_host::resetting member is used to prevent the IRQ
>> setting calls done through the IRQ subsystem (mask, unmask) from
>> accessing the controller registers while .reset_root_port() has powered
>> down the IP. It also rejects a concurrent .reset_root_port() with -EBUSY.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Same comment as previous patch. More inline.
> 
>> ---
>>
>> Changes in v7:
>> - added struct rzg3s_pcie_host::resetting to avoid concurrency b/w IRQ
>>    subsystem and the .reset_root_port() and b/w .reset_root_port() and
>>    the link IRQ thread
>> - in rzg3s_pcie_link_event()
>> -- dropped the usage of __free(pci_dev_put)
>> -- don't continue if the .reset_root_port() filed to start the IP or
>>     if there is a reset in progress
>> - in rzg3s_pcie_event_irq_thread() don't continue if the reset is in
>>    progress
>> - access host->started with READ_ONCE()/WRITE_ONCE()
>> - use disable_irq() in .reset_root_port()
>> - in rzg3s_pcie_pm_notifier() checked host->resetting and host->started
>>    before accessing IP registers
>>
>> Changes in v6:
>> - call pci_host_handle_link_down() if at least a link event occured
>>    and there are devices on the bus.
>> - dropped struct rzg3s_pcie_host::stared from here since it is now
>>    part of patch 8/9
>> - read the link IRQs in .reset_root_port() and restore them at the
>>    end
>> - flush the IRQ mask before synchronize()
>> - in .reset_root_port() clear the link IRQ before enabling it to cope
>>    with the new link handling procedure
>> - due to these dropped the tags
>>
>> Changes in v5:
>> - lock around reads/writes on RZG3S_PCI_PINTRCVIE
>> - in rzg3s_pcie_host_reset_root_port() kept non-relaxed reads/writes
>>    on interrupt disable registers (even though the spin lock/unlock are around
>>    them) to emphasize the need for updates before the IRQs are synchronized and
>>    relaxed variants on interrupt enable path
>> - collected tags
>>
>> Changes in v4:
>> - this patch is new and is a split from patch 7 of v3
>> - use a boolean to keep track of the controller start state; with this
>>    the state management code from patch 7 of v3 was dropped
>>
>>
>>   drivers/pci/controller/Kconfig           |   1 +
>>   drivers/pci/controller/pcie-rzg3s-host.c | 184 ++++++++++++++++++++---
>>   2 files changed, 167 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 7e550c474b7a..c747bd5a9ec1 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -296,6 +296,7 @@ config PCIE_RENESAS_RZG3S_HOST
>>   	depends on ARCH_RENESAS || COMPILE_TEST
>>   	select MFD_SYSCON
>>   	select IRQ_MSI_LIB
>> +	select PCI_HOST_COMMON
>>   	help
>>   	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S
>>   	  SoC.
>> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
>> index a1c9e29f43e5..f6823c9bc414 100644
>> --- a/drivers/pci/controller/pcie-rzg3s-host.c
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>> @@ -336,6 +336,7 @@ struct rzg3s_pcie_port {
>>    * @controller_id: PCIe controller identifier, used for System Controller access
>>    * @link_rescan: The PCIe link rescan state
>>    * @started: The PCIe controller state (started or not)
>> + * @resetting: Mentions if the root port reset is in progress
>>    * @num_lanes: The number of lanes
>>    */
>>   struct rzg3s_pcie_host {
>> @@ -358,6 +359,7 @@ struct rzg3s_pcie_host {
>>   	enum rzg3s_pcie_controller_id controller_id;
>>   	bool link_rescan;
>>   	bool started;
>> +	bool resetting;
> 
> I don't think you need this new variable. Other reset_root_port implementation,
> esp pcie-qcom doesn't need it and it uses a mutex to protect the whole reset
> helper. Why can't you do the same?

This was added as a result of this Sashiko review [1] which I think is valid:

[Severity: High]
This restores the potentially stale irqs local variable, overwriting
any mask changes made concurrently by the IRQ subsystem while the lock
was dropped.

If that is valid, and the IRQ chip helpers can race with .reset_root_port(), a 
call to the IRQ chip helpers while the controller is in reset/resetting lead to 
sync abort on RZ/G3S. We can't take mutex from the IRQ chip helpers. On the 
other hand disable_irq() (these were previously synchronize_irqs()) calls from 
.reset_root_port() may sleep, along with clock APIs and other fsleep() calls 
called though rzg3s_pcie_host_start(), thus we can't keep a spinlock held in 
.reset_root_port().

Please let me know if you consider invalid the Sashiko comment.

[1] https://lore.kernel.org/all/sashiko-outbox-162654@kernel.org/

> 
>>   	u8 num_lanes;
>>   };
>>   
>> @@ -653,6 +655,9 @@ static void rzg3s_pcie_msi_irq_mask(struct irq_data *d)
>>   
>>   	guard(raw_spinlock_irqsave)(&host->hw_lock);
>>   
>> +	if (host->resetting)
>> +		return;
>> +
>>   	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>>   			       BIT(reg_bit));
>>   }
>> @@ -666,6 +671,9 @@ static void rzg3s_pcie_msi_irq_unmask(struct irq_data *d)
>>   
>>   	guard(raw_spinlock_irqsave)(&host->hw_lock);
>>   
>> +	if (host->resetting)
>> +		return;
>> +
>>   	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>>   			       0);
>>   }
>> @@ -972,6 +980,9 @@ static void rzg3s_pcie_intx_irq_mask(struct irq_data *d)
>>   
>>   	guard(raw_spinlock_irqsave)(&host->hw_lock);
>>   
>> +	if (host->resetting)
>> +		return;
>> +
>>   	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
>>   			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq), 0);
>>   }
>> @@ -982,6 +993,9 @@ static void rzg3s_pcie_intx_irq_unmask(struct irq_data *d)
>>   
>>   	guard(raw_spinlock_irqsave)(&host->hw_lock);
>>   
>> +	if (host->resetting)
>> +		return;
>> +
>>   	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
>>   			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq),
>>   			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq));
>> @@ -1185,12 +1199,46 @@ static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bounced)
>>   {
>>   	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>>   	struct pci_bus *bus = bridge->bus, *child;
>> +	unsigned long flags;
>>   	u32 val;
>>   	int ret;
>>   
>> -	pci_lock_rescan_remove();
>> +	/*
>> +	 * A latched DL_UpDown means at least one real link transition took
>> +	 * place since the last enumeration. If devices are enumerated
>> +	 * recover the Root Port first.
>> +	 */
>> +	if (bounced && !list_empty(&bus->devices)) {
>> +		struct pci_dev *port = pci_get_slot(bus, PCI_DEVFN(0, 0));
>> +
>> +		if (port && pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
>> +			pci_host_handle_link_down(port);
>>   
>> +		pci_dev_put(port);
>> +	}
>> +
>> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
>> +
>> +	/*
>> +	 * Don't continue if reset in progress or .reset_root_port() failed to
>> +	 * start HW.
>> +	 */
>> +	if (host->resetting || !READ_ONCE(host->started)) {
>> +		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Check the link state after the recovery: the .reset_root_port()
>> +	 * retrains the link, so a device that is still present comes back
>> +	 * up here and is re-enumerated right away instead of waiting for
>> +	 * the next DL_UpDown event.
>> +	 */
>>   	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
>> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
>> +
>> +	pci_lock_rescan_remove();
>> +
>>   	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
>>   		if (!list_empty(&bus->devices)) {
>>   			dev_info(host->dev,
>> @@ -1246,20 +1294,26 @@ static irqreturn_t rzg3s_pcie_event_irq_thread(int irq, void *data)
>>   {
>>   	struct rzg3s_pcie_host *host = data;
>>   	bool bounced;
>> -	u32 status;
>>   
>> -	status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
>> -	bounced = status & RZG3S_PCI_PEIS0_DL_UPDOWN;
>> +	scoped_guard(raw_spinlock_irqsave, &host->hw_lock) {
>> +		u32 status;
>>   
>> -	if (!bounced && !READ_ONCE(host->link_rescan))
>> -		return IRQ_NONE;
>> +		if (host->resetting)
>> +			return IRQ_NONE;
>> +
>> +		status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
>> +		bounced = status & RZG3S_PCI_PEIS0_DL_UPDOWN;
>> +
>> +		if (!bounced && !READ_ONCE(host->link_rescan))
>> +			return IRQ_NONE;
>>   
>> -	/* Clear the DL_UpDown status (W1C) */
>> -	if (bounced) {
>> -		writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
>> -			       host->axi + RZG3S_PCI_PEIS0);
>> +		/* Clear the DL_UpDown status (W1C) */
>> +		if (bounced) {
>> +			writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
>> +				       host->axi + RZG3S_PCI_PEIS0);
>> +		}
>> +		WRITE_ONCE(host->link_rescan, false);
>>   	}
>> -	WRITE_ONCE(host->link_rescan, false);
>>   
>>   	rzg3s_pcie_link_event(host, bounced);
>>   
>> @@ -1982,13 +2036,13 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
>>   	return ret;
>>   }
>>   
>> -static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
>> +static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host, bool set_started)
>>   {
>>   	const struct rzg3s_pcie_soc_data *data = host->data;
>>   	struct rzg3s_sysc *sysc = host->sysc;
>>   	int ret;
>>   
>> -	if (host->started)
>> +	if (READ_ONCE(host->started))
>>   		return 0;
>>   
>>   	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
>> @@ -2023,7 +2077,10 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
>>   	if (ret)
>>   		goto assert_power_resets;
>>   
>> -	host->started = true;
>> +	if (set_started) {
>> +		WRITE_ONCE(host->started, true);
>> +		host->resetting = false;
>> +	}
>>   
>>   	return 0;
>>   
>> @@ -2038,6 +2095,91 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
>>   	return ret;
>>   }
>>   
>> +static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridge,
>> +					   struct pci_dev *pdev)
>> +{
>> +	struct rzg3s_pcie_host *host = pci_host_bridge_priv(bridge);
>> +	unsigned long flags;
>> +	u32 irqs, link_irqs;
>> +	int ret;
>> +
>> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
>> +	if (host->resetting) {
>> +		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
>> +		return -EBUSY;
>> +	}
>> +	host->resetting = true;
> 
> This really looks like a bad pattern.
> 
>> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
>> +
>> +	/* Mask link up/down interrupts. */
>> +	link_irqs = readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
>> +	writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
>> +
>> +	/* Mask INTx and MSI interrupts. */
>> +	irqs = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
>> +	writel_relaxed(0, host->axi + RZG3S_PCI_PINTRCVIE);
>> +
>> +	/* Flush IRQ masks. */
>> +	readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
>> +	readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
>> +
>> +	/*
>> +	 * Make sure the next operations are not disturbed by any pending
>> +	 * IRQs.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		disable_irq(host->msi.irq);
>> +	for (unsigned int i = 0; i < PCI_NUM_INTX; i++)
>> +		disable_irq(host->intx_irqs[i]);
>> +
> 
> I'm not sure about these. You already masked the IRQs above and flushed them.
> Why do you need to explicitly disable interrupts here? If your concern is to
> avoid triggering the irq handlers while this one is run, I don't think these
> disable_irq() calls can guarantee you that.

The point was to wait (though the synchronize_irq() calls inside the 
disable_irq()) for the unserverd triggered IRQs, to finish before resetting the 
root port, avoiding this way handler trigger while the reset is in progress, and 
thus, any potential register accesseses, which may be fatal on RZ/G3S.

Thank you for your review,
Claudiu
