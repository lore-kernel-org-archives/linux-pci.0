Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628588;
	b=hvjgYpwo6Rj1r3IZjE7DRiTjlsPutzT6ZePvywxmDpLrqB8s2LE5y7cZoOuza1tLXF3c
	 YIcoQEL4Xp4SrAseGlsSkNHv4FQj1Y46obzneAhNS4NSuNUth7dLMSp8UuJXOT4W3PwaD
	 /NcQ78Z/phgOEfJGpR+bbeTEdGv+wJHSS6YDRYb6ejwdg+UZD3PlyxhEh2sXHKj3wIFl+
	 BvT1eGrBSXiDaSPimPTQzYuTVDS7h2BnAX/IrJMumvjf4gDWmzT+BGOqIa5lq8GA8zrIq
	 5hmJQgMmCDU7grfKsvrQGw7OgGYRozQVW4cl6nRhm8VYqirEZ6Z5tdLS0DdWDj1jpWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628588;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=mlH3Ot+IHhut4BfCfZ7T7aOiQLYg6fjdNfJgOiYU4j8=;
	b=Y3XHdvBusYz1GB/rUqyo0V9FbhhPP/Za3epNsJODU1DSr0wTiLUa02RPvbmyGA+GV6n2
	 7C5mrXfnT73sKwIhY5cuGBuSSeQ871muvC8CNtAtS0z43f3Sb+alkHoYNEVYUcNcuAuGn
	 ugwFnhP3hD5gEtIdzfK5MoByNZyyyzdjshKrrmyEfaxBk5YBo0sH5DnXMWHk2t4MrdtRD
	 BG19XWFoHuNhEUsbCjHiS3xozXaQE2Wd3Pf+MgWIjGOYSoXrXYpE18o37ys9FL4hdaAKh
	 dhbJdOZK+Dv1OFjML+gHUOYhqIZLGZ1BfkesRoC7vd5ZzJKcNPBhZugvrpdbrCjTATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795D606A323;
	Wed, 25 Nov 2026 17:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DEB1F000D2;
	Wed, 25 Nov 2026 17:43:02 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 14/14] PCI: rzg3s-host: Add
 bridge::reset_root_port()
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20261019065025.2146539-15-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-15-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 23:12:57 +0530
Message-Id: <179562857756.5580.4122801140919209882.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10967;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=4KS4BhvUJ2W0yfY9xegidPcnQjU7TssHhfMG76CLORs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBx4l7ctcIsphZv6z7bmjU8oEzfo+YFfLWRKZn
 1l3r0IDK12JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawceJQAKCRBVnxHm/pHO
 9cclB/oC7gBroR2EqcBpGLikIAIdz7ZsVgpJOutrr0FjLSrZlQgNVR7U7DF8FYfycPJG1THihQv
 UPc2m3DZGoiXAgTYGHEZwKer6NIPBhvX14sKNOe11A+kwIQKh2wgF7OG9VfipBSCDF84s++6cAB
 XDfoK7+iRuoNTbAF1UeCEnAnppDF4qDrxu++iwjjxyW0F2MCtZ/QaflnZh43CJxJet3VgN7XucU
 O3jzLfhGxty6oMgJBu05z0lpvEZ2fvR8pe+1KghahQzaydYcvQSahY1Mja+WyzsA1rFXeIqPcbN
 Mz67AnEf/9IAxdIPOsko9GivrL2jC0qqvV6wlcenNkLHP6Nq
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add bridge::reset_root_port(). This allows, on some devices, performing
> reads and writes to an NVMe endpoint after a link down/link up cycle
> without failures.
> 
> The implementation of struct pci_host_bridge::reset_root_port() masks all
> enabled interrupts and synchronizes them before resetting the controller
> to prevent asynchronous events from interfering with the reset operation.
> 
> The struct rzg3s_pcie_host::resetting member is used to prevent the IRQ
> setting calls done through the IRQ subsystem (mask, unmask) from
> accessing the controller registers while .reset_root_port() has powered
> down the IP. It also rejects a concurrent .reset_root_port() with -EBUSY.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Same comment as previous patch. More inline.

