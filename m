Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D4488223
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940320; cv=none; b=mw4Nlwd8YuKhK5IyxvqbyhcvERqYbz4OYxbxFdWvE5SisvRxoGMpLFvr1TDU2CwRuvStk3KRh1MWOmE1zqSbJB5dS8FBku2aWbpbVDxwmSBZHc5j72Ah9493vOGMcLwGz0nKOGZLyL0Jz9em83jc0jj3hwSuCiIZYWsxIszyRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940320; c=relaxed/simple;
	bh=HsRMpAn4DmpzKZU08Hr2rZTWZDDXaRSfsgQHvDhXwQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DUflm2T/ax0yEbTZXHHbtKoYsUKxMS5WKeXyveZu7eAZuuzToJsY+2/ZLvD+ttYXECIN7Llb119Q71vGrvlAkqyWI125AX1pUA8l7ZEPJmi8xknqAiEi70XZ1etq2lBkrqacyvggwaBtx6EA/CbwndJsg+ktpOVYrGPYYnRFZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/+yVIj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/+yVIj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD401F000FF;
	Fri,  2 Oct 2026 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940318;
	bh=ebUhQsceJdzHs0odoG1tRYv2HFeKZAjucFx/4h1XbAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/+yVIj/mIrFMiyFMlb4TpDhqBOI/nyLvlNoQtVMfZLOxuIywMn0meMZz1YSBTI3f
	 Cv8aSNi/vYRG7wOzcH7mcH8Elf/pL/t7OV0VelGW4aQYdvr8cNqVjVIUaKN0vKLvlD
	 SxGocxa1nMk2XreEf7vf60rXFS3RlaNrE4rP6DXRGKAS3i0BftbJdhIie83CfaarHo
	 q2pzSs9DL/xG2bWnuIYBRVextiBQVEIunaNjeaDm/EhZz9Po6WPfRJHszadQ9D+xHw
	 Go8ivZi8kwu52XfkdqL1El1sbn67gRoia9E5K3HYRbmYQafEOqeYPtGXuMJuG2F5Rh
	 gfacPGY2/4jBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] PCI: rzg3s-host: Add bridge::reset_root_port()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261002110935.2004349-10-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-10-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:25:18 +0000
Message-Id: <20261002112518.9DD401F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] pci: rzg3s: INTx/MSI mask state loss due to stale register snapshot
- [High] pci: rzg3s: fatal unpowered MMIO access in PM notifier after reset=
 failure
- [High] pci: rzg3s: lockless iteration over bus->devices causes list corru=
ption
- [Medium] pci: rzg3s: missing I/O flush allows IRQs to fire after synchron=
ize_irq
--

commit c5ffdc83b56df877b7b137c1229cfe9487c3fb34
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: PCI: rzg3s-host: Add bridge::reset_root_port()

This commit adds a reset_root_port() callback for the rzg3s-host bridge.
It introduces the started boolean to track the controller state and prevents
double start/stop from breaking reference counters. It also updates the link
event and power management notifier paths to handle the interrupts correctl=
y.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 78e783928b9dc..eea215818633b 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1115,6 +1117,11 @@ static void rzg3s_pcie_link_event(struct rzg3s_pci=
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
Is it safe to iterate over bus->devices without holding the PCI
rescan/remove lock?

It looks like concurrent modifications to the list from sysfs rescan or
hotplug events could cause list corruption or a use-after-free. The
necessary lock is correctly taken immediately after this loop for the remov=
al
step, but appears to be omitted for this iteration.

[ ... ]
> @@ -1956,6 +1974,64 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie=
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
> +	u32 irqs;
> +	int ret;
> +
> +	/* Mask link up/down interrupts. */
> +	writel(0, host->axi + RZG3S_PCI_PEIE0);
> +
> +	/* Mask INTx and MSI interrupts. */
> +	raw_spin_lock_irqsave(&host->hw_lock, flags);
> +	irqs =3D readl(host->axi + RZG3S_PCI_PINTRCVIE);
> +	writel(0, host->axi + RZG3S_PCI_PINTRCVIE);
> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
> +
> +	/*
> +	 * Make sure the next operations are not disturbed by any pending
> +	 * IRQs.
> +	 */
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		synchronize_irq(host->msi.irq);

[Severity: Medium]
Does the posted write to the interrupt mask register need to be flushed
with a dummy read before calling synchronize_irq()?

Without a read-back to ensure the mask has reached the physical hardware, t=
he
controller might still emit an interrupt while synchronize_irq() runs,
potentially creating a race window where the handler crashes when the
controller clocks are subsequently cut in rzg3s_pcie_host_stop().

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
> +	raw_spin_unlock_irqrestore(&host->hw_lock, flags);

[Severity: High]
Could this unconditional restore overwrite mask changes made by concurrent
INTx mask/unmask operations?

Since hw_lock was dropped earlier to wait for IRQs and execute the
controller stop/start sequence, any intermediate updates to the register by
other drivers dynamically masking or unmasking their IRQs might be
permanently lost here when the old snapshot is restored.

> +
> +	/* Unmask link up/down interrupts. */
> +	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
> +
> +	host->started =3D true;
> +
> +	return ret;
> +}
[ ... ]
> @@ -2036,6 +2112,7 @@ static int rzg3s_pcie_pm_notifier(struct notifier_b=
lock *nb,
>  	case PM_SUSPEND_PREPARE:
>  		/* Disable link up/down interrupts. */
>  		disable_irq(host->event_irq);
> +		writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);

[Severity: High]
Could this write cause a synchronous external abort if the controller is
currently unpowered?

If rzg3s_pcie_host_start() fails inside rzg3s_pcie_host_reset_root_port(),
the function intentionally returns early, leaving host->started false and
the controller in reset with clocks disabled. A subsequent system suspend
would unconditionally hit this AXI write, which might hang the bus since
the target peripheral is held in reset.

>  		break;
> =20
>  	case PM_POST_SUSPEND:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D9
