Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822250;
	b=oBSC4shMQbXyiH0C/z3Rnh/eK3KxAnEINNDS3zvCmTY4Ucx8JagaAPC4bUtcLF8hDn2Q
	 F2R7Doz7pVtKmzeLhJOpKF4ebOU4cBRJpCaJQrf4P436K00kZ/8OLdpF7is0t8h/bgVhO
	 QUkhAtuTGlYMo0YrHajrAagOIzPD/2aCoVDRCjJ3bOmvahUQq3Ka51RoRogNU3blkXYSq
	 ZuTrqIHuWDyGqF4eDvhuoiF/K+zGA6kHl44IaagieGg1IbYb+MA3VHH0KaJoMnL/RVX8F
	 Bd/CogNw9tQzlJvm++tSCnOhf0KPM/rAWqM0tkctD2hLRJ48Plbn8shfD1YJPugmBlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822250;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SH6umq0q67z0mi+pij9P60DIf6mBd68NWFOfZUrLdAo=;
	b=xHbpdebHiNsMxUilZwOykEjg+QNDCJMqK1Hxvbm7IBG3Z/Bo9erXYgzNW2tGyXfriSQf
	 buq1l9YPHOfc8unY3Vp5DvB2BSv647ldN06mL5GjUQ1nwVTsQbETHKnI1N64tkRSZcvS7
	 mh79nWBojIb8HLFILkWm02ElG7TC9CmHVD5e3Z1GJTC+/B+n8VcvgdRU2DLkNorOB2m8u
	 LAUEUOGvgJjIl1PVinmJhBWWcwll0miI3WIV2m4JMEZ5CVBkYJOOWR3qsnZQSM/BKv/SC
	 WGE5qysBETUBiTvTUBmxkAw638xk/+eaV9Nparx4DaOY246Trm+nObXBMvK47MJerbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVdlqadB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874660A13C0
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VVdlqadB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098341F00A02;
	Wed,  4 Nov 2026 19:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822250;
	bh=SH6umq0q67z0mi+pij9P60DIf6mBd68NWFOfZUrLdAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VVdlqadBLKbnDrYxXQyBO8l/eBXLDOpDZ+XuBICjtl4mlUW9u5AMnDoFrfflC0y2W
	 Qj7ufz7DToPilQaaiGVZYozJWurz0Ffm8/oWnyTrJ4OLiXTKdc/3A5z4H4hU9S0/I3
	 k+NRIt8R99KqipNE139+wbHpb5I+jIfNktOHY7RSNShWE24uUIaXMDOn5v6CZriurq
	 FEWxvHf7JEjb0zkb+hY4w6k6QK280ylYsNv+Pi4ru6JlSEFIn57X/H0K3gFJ9Xmdcb
	 Ei3/1e2w0ussRt5K75GlQySy+M0yuUjhK7ty+lR0IDqIk3XtkO/zzXAwiJl3rE/Hjr
	 2efCh089cwMvA==
Message-ID: <sashiko-outbox-197982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] PCI: dw-rockchip: Add system PM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-9-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-9-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:57:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] PCI: dw-rockchip: premature rst_gpio deassertion in rockchip_pcie_=
resume()
- [High] PCI: dw-rockchip: unclocked MMIO and double disable in rockchip_pc=
ie_suspend()
- [Medium] PCI: dw-rockchip: wrong IRQ mask and order in rockchip_pcie_resu=
me()
- [Low] PCI: dw-rockchip: signed shift overflow in rockchip_pcie_resume()
--

commit 941dec7d380bdb3a689bc84885404d2f2e8eef67
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Add system PM support

This commit adds noirq system suspend and resume callbacks for Rockchip
DesignWare PCIe controllers in Root Complex mode. It saves and restores the
legacy interrupt mask and sequences the PCIe link, PERST# GPIO, PHY, clocks,
reset line, and 3.3V regulator across suspend and resume.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 2e759f92b5c6f..75b40091bb953 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c

[ ... ]

> @@ -1037,6 +1039,102 @@ static int rockchip_pcie_rc_reset_root_port(struc=
t pci_host_bridge *bridge,
>  	return ret;
>  }
> =20
> +static int rockchip_pcie_suspend(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &rockchip->pci;
> +	int ret;
> +
> +	if (rockchip->data->mode =3D=3D DW_PCIE_EP_TYPE)
> +		return 0;
> +
> +	rockchip->intx =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_M=
ASK_LEGACY);
> +
> +	ret =3D dw_pcie_suspend_noirq(pci);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +	rockchip_pcie_phy_deinit(rockchip);
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	reset_control_assert(rockchip->rst);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);

[Severity: High]
What happens on a subsequent suspend if rockchip_pcie_resume() fails?

During suspend, dw_pcie_suspend_noirq() sets pci->suspended =3D true, and
rockchip_pcie_suspend() then powers off the PHY, disables clocks, asserts
reset, and disables rockchip->vpcie3v3.

If a later call to rockchip_pcie_resume() fails (for example, if
dw_pcie_resume_noirq() returns -ETIMEDOUT when dw_pcie_wait_for_link() times
out, or if regulator, PHY, reset, or clock initialization fails), the error
unwind path in rockchip_pcie_resume() disables the clocks, asserts reset,
deinitializes the PHY, and disables rockchip->vpcie3v3 while pci->suspended
remains true:

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_resume() {
	...
	ret =3D dw_pcie_resume_noirq(pci);
	if (ret) {
		dev_err(dev, "failed to resume: %d\n", ret);
		goto err_clear_rst_gpio;
	}

	return 0;

err_clear_rst_gpio:
	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
err_disable_clk:
	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
err_assert_reset:
	reset_control_assert(rockchip->rst);
err_deinit_phy:
	rockchip_pcie_phy_deinit(rockchip);
err_disable_regulator:
	if (rockchip->vpcie3v3)
		regulator_disable(rockchip->vpcie3v3);

	return ret;
}

