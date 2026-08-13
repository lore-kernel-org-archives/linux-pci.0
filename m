Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA832E151
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662034; cv=none; b=jWot2aO63Y/3STNl75jhgEd2Ad0zvT5tCGTjVVQKYrpzV6TsRSDn2qCVqFSSDGgR3P16theiVVN9SRYfUX8j1UF+BnLE8Xb0962zKQNYfLbXI9y2GRiuufn2dsA9f/VJ+TtwWMXmk+rngSUy5RUOazftt/qlsHpNdYj/29tg78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662034; c=relaxed/simple;
	bh=D7r82ATzlXfDK0pMdOH9W7Jzl3PMUTvqO/p+V9irtmw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HCSLUoL0p3OQTn1SKsBCw6Tm6Ezqn1Iggn5A9uz7bcH+c3abfZUp0U7i91FjQxtbcEZK/l+kt3WnppSDVJ6WWf3L1h/wxJzwFSYupO2/viwuO5/tWRPMBuXjBvC43pN2RDChFb/F5bSLhRb2aI/fLmDrOa2MwT5U/aoznXLCrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL+OYY/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL+OYY/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E41F000E9;
	Thu, 13 Aug 2026 23:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786662033;
	bh=nLW0SaeK2ltEAWxoQlveM7PWW8YFMPHcxJADb5mTsk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PL+OYY/jqx35TlSYfDeDPIMSggGglmJdoUR+uUCfc9KVJuDbIjCAISZE8rw31wrIx
	 VeM3/cHn5Ijqk15ax4wG5ggOKRmY+TklUbUgl/w6WeuOF5Z5bJDMLGDuFshtvw7Mtq
	 4M8TLCBhcEvB03kl4pxVC7iUicklTmHRyB3zOrHaXiU30YaTX3jp0ulM9p9LIiFdQI
	 HXSFnyNwykNB2MTRMwBERX2scKL6J0usk+op+Lol1TSycw4oFoTP2gooYqc/2j5dfl
	 aCSG0+13+XqdBUV6WpJSUIiAAtBo/MiIU6I7K5k/vdkfCRialcPYdVoiBHiSVkWvqC
	 wA6R2k7PjNfNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/14] PCI: tegra194: Free up EP resources during
 remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260324190755.1094879-11-mmaddireddy@nvidia.com>
References: <20260324190755.1094879-11-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:00:32 +0000
Message-Id: <20260813230032.D23E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Calling `dw_pcie_ep_deinit()` after the hardware is manually power=
ed down causes a synchronous external abort when accessing eDMA registers.

Pre-existing issues:
- [High] The shared IRQ handlers tegra_pcie_ep_hard_irq() and tegra_pcie_rp=
_irq_handler() access memory-mapped registers without verifying if the devi=
ce is active.
- [High] The shared PCIe IRQ handler remains active while hardware is power=
ed down during and after device removal, risking an SError crash.
- [Medium] An early return in `tegra_pcie_dw_remove()` for RC mode skips vi=
tal cleanup steps, leaking the BPMP reference and leaving a GPIO asserted.
- [Low] The `dev_pm_ops` structure and its callbacks lack the `pm_ptr()` an=
d `pm_sleep_ptr()` wrappers, causing dead code when PM is disabled.
--

--- Patch [10]: [PATCH v8 10/14] PCI: tegra194: Free up EP resources during=
 remove() ---
commit fd329e127a60d994cdbbfaa29a5a96dddb4a9df8
Author: Vidya Sagar <vidyas@nvidia.com>

PCI: tegra194: Free up EP resources during remove()

