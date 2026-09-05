Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92CF9C0;
	Sat,  5 Sep 2026 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566657; cv=none; b=qGf5obfv3R+fjcyQnXVpimSt4HxVxwSof1VFrwMO3oMaBkKL8E4m/uq6fHkM6+UD8u1JoUKX71W+FVt/MQZvTYRn0l449zZ07lGX1hy6BRK0D6Sh0Y7D7b0cglwDJd9vZ3kxCfKlL4hzSKTfIAe/Yp3nhtIQYufUZm+wolT9oJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566657; c=relaxed/simple;
	bh=WGlTO/B9dx+gcBj+aCTItj+0MoJeBlqiPjiBynv7gaw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bh2r7Su79cFuhD8V/bSwS/T2C509wSSJhz6KHXsiwABvvBhj69UPeUQSyWnVFjS8PQpzsbTwJD35f41YDG4dUr89t5yRj+2s7TNlaT56m2m6yWeK2zslJj1U9LWU+epRZkzAYB+zYNkB7zBCNmlr6Q52VKJg/kM7JHBF1meoOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3rkPjoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3rkPjoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998BC1F00A3D;
	Sat,  5 Sep 2026 00:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566656;
	bh=nzHzMSFpcSMrtxqn4tGUFo35FQ5hl4emhN8YkkkEZKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3rkPjoQZRcme3Dug+BWOsGvhNNJ/9KQOQ+SomspWnnQ7XUmwe/S6tUyvs8eIqR09
	 TJyvCPzhtN5X4nl1nqwXp+vlnk2F6uODafrsmqmEylRStjXHnA1nvIjFrYBoZOb1QM
	 TRcPtgE0rydzueyieHcm36uOwYjdsN/tu3e9YHBrY8vTAXntTeC8Ylcz9YkM4hnTsK
	 FgDfMyrIJhS12VrLzA9hmeO9EfUjYaxEX4GIfhUVsJe6uFJmOEzZsYwi3l0mD2SwBU
	 i2SNIHvxL+dd81gZbEgWmeR6IsoNFzZOkrE9KJIx2cQju/cMIuRvOmPFp2lxkLNSO0
	 R6GmM3wh9TY3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Kconfig: purge twenty-eight legacy ghost options
 (v2)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-input@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904232904.87530-1-breno3011alves@gmail.com>
References: <20260904232904.87530-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:04:15 +0000
Message-Id: <20260905000415.998BC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Removal of Kconfig options that serve as the only user-visible pro=
mpts to select hidden configuration symbols.
- [High] Removal of Kconfig options that only appeared 'unused' due to pree=
xisting copy-paste typos in Makefiles or C code.
- [Low] Dangling comment in `drivers/leds/Kconfig` referencing the removed =
`HID_THINGM` option.
--

commit 7e7aea7e95bed23309216588f06ea0dc933d0354
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

Kconfig: purge twenty-eight legacy ghost options (v2)

This commit removes 28 Kconfig options that were identified as legacy ghost
options lacking explicit C code or Makefile references.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
[ ... ]
> @@ -1296,15 +1296,6 @@ config HID_TOPRE
>  	  Say Y for N-key rollover support on Topre REALFORCE R2 108/87 key and
>            Topre REALFORCE R3S 87 key keyboards.
> =20
> -config HID_THINGM
> -	tristate "ThingM blink(1) USB RGB LED"
> -	depends on LEDS_CLASS
> -	select HID_LED
> -	help
> -	Support for the ThingM blink(1) USB RGB LED. This driver has been
> -	merged into the generic hid led driver. Config symbol HID_THINGM
> -	just selects HID_LED and will be removed soon.
> -

[Severity: Low]
Does removing this option leave a dangling reference in the tree?

There is a comment in drivers/leds/Kconfig that explicitly references this
removed option:

comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (=
HID_THINGM)"

> diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect=
/mediatek/Kconfig
> --- a/drivers/interconnect/mediatek/Kconfig
> +++ b/drivers/interconnect/mediatek/Kconfig
[ ... ]
> @@ -28,9 +28,3 @@ config INTERCONNECT_MTK_MT8195
>  	  This is a driver for the MediaTek bus interconnect on MT8195-based
>  	  platforms.
> =20
> -config INTERCONNECT_MTK_MT8196
> -	tristate "MediaTek MT8196 interconnect driver"
> -	depends on INTERCONNECT_MTK_DVFSRC_EMI
> -	help
> -	  This is a driver for the MediaTek bus interconnect on MT8196-based
> -	  platforms.

[Severity: High]
Does removing this option mask an underlying typo in the Makefile rather th=
an
removing true dead weight?

Looking at drivers/interconnect/mediatek/Makefile, mt8196.o is mapped to
CONFIG_INTERCONNECT_MTK_MT8195 instead of CONFIG_INTERCONNECT_MTK_MT8196:

obj-$(CONFIG_INTERCONNECT_MTK_MT8195) +=3D mt8196.o

If we remove the Kconfig option entirely, we lose the ability to fix the ro=
ot
typo and compile this driver.

> diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kcon=
fig
> --- a/drivers/media/dvb-core/Kconfig
> +++ b/drivers/media/dvb-core/Kconfig
[ ... ]
> @@ -67,14 +67,3 @@ config DVB_DEMUX_SECTION_LOSS_LOG
> =20
>  	  If you are unsure about this, say N here.
> =20
> -config DVB_ULE_DEBUG
> -	bool "Enable DVB net ULE packet debug messages"
> -	depends on DVB_CORE
> -	help
> -	  Enable extra log messages meant to detect problems while
> -	  handling DVB network ULE packet loss inside the Kernel.
> -
> -	  Should not be enabled on normal cases, as logs can
> -	  be very verbose.
> -
> -	  If you are unsure about this, say N here.

[Severity: High]
Does removing this option permanently break the debug feature due to an
existing typo in the C code?

In drivers/media/dvb-core/dvb_net.c, the code checks for the macro without
the CONFIG_ prefix:

#ifdef DVB_ULE_DEBUG

Removing this Kconfig option eliminates the intended way to fix the typo and
enable these debug logs.

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
[ ... ]
> @@ -121,20 +121,6 @@ config PCI_IMX6_HOST
>  	  on DesignWare hardware and therefore the driver re-uses the
>  	  DesignWare core functions to implement the driver.
> =20
> -config PCI_IMX6_EP
> -	bool "Freescale i.MX6/7/8 PCIe controller (endpoint mode)"
> -	depends on ARCH_MXC || COMPILE_TEST
> -	depends on PCI_ENDPOINT
> -	select PCIE_DW_EP
> -	select PCI_HOST_COMMON
> -	select PCI_IMX6
> -	select PCI_PWRCTRL_GENERIC
> -	help
> -	  Enables support for the PCIe controller in the i.MX SoCs to
> -	  work in endpoint mode. The PCI controller on i.MX is based
> -	  on DesignWare hardware and therefore the driver re-uses the
> -	  DesignWare core functions to implement the driver.
> -

[Severity: High]
Does removing this option silently disable hardware support by removing the
only prompt that selects the hidden PCIE_DW_EP symbol?

Without PCI_IMX6_EP to select PCIE_DW_EP, the endpoint initialization
function imx_add_pcie_ep() in drivers/pci/controller/dwc/pci-imx6.c will
end up calling dw_pcie_ep_init().=20

When PCIE_DW_EP is not selected, dw_pcie_ep_init() resolves to a stub that
returns 0, leaving ep->epc uninitialized and the endpoint silently broken.

> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
[ ... ]
> @@ -900,16 +899,6 @@ config REGULATOR_MT6315
>  	  This driver supports the control of different power rails of device
>  	  through regulator interface.
> =20
> -config REGULATOR_MT6316
> -	tristate "MT6316 SPMI PMIC regulator driver"
> -	depends on SPMI
> -	select REGMAP_SPMI
> -	help
> -	  Say Y here to enable support for 2+2, 3+1 and 4 phase regulators
> -	  found in the MediaTek MT6316 BP, CP, DP, HP, VP and TP SPMI PMICs.
> -	  This driver supports the control of different power rails of device
> -	  through regulator interface.
> -

[Severity: High]
Does removing this option mask an underlying typo in the Makefile rather th=
an
removing true dead weight?

Looking at drivers/regulator/Makefile, mt6316-regulator.o is mistakenly
mapped to CONFIG_REGULATOR_MT6315:

obj-$(CONFIG_REGULATOR_MT6315)  +=3D mt6316-regulator.o

Removing the Kconfig option destroys the intended path to fix the root typo
and compile the MT6316 PMIC regulator driver.

> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> --- a/sound/soc/tegra/Kconfig
> +++ b/sound/soc/tegra/Kconfig
[ ... ]
> @@ -192,15 +192,6 @@ config SND_SOC_TEGRA_AUDIO_GRAPH_CARD
>  config SND_SOC_TEGRA_MACHINE_DRV
>  	tristate
> =20
> -config SND_SOC_TEGRA_RT5631
> -	tristate "SoC Audio support for Tegra boards using an RT5631 codec"
> -	depends on SND_SOC_TEGRA && I2C && GPIOLIB
> -	select SND_SOC_TEGRA_MACHINE_DRV
> -	select SND_SOC_RT5631
> -	help
> -	  Say Y or M here if you want to add support for SoC audio on Tegra
> -	  boards using the RT5631 codec, such as Transformer.
> -

[Severity: High]
Will users still be able to enable the Tegra audio machine driver without t=
his
prompt?

This option appears to be the necessary user-visible prompt to select the
hidden configuration symbol SND_SOC_TEGRA_MACHINE_DRV for this specific
hardware.

[ ... ]
> @@ -276,24 +267,6 @@ config SND_SOC_TEGRA_MAX98090
>  	  Say Y or M here if you want to add support for SoC audio on Tegra
>  	  boards using the MAX98090 codec, such as Venice2.
> =20
> -config SND_SOC_TEGRA_MAX98088
> -	tristate "SoC Audio support for Tegra boards using a MAX9808x codec"
> -	depends on I2C && GPIOLIB
> -	select SND_SOC_TEGRA_MACHINE_DRV
> -	select SND_SOC_MAX98088
> -	help
> -	  Say Y or M here if you want to add support for SoC audio on Tegra
> -	  boards using the MAX98088 codec, such as LG X3.
> -

[Severity: High]
Similar to the RT5631 codec above, does removing this option prevent the
user from enabling the hidden SND_SOC_TEGRA_MACHINE_DRV symbol needed for
MAX9808x support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904232904.8753=
0-1-breno3011alves@gmail.com?part=3D1
