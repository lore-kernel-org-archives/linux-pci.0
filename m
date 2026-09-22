Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832455293F
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089507; cv=none; b=dORJES0NIWnaiSSV5oTVIP+xL8WbHvkeRTWeSAbYEAeffF8leIMclSZIsHWk32Kv6yHpbBS0zUcRfHXpS0b5N/37PiqZVFyUxAApRi0tfnGAbGR33GkeMwtfoPJmNZro2udMyDclED0ygzIg7tr0Pcwrgjkr4mKzg6NopSQn4oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089507; c=relaxed/simple;
	bh=2ZQp6vwnm7qzLJ6CWCaTSOsklBwg/zjhx0JmVobw3Z0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAN/sf4871VVAyknZ54ATa0qij27VLrqynhYUDixivDSRW1kRs8Dn6naEkrMq4tk765ZWSSneEkos/S/FptanLb/pufZGv0ipjcyL8lTmTjiy7+BbdbdT2QaMS8PlLtd90Z5SvNSXbigQ82JDS2eow187gaSct0Wiz1xZcTzuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI8Fz97Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI8Fz97Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686E01F000FF;
	Tue, 22 Sep 2026 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089505;
	bh=V/r3bl8QZshYUOkYkxbLFT1TGKhjFhYpNRBv01EI7os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZI8Fz97Q0wA8PUBP/3aSaA9CWkiwl4quq0ao28a3Ev/pwAEoX22sIxr9ZC4k1Iqit
	 E9aPSHdWcuun3wTp0IZ70aHDXgjvmgjz/pdmLrUsMLMujeW7IrUfGPs3KP0ApOMQXd
	 pv9UEZ80snU3j8sOhR8nPa0TSEzo6bdtYeUMjuiJKLUHHddaARnX2GaSMguShJl8YY
	 BwIu4dZKJED+b0gRxYMMuXhu1Z2naMGrYoX2c8h7Zd4nAD3Kr6Tdzc7zB6V+8YBklW
	 /5DGarqzPP1CSK99s2YL/Z49HIo4Ml7jr8wui7DyeulgVZEtqTQ3s3FlgtmHCoyKGW
	 nG2GWqcZl7f3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/8] PCI: rzg3s-host: Add bridge::reset_root_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260922144629.586997-9-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-9-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:05:04 +0000
Message-Id: <20260922150505.686E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] pci: lockless RMW of RZG3S_PCI_PINTRCVIE clobbers IRQ masks
- [High] pci: lockless traversal of bus->devices causes list corruption
- [High] pci: missing synchronization of event_irq triggers abort
- [High] pci: Root Port removal breaks AER recovery logic
- [High] pci: latched GIC interrupts crash controller during reset
- [High] pci: data race on host->started imbalances clocks
- [Medium] pci: synchronize_irq(0) stall when CONFIG_PCI_MSI is disabled
--

commit 58da40640a7be86e3db083244a44a0cf4c9eb5f2
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

    PCI: rzg3s-host: Add bridge::reset_root_port()
   =20
    Add bridge::reset_root_port(). This allows, on some devices, performing
    reads and writes to an NVMe endpoint after a link down/link up cycle
    without failures.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 1c0353598b599..9cba898a9536d 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1110,6 +1112,11 @@ static void rzg3s_pcie_link_event(struct rzg3s_pci=
e_host *host)
> =20
>  		dev_info(host->dev, "PCIe link down, removing devices\n");
> =20
> +		for_each_pci_bridge(dev, bridge->bus) {
> +			if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +				pci_host_handle_link_down(dev);
> +		}
> +
>  		pci_lock_rescan_remove();

[Severity: High]
Does traversing bridge->bus->devices here without holding pci_bus_sem or
pci_lock_rescan_remove() risk a use-after-free?

If concurrent hotplug, AER recovery, or sysfs unbind operations modify the
list, could the traversal follow corrupted pointers?

>  		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
>  						 bus_list)
>  			pci_stop_and_remove_bus_device(dev);

[Severity: High]
Does this code remove the Root Port device right after initiating its recov=
ery?

When a link down event occurs, the loop above iterates over devices on the =
root
bus (which are the Root Ports themselves) and invokes
pci_host_handle_link_down(dev) to schedule DPC/AER recovery.