Free up the resources during remove() that were acquired by the DesignWare
driver for the Endpoint mode during probe().

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index f66a93f0cf658..d4bbef07964fe 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2251,6 +2251,7 @@ static int tegra_pcie_dw_probe(struct platform_devi=
ce *pdev)
>  static void tegra_pcie_dw_remove(struct platform_device *pdev)
>  {
>  	struct tegra_pcie_dw *pcie =3D platform_get_drvdata(pdev);
> +	struct dw_pcie_ep *ep =3D &pcie->pci.ep;
> =20
>  	if (pcie->of_data->mode =3D=3D DW_PCIE_RC_TYPE) {
>  		if (!pcie->link_state)
>  			return;

[Severity: Medium]
This is a pre-existing issue, but does this early return in
tegra_pcie_dw_remove() skip vital cleanup steps?

During probe, an inactive link returns -ENOMEDIUM which is ignored, allowing
probe to succeed with !pcie->link_state.

When returning early here for RC mode without an active link, it bypasses t=
he
trailing cleanup sequence, which leaves tegra_bpmp_put() uncalled and the
pex_refclk_sel_gpiod GPIO asserted.

> @@ -2262,6 +2263,7 @@ static void tegra_pcie_dw_remove(struct platform_de=
vice *pdev)
>  	} else {
>  		disable_irq(pcie->pex_rst_irq);
>  		pex_ep_event_pex_rst_assert(pcie);

[Severity: High]
This is a pre-existing issue, but does powering down the controller here le=
ave
the shared PCIe IRQ handler active?

Since the main PCIe interrupt is registered using IRQF_SHARED, turning off =
the
controller's power by asserting resets and disabling clocks without explici=
tly
freeing or disabling the main IRQ creates a race condition.

Can an active interrupt handler execute and read memory-mapped registers on
powered-down hardware before devres frees the IRQ after remove() returns?

> +		dw_pcie_ep_deinit(ep);

[Severity: High]
Does calling dw_pcie_ep_deinit() after the hardware is manually powered down
cause a synchronous external abort when accessing eDMA registers?

When pex_ep_event_pex_rst_assert() is called right before this, it complete=
ly
powers down the PCIe IP by gating clocks and asserting hardware resets.

Then dw_pcie_ep_deinit() attempts memory-mapped writes to the eDMA registers
of the powered-down controller via dw_pcie_edma_remove() and
dw_edma_core_off().

Could dw_pcie_ep_deinit() be called before asserting the reset?

>  	}
> =20
>  	pm_runtime_disable(pcie->dev);

[Severity: High]
This is a pre-existing issue, but do the shared IRQ handlers access
memory-mapped registers without verifying if the device is active?

In drivers/pci/controller/dwc/pcie-tegra194.c:tegra_pcie_ep_hard_irq():

	status_l0 =3D appl_readl(pcie, APPL_INTR_STATUS_L0);

And similarly in drivers/pci/controller/dwc/pcie-tegra194.c:tegra_pcie_rp_i=
rq_handler():

	val =3D appl_readl(pcie, APPL_INTR_STATUS_L0);

Since these IRQ handlers are registered with IRQF_SHARED, they can be
triggered by external or unrelated devices while the PCIe controller is
runtime-suspended.

Would reading the APPL_INTR_STATUS_L0 register while clocks are gated cause=
 a
fatal system crash?

Should these handlers call pm_runtime_get_if_active() before reading regist=
ers?

[Severity: Low]
This is a pre-existing issue, but does the dev_pm_ops structure lack the
pm_ptr() and pm_sleep_ptr() wrappers?

In drivers/pci/controller/dwc/pcie-tegra194.c:

static const struct dev_pm_ops tegra_pcie_dw_pm_ops =3D {
	.suspend =3D tegra_pcie_dw_suspend,
	...
};

static struct platform_driver tegra_pcie_dw_driver =3D {
	...
	.driver =3D {
		...
		.pm =3D &tegra_pcie_dw_pm_ops,
	},
};

Since the callbacks and dev_pm_ops structure are assigned unconditionally,
does this cause dead code to be compiled into the kernel when CONFIG_PM or
CONFIG_PM_SLEEP is disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324190755.1094=
879-1-mmaddireddy@nvidia.com?part=3D10
