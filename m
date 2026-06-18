Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D621D5AF
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810795; cv=none; b=gmm7uZkE0K+MP1gIR4gmE10T0CkBKZLKGuj4R8mRL0z2Kqp6veRjMvK+dUjy/OoevkYg9/nCroPSSg+1zKfBwObkdMUwyBtRoJEoIWW3r3GUqNgMaGRrSPAzJSC5Zu5wN4mLdI4hruyZrnq0rd2rIddKloZjuCbwAcghdoPwJv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810795; c=relaxed/simple;
	bh=18Qc+NjUIcfeoRgZA9Xu8ZID/6VjOj2shZr18ZzKI3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eiolwK8Oe/ZqFX5i92ABkTmlLQ7G3b0tLv5W5ZG1ElPIAjpV0sdlW1LVBoETPgqk4lo/cEL0mtBjFwVW7qjvuB96bv8qo8PLU6xd4vspYGRlbqNIb7nnLPC4ig5a1JqWj2W0C3YDdhebLbKdNzeBHNSNuIrLenbyEaobw2GH7wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag08H2GT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag08H2GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781351F000E9;
	Thu, 18 Jun 2026 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781810793;
	bh=QMjWGYRlhtX4FRuaQPEJZL2FF54nfFRJ7JCqGQiCr7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ag08H2GTeQhdXMz1bzv4gZyNXowHfXfD72zlhhrr7VFNh3rrV+3CgKLUTHIGcZjtM
	 m3AZpvQgHXqxvNvNbeVR6Ql3GUa09K1G7lOcEIa+kgxXYT0t+B4p/ZG+NUHILqGm1C
	 P4J+mgji5tTfXts3JdzwRLoCEeddjw+EmOy3/uCt39Ltm2jNIIKyfURDBqDSKtTgfv
	 8KM9Wid8gSPy7Npu/rciqwIXdTDY7DFgUp/9ePs2YSc1FfNaGb4O9om/9bLDIg3Vv3
	 7wVr81H/BcjvGUYzrumkDzpjkCGZic4DaYBDglw5fPaChLAZvPtPeuBs/PT5/mg9CS
	 ln9BXw94BAk/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Madieu" <john.madieu.xa@bp.renesas.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260618190935.3018531-1-john.madieu.xa@bp.renesas.com>
References: <20260618190935.3018531-1-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 19:26:32 +0000
Message-Id: <20260618192633.781351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [High] Calling cancel_work_sync() in the suspend_noirq callback can cause=
 a system deadlock and violates atomic context rules.
- [High] The event IRQ handler accesses hardware registers unconditionally,=
 which will crash the system if the device is suspended or unclocked.
- [High] Link state change events that occur while the system is suspended =
are intentionally dropped but never recovered on resume, permanently desync=
hronizing the driver's state.
- [High] Devices physically unplugged during system suspend are not removed=
 from the bus, resulting in zombie devices.
- [High] Unprotected Read-Modify-Write of Root Port configuration space rac=
es with generic PCI subsystem accesses.

Pre-existing issues:
- [High] Calling pm_runtime_put_sync() in suspend_noirq unconditionally abo=
rts system suspend.
- [High] The rzg3s_pcie_resume_noirq() callback calls sleeping functions wh=
ile interrupts are disabled.
- [High] Read-modify-write on W1C (Write-1-to-Clear) interrupt status regis=
ters silently drops concurrent hardware interrupts.
- [High] The hardware IRQ index calculation assumes contiguous Linux virtua=
l IRQ numbers, leading to unhandled IRQ loops.
--

commit 59f68b406a390ed1dd3041cecba9856005c43783
Author: John Madieu <john.madieu.xa@bp.renesas.com>

PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

