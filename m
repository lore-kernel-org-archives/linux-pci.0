Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF117A303
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394273; cv=none; b=QSwOhIxQ0/+SHJps8FzVw0eC/SRgwDsoRcym1oY14P8aVjutaHYYYnLwfMPBIcA2PiXE4fwJd6//HM3OHVS+/IA8So80ymQM7kVqKBJ2EnGgtN4G4ntWH9MLFgbYBQGqpJN1Apz9+RRn0VIvk3myHAKq9K6rbLWZ4oc23sGDM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394273; c=relaxed/simple;
	bh=4E3qsJAXPCLQyLOQ8hCd1imeJ94QNMoZjQe24AeLiKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N08qWIR+Og3jLn2WR2Bmx8gzS5pEFpc5Y+3/BLGbSgKu/VWsOzQjh45lpFH/fcrxyHCQ8195+f7GyyKPMbFOYL8p0VeH4hlLduMmnIn7wG5B60qmkxNGMNYBjyQL6BluGtTUzb+PBUl8bPkBXptOjlZdi0YFbUH85/d5BPcHswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSM/2gWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSM/2gWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE891F000E9;
	Thu, 21 May 2026 20:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779394272;
	bh=GPUESdx4wN0spr93x6T14LRM5+LnI4pOOJuICMZm6t8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WSM/2gWQ2VKs6CodGHk/sgq5KLZl+LMi1qF5vazUYHZoIaP27nvE55Bt2FfBtdL3+
	 HA2wroyHUlFzBr8TLST0lRFeTWKa+VkZ5gadxdy0JVNaFc1XBMPo+jFoe9pfgtXg/J
	 7foYn2rK86lUwCz0spr/CnSLDaTMsOgxXFU+gnW4z34FZCz0APsZGsbhy7dfE+Gd/6
	 BhelP5Tn1xy5ypOOgoQm7YztEbkK79R8MsE4b9dINnT1ZEE5XoJpNebPjzLqcYiJpz
	 IAvCcy+DFqnBRYuGF8Gfx+XarpZpGpiZ2XOyq+fSr9NIAOprwyE7IQ41DUK9R3qm3O
	 W1rLk9MsHcBqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] PCI: mediatek: Protect root bus removal with rescan
 lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521161822.132996-7-18255117159@163.com>
References: <20260521161822.132996-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 20:11:11 +0000
Message-Id: <20260521201111.CAE891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced clock disable and PM runtime disable when PCIe links ar=
e down.
--

commit 92b7c7047c2235e7192b983ddc544d37ac83ba04
Author: Hans Zhang <18255117159@163.com>

PCI: mediatek: Protect root bus removal with rescan lock

Secure mtk_pcie_remove() by adding pci_lock_rescan_remove() /
pci_unlock_rescan_remove() around pci_stop_root_bus() and
pci_remove_root_bus().

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 75722524fe744..2fedb6d2939de 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1172,8 +1172,10 @@ static void mtk_pcie_remove(struct platform_device=
 *pdev)
>  	struct mtk_pcie *pcie =3D platform_get_drvdata(pdev);
>  	struct pci_host_bridge *host =3D pci_host_bridge_from_priv(pcie);
> =20
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(host->bus);
>  	pci_remove_root_bus(host->bus);
> +	pci_unlock_rescan_remove();
>  	mtk_pcie_free_resources(pcie);
> =20
>  	mtk_pcie_irq_teardown(pcie);

[Severity: High]
This is a pre-existing issue, but does the unconditional call to
mtk_pcie_put_resources(pcie) at the end of this function cause unbalanced
disables if all port links failed to come up?

In mtk_pcie_setup(), if all port links fail to come up (for instance, if no
PCIe endpoint is connected), list_empty(&pcie->ports) evaluates to true.
When this happens, mtk_pcie_subsys_powerdown(pcie) is called early,
disabling the clock and PM runtime. However, mtk_pcie_probe() successfully
completes and registers the empty root bus.

When the driver is later unbound or removed, mtk_pcie_remove()
unconditionally executes mtk_pcie_put_resources(pcie), without the necessary
!list_empty(&pcie->ports) guard that correctly exists in the probe error
path. This calls mtk_pcie_subsys_powerdown() a second time.

Will this double clk_disable_unprepare() trigger a clock framework WARN,
and increment the PM disable depth to 2?

If the driver is later re-probed, pm_runtime_enable() only decrements the
depth by 1, leaving the device disabled.

Can this result in pm_runtime_get_sync() silently failing to power on the
PCIe power domain, causing subsequent MMIO register accesses in
mtk_pcie_enable_port() to trigger a synchronous external abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521161822.1329=
96-1-18255117159@163.com?part=3D6
