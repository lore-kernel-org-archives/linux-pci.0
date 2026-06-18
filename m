Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101013DCD92;
	Thu, 18 Jun 2026 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775281; cv=none; b=iCA0k0J84Tv11wPl+QhqHI8atT+tvLbFFbd5mLRULTOXnBJyI1UFns958QbF8OkpTLL8Jma9SZU/tpmJrkb7OGa6BBR+ymNaiyJyBcr/6A/hNx1AXzpGU1Q2EDeyTahej/7Sj0rOBcb0SqBC11LvhUUEGfzDrESS2NQ+RMl2Yq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775281; c=relaxed/simple;
	bh=HH8NIKNt0Jrpzp+bTOCoGGIgkopyrLxtDN0lMgoUxFY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VYSKI81pnLliw+3gIRpApymiftsFLGxPmro7iGuNsN1JqXP3BB1/aL9G69A6/1oFElBXM8FYFvV9sK0S442hv7TVbsTBqptPGrSLKlOtbejK8S6D30gfU/CI+jHC4HWXJnJEq7DCW8HtqZ5LRLVbBbOT37V/Jh7OCGVyVhmuEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTbnFqwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTbnFqwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B9B1F000E9;
	Thu, 18 Jun 2026 09:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775278;
	bh=ebAZryT7OVF/z5evMq33O3XtSb+ClTJZ9XcaL97HuEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RTbnFqwKltRrh+4qGobFLQT//qw0Odb1F9wk9o/5NlOQt24RFbkPtsdNYfDuWxN87
	 xvGvUjmyFzqkJNYUj4m0B79JNHsFy0YpjeDLq5hTa3dPDWiVT8NDi5eKdqABiEOC2P
	 Ybq2XrIvld2z/Xm4VwwSL28XhZpCO8/6ip8CowYa9zmcQ2zQMnVeFI8Ca1FgC7yYKG
	 ldEa38f6SrArGPAcd7d6ym4isryi/2IouK0v5xy+a0KMRYhGAnfVV2EWdhvYgsATDW
	 VzD0mxQMZx77ZTFQALecDU9lCIPvdDDMU7E9UqN1B4FuHwzBYoojUh1d4CGf4ESmzy
	 EiUlCw0g8RZjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] PCI: imx6: Add root port reset to support link
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260618092100.3669556-4-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
 <20260618092100.3669556-4-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:34:37 +0000
Message-Id: <20260618093438.12B9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Using read-modify-write operations on a mixed RW/W1C register unin=
tentionally clears pending hardware interrupts.
- [High] The ISR unconditionally clears the link down status bit even if th=
e interrupt is disabled, dropping shared link recovery events.
- [High] Unsafe, lockless iteration over the PCI bus devices list without h=
olding pci_bus_sem.
- [High] The threaded interrupt handler is not synchronized during system s=
hutdown, leading to a race condition with controller power-off.
- [High] Accessing shared LUT GPR registers without acquiring imx_pcie->loc=
k causes a data race.
- [Medium] The `imx_pcie_reset_root_port` function silently ignores failure=
s to recover the PCIe link.
- [Low] The patch references undeclared functions and undefined struct memb=
ers, causing build failures.
--

commit 1a657928e9eb6aa6da8f1cc80545e5be5d066898
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Add root port reset to support link recovery

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..b38eb61983e15 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1442,6 +1450,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
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
Is reset_root_port defined in struct pci_host_bridge? Looking at
include/linux/pci.h, this member does not appear to exist in the standard
kernel. Does this patch depend on a prerequisite patch that adds it?

[ ... ]