The RZ/G3E PCIe controller does not expose the standard PCIe Slot Capability
registers, so the generic pciehp driver cannot be used. The only link-state
signal the hardware provides is the DL_UpDown bit in the PEIS0 event status
register, which is raised on every Data Link layer up/down transition.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index d86e7516dcc29..5a10422ced2e5 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -575,6 +584,30 @@ static irqreturn_t rzg3s_pcie_msi_irq(int irq, void =
*data)
>  	return IRQ_HANDLED;
>  }

[Severity: High]
This is a pre-existing issue, but does read-modify-write on a W1C register
silently drop concurrent hardware interrupts?

In rzg3s_pcie_msi_irq(), rzg3s_pcie_update_bits() is used:

    rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
                           RZG3S_PCI_PINTRCVIS_MSI,
                           RZG3S_PCI_PINTRCVIS_MSI);

Since RZG3S_PCI_PINTRCVIS is a W1C register, does this read all pending
interrupts as 1s and write them back, clearing all interrupts simultaneously
before their handlers can process them?

> +static irqreturn_t rzg3s_pcie_event_irq(int irq, void *data)
> +{
> +	struct rzg3s_pcie_host *host =3D data;
> +	u32 status;
> +
> +	status =3D readl_relaxed(host->axi + RZG3S_PCI_PEIS0);

[Severity: High]
Can this unconditional hardware register read crash the system if the device
is suspended or unclocked?

The pcie_evt IRQ may act as a system wakeup source. If the interrupt fires
during sleep, the handler runs immediately after CPU wakeup, before the PM
core reaches resume_noirq to restore power and clocks to the controller.

Will reading the AXI register RZG3S_PCI_PEIS0 while the block is unclocked
trigger a synchronous external abort? Should the handler verify if the devi=
ce
is powered before touching its registers?

> +
> +	if (!(status & RZG3S_PCI_PEIS0_DL_UPDOWN))
> +		return IRQ_NONE;
> +
> +	/* Clear the DL_UpDown status (W1C) */
> +	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
> +
> +	/*
> +	 * Drop the event until the controller is fully initialised. The
> +	 * event IRQ may act as a system wakeup source and fire during
> +	 * resume before the HW registers have been reconfigured.
> +	 */
> +	if (READ_ONCE(host->hw_initialized))
> +		schedule_work(&host->link_work);

[Severity: High]
Does dropping these events permanently desynchronize the driver's state?

In rzg3s_pcie_suspend_noirq(), hw_initialized is set to false, which causes
this handler to intentionally drop valid hotplug events without scheduling =
the
bus rescan work.

During system resume, the hw_initialized flag is restored to true, but the
driver doesn't appear to poll the link state or trigger a manual rescan. Wi=
ll
devices inserted or removed during the suspend/resume cycle fail to be
enumerated or cleaned up?

[ ... ]

> @@ -1107,6 +1140,47 @@ static int rzg3s_pcie_set_max_link_speed(struct rz=
g3s_pcie_host *host)
>  	return ret;
>  }
> =20
> +static void rzg3s_pcie_link_work(struct work_struct *work)
> +{
[ ... ]
> +		/*
> +		 * Attempt link speed negotiation now that the link is up.
> +		 * Failure is non-fatal: the device works at the negotiated
> +		 * speed.
> +		 */
> +		ret =3D rzg3s_pcie_set_max_link_speed(host);

[Severity: High]
Does rzg3s_pcie_set_max_link_speed() race with generic PCI subsystem access=
es?

The scheduled link_work calls rzg3s_pcie_set_max_link_speed(), which uses t=
he
rzg3s_pcie_update_bits() helper:

    rzg3s_pcie_update_bits(host->pcie, pcie_cap + PCI_EXP_LNKCTL2,
                           PCI_EXP_LNKCTL2_TLS,
                           FIELD_PREP(PCI_EXP_LNKCTL2_TLS, link_speed));

Since this natively modifies the Root Port's configuration space without
holding the PCI subsystem's pci_lock, can concurrent userspace accesses (via
sysfs setpci) or other kernel configuration accesses corrupt the configurat=
ion
state?

