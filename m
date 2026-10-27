Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088809;
	b=OVsVdGgEsB5sJ2JMhguT2uU6BkgHvs9mB0+7KX0AyBq74crNmfA15syFniT66IfH6A/y
	 irajIlAgw7g3/zXdgtRLMsmDEL56N/J/LRL1OAMs6J+qqCK+pborkGq+th6WSM7ka+yze
	 NWiXcPuM4ddN6+/ieg07bvWn5A2qQBVOYmdlDWY0T96t6OysdN+nV67Sv+layjq9Mg/yW
	 cKDOj0i3GaqpGUqPbEd/NMDUJqMt/5CB6PvcJA2qm4wu99SRl5nB5KTmFcssrFRCwFvwp
	 V18cmse6dOLCJq8mV7rTIXbRlFZ6TbE8QDZESCvBMQ/PwauQ9fekk7/2d4tweB9nyXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CiNBfeHd8yYO5JhojM6dNiweYw9Tnwug+Qp4rdwqj4E=;
	b=HwOUsGLvYIJoMSnCJyDoKOgFI91vpyfQ847IA3SX/WXrinRpMKIwbY51CByhgahosWI6
	 UjKMuPiI/xfGPrde2sjwlBSOCSnINNLu/7hjsEBGNj/XSCiIzLVW+tdFQ1g//LLgAyuFF
	 oIa9lMT/Gb7DMXGhbzV4JH2Ok8bf2TIiiGKj6UAZbb2Y1yJSrolZDxmCuQyQmsqhxVlF+
	 I6SrL5YHdHdCigcMnaq77bV3EYzD5mj9FmvMB7tdu1Iba5LymemjojojDGSRFBtuyyg5Q
	 FQhd/EYzGKX8uOwumRNO3QqFDQmHu3v6tQgZki/i5jpE09L3XCDbCcY2rqYO47tPlEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkTx+mkk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF38606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DkTx+mkk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B6D1F01825;
	Tue, 27 Oct 2026 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088809;
	bh=CiNBfeHd8yYO5JhojM6dNiweYw9Tnwug+Qp4rdwqj4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkTx+mkkFeH1s08SnYRNXM/ZvqlBjL4yyqnIElKtXtMi+nznCOrapa4OmJg+swnvm
	 wL/ZvkOXPJZVext9NYYQOq8EQ8q2SVuSlN4dm+3eX2HrvEU07S6vsRPsC4prVgvg2e
	 S75rVq8eMTC2Msq5YPUrKk8SrR0u+ezkG1nQ1Bj3+G5yHlNKnKSXq36OMx78+HkUd5
	 oyLnjSDFhgy1OdCZQqDCMHQt9udhvx5Mln2R97X2aAV3+NDH4pP21GiZuWIpu3ty8A
	 tR2zpc3VwEwuVLmOedLsC4B0BxzgDPoeZbNrMqzElGaBfhZJlaZNVp9/tRRTpfGVG9
	 Afzv+V2hqAx4g==
Message-ID: <sashiko-outbox-186271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3588-evb1: describe the
 PCIe3x4 slot supply
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027075520.3591049-3-shawn.lin@rock-chips.com>
References: <20261027075520.3591049-1-shawn.lin@rock-chips.com>
 <20261027075520.3591049-3-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 08:13:28 +0000
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
- [High] PCI: dw-rockchip: missing select PCI_PWRCTRL_GENERIC breaks link a=
nd power
- [High] PCI: dw-rockchip: rockchip_pcie_probe() destroys pwrctrl devices o=
n deferral
--

commit 78bab75f21b5749b90228d2891ea140c86ee2884
Author: Shawn Lin <shawn.lin@rock-chips.com>

arm64: dts: rockchip: rk3588-evb1: describe the PCIe3x4 slot supply

