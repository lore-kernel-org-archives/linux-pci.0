Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793484;
	b=cYCkUMGu3qOIuOjU+HpGmBNIoVWMgHWXm9J235PTKPZz6dxRWykRUX2Pp0s0g26ds7Rj
	 R9wuDNOEum9A3FQYQkdaEN7GKils7Th8La6Mgz979yWr7SuIENDq6TOO/RjRiuUtl8hua
	 PQtoB+Vi0F7QDap+LzRowbC7F09mNF1EGWhclpD0hsCHYxZ51KatCMF6vWypIx+RFuwL+
	 0P9cUn/iqAAFwpVmVvgF2+YtcdKk/OFdnh6ImN3GfqUXvLxGv3172Fk3Hao+F/LSerWir
	 99gY9LnSCyWxPcfwLhJp4AzwQ0DeZOym/NAEUYPsccEq58m+QKhSnLLQ9p7ux8wWyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793484;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IQPe/8n3kf/tTgG8PT+0AhVGgGf6prJxujXP+35PqOA=;
	b=l2vupKuSsL/f80mdQOR7QqBr9clXBmLjyEZpFGDVCZynDN5Onwxr/YIoC/Mw45vPo118
	 5lE4m5aW2J0ql+npjD/wdq6T49kkxE9Mq1dEOvbxAJl2WBNwBgn9tBxJV/AUX9AzGCXFL
	 AhsXezfOoDSongvce7kX7VYOvEern+2lbTlDjaDaL5CJYqQ+YTSSvIacOia2wOqAGix3+
	 YXbzL1UsBtSLEUQ7725o0Qv3kR8IRNdC6SPKGSteXrP5a5RnklZo5uyG5D95tO0ikdX0s
	 mEE86MHMF0ucF2rIDit+zw4gz7g8CIWALvNadvDAaTjyxP/oqoAevJ/KcYxKxuz4WYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9XBSkKr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B6606A31B;
	Wed,  4 Nov 2026 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9XBSkKr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668761F000C1;
	Wed,  4 Nov 2026 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793793483;
	bh=IQPe/8n3kf/tTgG8PT+0AhVGgGf6prJxujXP+35PqOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9XBSkKrgdMX8toBgtyyd19uIsW7eGGisbRF6nwPkqk+4UYrR3NQmHwMIiNSlxBla
	 5s7bSf3ddcywoO6qylQKrBkLs6WGLCNTUgqsLZzXusu2gk6hMwaXBKKT9vlDJp6PQj
	 l7HsNTLB/dcaRTUhLrOn076wLx2EUmAgDKEFzf0z3ghrYzXm+a6D34PQ+cQAc+6g5a
	 +hMIgMrFrQGtWAvJ4K5YDo3ZvexHSF4hNyZI0aglgOm+5xPcJ/TAhBcSmRcOykYQCM
	 l1qgwb3PoZ4dIJWXsrNtt7ydZauRENCg6ulMF/S3SsLDsyuMdn3JiZ2x/f1NXK12SX
	 +4O/KM9UF1vJQ==
Message-ID: <sashiko-outbox-197217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: apple: t600x: Add PCIe pwren gpios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104-apple-pcie-pwren-v2-3-216a4066965f@cyberchaos.dev>
References: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
 <20261104-apple-pcie-pwren-v2-3-216a4066965f@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 11:58:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] arm64: dts: apple: t600x PCIe regulators break PCIe power on t602x=
 boards
- [Medium] PCI: apple: missing pwrctrl power-off and cleanup on error in ap=
ple_pcie_init()
- [Low] arm64: dts: apple: undocumented power-supply property on PCIe bridg=
e nodes
- [Low] PCI/pwrctrl: missing !CONFIG_PCI_PWRCTRL stubs for per-device pwrct=
rl APIs
- [Low] PCI/pwrctrl: mismatched kernel-doc parameter names in drivers/pci/p=
wrctrl/core.c
--

