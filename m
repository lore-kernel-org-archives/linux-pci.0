Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088495;
	b=VpQzEOTACd0Tub/iQQA2DpiYDLlO02V8w5HKeAxhdr/I8BTi9rd3cf6zJHJSd7Ycwlvj
	 CO9dwCUces+YRiB7dV+yBAkRopYc40LDDGazDQXIatYvEuD+2kMfHS+yZX2DOetDpD1zL
	 zKrK1WN29CHMFXEM3i46vQWbZtRmW84s/YqCK/t3+NjRYOlZU1LJj3DKliyxchu4oD8yN
	 eAph8jKFck/IEYywI4t/FHKPMx5iJ++++QSYMth4DONxjyCaiNIAs3KisfeaO8q5+Atdz
	 7Em7QBBqXg19QIP0QwZ6vZ+TH8FtHYCtVb9JakX/XxIsmv/gO09+24mra38VHalewLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XdW+pNeBqTm0EFQl1RwhYaRlxgCrffUoQgfY2UbDvik=;
	b=SVeE7tkmx0JuIBFSFsBkxANKVzjb/4q3rUsLwcjAr+yNu+3e7PIa9gsl1Oh7UM3oXjzm
	 b9/cmDW2JVFsjb3o2aZZ6wYKY4LSZJqjGSP1O59EilPuA48MKj/wZIQSWkYtvGJgCn+6w
	 IyvRx8UN5qKE/puhoBR9VDdw1hwGM20uSjQ1/RU//4Ya8u2BXcV3PJbGsPs80nhRmj68c
	 fsw5wW7dU3BBCJ7Ag6dTyN+tnvUPs/L94H/wja7css7JYYvxewsF0aKzvckS4IsdrZDNX
	 JtwEvlIYolKaFtKzEuW0IG/hijvT6BmJkw6CK5BHtnTHM4WH+H8dFsoFl1RYpQ4lnKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY8jGyyp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F19606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY8jGyyp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161941F01825;
	Tue, 27 Oct 2026 08:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088495;
	bh=XdW+pNeBqTm0EFQl1RwhYaRlxgCrffUoQgfY2UbDvik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VY8jGyyp26iof3RXk8897+twZNd9LoVvlWMXIgxVUV4sOdNaoUV0pzJqnt/PpwP8m
	 ZUokv8OBB2+FUGEboSW0SsM6zHNNraWWMxrxKVzxZLeFnrVSNaw5n/87emcbFDSNsR
	 HElDEMaAtfCBOuhpSfpLrcPnYYtaoYFaPqAB3irh6PPfEWVCURcDg6S41E+/EFf0+D
	 kbz+zH5ZdDT3DSKx9INNQEG2hkYjcRKgewWs99rW6ILtEVixR7sy4b7S4VMo7NZMqx
	 aefJu2vs9IeZggzaIszTWVkcgNo6kmVisU1B+j/Jitm+3mCf4+AshA16XpMGO+9OFs
	 ZdTs4IV5/OkKQ==
Message-ID: <sashiko-outbox-186265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dw-rockchip: Power on devices below the RC
 using pwrctrl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027075520.3591049-2-shawn.lin@rock-chips.com>
References: <20261027075520.3591049-1-shawn.lin@rock-chips.com>
 <20261027075520.3591049-2-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 08:08:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI: dw-rockchip: pwrctrl devices destroyed on -EPROBE_DEFER in pr=
obe
- [Medium] PCI: dw-rockchip: link failure when CONFIG_PCI_PWRCTRL=3Dm
--

commit f0cd23e8e46914fb711657df22bcc2cf90053573
Author: Shawn Lin <shawn.lin@rock-chips.com>

PCI: dw-rockchip: Power on devices below the RC using pwrctrl

