Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAC259CB9;
	Thu, 21 May 2026 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362489; cv=none; b=oKyCX4YkbyY4riSgMSNrylsjgd7IDQL74sA92eaPCyH90pCpW3nPPgTeivEIKOudbzNboy9eHGcEJlgVO3op7Y29uilm54WcsQYgOaXl4nlJWuMIEwYjdShsN3JWeIvCGJE7YWbr18m29Lsz1ERwAILnqc91jT0ft3LbLx/I4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362489; c=relaxed/simple;
	bh=VqIMhBzh7G/hJU9RHjHzynlbo4/xg7n5QAsYEKBoIyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uQWewSM/CzR8PVOp4gIiWEI4LQSN8TmcnPnGbZ4YNJ7yPp+HGbb4+qs1dwxJM877aOQjICcSDAi+hBxMQrLq/jqOJepEiRbc86IbBmEFIDr/XqWV/rkoKYtAa5GvRQUiT5CR0zWRxXGkhUoWdmgftwzsCeo6xY7AyHQN7xAaNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqRKCdtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqRKCdtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F334C1F000E9;
	Thu, 21 May 2026 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779362483;
	bh=zg0+d0yv3WuXDbofre/B8PrKu0JE9q4fqVreIaJ9WOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RqRKCdtn+Yb8PLzyuChRfBhNkW+8Vpp9OLPY7WZyn4SK2P7dhqxT6wrAZSSf0H4qA
	 swJHZ83GRg8P+j/DB4GnBKJA1Cn1TkE9r+/7eDvGKs1I13Ea6bymfjq2dXpUjclkpU
	 jNCaXi1NjtkJjHZInVRrZmAnpPDlin9PRCgJT6mFIrQN/UwV8Gtd68YdLuGckUf0Yl
	 3+aZ2KBvyyXHnkA/zOu3oSWlk+74mC53RLj1b6dJkuplCJwUn/p5i84/ycdcIR5fjE
	 fFATYbc9uR3Z4LVMR64W4Il5xQqbqUaIOusWWKICWcSkgBJkGT5PWHpGzm/9lu1qS+
	 mR6nI5YrmlFug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] PCI: imx6: Add root port reset to support link
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Zhu" <hongxing.zhu@nxp.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260521093255.61585-4-hongxing.zhu@nxp.com>
References: <20260521093255.61585-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 11:21:22 +0000
Message-Id: <20260521112122.F334C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] The `lnk_intr` member is defined as `u32`, which wraps negative er=
ror codes from `platform_get_irq_byname` to large positive integers, breaki=
ng driver probe.
- [High] Read-modify-write (RMW) operations via `regmap_clear_bits` and `re=
gmap_set_bits` unintentionally clear Write-1-to-Clear (W1C) status bits.
- [High] Iterating over the PCI bus device list without holding the `pci_bu=
s_sem` read lock causes a race condition.
- [High] The patch references `reset_root_port` and calls `pci_host_handle_=
link_down()`, neither of which exist in the mainline kernel tree.
- [High] Hardware LUT state is accessed in `imx_pcie_reset_root_port` witho=
ut acquiring the protective `imx_pcie->lock` mutex.
- [Medium] The shared interrupt handler claims the interrupt without verify=
ing that its specific interrupt source is actually enabled, leading to spur=
ious wakeups.
- [Low] Using `platform_get_irq_byname` instead of `platform_get_irq_byname=
_optional` for an optional interrupt will cause unnecessary kernel error lo=
gs.
--

commit c3df91626a3cc2df53cc4e1da0e0b1aeb4d5d8cd
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Add root port reset to support link recovery

The PCIe link can go down due to various unexpected circumstances. Add
root port reset support to enable link recovery for the i.MX PCIe
controller when the optional "intr" interrupt is present.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -158,6 +165,7 @@ struct imx_pcie {
>  	bool			supports_clkreq;
>  	bool			enable_ext_refclk;
>  	struct regmap		*iomuxc_gpr;
> +	u32			lnk_intr;

[Severity: High]
Will platform_get_irq_byname returning a negative error code (like -ENXIO)
wrap to a large positive integer here, causing the later
if (imx_pcie->lnk_intr > 0) check to pass and break driver probe on systems
without the optional interrupt? Should this be an int instead?

[ ... ]

> @@ -1306,6 +1314,13 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
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

[Severity: High]
Does struct pci_host_bridge have a reset_root_port member? It appears this
patch relies on out-of-tree or unmerged prerequisites and will cause build
failures.

[ ... ]

> @@ -1573,6 +1588,9 @@ static int imx_pcie_suspend_noirq(struct device *de=
v)
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
> =20
> +	if (imx_pcie->lnk_intr)
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_LINK_INT_CTRL_STS,
> +				  IMX95_LINK_DOWN_INT_EN);

[Severity: High]
Does this read-modify-write operation accidentally clear Write-1-to-Clear
status bits?

IMX95_LINK_INT_CTRL_STS contains W1C bits like IMX95_LINK_DOWN_INT_STS.
When regmap_clear_bits reads the register, any pending W1C bits will be
read as 1. Writing them back during the modify phase will inadvertently
clear the status bits without handling the interrupt.

[ ... ]

> @@ -1632,6 +1653,85 @@ static const struct dev_pm_ops imx_pcie_pm_ops =3D=
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

[Severity: Medium]
Should this check verify that the interrupt is actually enabled?

Since this is an IRQF_SHARED handler sharing a line with the PME driver, if
the hardware status bit is asserted but IMX95_LINK_DOWN_INT_EN is masked, a
subsequent interrupt triggered by the PME driver could cause this ISR to
incorrectly claim the interrupt and return IRQ_WAKE_THREAD.

[ ... ]

> +static irqreturn_t imx_pcie_lnk_irq_thread(int irq, void *priv)
> +{
> +	struct imx_pcie *imx_pcie =3D priv;
> +	struct dw_pcie *pci =3D imx_pcie->pci;
> +	struct dw_pcie_rp *pp =3D &pci->pp;
> +	struct pci_dev *port;
> +
> +	for_each_pci_bridge(port, pp->bridge->bus)

[Severity: High]
Is it safe to iterate over the PCI bus device list without holding the
pci_bus_sem read lock? Traversing the bus->devices list asynchronously
risks list corruption and use-after-free vulnerabilities if PCI devices
are concurrently hot-added or removed. Should pci_walk_bus() or
down_read(&pci_bus_sem) be used here?

> +		if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_ROOT_PORT)
> +			pci_host_handle_link_down(port);

[Severity: High]
Is pci_host_handle_link_down() available in the mainline kernel tree?
This function appears to be undefined, which will cause a build failure.

[ ... ]

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
Does this access the hardware LUT state without acquiring the protective
imx_pcie->lock mutex?

Since imx_pcie_reset_root_port can be invoked asynchronously from the
link down interrupt handler, concurrent accesses to the LUT configuration
from other execution paths (which do use the lock) could lead to a race
condition and corrupt the hardware LUT configuration.

[ ... ]

> @@ -1834,9 +1934,33 @@ static int imx_pcie_probe(struct platform_device *=
pdev)
>  			val |=3D PCI_MSI_FLAGS_ENABLE;
>  			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
>  		}
> +
> +		/* Get link event irq if it is present */
> +		imx_pcie->lnk_intr =3D platform_get_irq_byname(pdev, "intr");

[Severity: Low]
Since this interrupt is optional, should this use
platform_get_irq_byname_optional() to avoid printing unnecessary error
messages to the kernel log when it is absent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521093255.6158=
5-1-hongxing.zhu@nxp.com?part=3D3
