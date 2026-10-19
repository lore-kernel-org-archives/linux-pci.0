Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5748B383
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 07:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394751; cv=none; b=mN4128UZVrUFNv+KAdTMr7sBeam8qZm5xU55bRaIrBJdxwuQzHXwLcLhjE1mxFVu6i9/UyaHpJzcxql9jVohImSx+qXtFVqc4FW+qSYIh/4XdsL2I+/ZHKnacs2w4uiAXHv6q6j+HqmoaxvYn6lSiSAuAyHTkXFTGvgBHWRzEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394751; c=relaxed/simple;
	bh=m2b+c9D3zXEdhmT7DA1gifnMKALbGFGBicy2HZdEO4s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iFqbu8vNSydlngVJRykcRTum29bTomfd5BbIJaZItykwE+SKhhiBi735dogJBslkDMGB9lyPBPWmQqN84fl9dsmBOq8ctrq8FZBLiXy2Khy2rqBh3DFJ+9mziMtnlND+XM1KNU60y5G5o2YbNL1jWe818WVGh6V5UQLxaoJpPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiyVRjBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiyVRjBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8411F000C4;
	Mon, 19 Oct 2026 07:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394747;
	bh=s5mbd10odh0WP4iIHTalkrrQx+TdiOQ1o0xD2xuXWfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eiyVRjBKaDPJMnVFt/MVxVLZ4UPobdCEk3ivKPvz865F7KCeBE4P2C7d6ToQ37yp7
	 Rf5TEwKfpK8xtsyErFHKMlxShCo+lexnTGnry4xwW+XE29tz3P6OsHN9Hl+038jU10
	 OceV5iJqEUSEiQTlTJSFBzCHhArpSwjE7wNRm3D6N+pLXdlihfBcyrCvpryBmP0muJ
	 qC6pbq0BcSTyQeeVo1KpDLgfJgd3L5CxNNTJSPxZkpWQ98yQUFoBb7BMmBwQkzSaRj
	 RNAhiZZBBpHoRi1tODM1JSeUjWqT5i7Bw+nTeRUkYhSH/gRPlC2+K1yUUgcqlAs1ff
	 3gq7pFz1ugOsQ==
Message-ID: <sashiko-outbox-176744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/14] PCI: rzg3s-host: Add bridge::reset_root_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261019065025.2146539-15-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-15-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:25:47 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] PCI: rzg3s-host: unguarded MMIO access and lost INTx mask after st=
art failure
- [High] PCI: rzg3s-host: lost MSI/INTx mask state across rzg3s_pcie_host_r=
eset_root_port()
- [High] PCI: rzg3s-host: race and lost link event in rzg3s_pcie_host_reset=
_root_port()
- [Medium] PCI: rzg3s-host: race in rzg3s_pcie_host_reset_root_port() state=
 ordering
- [Medium] PCI: rzg3s-host: race on RZG3S_PCI_PEIE0 between reset and PM no=
tifier
- [Medium] PCI: rzg3s-host: ineffective disable_irq() on chained INTx IRQs =
in reset
--

commit 6658179b714958398bb0f41660bab61430893417
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

PCI: rzg3s-host: Add bridge::reset_root_port()

This commit implements pci_host_bridge::reset_root_port() for the Renesas
RZ/G3S PCIe host controller so the Root Port can be reset and recovered
across a link down/up cycle. It masks and disables MSI and INTx interrupts
around stopping and restarting the controller and adds a host->resetting
flag to block concurrent register accesses from the IRQ callbacks.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index a1c9e29f43e5d..f6823c9bc4149 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

[ ... ]

> @@ -653,6 +655,9 @@ static void rzg3s_pcie_msi_irq_mask(struct irq_data *=
d)
> =20
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
> =20
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>  			       BIT(reg_bit));
>  }
> @@ -666,6 +671,9 @@ static void rzg3s_pcie_msi_irq_unmask(struct irq_data=
 *d)
