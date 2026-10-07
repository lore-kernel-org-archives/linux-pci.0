Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5F3EA66
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352470; cv=none; b=WaHd8bF/wf1JTo2O3e3JIw/votqrrGPHDv29OavL+rxPGMa/QgUKR6KAh8tK82ORzViBGHyn1kEuFD17ELYdXkSdsNzPTQ2imyBqbon8FS31X7sWxthWTaGh6UnbBtWJIGYG/0EjJude4DmsAwEhGwfvsswxyaZRwqz2vo/Hok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352470; c=relaxed/simple;
	bh=GafCVRz7s/cyqv5TI5hug12XOWeJDmjrgROfWWGAi/0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=T8zjZqUiYelO6E/HZ0CGvSZY/Ebbt+dQYGUxdkqOF8QeQZe12qAnRVqssUopOcS9sQQ81GDImsF7FYaC3wRkZkwzZL2zHxFKTiu6npFcp/VCdkXegziJLRHuiG3vBfQaDaeKzHFgiTxRycmJBsgO4zFopvbj5ZiXIhXc5RKiCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxD8iNpz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxD8iNpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6159E1F0089B;
	Wed,  7 Oct 2026 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352469;
	bh=i3xaDva/z5ofNY/sbqyf5/bh8n4ev0pHbnBFfUeAniA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MxD8iNpzjOWouM70RlOrUCpj1gmDLbi1i+eXgIgjk8sR9hKRPAyW76duKyoF0dDUH
	 45q1honeD004Om1ZG1QjEztJLTYFcn2jRVqMaXMdalDtBTdXr1moAX27Q1BwnsV0Ho
	 54XV+V3wnhC14FDgMrg5iNSdwxfImy2n6JKY8vr0Qw8DRQjWN2cwEj1t81I6J55hDH
	 ewkfKBJFCwToxspaesBACW0IZ+CN52oH9ThV3lxOylnEbqco2WBSTO9BmTpuxY7q5d
	 D8C83pBNQEkJrY8YFVkYpuSy/LmYuvvr9Lig/0x8UdVPEVYL6rafFVHM5EJ7X4hhdL
	 lGfboWtfG2c7g==
Message-ID: <sashiko-outbox-162654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] PCI: rzg3s-host: Add bridge::reset_root_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261007053645.1391545-10-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-10-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:54:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] pci: rzg3s-host: Missing sysfs/AER vs event_irq synchronizatio=
n causing AXI abort
- [High] pci: PINTRCVIE INTx/MSI mask overwritten after unlocked hardware r=
eset
- [Medium] pci: goto-based error handling mixed with __free() scope cleanups
- [Medium] pcie: rzg3s: data race on PEIE0 register during concurrent sysfs=
 reset and suspend
--

commit 52776c6784c4d35d5a362a3b52bff852eb31f68f
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

PCI: rzg3s-host: Add bridge::reset_root_port()

This commit adds the bridge::reset_root_port() implementation to allow
reads and writes to an NVMe endpoint after a link down/up cycle. It
masks all enabled interrupts, resets the controller, and synchronizes
IRQs to prevent asynchronous events from interfering with the reset.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index c2fbacfe67044..a8b222625a2a6 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1193,8 +1193,27 @@ static void rzg3s_pcie_link_event(struct rzg3s_pci=
e_host *host, bool bounced)
>  	u32 val;
>  	int ret;
> =20
> +	/*
> +	 * A latched DL_UpDown means at least one real link transition took
> +	 * place since the last enumeration. If devices are enumerated
> +	 * recover the Root Port first.
> +	 */
> +	if (bounced && !list_empty(&bus->devices)) {
> +		struct pci_dev *port __free(pci_dev_put) =3D
> +			pci_get_slot(bus, PCI_DEVFN(0, 0));

[Severity: Medium]
This adds a __free() variable to a function that relies on goto-based error
handling (e.g. goto unlock; later in this function).

The global cleanup guidelines state that goto and cleanup helpers should ne=
ver
be mixed in the same function. Should all resources in this function be
converted to scope-based cleanup, or should we continue using traditional
cleanup here?

> +
> +		if (port && pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);
> +	}
> +
>  	pci_lock_rescan_remove();
> =20
> +	/*
> +	 * Read the link state after the recovery: the .reset_root_port()
> +	 * retrains the link, so a device that is still present comes back
> +	 * up here and is re-enumerated right away instead of waiting for
> +	 * the next DL_UpDown event.
> +	 */
>  	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);