commit fc220e60fe2546bbee22affe9598f38be84ac7dc
Author: Yureka Lilian <yureka@cyberchaos.dev>

arm64: dts: apple: t600x: Add PCIe pwren gpios

This series exports per-device PCI power control helpers, integrates them i=
nto
the Apple PCIe controller driver, and adds SMC GPIO-controlled fixed
regulators for PCIe root ports on Apple T600x devicetrees.

> diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/=
boot/dts/apple/t600x-j314-j316.dtsi
> index caded1636f3d2..4f9dccf839ad0 100644
> --- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
> @@ -55,6 +55,20 @@ led-0 {
>  			default-state =3D "keep";
>  		};
>  	};
> +
> +	vreg_pcie0_port0: regulator-pcie0-port0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pwren-pcie0-port0";
> +		gpio =3D <&smc_gpio 13 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	vreg_pcie0_port1: regulator-pcie0-port1 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "pwren-pcie0-port1";
> +		gpio =3D <&smc_gpio 26 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  };

[Severity: High]
Will adding these regulators to t600x-j314-j316.dtsi and t600x-j375.dtsi cut
power to PCIe endpoints on T602x systems?

Both files are included by the T602x board files:

arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi:
    /*
     * These models are essentially identical to the previous generation, o=
ther than
     * the GPIO indices.
     */

    #include "t600x-j314-j316.dtsi"

arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi:
    /*
     * These models are very similar to the previous generation Mac Studio,=
 other
     * than GPIO indices.
     */

    #include "t600x-j375.dtsi"

Because vreg_pcie0_port0, vreg_pcie0_port1, and vreg_pcie0_port3 do not set
regulator-boot-on, reg_fixed_voltage_probe() requests each SMC GPIO with
GPIOD_OUT_LOW and immediately drives the pin low via macsmc_gpio_set().

However, port00 through port03 in arch/arm64/boot/dts/apple/t602x-die0.dtsi=
 do
not have compatible =3D "pciclass,0604":