> =20
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
> =20
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
>  			       0);
>  }
> @@ -972,6 +980,9 @@ static void rzg3s_pcie_intx_irq_mask(struct irq_data =
*d)
> =20
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
> =20
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
>  			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq), 0);
>  }
> @@ -982,6 +993,9 @@ static void rzg3s_pcie_intx_irq_unmask(struct irq_dat=
a *d)
> =20
>  	guard(raw_spinlock_irqsave)(&host->hw_lock);
> =20
> +	if (host->resetting)
> +		return;
> +
>  	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
>  			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq),
>  			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq));

[Severity: High]
Could returning early when host->resetting is true cause the hardware IRQ
masks in RZG3S_PCI_MSIRM(reg_id) and RZG3S_PCI_PINTRCVIE to go out of sync
with genirq?

In kernel/irq/chip.c, mask_irq() and unmask_irq() unconditionally update
IRQD_IRQ_MASKED after calling the chip callback. If an INTx or MSI vector is
masked or unmasked while host->resetting is true, these callbacks drop the
update without recording it, and rzg3s_pcie_host_reset_root_port() later
writes the pre-reset irqs snapshot back to RZG3S_PCI_PINTRCVIE.

In particular, rzg3s_pcie_host_reset_root_port() sets host->resetting =3D t=
rue
before reading RZG3S_PCI_PINTRCVIE into irqs (outside host->hw_lock) and
before calling disable_irq(host->intx_irqs[i]). If an INTx interrupt is in
flight on another CPU in handle_level_irq() or in a threaded IRQF_ONESHOT
handler on a child virq when irqs is snapshotted, its bit in
RZG3S_PCI_PINTRCVIE is 0. When that handler finishes and calls
cond_unmask_irq() or irq_finalize_oneshot() -> rzg3s_pcie_intx_irq_unmask(),
the unmask is ignored because host->resetting is true, and restoring the
stale irqs snapshot at unmask_irqs leaves the INTx line masked in hardware
while genirq considers it unmasked.

Also, because rzg3s_pcie_msi_parent_ops sets MSI_FLAG_PCI_MSI_MASK_PARENT,
per-vector MSI masking lives in RZG3S_PCI_MSIRM(reg_id) rather than
RZG3S_PCI_PINTRCVIE. Across rzg3s_pcie_host_stop() and
rzg3s_pcie_host_start(), RZG3S_PCI_MSIRM(reg_id) is reset and never saved or
restored.

> @@ -1185,12 +1199,46 @@ static void rzg3s_pcie_link_event(struct rzg3s_pc=
ie_host *host, bool bounced)
>  {
>  	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host);
>  	struct pci_bus *bus =3D bridge->bus, *child;
> +	unsigned long flags;
>  	u32 val;
>  	int ret;
> =20
> -	pci_lock_rescan_remove();
> +	/*
> +	 * A latched DL_UpDown means at least one real link transition took
> +	 * place since the last enumeration. If devices are enumerated
> +	 * recover the Root Port first.
> +	 */
> +	if (bounced && !list_empty(&bus->devices)) {
> +		struct pci_dev *port =3D pci_get_slot(bus, PCI_DEVFN(0, 0));
> +
> +		if (port && pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);
> =20
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
>  	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);

[Severity: High]
What prevents a concurrent rzg3s_pcie_host_reset_root_port() from stopping
the controller after host->hw_lock is released here while
rzg3s_pcie_link_event() is still accessing controller registers?

