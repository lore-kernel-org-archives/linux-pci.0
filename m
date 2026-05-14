Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FF36A349;
	Thu, 14 May 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758515; cv=none; b=B+uUIsh4cTvvO/ttyoCiS9XgDH6VRboQuOUKkvS/tOC7PPOS4Uf6xlF0bZQZh+BKw+I4P70FA/Z4iYlamkRovZ1xnY9g/mCGkKAQ8QaiYGcpy8ifTZQs0J6F6njx9zjdyLzBSflDW7MkcD2bdeKchzUfLzum+P2bZnZuyP1EPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758515; c=relaxed/simple;
	bh=nR1W5quuMzbgSWhodreIJr6oCScftENTAMR9uGrNBns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hhNYVa4TDZZNuSMgXYe+9JKeAf7WfYjOHcc26q9xqK7AEbVe6HWPYQtign3y/wnZbw4F1kcoNcVc5r6Nro8fdPY540rycrLsQclmthmFGrZ4vlUdPyXAuWYocfbOC7DZM1jBfRmd02epr4mnYLWoZpXoMtxZH4a5UKCT01/E1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSo8bNnu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSo8bNnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15297C2BCB3;
	Thu, 14 May 2026 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778758514;
	bh=nR1W5quuMzbgSWhodreIJr6oCScftENTAMR9uGrNBns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GSo8bNnuWrYdFDysbeLdJLOKJoN9zm0A2JMtsyjfmGyc6i54/xPGcFnc2pYV4BhAY
	 rmKvgsJfMC/XUfGj4/tqCyIj4jeEX/NjVG+Z0xXK2cCgAqL90Y+op7dVNT0wxzEmrG
	 aeHv6pvNCdnxslcQPesj6UYv6DULAMNETDItNAe67NIHvqSaHhKKkiOBkJ9RU3B0UO
	 VHnZ80kYRI1oM1CMdo0Rhfj2NASPPC6wtUyb3/IVJxtf7G0yihouIEwn5CwRx9P3Wg
	 CbSA/Wk0OiiUMG3e0sT6pionmEcR4njCNlfjBF41ANTVZRIM5CkV91iY6tGkfLsYp8
	 OPev0IRkzal/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] PCI: mediatek: Add support for EcoNet EN7528 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Caleb James DeLisle" <cjd@cjdns.fr>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260513191652.3200607-3-cjd@cjdns.fr>
References: <20260513191652.3200607-3-cjd@cjdns.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:35:13 +0000
Message-Id: <20260514113514.15297C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Use-after-free on probe error path due to missing pci_remove_root_=
bus().
- [High] Hardware is exposed to endpoint drivers before link retraining com=
pletes, causing MMIO failures.
- [High] mtk_pcie_retrain() only retrains the first root port, ignoring oth=
ers.
- [Medium] Data race and potential use-after-free due to unprotected iterat=
ion of the PCI bus list.
- [Medium] Truncation of 64-bit resource_size_t in fls() causes incorrect A=
XI window size calculation.
- [Medium] Silent feature degradation when the driver is compiled as a load=
able module.
--

commit 940197600e9e8eb5cb8f108830edfaee6eeb6d16
Author: Caleb James DeLisle <cjd@cjdns.fr>

PCI: mediatek: Add support for EcoNet EN7528 SoC

This commit adds support for the PCIe controller on the EcoNet EN7528 and
EN751221 SoCs. It includes logic to re-train Gen2 capable ports that
initially start at Gen1 speeds.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
[ ... ]
> @@ -753,6 +764,132 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie=
_port *port)
>  	return 0;
>  }
> =20
> +static int mtk_pcie_startup_port_en7528(struct mtk_pcie_port *port)
> +{
[ ... ]
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		mtk_pcie_enable_msi(port);
> +
> +	/* Set AHB to PCIe translation windows */
> +	val =3D lower_32_bits(mem->start) |
> +	      AHB2PCIE_SIZE(fls(resource_size(mem)));

Does passing resource_size(mem) to fls() risk truncating 64-bit values?
Since resource_size_t can be a 64-bit integer and fls() expects a 32-bit
unsigned int, an exact 4GB window (0x100000000) or larger could truncate
to 0, leading to an incorrect translation window size. Should this use
fls64() instead?

> +	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
[ ... ]
> +static int mtk_pcie_retrain(struct device *dev, struct pci_host_bridge *=
host)
> +{
> +	struct pci_dev *rp;
> +	int ret =3D -ENOENT;
> +	u16 lnksta =3D 0;
> +	u32 speed;
> +
> +	for_each_pci_bridge(rp, host->bus) {
> +		if (pci_pcie_type(rp) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			goto found_port;
> +	}

By jumping to found_port immediately upon finding the first root port, does
this skip retraining for any subsequent ports (like RC1 on the EN7528)? The
commit message mentions it is most convenient to re-train every port after
startup.

Also, is it safe to iterate host->bus->devices via for_each_pci_bridge()
and use the rp device pointer without holding down_read(&pci_bus_sem) or
taking a reference via pci_dev_get()? Since this function runs after
pci_host_probe() finishes, could the device list change concurrently?

> +
> +	/* Should not happen */
> +	return dev_err_probe(dev, ret, "root bridge not found\n");
> +
> +found_port:
> +	if (!IS_BUILTIN(CONFIG_PCIE_MEDIATEK)) {
> +		/* Let it go because the device will work as Gen1 */
> +		dev_warn(dev, "module must be built-in to retrain to Gen2\n");
> +		return 0;
> +	}
> +
> +#if IS_BUILTIN(CONFIG_PCIE_MEDIATEK)
> +	ret =3D pcie_retrain_link(rp, true);
> +#endif

If the driver is built as a loadable module, this skips link retraining and
silently leaves the hardware operating at Gen1 speeds. Is there a way to
achieve consistent hardware capabilities regardless of the build
configuration without relying on IS_BUILTIN checks?

> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to retrain port\n");
[ ... ]
> @@ -1149,6 +1286,11 @@ static int mtk_pcie_probe(struct platform_device *=
pdev)
>  	err =3D pci_host_probe(host);
>  	if (err)
>  		goto put_resources;
> =20
> +	if (pcie->soc->quirks & MTK_PCIE_RETRAIN)
> +		err =3D mtk_pcie_retrain(dev, host);
> +	if (err)
> +		goto put_resources;
> +
>  	return 0;
> =20
>  put_resources:

Since mtk_pcie_retrain() is called after pci_host_probe() returns, are the
devices exposed to endpoint drivers before the link retraining completes?

If endpoint drivers are actively probing and communicating with the hardware
via MMIO while the link is forced into the Recovery state, could this cause
transactions to fail or timeout?

Additionally, if mtk_pcie_retrain() fails, the code jumps to put_resources
and returns an error. This causes devres to free the host bridge memory.
However, since pci_host_probe() already fully registered the PCI root bus
and its child devices, does this error path leave dangling references in the
PCI subsystem by failing to call pci_stop_root_bus() and
pci_remove_root_bus() before freeing resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513191652.3200=
607-1-cjd@cjdns.fr?part=3D2