arch/arm64/boot/dts/apple/t602x-die0.dtsi:
		port00: pci@0,0 {
			device_type =3D "pci";
			reg =3D <0x0 0x0 0x0 0x0 0x0>;
			reset-gpios =3D <&pinctrl_ap 4 GPIO_ACTIVE_LOW>;

As a result, pci_pwrctrl_is_required() returns false on T602x, no pwrctrl
device binds to re-enable the regulators after reg_fixed_voltage_probe() tu=
rns
them off, the T602x files note that GPIO indices differ from T600x, and
arch/arm64/boot/dts/apple/t6020-j474s.dts has an unused port01 where sdhci0=
 is
deleted (/delete-node/ &sdhci0;) while vreg_pcie0_port1 still claims smc_gp=
io
26.

[ ... ]

> @@ -176,6 +190,7 @@ &nco_clkref {
>  /* PCIe devices */
>  &port00 {
>  	/* WLAN */
> +	power-supply =3D <&vreg_pcie0_port0>;
>  	bus-range =3D <1 1>;
>  	wifi0: wifi@0,0 {
>  		compatible =3D "pci14e4,4433";
> @@ -195,6 +210,7 @@ bluetooth0: bluetooth@0,1 {
> =20
>  &port01 {
>  	/* SD card reader */
> +	power-supply =3D <&vreg_pcie0_port1>;
>  	bus-range =3D <2 2>;
>  	sdhci0: mmc@0,0 {
>  		compatible =3D "pci17a0,9755";

[Severity: Low]
Should port00 and port01 here (and port00, port01, and port03 in
arch/arm64/boot/dts/apple/t600x-j375.dtsi) use a documented PCI slot supply
property such as vpcie3v3-supply instead of power-supply?

Documentation/devicetree/bindings/pci/apple,pcie.yaml sets
unevaluatedProperties: false and references /schemas/pci/pci-host-bridge.ya=
ml#
for child bridge nodes, where power-supply is not a documented property and
causes dtbs_check warnings, whereas vpcie3v3-supply is defined by the PCI s=
lot
schema and consumed by pci-pwrctrl-slot via of_pci_supply_present() and
of_regulator_bulk_get_all().

[ ... ]

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller=
/pcie-apple.c
> index c2cffc0659f44..2d32092e2122b 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -30,6 +30,7 @@
>  #include <linux/msi.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci-ecam.h>
> +#include <linux/pci-pwrctrl.h>
> =20
>  #include "pci-host-common.h"
> =20
> @@ -825,6 +826,28 @@ static int apple_pcie_init(struct pci_config_window =
*cfg)
>  	if (WARN_ON(!pcie))
>  		return -ENOENT;
> =20
> +	// Ensure all ports can be powered on before attempting initialization
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret =3D pci_pwrctrl_create_device(of_port, pcie->dev);
> +		if (ret) {
> +			dev_err(pcie->dev, "Failed to create pwrctrl device: %pe\n", ERR_PTR(=
ret));
> +			return ret;
> +		}
> +
> +		ret =3D pci_pwrctrl_power_on_device(of_port);
> +		if (ret) {
> +			if (ret !=3D -EPROBE_DEFER) {
> +				dev_err(pcie->dev,
> +					"Failed to power on device: %pe\n",
> +					ERR_PTR(ret));
> +				for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +					pci_pwrctrl_destroy_device(of_port);
> +				}
> +			}
> +			return ret;
> +		}
> +	}
> +
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
>  		ret =3D apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {

[Severity: Medium]
What happens to already-enabled port regulators if a subsequent port fails =
or
defers in apple_pcie_init()?

Once an earlier port succeeds in pci_pwrctrl_power_on_device(), its regulat=
or
has been enabled via slot_pwrctrl_power_on().

1. If a later port returns -EPROBE_DEFER from pci_pwrctrl_power_on_device(),
   apple_pcie_init() returns without calling pci_pwrctrl_power_off_device()=
 on
   the ports that were already powered on. On the next probe retry,
   pci_pwrctrl_power_on_device() will enable those regulators a second time,
   leaking regulator enable reference counts.

2. If pci_pwrctrl_power_on_device() fails with an error other than
   -EPROBE_DEFER, apple_pcie_init() calls pci_pwrctrl_destroy_device() on a=
ll
   ports without calling pci_pwrctrl_power_off_device() first, which unbinds
   the slot pwrctrl device and runs devm_slot_pwrctrl_release() ->
   regulator_bulk_free() while the regulator is still enabled, triggering
   WARN_ON(regulator->enable_count) in _regulator_put().

3. If pci_pwrctrl_create_device() fails on a later port or
   apple_pcie_setup_port() fails in the second loop, the previously created
   and powered-on pwrctrl devices are neither powered off nor destroyed.

Could apple_pcie_init() use pci_pwrctrl_create_devices() and
pci_pwrctrl_power_on_devices() (which already unwind previously powered-on =
or
created child nodes on error), and call pci_pwrctrl_power_off_devices() and
pci_pwrctrl_destroy_devices() if apple_pcie_setup_port() fails?

> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 0e2387cf46577..b59dbedf251bc 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -191,7 +191,16 @@ static int __pci_pwrctrl_power_off_device(struct dev=
ice *dev)
>  	return pwrctrl->power_off(pwrctrl);
>  }
> =20
> -static void pci_pwrctrl_power_off_device(struct device_node *np)
> +/**
> + * pci_pwrctrl_power_off_device - Power off pwrctrl devices
> + *
> + * @device_node: PCI port or device to operate on
> + *
> + * Recursively traverse all pwrctrl devices for the devicetree hierarchy
> + * below the specified PCI port or device and power them off in a depth
> + * first manner.
> + */
> +void pci_pwrctrl_power_off_device(struct device_node *np)

[ ... ]

> @@ -245,11 +255,21 @@ static int __pci_pwrctrl_power_on_device(struct dev=
ice *dev)
>  	return pwrctrl->power_on(pwrctrl);
>  }
> =20
> -/*
> +/**
> + * pci_pwrctrl_power_on_device - Power on pwrctrl devices
> + *
> + * @device_node: PCI port or device to operate on
> + *
>   * Power on the devices in a depth first manner. Before powering on the =
device,
>   * make sure its driver is bound.
> + * Recursively traverse all pwrctrl devices for the devicetree hierarchy
> + * below the specified PCI port or device and power them on in a depth
> + * first manner.  Before powering on the device, make sure its driver is=
 bound.
> + *
> + * Return: 0 on success, -EPROBE_DEFER if any pwrctrl driver is not boun=
d, an
> + * appropriate error code otherwise.
>   */
> -static int pci_pwrctrl_power_on_device(struct device_node *np)
> +int pci_pwrctrl_power_on_device(struct device_node *np)

[ ... ]

> @@ -335,7 +356,17 @@ int pci_pwrctrl_power_on_devices(struct device *pare=
nt)
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
> =20
> -static int pci_pwrctrl_create_device(struct device_node *np,
> +/**
> + * pci_pwrctrl_create_device - Create pwrctrl devices
> + *
> + * @device_node: PCI port or device to operate on
> + *
> + * Recursively create pwrctrl devices for the devicetree hierarchy below
> + * the specified PCI port or device in a depth first manner.
> + *
> + * Return: 0 on success, negative error number on error.
> + */
> +int pci_pwrctrl_create_device(struct device_node *np,
>  				     struct device *parent)

[ ... ]

> @@ -396,7 +428,15 @@ int pci_pwrctrl_create_devices(struct device *parent)
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_create_devices);
> =20
> -static void pci_pwrctrl_destroy_device(struct device_node *np)
> +/**
> + * pci_pwrctrl_destroy_device - Destroy pwrctrl devices
> + *
> + * @device_node: PCI port or device to operate on
> + *
> + * Recursively destroy pwrctrl devices for the devicetree hierarchy below
> + * the specified PCI port or device in a depth first manner.
> + */
> +void pci_pwrctrl_destroy_device(struct device_node *np)

[Severity: Low]
In these four kernel-doc comments in drivers/pci/pwrctrl/core.c, the parame=
ter
is documented as @device_node instead of @np, pci_pwrctrl_create_device() is
missing @parent, and pci_pwrctrl_power_on_device() repeats "Before powering=
 on
the device, make sure its driver is bound." twice. Could these be updated to
avoid W=3D1 kernel-doc warnings?

[ ... ]

> diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
> index 1192a2527521d..f27be6489b50f 100644
> --- a/include/linux/pci-pwrctrl.h
> +++ b/include/linux/pci-pwrctrl.h
> @@ -59,6 +59,10 @@ int pci_pwrctrl_create_devices(struct device *parent);
>  void pci_pwrctrl_destroy_devices(struct device *parent);
>  int pci_pwrctrl_power_on_devices(struct device *parent);
>  void pci_pwrctrl_power_off_devices(struct device *parent);
> +int pci_pwrctrl_create_device(struct device_node *np, struct device *par=
ent);
> +void pci_pwrctrl_destroy_device(struct device_node *np);
> +int pci_pwrctrl_power_on_device(struct device_node *np);
> +void pci_pwrctrl_power_off_device(struct device_node *np);
>  #else
>  static inline int pci_pwrctrl_create_devices(struct device *parent) { re=
turn 0; }
>  static void pci_pwrctrl_destroy_devices(struct device *parent) { }

[Severity: Low]
Should include/linux/pci-pwrctrl.h also provide static inline stubs in the
#else (!CONFIG_PCI_PWRCTRL) branch for pci_pwrctrl_create_device(),
pci_pwrctrl_destroy_device(), pci_pwrctrl_power_on_device(), and
pci_pwrctrl_power_off_device(), along with a struct device_node forward
declaration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-apple-pcie=
-pwren-v2-0-216a4066965f@cyberchaos.dev?part=3D3