Because the PM core logs the noirq resume error, clears is_noirq_suspended,
and continues resuming the system, won't child PCI device resume and the ne=
xt
call to rockchip_pcie_suspend() read APB/DBI registers while the controller
clocks are disabled and reset is asserted (causing an SError on ARM64), and
then call rockchip_pcie_phy_deinit(), clk_bulk_disable_unprepare(), and
regulator_disable() a second time?

> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_resume(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &rockchip->pci;
> +	int ret;
> +
> +	if (rockchip->data->mode =3D=3D DW_PCIE_EP_TYPE)
> +		return 0;
> +
> +	if (rockchip->vpcie3v3) {
> +		ret =3D regulator_enable(rockchip->vpcie3v3);
> +		if (ret) {
> +			dev_err(dev, "regulator enable failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D rockchip_pcie_phy_init(rockchip);
> +	if (ret) {
> +		dev_err(dev, "phy init failed: %d\n", ret);
> +		goto err_disable_regulator;
> +	}
> +
> +	ret =3D reset_control_deassert(rockchip->rst);
> +	if (ret) {
> +		dev_err(dev, "reset deassert failed: %d\n", ret);
> +		goto err_deinit_phy;
> +	}
> +
> +	ret =3D clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret) {
> +		dev_err(dev, "clock init failed: %d\n", ret);
> +		goto err_assert_reset;
> +	}
> +
> +	rockchip_pcie_writel_apb(rockchip, FIELD_PREP_WM16(0xffff, rockchip->in=
tx),
> +				 PCIE_CLIENT_INTR_MASK_LEGACY);

[Severity: Low]
Could passing 0xffff to FIELD_PREP_WM16() trigger a signed shift overflow in
rockchip_pcie_resume()?

FIELD_PREP_WM16() preserves the type of _mask and shifts it left by 16:

include/linux/hw_bitfield.h:
#define FIELD_PREP_WM16(_mask, _val)					     \
	({								     \
		typeof(_val) __val =3D _val;				     \
		typeof(_mask) __mask =3D _mask;				     \
		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
				 "HWORD_UPDATE: ");			     \
		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
		((__mask) << 16);					     \
	})

Because 0xffff is a signed int literal with bit 15 set, (__mask) << 16 shif=
ts
into the sign bit of a 32-bit signed int, triggering a UBSAN
shift-out-of-bounds warning when CONFIG_UBSAN_SHIFT is enabled. Should this
use PCIE_INTR_MASK (GENMASK(7, 0)) or an unsigned mask instead?

> +
> +	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
> +	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);

[Severity: Medium]
Should rockchip_pcie_resume() be calling rockchip_pcie_unmask_dll_indicator=
()
here in Root Complex mode and before dw_pcie_resume_noirq()?

Looking at rockchip_pcie_unmask_dll_indicator():

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_unmask_dll_indi=
cator() {
	u32 val;

	/* unmask DLL up/down indicator and hot reset/link-down reset */
	val =3D FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
}

In RC mode, rockchip_pcie_configure_rc() and
rockchip_pcie_rc_reset_root_port() only unmask PCIE_LINK_REQ_RST_NOT_INT, a=
nd
rockchip_pcie_configure_rc() only does so after dw_pcie_host_init() has
configured the RC and brought up the link:

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_configure_rc() {
	...
	ret =3D dw_pcie_host_init(pp);
	if (ret) {
		dev_err(dev, "failed to initialize host\n");
		return ret;
	}

	/* unmask hot reset/link-down reset */
	val =3D FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
}

Because rockchip_pcie_rc_sys_irq_thread() only handles
PCIE_LINK_REQ_RST_NOT_INT (whereas PCIE_RDLH_LINK_UP_CHGED is handled by
rockchip_pcie_ep_sys_irq_thread()), won't calling
rockchip_pcie_unmask_dll_indicator() before dw_pcie_resume_noirq() cause
spurious pcie-sys-rc interrupts on link-up changes and allow link transitio=
ns
during resume link training to latch PCIE_LINK_REQ_RST_NOT_INT and trigger
pci_host_handle_link_down() once IRQs are re-enabled?

> +
> +	ret =3D gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +	if (ret) {
> +		dev_err(dev, "failed to set reset gpio: %d\n", ret);
> +		goto err_disable_clk;
> +	}
> +
> +	ret =3D dw_pcie_resume_noirq(pci);

[Severity: High]
Does setting rockchip->rst_gpio to 1 before dw_pcie_resume_noirq() cause a
premature PERST# deassertion and reset glitch on resume?

In rockchip_pcie_resume(), gpiod_set_value_cansleep(rockchip->rst_gpio, 1)
deasserts PERST# before dw_pcie_resume_noirq() runs. Immediately afterward,
dw_pcie_resume_noirq() calls dw_pcie_setup_rc() and
dw_pcie_start_link() -> rockchip_pcie_start_link(), which drives
rockchip->rst_gpio back to 0, enables LTSSM, waits PCIE_T_PVPERL_MS (100ms),
and then drives rockchip->rst_gpio to 1:

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_start_link() {
	struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);

	/* Reset device */
	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);

	rockchip_pcie_enable_ltssm(rockchip);
	...
	msleep(PCIE_T_PVPERL_MS);

	rockchip_pcie_ltssm_trace(rockchip, true);

	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);

	return 0;
}

Won't driving rockchip->rst_gpio high before rockchip_pcie_start_link()
produce a 0 -> 1 -> 0 -> 1 glitch on PERST# before the RC is configured,
before LTSSM and refclk are enabled, and before PCIE_T_PVPERL_MS has elapse=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D9
