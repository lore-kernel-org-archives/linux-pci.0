Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A035C6BA
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352420; cv=none; b=UIxLBvSAZycoNaZJAcUfnUHuhXJTSwJhwwpG/1/szz4IEisoy9Y8rtNht9ls5mMV3vS9G5txSclPeqX3r8YUusQBdQWZwAc4/BMRRdC4uS7YW/Hq2kay1+6vglHNtH9B4G9t6FVeBWQY4imFzV14NUZtGHwdco7ggDe6FgPOzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352420; c=relaxed/simple;
	bh=xUmKuKdXZUieM3GEUFpB8IcaPVgNsHbFJRj4lhsTGCI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uZG2yg7kQ/8qwATKovLTNkGdHBbO0xYCwk8QPltAQkWo0zCZJ3burdxKj34iMyTkYztDQ/JgZBnzMWIRAamkb0hf5UvjlYW3ReHokvRnU5+oswRf+zsoH6sgClOkOOjKLA/s7ybnGqKQejuJUKBBUwlVIQA2J/Nzlr/rgIWvxC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsRsl4TR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsRsl4TR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBDA1F0089C;
	Wed,  7 Oct 2026 05:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352418;
	bh=RyMMdmNVyKG2TnXYN1ZKuhZWY0GKll5hl2Fqeo9xqd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XsRsl4TRuuZSsRa3xsGxH+KOFBLyUbtCEKmqwZNgxx0o3U3jDwMW7BhkFipVV4xkR
	 FQexUmd2fkX17nQ1OXYQ63YwQks3wHuAPdeB8F9TZL2jlAdDcxDRQScbXxDTT+Y3GF
	 vWdakEuJMd3PH90544Q0OiY35X09GmJ5fK6nOg5AG5Nbpfvd6kf5tMleaMOmg1L7zJ
	 Yos6eDXihHH8yaBCqvNzEg+5kM4PYDqVgtJck0zMJShV/ohCKxotofr07pF/WnD4wu
	 PfCUYYdFclIcbenXohvwQbjtJcSNonsnJyKmgkROPA0rTln/MbFsgDmWUmtL7lgTEj
	 ewC74iuJ8NsLQ==
Message-ID: <sashiko-outbox-162653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261007053645.1391545-9-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-9-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:53:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] pci: link event incorrectly removes Root Port instead of endpoint =
devices
- [High] pci: missing pci_dev_set_disconnected() on link down causes MMIO a=
borts
- [High] pci: probe error path disables clocks before freeing IRQ
- [High] pci: NULL pointer dereference in rzg3s_pcie_link_event() on spurio=
us IRQ
- [Medium] pm: missing hibernation PM events in notifier causes deadlock
- [Low] cleanup: mixing goto cleanup labels and __free() in rzg3s_pcie_link=
_event()
--

commit f03b110c046274fb59aa60ec476f662ddada8707
Author: John Madieu <john.madieu.xa@bp.renesas.com>
Subject: PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