> ---
> 
> Changes in v7:
> - added struct rzg3s_pcie_host::resetting to avoid concurrency b/w IRQ
>   subsystem and the .reset_root_port() and b/w .reset_root_port() and
>   the link IRQ thread
> - in rzg3s_pcie_link_event()
> -- dropped the usage of __free(pci_dev_put)
> -- don't continue if the .reset_root_port() filed to start the IP or
>    if there is a reset in progress
> - in rzg3s_pcie_event_irq_thread() don't continue if the reset is in
>   progress
> - access host->started with READ_ONCE()/WRITE_ONCE()
> - use disable_irq() in .reset_root_port()
> - in rzg3s_pcie_pm_notifier() checked host->resetting and host->started
>   before accessing IP registers
> 
> Changes in v6:
> - call pci_host_handle_link_down() if at least a link event occured
>   and there are devices on the bus.
> - dropped struct rzg3s_pcie_host::stared from here since it is now
>   part of patch 8/9
> - read the link IRQs in .reset_root_port() and restore them at the
>   end
> - flush the IRQ mask before synchronize()
> - in .reset_root_port() clear the link IRQ before enabling it to cope
>   with the new link handling procedure
> - due to these dropped the tags
> 
> Changes in v5:
> - lock around reads/writes on RZG3S_PCI_PINTRCVIE
> - in rzg3s_pcie_host_reset_root_port() kept non-relaxed reads/writes
>   on interrupt disable registers (even though the spin lock/unlock are around
>   them) to emphasize the need for updates before the IRQs are synchronized and
>   relaxed variants on interrupt enable path
> - collected tags
> 
> Changes in v4:
> - this patch is new and is a split from patch 7 of v3
> - use a boolean to keep track of the controller start state; with this
>   the state management code from patch 7 of v3 was dropped 
> 
> 
>  drivers/pci/controller/Kconfig           |   1 +
>  drivers/pci/controller/pcie-rzg3s-host.c | 184 ++++++++++++++++++++---
>  2 files changed, 167 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 7e550c474b7a..c747bd5a9ec1 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -296,6 +296,7 @@ config PCIE_RENESAS_RZG3S_HOST
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select MFD_SYSCON
>  	select IRQ_MSI_LIB
> +	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S
>  	  SoC.
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index a1c9e29f43e5..f6823c9bc414 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -336,6 +336,7 @@ struct rzg3s_pcie_port {
>   * @controller_id: PCIe controller identifier, used for System Controller access
>   * @link_rescan: The PCIe link rescan state
>   * @started: The PCIe controller state (started or not)
> + * @resetting: Mentions if the root port reset is in progress
>   * @num_lanes: The number of lanes
>   */
>  struct rzg3s_pcie_host {
> @@ -358,6 +359,7 @@ struct rzg3s_pcie_host {
>  	enum rzg3s_pcie_controller_id controller_id;
>  	bool link_rescan;
>  	bool started;
> +	bool resetting;

I don't think you need this new variable. Other reset_root_port implementation,
esp pcie-qcom doesn't need it and it uses a mutex to protect the whole reset
helper. Why can't you do the same?

>  	u8 num_lanes;
>  };
>  
> @@ -653,6 +655,9 @@ static void rzg3s_pcie_msi_irq_mask(struct irq_data *d)
>  
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
>  
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>  			       BIT(reg_bit));
>  }
> @@ -666,6 +671,9 @@ static void rzg3s_pcie_msi_irq_unmask(struct irq_data *d)
>  
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
>  
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>  			       0);
>  }
> @@ -972,6 +980,9 @@ static void rzg3s_pcie_intx_irq_mask(struct irq_data *d)
>  
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
>  
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
>  			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq), 0);
>  }
> @@ -982,6 +993,9 @@ static void rzg3s_pcie_intx_irq_unmask(struct irq_data *d)
>  
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
>  
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
>  			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq),
>  			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq));
> @@ -1185,12 +1199,46 @@ static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bounced)
>  {
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>  	struct pci_bus *bus = bridge->bus, *child;
> +	unsigned long flags;
>  	u32 val;
>  	int ret;
>  
> -	pci_lock_rescan_remove();
> +	/*
> +	 * A latched DL_UpDown means at least one real link transition took
> +	 * place since the last enumeration. If devices are enumerated
> +	 * recover the Root Port first.
> +	 */
> +	if (bounced && !list_empty(&bus->devices)) {
> +		struct pci_dev *port = pci_get_slot(bus, PCI_DEVFN(0, 0));
> +
> +		if (port && pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);
>  
> +		pci_dev_put(port);
> +	}
> +
> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
> +
> +	/*
> +	 * Don't continue if reset in progress or .reset_root_port() failed to
> +	 * start HW.
> +	 */
> +	if (host->resetting || !READ_ONCE(host->started)) {
> +		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +		return;
> +	}
> +
> +	/*
> +	 * Check the link state after the recovery: the .reset_root_port()
> +	 * retrains the link, so a device that is still present comes back
> +	 * up here and is re-enumerated right away instead of waiting for
> +	 * the next DL_UpDown event.
> +	 */
>  	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +
> +	pci_lock_rescan_remove();
> +
>  	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
>  		if (!list_empty(&bus->devices)) {
>  			dev_info(host->dev,
> @@ -1246,20 +1294,26 @@ static irqreturn_t rzg3s_pcie_event_irq_thread(int irq, void *data)
>  {
>  	struct rzg3s_pcie_host *host = data;
>  	bool bounced;
> -	u32 status;
>  
> -	status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
> -	bounced = status & RZG3S_PCI_PEIS0_DL_UPDOWN;
> +	scoped_guard(raw_spinlock_irqsave, &host->hw_lock) {
> +		u32 status;
>  
> -	if (!bounced && !READ_ONCE(host->link_rescan))
> -		return IRQ_NONE;
> +		if (host->resetting)
> +			return IRQ_NONE;
> +
> +		status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
> +		bounced = status & RZG3S_PCI_PEIS0_DL_UPDOWN;
> +
> +		if (!bounced && !READ_ONCE(host->link_rescan))
> +			return IRQ_NONE;
>  
> -	/* Clear the DL_UpDown status (W1C) */
> -	if (bounced) {
> -		writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
> -			       host->axi + RZG3S_PCI_PEIS0);
> +		/* Clear the DL_UpDown status (W1C) */
> +		if (bounced) {
> +			writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
> +				       host->axi + RZG3S_PCI_PEIS0);
> +		}
> +		WRITE_ONCE(host->link_rescan, false);
>  	}
> -	WRITE_ONCE(host->link_rescan, false);
>  
>  	rzg3s_pcie_link_event(host, bounced);
>  
> @@ -1982,13 +2036,13 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
>  	return ret;
>  }
>  
> -static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
> +static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host, bool set_started)
>  {
>  	const struct rzg3s_pcie_soc_data *data = host->data;
>  	struct rzg3s_sysc *sysc = host->sysc;
>  	int ret;
>  
> -	if (host->started)
> +	if (READ_ONCE(host->started))
>  		return 0;
>  
>  	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
> @@ -2023,7 +2077,10 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
>  	if (ret)
>  		goto assert_power_resets;
>  
> -	host->started = true;
> +	if (set_started) {
> +		WRITE_ONCE(host->started, true);
> +		host->resetting = false;
> +	}
>  
>  	return 0;
>  
> @@ -2038,6 +2095,91 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
>  	return ret;
>  }
>  
> +static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridge,
> +					   struct pci_dev *pdev)
> +{
> +	struct rzg3s_pcie_host *host = pci_host_bridge_priv(bridge);
> +	unsigned long flags;
> +	u32 irqs, link_irqs;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
> +	if (host->resetting) {
> +		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +		return -EBUSY;
> +	}
> +	host->resetting = true;

This really looks like a bad pattern.

> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +
> +	/* Mask link up/down interrupts. */
> +	link_irqs = readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
> +
> +	/* Mask INTx and MSI interrupts. */
> +	irqs = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PINTRCVIE);
> +
> +	/* Flush IRQ masks. */
> +	readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
> +	readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
> +
> +	/*
> +	 * Make sure the next operations are not disturbed by any pending
> +	 * IRQs.
> +	 */
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		disable_irq(host->msi.irq);
> +	for (unsigned int i = 0; i < PCI_NUM_INTX; i++)
> +		disable_irq(host->intx_irqs[i]);
> +

I'm not sure about these. You already masked the IRQs above and flushed them.
Why do you need to explicitly disable interrupts here? If your concern is to
avoid triggering the irq handlers while this one is run, I don't think these
disable_irq() calls can guarantee you that.

- Mani


