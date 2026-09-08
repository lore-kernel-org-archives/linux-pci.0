Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6C55D878
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880999; cv=none; b=nS9AI28M9lrZXGfURXHFhyIo5l5Yec0YNgDuIE7s2JeG9ZrSGw1DB1VtPvVANIixlbyTfBoyBqbn3/goc+gdpxa00wlIBgE7dFPVLHoMgQ5SiuN5PI0uUAsj2HOEB3V4Z0+MNffme265TXiYyytA7lqS4uM4FXyyzutmgybg6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880999; c=relaxed/simple;
	bh=xrziD/Q7pcO1vVMt7Sfa0tx3JBuey//bBdJFGxI+bhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oe33c5MiOzkykG1+D3BNZtRoIXrx5sc0l9VlKJA6V1fs8cInnvqItKVPutj02UP7Yh55hGzBhC+LG4QKcMcMFp7TiM0ZorEEN3uNXO+WAW9jC2M3zv5i4t8zG5oJtEvUUjFfV6ZGk2o60VLb9U3WQji8ORUOWv++yQamXLYS1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIMXX/16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIMXX/16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614621F00A3D;
	Tue,  8 Sep 2026 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788880988;
	bh=s+ghLg0CfYFaZz+vIST+85atEEDEVoGEm+RtStAkozs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIMXX/16OEH04TL9bpAUL+uVctEjWigWE38vF+sydbci8KFbhQ39tV/oHsh045NR2
	 hiE2J6Kg2OcBXHiq/g1FMqCyVRKqe0HarpEo1nCEIXjHJpQiqZ3ZuJ7CLIUn42ULGO
	 inlsAZh/Km0Lu/SzP1/lkmM7TvdfilNwVqse+RR5dOzK0NDJeT49b2NsKAqwMDWHjM
	 /LI7k29jpBDZ32YLYyl35ueTQTkzw7Bhr9y8t9xh06bVPZUQFYbURqSDavJBKfs+Yv
	 QqcmprPFdC51VZA9Ud9H1Kiza1LbNO5g0OSRRo13O98cTk6lJeu2bbFYKLtf4YbNsh
	 +cJlqX22aSUdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] PCI: dw-rockchip: Add helper function for
 enhanced LTSSM control mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-4-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-4-fbabcca9921b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:23:07 +0000
Message-Id: <20260908152308.614621F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Variable parameter passed to FIELD_PREP_WM16() causes build fail=
ures and contains a latent logic bug.

Pre-existing issues:
- [Low] Incomplete refactoring of enhanced LTSSM control mode setup.
--

commit 754de1ab627f784507a4b699acc006187c6a91fb
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode

Remove code duplication and improve readability by introducing a new
function to setup the enhanced LTSSM mode.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 7472ec78b4738..6f84b07406d49 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -696,6 +696,18 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(i=
nt irq, void *arg)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rock=
chip_pcie *rockchip,
> +							     u32 flags)
> +{
> +	u32 val;
> +
> +	/* Enable the enhanced control mode of signal app_ltssm_enable */
> +	val =3D FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
> +	if (flags)
> +		val |=3D FIELD_PREP_WM16(flags, 1);

[Severity: Medium]
Does passing the variable flags to FIELD_PREP_WM16() violate the macro's
requirement for a compile-time constant mask?

If rockchip_pcie_enable_enhanced_ltssm_control_mode() is outlined, will this
trigger a BUILD_BUG_ON_MSG(!__builtin_constant_p) build failure?

Also, if a future caller passes a multi-bit mask to flags (e.g. BIT(1) |
BIT(3)), would the macro evaluate to (1 << 1) & mask, setting only BIT(1)
and writing 0 to BIT(3), despite enabling both in the upper 16 bits?

> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +}

[Severity: Low]
This is a pre-existing issue, but since the goal of this helper is to remove
code duplication for setting up enhanced LTSSM mode, should the exact same
duplicate sequence in rockchip_pcie_rc_reset_root_port() also be replaced
with rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0)?

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_rc_reset_root_p=
ort() {
    ...
    /* LTSSM enable control mode */
    val =3D FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
    rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
    ...
}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rockchip-p=
cie-system-suspend-v6-0-fbabcca9921b@collabora.com?part=3D4
