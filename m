Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0F2C08BC;
	Wed,  3 Jun 2026 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470335; cv=none; b=gJirvYo0Vm3Q/gZ+4D3CcCs0ZKoB+PrzjnIDNsvGNkcj2N0Ialy36Svwf+brysZ/6juoeVPFxOycOPkawMH6MhfDoxu1PG8VhnXJoKWaBvA07+HyRVFIzbQPL/HL0qcsE+/KwKOmsowEDpUfrGELuYgkKiIk10tjLXeyl94JN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470335; c=relaxed/simple;
	bh=obhaxkDBbofL2T3y02WGHzlUpfinhZPfwomPxGaN1FQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9zqILxPlbmQjyDsT12YNeZwk8VjodL5zKX+CH58KtlyKGcm8p7AJkNClAg0zDNFOfQoFQ+wiTGgeSLIBBuKhXpfPe/QGz+ITWF4r+JSTNp3ygcE62tDqS85sJFAGV/9WubHzMdTCLt/tGlJ/7w2/LudO2HuChJeyW+qwFZLdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPasc9NF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPasc9NF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641461F00893;
	Wed,  3 Jun 2026 07:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470333;
	bh=1KSrGaZqDQ3Mx4+dmtoKcc8eUVkR3wqHBa3kGRLwpZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPasc9NFlnGw3KzoaiNRW9/m/7zcCXDe+xo36qT6yyoqnSVgQELmvw2zDc9R+IINL
	 LJ5ORgr4sbFZ8sQSo6v+UK/vPzBt2HG3vrbr4CMd7Fj9wQYAgXQar/1S8gxQE/aM/a
	 7xJuKgIic+5xqxNrOHlAwd0vXAuqu4A/hyhuQKvk6yxO93NegGC7AVQI8LfdcJQcFX
	 1P+84QPcS71aDTeFN/AtpmZpB/neKZRljmeX06/HHkyVkp16ttF3E7Ps/3ZwuFIc4x
	 ZwRjn3gZn1jZe4ptANtPQ6/gZlIo/4imlVrRJmxQVZTN5/z0ORUbTOo5MzxGvr9JTj
	 0c76M5DHbaHqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add root port reset to support link
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260603062510.3767610-4-hongxing.zhu@oss.nxp.com>
References: <20260603062510.3767610-4-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 07:05:32 +0000
Message-Id: <20260603070533.641461F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Read-modify-write operations on mixed RW/W1C register silently dro=
p interrupts.
- [High] Shared interrupt handler checks status but fails to verify if the =
interrupt is enabled.
- [High] Ignored return value of `dw_pcie_wait_for_link()` hides downstream=
 link recovery failures.
- [High] Lockless traversal of PCI bus devices in an asynchronous IRQ threa=
d exposes the kernel to Use-After-Free and list corruption.
- [High] Link down interrupt is not disabled during system shutdown, causin=
g an AXI bus fault and system hang.
- [High] Failed root port reset leaves the controller unclocked while still=
 active, causing a crash on subsequent PM suspend.
- [High] Unprotected hardware indirect register access during root port res=
et.
- [Medium] Ignored negative error codes from `platform_get_irq_byname_optio=
nal()` break probe deferral.
- [Low] Build failure due to undefined functions and struct members.
--

commit 5bee25b25210b0bc28349bc8474d10204a25cd72
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Add root port reset to support link recovery

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 773ab65b2afac..aa5c90be23df8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1394,6 +1401,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
p)
> =20
>  	imx_setup_phy_mpll(imx_pcie);
> =20
> +	/*
> +	 * Callback invoked by PCI core when link down is detected and
> +	 * recovery is needed.
> +	 */
> +	if (pp->bridge)
> +		pp->bridge->reset_root_port =3D imx_pcie_reset_root_port;

[Severity: Low]
Does the reset_root_port member actually exist in struct pci_host_bridge?=20
This appears to cause a build failure since the struct member is undefined.

[ ... ]

> @@ -1661,6 +1675,9 @@ static int imx_pcie_suspend_noirq(struct device *de=
v)
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
> =20
> +	if (imx_pcie->lnk_intr > 0)
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				  IMX95_LINK_DOWN_INT_EN);

[Severity: High]
Since IMX95_LINK_INT_CTRL_STS mixes an RW enable bit and a write-1-to-clear=
=20
status bit, will using regmap_clear_bits perform a read-modify-write cycle=
=20
that inadvertently clears pending status bits if they are latched during th=
e=20
read?

[ ... ]