bridge->reset_root_port can be invoked outside rzg3s_pcie_link_event()
through pci_bridge_secondary_bus_reset() -> pcibios_reset_secondary_bus()
(for example via sysfs reset_subordinate, pci_reset_function(),
pci_reset_bus(), or aer_root_reset()). Once rzg3s_pcie_link_event() drops
host->hw_lock after reading RZG3S_PCI_PCSTAT1, it proceeds to touch
host->axi and host->pcie in rzg3s_pcie_device_replaced(),
rzg3s_pcie_set_max_link_speed(), pci_scan_child_bus(), and
rzg3s_pcie_cache_connected_dev_id(). Because rzg3s_pcie_host_reset_root_por=
t()
only takes host->hw_lock briefly to set host->resetting =3D true and does n=
ot
synchronize with host->event_irq, it can enter rzg3s_pcie_host_stop() and
assert power_resets while rzg3s_pcie_link_event() is in the middle of those
MMIO accesses.

Conversely, if rzg3s_pcie_event_irq_thread() clears RZG3S_PCI_PEIS0_DL_UPDO=
WN
and host->link_rescan and then rzg3s_pcie_link_event() returns early here
because a concurrent reset set host->resetting =3D true, won't that link ev=
ent
or rescan request be lost?

[ ... ]

> @@ -2038,6 +2095,91 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie=
_host *host)
>  	return ret;
>  }
> =20
> +static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridg=
e,
> +					   struct pci_dev *pdev)
> +{
> +	struct rzg3s_pcie_host *host =3D pci_host_bridge_priv(bridge);
> +	unsigned long flags;
> +	u32 irqs, link_irqs;
> +	int ret;
> +
> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
> +	if (host->resetting) {
> +		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +		return -EBUSY;
> +	}
> +	host->resetting =3D true;
> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +
> +	/* Mask link up/down interrupts. */
> +	link_irqs =3D readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
> +
> +	/* Mask INTx and MSI interrupts. */
> +	irqs =3D readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
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
> +	for (unsigned int i =3D 0; i < PCI_NUM_INTX; i++)
> +		disable_irq(host->intx_irqs[i]);

[Severity: Medium]
Does disable_irq(host->intx_irqs[i]) actually mask or synchronize the INTx
interrupts here?

In rzg3s_pcie_init_irqdomain(), host->intx_irqs[i] are registered with
irq_set_chained_handler_and_data(irq, rzg3s_pcie_intx_irq_handler, host)
without IRQ_DISABLE_UNLAZY. On GICv3, irq_chip::irq_disable is NULL, so
__irq_disable() only sets IRQD_IRQ_DISABLED (lazy disable) without masking
the GIC SPI. And because chained handlers replace desc->handle_irq with
rzg3s_pcie_intx_irq_handler(), generic_handle_irq_desc() invokes
rzg3s_pcie_intx_irq_handler() directly without checking irqd_irq_disabled()
or setting IRQD_IRQ_INPROGRESS.

If an INTx SPI is already pending at the GIC before RZG3S_PCI_PINTRCVIE is
cleared, or glitches while resets are toggled, rzg3s_pcie_intx_irq_handler()
can still run during reset and call generic_handle_domain_irq() ->
handle_level_irq() -> mask_ack_irq() -> rzg3s_pcie_intx_irq_ack(), which
writes to host->axi + RZG3S_PCI_PINTRCVIS without checking host->resetting.

> +
> +	ret =3D rzg3s_pcie_host_stop(host);
> +	if (ret) {
> +		dev_err(host->dev, "Failed to stop the host!\n");
> +		goto unmask_irqs;
> +	}
> +
> +	ret =3D rzg3s_pcie_host_start(host, false);
> +	if (ret) {
> +		dev_err(host->dev, "Failed to start the host!\n");
> +
> +		/*
> +		 * Don't unmask IRQs. We are in a bad state here and we
> +		 * can recover only through a suspend/resume cycle. Just
> +		 * re-enable the IRQs and return.
> +		 */
> +		goto enable_irqs;
> +	}

[Severity: High]
If rzg3s_pcie_host_start(host, false) fails here and jumps to enable_irqs,
won't subsequent callers access host->pcie and host->axi while power_resets
are asserted and RST_RSM_B is 0?

When rzg3s_pcie_host_reset_root_port() returns an error to
pcibios_reset_secondary_bus(), pci_bridge_secondary_bus_reset() still calls
pci_bridge_wait_for_secondary_bus(), which immediately polls config space
through rzg3s_pcie_root_ops (rzg3s_pcie_root_map_bus()) and
rzg3s_pcie_child_ops (rzg3s_pcie_child_read()), neither of which checks
host->started or host->resetting. Moreover, rzg3s_pcie_link_event() returns
early on !READ_ONCE(host->started) without removing or marking child devices
disconnected, so endpoint drivers and pci_pm_suspend() during the recovery
suspend/resume cycle will also access config space and MMIO while the IP is
held in reset.

In addition, jumping to enable_irqs discards the local irqs variable holding
the saved RZG3S_PCI_PINTRCVIE value. When rzg3s_pcie_resume_noirq() later
calls rzg3s_pcie_host_start(host, true), only RZG3S_PCI_PINTRCVIE_MSI is set
and the INTx enable bits in RZG3S_PCI_PINTRCVIE are never restored. And if
rzg3s_pcie_resume_noirq() itself fails in rzg3s_pcie_host_start(host, true),
host->started remains false while host->resetting is false, so
rzg3s_pcie_host_reset_root_port(), rzg3s_pcie_msi_irq_mask/unmask(),
rzg3s_pcie_intx_irq_mask/unmask(), and rzg3s_pcie_event_irq_thread() (which
only check host->resetting) will access host->axi while the IP is not
started.

> +
> +unmask_irqs:
> +	/* Unmask INTx and MSI interrupts. */
> +	writel_relaxed(irqs, host->axi + RZG3S_PCI_PINTRCVIE);
> +
> +	/*
> +	 * rzg3s_pcie_host_start() retrains the link. If the link comes
> +	 * back up, DL_UpDown gets latched in PEIS0. Clear the latch.
> +	 * The link state is evaluated after this function returns, so
> +	 * the event is not lost. For the same reason there is no need
> +	 * to set host->link_rescan.
> +	 */
> +	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);