This commit updates rockchip_pcie_probe() to create and power on PCI
pwrctrl devices for DT child nodes below the Rockchip PCIe host controller
before initializing the PHY when operating in RC mode.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index bd86e32cc2b15..952b4c6cc4bf2 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pci-pwrctrl.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -841,16 +842,32 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * Power on the devices described below this controller before the PHY
> +	 * is initialized: the slot supplies must be up before PHY init.
> +	 */
> +	if (data->mode =3D=3D DW_PCIE_RC_TYPE) {
> +		ret =3D pci_pwrctrl_create_devices(dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to create pwrctrl devices\n");

[Severity: Medium]
Can this cause a vmlinux link failure when CONFIG_PCIE_ROCKCHIP_DW=3Dy and
CONFIG_PCI_PWRCTRL=3Dm?

In drivers/pci/controller/dwc/Kconfig, PCIE_ROCKCHIP_DW,
PCIE_ROCKCHIP_DW_HOST, and PCIE_ROCKCHIP_DW_EP are bool options:

config PCIE_ROCKCHIP_DW
	bool

config PCIE_ROCKCHIP_DW_HOST
	bool "Rockchip DesignWare PCIe controller (host mode)"
	depends on PCI_MSI
	depends on ARCH_ROCKCHIP || COMPILE_TEST
	depends on OF
	select PCIE_DW_HOST
	select PCIE_ROCKCHIP_DW
	select PCI_HOST_COMMON

In include/linux/pci-pwrctrl.h, the declarations for
pci_pwrctrl_create_devices(), pci_pwrctrl_destroy_devices(),
pci_pwrctrl_power_on_devices(), and pci_pwrctrl_power_off_devices() are
guarded by #if IS_ENABLED(CONFIG_PCI_PWRCTRL):

#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
int pci_pwrctrl_create_devices(struct device *parent);
void pci_pwrctrl_destroy_devices(struct device *parent);
int pci_pwrctrl_power_on_devices(struct device *parent);
void pci_pwrctrl_power_off_devices(struct device *parent);

Because data->mode =3D=3D DW_PCIE_RC_TYPE in rockchip_pcie_probe() is a run=
time
check, built-in pcie-dw-rockchip.o emits references to the pci_pwrctrl_*
symbols whenever PCIE_ROCKCHIP_DW_HOST=3Dy or PCIE_ROCKCHIP_DW_EP=3Dy is
enabled, failing to link when pci-pwrctrl-core is built as a module (and
compiling to no-op stubs if CONFIG_PCI_PWRCTRL is disabled).

Should PCIE_ROCKCHIP_DW (or PCIE_ROCKCHIP_DW_HOST and PCIE_ROCKCHIP_DW_EP)
select PCI_PWRCTRL_GENERIC in drivers/pci/controller/dwc/Kconfig, similar
to PCI_IMX6_HOST, PCI_IMX6_EP, and PCIE_QCOM?

> +
> +		ret =3D pci_pwrctrl_power_on_devices(dev);
> +		if (ret) {
> +			pci_pwrctrl_destroy_devices(dev);
> +			return dev_err_probe(dev, ret,
> +					     "failed to power on pwrctrl devices\n");
> +		}
> +	}
> +
>  	/* DON'T MOVE ME: must be enable before PHY init */
>  	ret =3D devm_regulator_get_enable_optional(dev, "vpcie3v3");
>  	if (ret < 0 && ret !=3D -ENODEV)
> -		return dev_err_probe(dev, ret,
> -				     "failed to enable vpcie3v3 regulator\n");
> +		goto err_pwrctrl_off;
> =20
>  	ret =3D rockchip_pcie_phy_init(rockchip);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "failed to initialize the phy\n");
> +		goto err_pwrctrl_off;
> =20
>  	ret =3D reset_control_deassert(rockchip->rst);
>  	if (ret)
> @@ -883,6 +900,11 @@ static int rockchip_pcie_probe(struct platform_devic=
e *pdev)
>  	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>  deinit_phy:
>  	rockchip_pcie_phy_deinit(rockchip);
> +err_pwrctrl_off:
> +	if (data->mode =3D=3D DW_PCIE_RC_TYPE) {
> +		pci_pwrctrl_power_off_devices(dev);
> +		pci_pwrctrl_destroy_devices(dev);
> +	}

[Severity: High]
Does calling pci_pwrctrl_destroy_devices(dev) unconditionally in
rockchip_pcie_probe() when ret =3D=3D -EPROBE_DEFER prevent deferred child
pwrctrl devices from binding and re-triggering probe?

When pci_pwrctrl_power_on_devices(dev) is called in rockchip_pcie_probe(),
drivers/pci/pwrctrl/core.c:pci_pwrctrl_power_on_device() checks whether
each created child pwrctrl platform device has bound to its driver:

	scoped_guard(device, &pdev->dev) {
		if (device_is_bound(&pdev->dev)) {
			ret =3D __pci_pwrctrl_power_on_device(&pdev->dev);
		} else {
			/* FIXME: Use blocking wait instead of probe deferral */
			dev_dbg(&pdev->dev, "driver is not bound\n");
			ret =3D -EPROBE_DEFER;
		}
	}

If a child pwrctrl device has not bound yet (for example because its
supplier deferred probe, its driver probes asynchronously, or its module is
not yet loaded), pci_pwrctrl_power_on_devices(dev) returns -EPROBE_DEFER
(or a subsequent step in rockchip_pcie_probe() such as
devm_regulator_get_enable_optional() or rockchip_pcie_phy_init() may return
-EPROBE_DEFER and jump to err_pwrctrl_off).

Both the error path of pci_pwrctrl_power_on_devices(dev) and the
err_pwrctrl_off cleanup block call pci_pwrctrl_destroy_devices(dev)
unconditionally, which unregisters the child pwrctrl platform devices via
of_device_unregister() and removes them from deferred_probe_pending_list so
they can never bind and re-trigger rockchip_pcie_probe().

Should pci_pwrctrl_destroy_devices(dev) only be called when
ret !=3D -EPROBE_DEFER (as done in pcie-qcom.c, pci-imx6.c, and
pcie-mediatek-gen3.c)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027075520.3591=
049-1-shawn.lin@rock-chips.com?part=3D1