This commit enables PCIe link-state change detection for RZ/G3 and RZ/V2
hardware by hooking into the DL_UpDown interrupt. On link up/down, the driv=
er
removes and rescans devices, adds suspend/resume PM notifiers to avoid
deadlocks, and modifies probe to tolerate absent devices initially.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index ebe89e6a0796a..c2fbacfe67044 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1105,12 +1119,188 @@ static int rzg3s_pcie_wait_for_link_up(struct rz=
g3s_pcie_host *host)
[ ... ]
> +static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bou=
nced)
> +{
> +	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host);
> +	struct pci_bus *bus =3D bridge->bus, *child;
> +	u32 val;
> +	int ret;
> +
> +	pci_lock_rescan_remove();
> +
> +	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
> +	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
> +		if (!list_empty(&bus->devices)) {

[Severity: High]
Does this code risk a NULL pointer dereference if a spurious IRQ fires early
in the probe sequence?

If the interrupt fires before pci_host_probe() initializes bridge->bus, then
bus will be NULL here. The IRQ handler rzg3s_pcie_event_irq_thread() does n=
ot
mask the raw status with the interrupt enable register, so it might process
events before initialization is complete.

> +			dev_info(host->dev,
> +				 "PCIe link down, removing devices\n");
> +			rzg3s_pcie_remove_devices(bus);

[Severity: High]
Does this remove the correct devices?  Here bus points to bridge->bus,
which is the system Root Bus (bus 0).  Removing devices from the Root Bus
will destroy the SoC's integrated Root Port device itself, rather than the
endpoint devices on the subordinate bus.

[Severity: High]
Also, does this path miss setting the devices as disconnected?  Unlike the
device replacement path below, there is no call to pci_dev_set_disconnected=
()
before removing the devices.

Since the link is down and the hardware is inaccessible, any unprotected MM=
IO
accesses in the endpoint driver's .remove() callback will fail and trigger
synchronous external aborts.

> +		}
> +		goto unlock;
> +	}
> +
> +	if (!list_empty(&bus->devices)) {
> +		bool replaced =3D rzg3s_pcie_device_replaced(host);
> +
[ ... ]
> +		if (replaced) {
> +			struct pci_dev *port __free(pci_dev_put) =3D
> +				pci_get_slot(bus, PCI_DEVFN(0, 0));

[Severity: Low]
This isn't a bug, but is it acceptable to mix __free() with goto unlock
labels in the same function?

The kernel cleanup guidelines discourage mixing goto-based cleanup labels w=
ith
scoped-based cleanups as it can create confusing ownership semantics.

> +
> +			if (port && port->subordinate)
> +				pci_walk_bus(port->subordinate,
> +					     pci_dev_set_disconnected, NULL);
> +		}
> +
> +		rzg3s_pcie_remove_devices(bus);

[Severity: High]
Does this also remove the Root Port instead of the endpoint devices?  Simil=
ar
to the link down path, bus points to the Root Bus instead of the subordinate
bus.

> +	}
[ ... ]
> +unlock:
> +	pci_unlock_rescan_remove();
> +}
> +
> +static irqreturn_t rzg3s_pcie_event_irq_thread(int irq, void *data)
> +{
> +	struct rzg3s_pcie_host *host =3D data;
> +	bool bounced;
> +	u32 status;
> +
> +	status =3D readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
> +	bounced =3D status & RZG3S_PCI_PEIS0_DL_UPDOWN;
> +
> +	if (!bounced && !READ_ONCE(host->link_rescan))
> +		return IRQ_NONE;

[Severity: High]
Does this handler need to mask the status against the interrupt enable
register (PEIE0)?

Without it, a spurious interrupt could cause the handler to process a
latched DL_UPDOWN event before it is officially unmasked, potentially
calling rzg3s_pcie_link_event() when bridge->bus is still uninitialized.

> +
> +	/* Clear the DL_UpDown status (W1C) */
> +	if (bounced)
> +		writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
> +	WRITE_ONCE(host->link_rescan, false);
[ ... ]
> @@ -1916,6 +2123,41 @@ static void rzv2h_pcie_release_lanes(void *data)
[ ... ]
> +static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	struct rzg3s_pcie_host *host =3D container_of(nb, struct rzg3s_pcie_hos=
t,
> +						    pm_nb);
> +
> +	switch (action) {
> +	case PM_SUSPEND_PREPARE:

[Severity: Medium]
Does this switch statement miss the hibernation PM events?

If events like PM_HIBERNATION_PREPARE or PM_RESTORE_PREPARE are not handled,
the link event IRQ could remain unmasked during hibernation. If a link flap
occurs, the handler might run and attempt to acquire locks while devices are
frozen, leading to the deadlock this notifier was designed to prevent.

> +		/* Disable link up/down interrupts. */
> +		disable_irq(host->event_irq);
> +		break;
[ ... ]
> @@ -2008,15 +2250,38 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
[ ... ]
> +pm_notifier_unregister:
> +	unregister_pm_notifier(&host->pm_nb);
>  host_probe_teardown:
>  	clk_disable_unprepare(host->port.refclk);
>  	rzg3s_pcie_teardown_irqdomain(host);

[Severity: High]
Does this error path disable clocks before freeing the event IRQ?

If the IRQ is still registered and active, it could fire after the reference
clock is gated. The IRQ handler reads the AXI register RZG3S_PCI_PEIS0, and
accessing unclocked AXI registers will typically cause a synchronous extern=
al
abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D8