[Severity: High]
Is it safe to clear RZG3S_PCI_PEIS0_DL_UPDOWN here without setting
host->link_rescan or waking host->event_irq when .reset_root_port() is
called outside rzg3s_pcie_link_event()?

When rzg3s_pcie_host_reset_root_port() is invoked via
pci_bridge_secondary_bus_reset() -> pcibios_reset_secondary_bus() from a pa=
th
other than rzg3s_pcie_link_event() (such as pci_reset_function(),
pci_reset_bus(), or sysfs reset_subordinate), nothing evaluates the link
state after this function returns, so clearing RZG3S_PCI_PEIS0_DL_UPDOWN
drops any link transition that occurred during the reset.

> +	/* Unmask link up/down interrupts. */
> +	writel_relaxed(link_irqs, host->axi + RZG3S_PCI_PEIE0);
> +
> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
> +	host->resetting =3D false;
> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +
> +	WRITE_ONCE(host->started, true);

[Severity: Medium]
Can the ordering between unmasking RZG3S_PCI_PEIE0, clearing
host->resetting, and setting host->started =3D true cause false failure
detection or a dropped link interrupt?

First, RZG3S_PCI_PEIE0 is unmasked before host->resetting is cleared, while
host->event_irq remains enabled throughout rzg3s_pcie_host_reset_root_port(=
).
If a link event fires right after RZG3S_PCI_PEIE0 is written,
rzg3s_pcie_event_irq_thread() can run while host->resetting is still true
and return IRQ_NONE.

Second, host->resetting =3D false is committed and host->hw_lock is released
before WRITE_ONCE(host->started, true) (since rzg3s_pcie_host_stop() set
host->started =3D false and rzg3s_pcie_host_start(host, false) was called w=
ith
set_started =3D false). In that window, both host->resetting and host->star=
ted
are false, so a reader holding host->hw_lock in rzg3s_pcie_link_event():

	if (host->resetting || !READ_ONCE(host->started)) {
		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
		return;
	}

