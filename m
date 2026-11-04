Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820036;
	b=L9oRpWhBSZ3wp0ioS/9W+GbVp46H87h0askkzbzMrghJw9Mbb26Ffo9bqG33MCGd3N22
	 FDskbMEh5Y5Mx20WU5fU+qafeWoc8tKD/P80TqeSUzb0n2zIreZH1YEGhFzh8Et1+X4U4
	 I3GaMNM9JUgeXfBFOcW7CuOceIg79Ydz6Q2axHAaxo3Hugz/lDMftIDlAFcS5TzLPx4N0
	 pUhuxDI3OOmdP8AM5axnwDPf9qpL5cK5YJ74Z9A6ElcRNhZHhjN+qBQ56rGQUrynGwwmp
	 tdwQcmiR+cPz0QKdnj8lLE7kvwterSUwYVvkb9kShDNP5RJq8ueBxRBNlxGnujsS7uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NwEAfZWJ+MhKe0snq8okZPBS5TpJquOS2RfdOiJ7dO8=;
	b=Q7vnEKJZDrzUSV374Nwf4N1oJEQRxvKd0fphdZ2DXJJsdfZj+S+eQk/krhWiMrrJ/iTf
	 zFo/PVhfr/0i3jNbULWNaFOSvQDf62jQYxeqwCN3aD2mG6n9IHoXVZCKxCOjEgxnuzRG9
	 kkXARAioHQKuAyM+8CYTL1QOt0sVsO9TJYMML2BMXpjmSOfDioHgbEvlN5OARxEdMkHuR
	 RXSh/Vc1Vxx8hCM349AAGp9tqTPuzANCmpT+r3B2OQ93zEyINhxajF62+cGV3LmWjX6Zd
	 EafnDt3xyem6b2e/eq6emetSsu7CRANYAa7yvSi+GUCFDu/La0uLy47wQb9kBMRBPuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOSZOdur;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D73F606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOSZOdur
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA111F00A1C;
	Wed,  4 Nov 2026 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793820035;
	bh=NwEAfZWJ+MhKe0snq8okZPBS5TpJquOS2RfdOiJ7dO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gOSZOdurZch7p/NdEdRvsVoOP60DI9zRKmYD5eWy9LvhPAqAv31TPtDY384dEaQP2
	 jiLOrr0h8qNmaWVTExLI0syEfVSYGZog3FHjcgmT3MJ+LebPMrRYGOWu68QBDPLcPc
	 vTk4AOlG8hoZjnfZKC6uChtwek2f/OjE0xXokavuAiQzBIAqwT3ps2zKElx2Lvyq3x
	 hsbOC7jNGbiTNMUUeh/Jn6vfzMhPRO+dAfmNycYrzKCf6oDWuIqIN2Pa9OHd1aQXSI
	 mH00rr/MrYAMnWFTwOR4nboyBVShR2bpb/znv6v9RB+4igkmU2310k/1fqEQND/zU8
	 d0jQ7w1bxck5w==
Message-ID: <sashiko-outbox-197939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] PCI: dw-rockchip: Add helper function for
 enhanced LTSSM control mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-4-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-4-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:20:35 +0000
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
- [Low] PCI: dw-rockchip: missed LTSSM helper in rockchip_pcie_rc_reset_roo=
t_port()
--

commit 01b1475be69dbc97dabfa0df29b029fb455894d6
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode

This commit introduces a rockchip_pcie_enable_enhanced_ltssm_control_mode()
helper function to deduplicate setting up the enhanced LTSSM mode in
rockchip_pcie_configure_rc() and rockchip_pcie_configure_ep().

> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/=
controller/dwc/pcie-dw-rockchip.c
> index a3b0fb918479f..7645b0895bf91 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -683,6 +683,18 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(i=
nt irq, void *arg)
>  	return IRQ_HANDLED;
>  }
> =20
> +static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rock=
chip_pcie *rockchip,
> +							     bool delay_link_training_after_reset)
> +{
> +	u32 val;
> +
> +	/* Enable the enhanced control mode of signal app_ltssm_enable */
> +	val =3D FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
> +	if (delay_link_training_after_reset)
> +		val |=3D FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +}
> +
>  static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  				      struct rockchip_pcie *rockchip)
>  {
> @@ -706,9 +718,7 @@ static int rockchip_pcie_configure_rc(struct platform=
_device *pdev,
>  		return ret;
>  	}
> =20
> -	/* LTSSM enable control mode */
> -	val =3D FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);

[Severity: Low]
As reported by Sashiko on v6 [1], rockchip_pcie_rc_reset_root_port() in
drivers/pci/controller/dwc/pcie-dw-rockchip.c still open-codes the same
PCIE_CLIENT_HOT_RESET_CTRL write:

	/* LTSSM enable control mode */
	val =3D FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);

Should rockchip_pcie_rc_reset_root_port() also be converted to call
rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false)?

[1] https://lore.kernel.org/r/20260908-rockchip-pcie-system-suspend-v6-4-fb=
abcca9921b@collabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D4
