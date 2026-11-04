Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836480;
	b=AMZeVtUjVgEPJ4YmwoTDCbBfg9b/QSvNHFfiEVbI7Wu2iC8B6Pes3QtPWUkOivH1MI7H
	 4nXpIXyxkKnq3OWr3ivQcZmhEZNjyUazDOq9XS8iC6ZKeJqPCEFWWqmiHuYQMM5WwxWYT
	 wH94FgRrwW8sr+bzF1IiznKkENMq+mjH8wMIX69TH++fsgriK+yZ2lduBHiDJn3S+6idw
	 HVjnhJlXwAZqTj3heUwN2YPyGr4WNBAfJs2d6miCBCd3OtC98Lb6I/0dltWwFjySb0ocL
	 W3CBWZewxIYYKqaj6xL0uWE1D0KDszmn6xu36X8UEr6PPWCDcyrMKmmCS601Mm3+B7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836480;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pv6mUyKQ8GXEZHlPdkNIYdCRhYjqbkbp+YOqnzLqNFo=;
	b=bmBTtUfiJ2ghM+4CGOY63xVzU7ZrOA6eSJDzTNo8IuzZFmCONGeSXxoXXq/ZGgZEsHNd
	 K4gBfuyz4iT2HJevaMcEgpQaNgWezzL1gOvRo3yaxt3Ctm5sGDWTZIeXZkz83al+3f4tK
	 lcPuHWnOHvle7xl78+3JdjaCoHnLym0Ae8vx7jCJ4nNtMQxe73X/JaMxXX/woJhCy5chE
	 hr1fxR6OgWgSTgTjcLrnNHjypPvhkuaHuf4AfQnZG/0x0DLFpSugNwW3A7mw45W8GZwix
	 EgrSQt0CqRgJ4IpcYSvFTDxl8VRuwQWnSxRLgTwBSkjRRqGyQrgU/PgLb9ZoLVFZuyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bh7P3Gbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E18606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bh7P3Gbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D0D1F000C1;
	Wed,  4 Nov 2026 23:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836479;
	bh=pv6mUyKQ8GXEZHlPdkNIYdCRhYjqbkbp+YOqnzLqNFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bh7P3Gbnn+42qDcr39fO0KP3nOqOFtRV6qrPqxwVLMCMUh/MCJWDuRR+QsyXw428z
	 fQ4Y/2gwCHTua3ngIgrc/ihAN5leMsrgExgKZADprWFDhCJ2q01DK2iP36+KMsgAYN
	 mNacZcVgt1yLXQrIycnDv2Zcrp6g6PlhZD59LDp55FI2izg6xn7XKrMHvMpV28lgWW
	 ZpVIzDOkrAeVcedGXBTQH6PVzWLF9Z7seWKyf4YooOwAgKpZ5ZY2U8/BfyZ1ZWyEyB
	 D/yhP/PRipX+dODoCTl+h69AXeyppwyAKGyT+3YqBJiMf2NTDvzLo8SSWdVszu/DR3
	 fMO1Ld9G4Wi5Q==
Message-ID: <sashiko-outbox-198318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/9] PCI: dw-rockchip: Add helper function for
 controller mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-5-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-5-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:54:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: dw-rockchip: missed rockchip_pcie_set_controller_mode() conver=
sion
--

commit 649877b47ab85eb175cd9bd067a5196956ea8d7a
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Add helper function for controller mode

This commit introduces rockchip_pcie_set_controller_mode() to deduplicate
setting the controller mode in PCIE_CLIENT_GENERAL_CON across RC and EP
configuration functions.

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index 92154a790ac09..c6a4649dae2e8 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -695,6 +695,11 @@ static void rockchip_pcie_enable_enhanced_ltssm_cont=
rol_mode(struct rockchip_pci
>  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
>  }
> =20
> +static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rock=
chip, u32 mode)
> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLI=
ENT_GENERAL_CON);
> +}
> +
>  static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  				      struct rockchip_pcie *rockchip)
>  {
> @@ -719,10 +724,7 @@ static int rockchip_pcie_configure_rc(struct platfor=
m_device *pdev,
>  	}
> =20
>  	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);
> -
> -	rockchip_pcie_writel_apb(rockchip,
> -				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
> -				 PCIE_CLIENT_GENERAL_CON);
> +	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
> =20
>  	irq =3D of_irq_get_byname(dev->of_node, "legacy");
>  	if (irq < 0)
> @@ -776,10 +778,7 @@ static int rockchip_pcie_configure_ep(struct platfor=
m_device *pdev,
>  	}
> =20
>  	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, true);
> -
> -	rockchip_pcie_writel_apb(rockchip,
> -				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
> -				 PCIE_CLIENT_GENERAL_CON);
> +	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_EP);

[Severity: Low]
This isn't a bug, but should rockchip_pcie_rc_reset_root_port() in
drivers/pci/controller/dwc/pcie-dw-rockchip.c also be updated to use
rockchip_pcie_set_controller_mode()?

drivers/pci/controller/dwc/pcie-dw-rockchip.c:rockchip_pcie_rc_reset_root_p=
ort() {
	...
	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);

	rockchip_pcie_writel_apb(rockchip,
				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
				 PCIE_CLIENT_GENERAL_CON);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D5