or in rzg3s_pcie_pm_notifier() can observe host->resetting =3D=3D false and
host->started =3D=3D false and treat a successful reset as a failed hardware
start. Note that rzg3s_pcie_host_start() (when set_started is true) and
rzg3s_pcie_host_stop() also update host->started and host->resetting without
holding host->hw_lock.

> +
> +enable_irqs:
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		enable_irq(host->msi.irq);
> +	for (unsigned int i =3D 0; i < PCI_NUM_INTX; i++)
> +		enable_irq(host->intx_irqs[i]);
> +
> +	return ret;
> +}
> +
>  static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
>  {
>  	struct device_node *np =3D host->dev->of_node;
> @@ -2113,18 +2255,22 @@ static int rzg3s_pcie_pm_notifier(struct notifier=
_block *nb,
>  {
>  	struct rzg3s_pcie_host *host =3D container_of(nb, struct rzg3s_pcie_hos=
t,
>  						    pm_nb);
> +	unsigned long flags;
> =20
>  	switch (action) {
>  	case PM_SUSPEND_PREPARE:
>  		/* Disable link up/down interrupts. */
> -		if (host->started)
> +		raw_spin_lock_irqsave(&host->hw_lock, flags);
> +		if (READ_ONCE(host->started) && !host->resetting)
>  			writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
> +		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
>  		disable_irq(host->event_irq);
>  		break;
> =20
>  	case PM_POST_SUSPEND:
>  		/* Enable link up/down interrupts and force link re-scan. */
> -		if (host->started) {
> +		raw_spin_lock_irqsave(&host->hw_lock, flags);
> +		if (READ_ONCE(host->started) && !host->resetting) {
>  			/*
>  			 * The link re-train in resume triggers the link up IRQ
>  			 * if there are connected devices. Clear the DL_UpDown
> @@ -2137,8 +2283,9 @@ static int rzg3s_pcie_pm_notifier(struct notifier_b=
lock *nb,
>  			writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
>  				       host->axi + RZG3S_PCI_PEIE0);
>  		}
> +		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
>  		enable_irq(host->event_irq);
> -		if (host->started)
> +		if (READ_ONCE(host->started))
>  			irq_wake_thread(host->event_irq, host);
>  		break;
>  	}

[Severity: Medium]
Can rzg3s_pcie_pm_notifier() and rzg3s_pcie_host_reset_root_port() race on
RZG3S_PCI_PEIE0?

PM_SUSPEND_PREPARE runs before tasks are frozen or devices are suspended. If
rzg3s_pcie_host_reset_root_port() is already running, it saves link_irqs =3D
RZG3S_PCI_PEIE0_DL_UPDOWN and sets host->resetting =3D true. When
rzg3s_pcie_pm_notifier(PM_SUSPEND_PREPARE) runs concurrently, it sees
host->resetting =3D=3D true and skips writing 0 to RZG3S_PCI_PEIE0, and
rzg3s_pcie_host_reset_root_port() then writes link_irqs back to
RZG3S_PCI_PEIE0 at unmask_irqs, leaving link interrupts unmasked in hardware
during suspend.

Conversely, if PM_SUSPEND_PREPARE runs first and writes 0 to
RZG3S_PCI_PEIE0, and a reset is then triggered before devices suspend,
rzg3s_pcie_host_reset_root_port() saves link_irqs =3D 0. If suspend aborts =
and
PM_POST_SUSPEND runs while the reset is still in progress (host->resetting
=3D=3D true, host->started =3D=3D false), PM_POST_SUSPEND skips re-enabling
RZG3S_PCI_PEIE0_DL_UPDOWN and skips irq_wake_thread(), and
rzg3s_pcie_host_reset_root_port() restores link_irqs =3D 0 at unmask_irqs,
leaving link up/down interrupts disabled after resume.

[ ... ]

>
> --=20
> 2.43.0
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D14
