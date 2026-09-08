Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B19559301
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880340; cv=none; b=Tx8fJw+cbrtSsD69KjKZPvrrpHkLrMlQ6NEEaGYfTL0YNr5DALDIQv+5r7A+SmFatYnWXzeWn3mUBCp6jVIBnD0UnykUk3jhXhA+TN9OrK5eaJkq4kAqYcQybzeDZYbtdXy3re5cVdqHDA6pH5OpoB0QvkDoRkqJU++QznlsqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880340; c=relaxed/simple;
	bh=/WhRq8/oPTHVcQ2r/CZvn8UNfx+hI8RDR4dC1MubwKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nGjvrdovp/cMox2vzBSxl+25Fym4hjpGSdTaX0+MymGpQuX+4cmNK2OARDE2uA1SVE8VMhlW9zMNUV2PetkGCOqQVbg+ByGejpAQqWiXSWjv1og242aOzp1XiOH63v1RJoVB5p4PleatZfBGlmSBIMYQUcuASpnKXIWtSWfIg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E201F00A3A;
	Tue,  8 Sep 2026 15:12:12 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] PCI: dw-rockchip: Add system PM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:12:11 +0000
Message-Id: <20260908151212.08E201F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] System resume unconditionally re-initializes the host, leaking the=
 existing IRQ domain and breaking legacy INTx interrupts while executing in=
valid GFP_KERNEL allocations in an atomic context.
- [High] The PM operations `rockchip_pcie_suspend` and `rockchip_pcie_resum=
e` are registered as `noirq` callbacks but call functions that can sleep.
- [High] Missing check for the return value of reset_control_deassert() in =
rockchip_pcie_resume().
- [Medium] Missing `reset_control_assert` in the error handling path of `ro=
ckchip_pcie_resume`.
- [Medium] The order of initializing and tearing down the regulator, PHY, a=
nd clocks in system PM callbacks contradicts the proven sequence used durin=
g driver probe.
--

commit 8a8b70dde70e09797d6c8a3b9234fe5f8265aec7
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Add system PM support

Add system PM support for Rockchip PCIe Designware Controllers.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 47d9cab909bce..e675918ba1848 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c

[ ... ]

> +static int rockchip_pcie_suspend(struct device *dev)
> +{

[ ... ]

> +	ret =3D dw_pcie_suspend_noirq(pci);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);

[Severity: High]
Since rockchip_pcie_suspend() is registered via NOIRQ_SYSTEM_SLEEP_PM_OPS(),
it executes as a noirq callback where local interrupts are disabled.

Is it safe to call sleepable functions in this atomic context? Functions li=
ke
gpiod_set_value_cansleep() and clk_bulk_disable_unprepare() (which takes a
mutex) might trigger might_sleep splats or deadlocks.

> +	rockchip_pcie_phy_deinit(rockchip);
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	reset_control_assert(rockchip->rst);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_resume(struct device *dev)
> +{

[ ... ]

> +	ret =3D clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);

[Severity: Medium]
Does this sequence invert the hardware initialization dependencies used dur=
ing
driver probe?

During probe, the driver enables the regulator, initializes the PHY, deasse=
rts
reset, and then enables the clocks. Here in rockchip_pcie_resume(), the clo=
cks
are enabled first, followed by the regulator and PHY. Could this inverted
order cause link-training bugs or PHY lockups?

> +	if (ret) {
> +		dev_err(dev, "clock init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (rockchip->vpcie3v3) {
> +		ret =3D regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			goto err_disable_clk;
> +	}
> +
> +	ret =3D rockchip_pcie_phy_init(rockchip);
> +	if (ret) {
> +		dev_err(dev, "phy init failed: %d\n", ret);
> +		goto err_disable_regulator;
> +	}
> +
> +	reset_control_deassert(rockchip->rst);

[Severity: High]
Does this code handle reset_control_deassert() failures?

If reset_control_deassert() fails, the driver immediately proceeds to write=
 to
the IP block's APB registers. If the hardware reset was not actually releas=
ed,
accessing these registers could trigger a synchronous external abort and ke=
rnel
panic.

> +
> +	rockchip_pcie_writel_apb(rockchip, FIELD_PREP_WM16(0xffff, rockchip->in=
tx),
> +				 PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
> +	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);
> +
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +
> +	ret =3D dw_pcie_resume_noirq(pci);

[Severity: High]
Does system resume unconditionally re-initialize the host, leaking the exis=
ting
IRQ domain and breaking legacy INTx interrupts?

When dw_pcie_resume_noirq() is called, it invokes the host initialization
callback rockchip_pcie_host_init(), which then calls
rockchip_pcie_init_irq_domain():

rockchip_pcie_host_init()
  rockchip_pcie_init_irq_domain()
    rockchip->irq_domain =3D irq_domain_create_linear(of_fwnode_handle(intc=
),
                                                    PCI_NUM_INTX,
                                                    &intx_domain_ops,
                                                    rockchip);

This executes an invalid GFP_KERNEL allocation inside the atomic noirq phas=
e,
overwrites the existing irq_domain pointer (leaking the old domain), and dr=
ops
existing INTx mappings.

> +	if (ret) {
> +		dev_err(dev, "failed to resume: %d\n", ret);

[ ... ]

> +err_deinit_phy:
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +	rockchip_pcie_phy_deinit(rockchip);
> +err_disable_regulator:

[Severity: Medium]
Does this error path leave the hardware controller in an inconsistent,
permanently deasserted state?

If dw_pcie_resume_noirq() fails, the error handling block tears down the PH=
Y,
clocks, and regulator, but it seems to miss calling
reset_control_assert(rockchip->rst).

> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +err_disable_clk:
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D9