[Severity: Critical]
Can reading this AXI register cause a synchronous external abort (kernel pa=
nic)
if a concurrent sysfs/AER thread calls rzg3s_pcie_host_stop() and disables
the clocks?

Since rzg3s_pcie_host_reset_root_port() intentionally omits
synchronize_irq(host->event_irq), and no other locks are held here to
exclude the sysfs reset path, it seems this thread can read the register
while power resets are asserted.

>  	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
>  		if (!list_empty(&bus->devices)) {
[ ... ]
> @@ -2053,6 +2073,77 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie=
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
> +	/* Mask link up/down interrupts. */
> +	link_irqs =3D readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
> +
> +	/* Mask INTx and MSI interrupts. */
> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
> +	irqs =3D readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
> +	writel_relaxed(0, host->axi + RZG3S_PCI_PINTRCVIE);
> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);

[Severity: High]
This caches the RZG3S_PCI_PINTRCVIE register in the local variable irqs,
then drops the lock.

If an endpoint driver concurrently calls request_irq(), free_irq(), or
enable_irq() for an INTx/MSI interrupt during the unlocked window below,
won't the stale irqs value be written back later, permanently losing or
causing spurious IRQ masks?

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
> +		synchronize_irq(host->msi.irq);
> +	for (unsigned int i =3D 0; i < PCI_NUM_INTX; i++)
> +		synchronize_irq(host->intx_irqs[i]);
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
> +		 * return and preserve the stop state.
> +		 */
> +		return ret;
> +	}
> +
> +unmask_irqs:
> +	/* Unmask INTx and MSI interrupts. */
> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
> +	writel_relaxed(irqs, host->axi + RZG3S_PCI_PINTRCVIE);

[Severity: High]
This restores the potentially stale irqs local variable, overwriting
any mask changes made concurrently by the IRQ subsystem while the lock
was dropped.

> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +
> +	/*
> +	 * rzg3s_pcie_host_start() retrains the link. If the link comes
> +	 * back up, DL_UpDown gets latched in PEIS0. Clear the latch.
> +	 * The link state is evaluated after this function returns, so
> +	 * the event is not lost. For the same reason there is no need
> +	 * to set host->link_rescan.
> +	 */
> +	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
> +	/* Unmask link up/down interrupts. */
> +	writel_relaxed(link_irqs, host->axi + RZG3S_PCI_PEIE0);

[Severity: Medium]
If a user concurrently triggers a sysfs reset while the system is
entering suspend, can this unconditionally restore an unmasked PEIE0 state
and overwrite the interrupt mask set by PM_SUSPEND_PREPARE?

Looking at rzg3s_pcie_pm_notifier(), it executes in PM_SUSPEND_PREPARE and
zeroes PEIE0 to mask interrupts for system sleep. A concurrent sysfs reset
will read the unmasked state, complete the reset, and blindly write the
unmasked state back, leaving interrupts unmasked during suspend and
potentially causing wake-up or power domain transition failures.

> +
> +	host->started =3D true;
> +
> +	return ret;
> +}
[ ... ]
> @@ -2133,6 +2224,8 @@ static int rzg3s_pcie_pm_notifier(struct notifier_b=
lock *nb,
>  	case PM_SUSPEND_PREPARE:
>  		/* Disable link up/down interrupts. */
>  		disable_irq(host->event_irq);
> +		if (host->started)
> +			writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);

[Severity: Medium]
This zeroes PEIE0 for system sleep, but a racing sysfs reset in
rzg3s_pcie_host_reset_root_port() can unconditionally overwrite this
state with its saved unmasked value.

>  		break;
> =20
>  	case PM_POST_SUSPEND:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D9