> @@ -1774,6 +1795,86 @@ static const struct dev_pm_ops imx_pcie_pm_ops =3D=
 {
>  				  imx_pcie_resume_noirq)
>  };
> =20
> +static irqreturn_t imx_pcie_lnk_irq_isr(int irq, void *priv)
> +{
> +	struct imx_pcie *imx_pcie =3D priv;
> +	struct dw_pcie *pci =3D imx_pcie->pci;
> +	struct device *dev =3D pci->dev;
> +	u32 val;
> +
> +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS, &val);
> +	if (val & IMX95_LINK_DOWN_INT_STS) {
> +		dev_dbg(dev, "PCIe link down detected, initiating recovery\n");
> +		/* Clear link down interrupt status by writing 1b'1 to it */
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				IMX95_LINK_DOWN_INT_STS);
> +		if (!(val & IMX95_LINK_DOWN_INT_EN))
> +			return IRQ_NONE;

[Severity: High]
If this interrupt is shared and masked during thread execution, could this
unconditionally clear a new link down event?

Since the status is cleared before checking IMX95_LINK_DOWN_INT_EN, if a new
event triggers concurrently with the threaded handler, it appears the event
will be cleared and then discarded when the ISR returns IRQ_NONE.

> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				  IMX95_LINK_DOWN_INT_EN);
> +
> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_INT_STS, &val);
> +	if (unlikely(val))
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_INT_STS, val);
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
> +		if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);

[Severity: High]
Is it safe to iterate over the PCI bus devices list asynchronously here wit=
hout
holding the pci_bus_sem semaphore?

If concurrent PCI enumeration, hotplug device removal, or SR-IOV VF
modifications occur, could this result in list pointer corruption or a
use-after-free?

[Severity: Low]
Also, is pci_host_handle_link_down() declared in the standard kernel header=
s?
I am unable to find it in include/linux/pci.h, which might cause a build
failure without a prerequisite patch.

> +
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +			IMX95_LINK_DOWN_INT_EN);

[Severity: High]
Can regmap_set_bits() unintentionally clear pending hardware interrupts her=
e?

Since regmap_set_bits() performs a read-modify-write, and the
IMX95_LINK_DOWN_INT_STS (BIT 11) is a write-1-to-clear bit, could it
accidentally write back a 1 for a newly arrived link down event and
permanently lose that event?

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
Does imx_pcie_lut_save() need to acquire the imx_pcie->lock?

Since imx_pcie_reset_root_port() runs asynchronously in the recovery thread,
could this cause a data race on the shared IMX95_PE0_LUT_ACSCTRL index
register if another device probe concurrently calls imx_pcie_add_lut()?

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
> +		return ret;
> +
> +	imx_pcie_start_link(pci);
> +	dw_pcie_wait_for_link(pci);

[Severity: Medium]
Should the return value of dw_pcie_wait_for_link() be checked and propagate=
d?

If the link fails to come up (for example, returning -ETIMEDOUT because the
endpoint was unplugged), dropping the error allows the function to
unconditionally return 0. Could this leave the system in an inconsistent
state?

> +
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
> +		imx_pcie_lut_restore(imx_pcie);

[Severity: High]
Similar to the save function above, does imx_pcie_lut_restore() need to
acquire imx_pcie->lock to prevent data races on the shared LUT index regist=
er
during restoration?

[ ... ]

> @@ -1973,15 +2074,46 @@ static int imx_pcie_probe(struct platform_device =
*pdev)

[ ... ]

>  static void imx_pcie_shutdown(struct platform_device *pdev)
>  {
>  	struct imx_pcie *imx_pcie =3D platform_get_drvdata(pdev);
> =20
> +	if (imx_pcie->lnk_intr > 0)
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				  IMX95_LINK_DOWN_INT_EN);
>  	/* bring down link, so bootloader gets clean state in case of reboot */
>  	imx_pcie_assert_core_reset(imx_pcie);

[Severity: High]
Can a concurrent threaded interrupt handler run during this shutdown proces=
s?

Since disable_irq() is not called, if a link down event triggers just before
shutdown, could the thread access PCIe configuration space right as
pci_pwrctrl_power_off_devices() powers off the hardware, potentially causin=
g a
synchronous external abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618092100.3669=
556-1-hongxing.zhu@oss.nxp.com?part=3D3