Immediately afterward, this list_for_each_entry_safe_reverse loop executes
pci_stop_and_remove_bus_device(dev) on the exact same Root Port device. Cou=
ld
this destroy the Root Port and unbind its drivers just as recovery is taking
place, breaking the recovery logic and future enumeration?

[ ... ]
> @@ -1855,6 +1862,9 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_h=
ost *host)
>  	struct rzg3s_sysc *sysc =3D host->sysc;
>  	int ret;
> =20
> +	if (!host->started)
> +		return 0;
> +
>  	clk_disable_unprepare(port->refclk);

[Severity: High]
Is host->started adequately protected against concurrent access?

Because host->started is checked and modified in rzg3s_pcie_host_stop() and
rzg3s_pcie_host_reset_root_port() without any locking, concurrent invocatio=
ns
of sysfs reset_root_port or PM transitions could both see host->started =3D=
=3D true.

Could both threads subsequently disable the reference clocks and assert res=
ets,
leading to imbalanced clock use counts and broken hardware state?

[ ... ]
> +static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridg=
e,
> +					   struct pci_dev *pdev)
> +{
> +	struct rzg3s_pcie_host *host =3D pci_host_bridge_priv(bridge);
> +	u32 irqs;
> +	int ret;
> +
> +	/* Mask link up/down interrupts. */
> +	writel(0, host->axi + RZG3S_PCI_PEIE0);
> +
> +	/* Mask INTx and MSI interrupts. */
> +	irqs =3D readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
> +	writel(0, host->axi + RZG3S_PCI_PINTRCVIE);

[Severity: High]
Should this mask register be read and written while holding host->hw_lock?

Concurrent calls to rzg3s_pcie_intx_irq_mask() running on another CPU will
modify this register while holding hw_lock. Could reading and clearing it h=
ere
locklessly, and restoring it later, clobber dynamic mask/unmask operations
that occurred during the reset window?

> +
> +	/*
> +	 * Make sure the next operations are not disturbed by any pending
> +	 * IRQs.
> +	 */
> +	synchronize_irq(host->msi.irq);

[Severity: Medium]
Will this stall if CONFIG_PCI_MSI is disabled?

host->msi.irq is populated only if CONFIG_PCI_MSI is enabled; otherwise, it
remains 0. Synchronizing against IRQ 0 targets a core architectural interru=
pt
or an invalid descriptor, which causes invalid synchronization behavior and
potential stalls.

> +	for (unsigned int i =3D 0; i < PCI_NUM_INTX; i++)
> +		synchronize_irq(host->intx_irqs[i]);
> +
> +	ret =3D rzg3s_pcie_host_stop(host);

[Severity: High]
Are there missing synchronization checks for the event_irq here?

Because host->event_irq is not synchronized, if the link state changes, the
rzg3s_pcie_event_irq_thread() can execute concurrently and attempt to read =
PCIe
configuration or AXI registers. Accessing the controller while clocks are
disabled by rzg3s_pcie_host_stop() immediately triggers a synchronous exter=
nal
abort.

[Severity: High]
Is synchronize_irq() sufficient to prevent latched GIC interrupts from
crashing the controller during reset?

Because MSIs are edge-triggered at the GIC, an interrupt that fires immedia=
tely
before the IP-level mask can remain latched in the GIC. synchronize_irq() o=
nly
waits for currently executing handlers, so the pending GIC interrupt remains
queued.

When the CPU enables local interrupts, the GIC dispatches the handler, which
attempts to read host->axi + RZG3S_PCI_PINTRCVIS while the controller clocks
are disabled by the reset, triggering a synchronous external abort. Should
disable_irq() be used instead?

[ ... ]
> +unmask_irqs:
> +	/* Unmask INTx and MSI interrupts. */
> +	writel_relaxed(irqs, host->axi + RZG3S_PCI_PINTRCVIE);

[Severity: High]
Could this lockless restore overwrite concurrent updates made by the IRQ
subsystem?

As noted above, restoring the previously read mask state locklessly clobbers
any dynamic mask/unmask operations that occurred during the reset window, w=
hich
can cause interrupt storms or lost interrupts.

> +
> +	/* Unmask link up/down interrupts. */
> +	writel(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
> +
> +	host->started =3D true;
> +
> +	return ret;
> +}

[Severity: High]
As mentioned earlier, does writing host->started without locking allow
concurrent updates to overwrite and desync the expected controller state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D8