> +static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv)
> +{
> +	struct imx_pcie *imx_pcie =3D priv;
> +	struct dw_pcie *pci =3D imx_pcie->pci;
> +	struct device *dev =3D pci->dev;
> +	u32 val;
> +
> +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
> +	if (val & IMX95_LINK_DOWN_INT_STS) {

[Severity: High]
Is it possible for this shared interrupt handler to be invoked while the=20
interrupt is disabled, see the latched status bit, and erroneously return=20
IRQ_WAKE_THREAD?=20

If a PME interrupt fires while the link down interrupt is intentionally=20
disabled, the ISR will still claim it. Would it be safer to check if=20
IMX95_LINK_DOWN_INT_EN is also set before proceeding?

> +		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
> +		/* Clear link down interrupt status by writing 1b'1 to it */
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				IMX95_LINK_DOWN_INT_STS);

[Severity: High]
Similar to the regmap_clear_bits call above, could using regmap_set_bits he=
re=20
perform a read-modify-write cycle that inadvertently clears other pending=20
write-1-to-clear bits in the same register?

> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				  IMX95_LINK_DOWN_INT_EN);
> +
> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv)
> +{
> +	struct imx_pcie *imx_pcie =3D priv;
> +	struct dw_pcie *pci =3D imx_pcie->pci;
> +	struct dw_pcie_rp *pp =3D &pci->pp;
> +	struct pci_dev *port;
> +
> +	for_each_pci_bridge(port, pp->bridge->bus)

[Severity: High]
Is it safe to iterate the bus list locklessly in this IRQ thread?=20
Could concurrent modifications to the PCI bus list cause a use-after-free=20
since the pci_bus_sem is not held?

> +		if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);

[Severity: Low]
Does the pci_host_handle_link_down function exist in the tree? This appears=
=20
to be an undefined function call which will cause a build failure.

> +
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +			IMX95_LINK_DOWN_INT_EN);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int imx_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +				    struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus =3D bridge->bus;
> +	struct dw_pcie_rp *pp =3D bus->sysdata;
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie =3D to_imx_pcie(pci);
> +	int ret;
> +
> +	imx_pcie_msi_save_restore(imx_pcie, true);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_save(imx_pcie);

[Severity: High]
The i.MX95 PCIe hardware uses an indirect access mechanism for LUTs. Since=
=20
this reset executes asynchronously in a threaded IRQ, should imx_pcie->lock=
=20
be acquired before calling imx_pcie_lut_save to prevent concurrent=20
operations from clobbering the shared indirect address indices?

> +	imx_pcie_stop_link(pci);
> +	imx_pcie_host_exit(pp);
> +
> +	ret =3D imx_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(pci->dev, "Failed to re-init PCIe\n");
> +		return ret;
> +	}
> +	ret =3D dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto err_host_deinit;
> +
> +	imx_pcie_start_link(pci);
> +	dw_pcie_wait_for_link(pci);

[Severity: High]
Should the return value of dw_pcie_wait_for_link be checked here?=20
By ignoring it, the function might falsely report success to the PCI core=20
even if downstream link recovery fails, which could lead to unsupported=20
request aborts when accessing downstream devices.

> +
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_restore(imx_pcie);
> +	imx_pcie_msi_save_restore(imx_pcie, false);
> +
> +	dev_dbg(pci->dev, "Root port reset completed\n");
> +	return 0;
> +
> +err_host_deinit:
> +	imx_pcie_host_exit(pp);

[Severity: High]
If the re-initialization fails and imx_pcie_host_exit disables the clocks,=
=20
the device still remains bound. If the system later initiates a suspend,=20
will imx_pcie_suspend_noirq execute unconditionally and trigger a fatal=20
external abort by attempting to read from the unclocked DBI registers?

> +
> +	return ret;
> +}
> +

[ ... ]

> @@ -1919,9 +2018,33 @@ static int imx_pcie_probe(struct platform_device *=
pdev)
>  			val |=3D PCI_MSI_FLAGS_ENABLE;
>  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
>  		}
> +
> +		/* Get link event irq if it is present */
> +		imx_pcie->lnk_intr =3D platform_get_irq_byname_optional(pdev, "intr");
> +		if (imx_pcie->lnk_intr > 0) {

[Severity: Medium]
If the interrupt controller is not yet ready, the platform irq function=20
returns -EPROBE_DEFER. Does checking strictly for > 0 cause the driver to=20
silently ignore this error code and fail to defer the probe, permanently=20
disabling the link recovery functionality?

[ ... ]

> +err_host_deinit:
> +	dw_pcie_host_deinit(&pci->pp);
> +
> +	return ret;
>  }
> =20
>  static void imx_pcie_shutdown(struct platform_device *pdev)

[Severity: High]
The patch enables the link down interrupt during probe, but looking at=20
imx_pcie_shutdown(), it does not disable it before asserting core reset.=20
Does asserting the core reset drop the link and trigger the interrupt?=20
If so, this could wake the threaded handler to access DBI registers while=20
the core is in reset, causing a synchronous external abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603062510.3767=
610-1-hongxing.zhu@oss.nxp.com?part=3D3