[ ... ]

> @@ -1655,8 +1734,15 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
> =20
>  	ret =3D rzg3s_pcie_host_init(host);
>  	if (ret) {
> -		dev_err_probe(dev, ret, "Failed to initialize the HW!\n");
> -		goto teardown_irqdomain;
> +		if (ret !=3D -ENODEV) {
> +			dev_err_probe(dev, ret,
> +				      "Failed to initialize the HW!\n");
> +			goto teardown_irqdomain;
> +		}
> +
> +		/* Link is down: hotplug via DL_UpDown will recover. */
> +		WRITE_ONCE(host->hw_initialized, true);
> +		return 0;

[Severity: High]
Can this leave zombie devices on the bus if a device is physically unplugged
during system suspend?

If a device is removed while suspended, rzg3s_pcie_host_init() correctly
returns -ENODEV (link down) during resume. However, by intercepting -ENODEV
and returning 0 here without cleaning up the bus, the stale child devices a=
re
retained.

Because there is no link state transition from up to down at this stage, the
DL_UpDown interrupt will not fire. Will the kernel indefinitely retain the
pci_dev structures for the absent devices and cause failed MMIO accesses?

[ ... ]

> @@ -1789,9 +1910,19 @@ static int rzg3s_pcie_suspend_noirq(struct device =
*dev)
>  	struct rzg3s_sysc *sysc =3D host->sysc;
>  	int ret;
> =20
> +	/*
> +	 * Stop accepting DL_UpDown events, then drain any worker that may
> +	 * already be running, before tearing the controller down.
> +	 */
> +	WRITE_ONCE(host->hw_initialized, false);
> +	cancel_work_sync(&host->link_work);

[Severity: High]
Does calling cancel_work_sync() here cause a system deadlock and violate
atomic context rules?

The suspend_noirq callback executes with local CPU interrupts disabled.
Calling cancel_work_sync() can block and sleep while waiting for the work
item to finish.

Can sleeping in an atomic context with interrupts disabled lead to a
'scheduling while atomic' bug or cause deadlocks if the work item relies on
locks or hardware interrupts that cannot be serviced?

> =20
>  	ret =3D pm_runtime_put_sync(dev);
> -	if (ret)
> +	if (ret) {
> +		/* Suspend aborted; keep handling DL_UpDown events. */
> +		WRITE_ONCE(host->hw_initialized, true);
>  		return ret;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does calling
pm_runtime_put_sync() in suspend_noirq unconditionally abort system suspend?

In the suspend_noirq phase, the PM core has already unconditionally disabled
runtime PM by incrementing the disable_depth, so pm_runtime_put_sync() will
fail with -EACCES.

By returning this error, does the driver force the PM core to abort the ent=
ire
system suspend? Should the driver use pm_runtime_force_suspend() instead?

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does the
rzg3s_pcie_resume_noirq() callback call sleeping functions while interrupts
are disabled?

rzg3s_pcie_resume_noirq() executes in the NOIRQ phase with local CPU
interrupts disabled. It indirectly calls msleep() and fsleep() via:

    rzg3s_pcie_resume_noirq() -> rzg3s_pcie_host_setup() -> msleep()

Can sleeping in an atomic context violate kernel rules and lead to a
'scheduling while atomic' bug or system deadlocks?

[Severity: High]
This is a pre-existing issue, but does the hardware IRQ index calculation
assume contiguous Linux virtual IRQ numbers?

In rzg3s_pcie_intx_irq_handler(), the hardware INTx index is calculated as:

    u32 intx =3D irq - host->intx_irqs[0];

Linux dynamically assigns virtual IRQs without contiguity guarantees. If the
allocated IRQs are not perfectly contiguous, does this math produce
out-of-bounds indices, causing generic_handle_domain_irq() to fail and
resulting in an unhandled IRQ storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618190935.3018=
531-1-john.madieu.xa@bp.renesas.com?part=3D1