This commit moves the vpcie3v3-supply regulator of the PCIe3x4 controller on
rk3588-evb1-v10 into a child pcie@0 bridge node so that it is managed by the
PCI pwrctrl framework.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm6=
4/boot/dts/rockchip/rk3588-evb1-v10.dts
> index 8969b56f3063e..80eb36e783e0c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -569,8 +569,20 @@ &pcie3x4 {
>  	pinctrl-0 =3D <&pcie3_reset>, <&pcie30x4m1_clkreqn>;
>  	supports-clkreq;
>  	reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> -	vpcie3v3-supply =3D <&vcc3v3_pcie30>;
>  	status =3D "okay";
> +
> +	pcie@0 {
> +		device_type =3D "pci";
> +		compatible =3D "pciclass,0604";
> +		reg =3D <0x000000 0x0 0x0 0x0 0x0>;
> +		bus-range =3D <0x00 0x0f>;
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> +	};

[Severity: High]
With vpcie3v3-supply moved from &pcie3x4 into the pcie@0 child node (matched
by compatible =3D "pciclass,0604" in pci-pwrctrl-slot under
CONFIG_PCI_PWRCTRL_GENERIC), and commit f0cd23e8e469 ("PCI: dw-rockchip:
Power on devices below the RC using pwrctrl") adding direct calls to the
pci_pwrctrl_* helpers in rockchip_pcie_probe(), should PCIE_ROCKCHIP_DW_HOST
select PCI_PWRCTRL_GENERIC in drivers/pci/controller/dwc/Kconfig?

Currently in drivers/pci/controller/dwc/Kconfig, PCIE_ROCKCHIP_DW and
PCIE_ROCKCHIP_DW_HOST are bool symbols built into vmlinux without selecting
PCI_PWRCTRL_GENERIC:

drivers/pci/controller/dwc/Kconfig:
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

Meanwhile, include/linux/pci-pwrctrl.h exposes the non-stub declarations
whenever CONFIG_PCI_PWRCTRL is enabled as either built-in or a module:

include/linux/pci-pwrctrl.h:
	#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
	int pci_pwrctrl_create_devices(struct device *parent);
	void pci_pwrctrl_destroy_devices(struct device *parent);
	int pci_pwrctrl_power_on_devices(struct device *parent);
	void pci_pwrctrl_power_off_devices(struct device *parent);
	#else

If CONFIG_PCIE_ROCKCHIP_DW_HOST=3Dy and CONFIG_PCI_PWRCTRL=3Dm (for example=
 when
CONFIG_PCI_PWRCTRL_GENERIC=3Dm as in arch/arm64/configs/defconfig and no ot=
her
built-in driver selects PCI_PWRCTRL_GENERIC=3Dy), linking vmlinux fails with
undefined references from rockchip_pcie_probe() to
pci_pwrctrl_create_devices(), pci_pwrctrl_power_on_devices(),
pci_pwrctrl_power_off_devices(), and pci_pwrctrl_destroy_devices().

Additionally, if CONFIG_PCI_PWRCTRL_GENERIC=3Dn, either CONFIG_PCI_PWRCTRL=
=3Dn
turns those calls into no-op stubs while &pcie3x4 no longer has
vpcie3v3-supply on the controller node (leaving vcc3v3_pcie30 disabled when
rockchip_pcie_phy_init() runs), or CONFIG_PCI_PWRCTRL=3Dy via another pwrct=
rl
driver causes pci_pwrctrl_power_on_devices() to return -EPROBE_DEFER
permanently because no driver binds to "pciclass,0604".

[Severity: High]
What happens on rk3588-evb1-v10 when pci_pwrctrl_power_on_devices() or a
subsequent step in rockchip_pcie_probe() returns -EPROBE_DEFER for this
pcie@0 child node?

In drivers/pci/pwrctrl/core.c, pci_pwrctrl_power_on_devices() calls
pci_pwrctrl_power_on_device(), which returns -EPROBE_DEFER whenever the new=
ly
created pwrctrl platform device for pcie@0 has not yet bound to its driver
(for example if slot_pwrctrl_probe() defers on vcc3v3_pcie30 or &gpio3, or =
if
pci-pwrctrl-slot is a module not yet loaded):

drivers/pci/pwrctrl/core.c:pci_pwrctrl_power_on_device()
	scoped_guard(device, &pdev->dev) {
		if (device_is_bound(&pdev->dev)) {
			ret =3D __pci_pwrctrl_power_on_device(&pdev->dev);
		} else {
			/* FIXME: Use blocking wait instead of probe deferral */
			dev_dbg(&pdev->dev, "driver is not bound\n");
			ret =3D -EPROBE_DEFER;
		}
	}

However, in drivers/pci/controller/dwc/pcie-dw-rockchip.c,
rockchip_pcie_probe() unconditionally destroys the pwrctrl child devices bo=
th
when pci_pwrctrl_power_on_devices() fails and at the err_pwrctrl_off cleanup
label:

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_probe()
	if (data->mode =3D=3D DW_PCIE_RC_TYPE) {
		ret =3D pci_pwrctrl_create_devices(dev);
		if (ret)
			return dev_err_probe(dev, ret,
					     "failed to create pwrctrl devices\n");

		ret =3D pci_pwrctrl_power_on_devices(dev);
		if (ret) {
			pci_pwrctrl_destroy_devices(dev);
			return dev_err_probe(dev, ret,
					     "failed to power on pwrctrl devices\n");
		}
	}
	...
err_pwrctrl_off:
	if (data->mode =3D=3D DW_PCIE_RC_TYPE) {
		pci_pwrctrl_power_off_devices(dev);
		pci_pwrctrl_destroy_devices(dev);
	}

Calling pci_pwrctrl_destroy_devices(dev) on -EPROBE_DEFER unregisters the
pcie@0 platform device via of_device_unregister(), removing it from sysfs a=
nd
deferred_probe_pending_list so it cannot bind to slot_pwrctrl_driver and
trigger a re-probe of &pcie3x4.

Should rockchip_pcie_probe() avoid calling pci_pwrctrl_destroy_devices(dev)
when ret =3D=3D -EPROBE_DEFER (matching pcie-qcom.c, pci-imx6.c, and
pcie-mediatek-gen3.c)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027075520.3591=
049-1-shawn.lin@rock-chips.com?part=3D2
