Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157B44CAF8
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624270; cv=none; b=iQgzTd9nwwi5B8e7tSPRMmT+kymV4URrz1B2+ngP2LCese8bnaEQFeLdSa2RfH5yWDoAz7F2Jy6213OPTK/grXN4a1jmT7ZSttnU2KdxZAWLcAAN5w7+aCXMLMPbzgpK0Rv73M9PTm86mQb7FeVgVhClU+1Pqt7rpk7KAVAlwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624270; c=relaxed/simple;
	bh=RsXfuqMmWd7YvLsLJTo8v6dfmBKODVGK8TvhlNBtp28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JpyoVtX5096E9KCrdphNDN8bN/Uf9XTz7rjr1LTxaMfsfqniG6TDVZkcpRKg5AjInP+S/aG7603oH0ScTKmWY7Sw2iBcgb/Jqo09lViJpcrTHLIQr5jPCcqfZ/KNL4YQDcibSlWValpoiRpIYDIbBbRozoG3IDOr0Btj1btzTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jejO28Xh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jejO28Xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2D41F000E9;
	Tue, 16 Jun 2026 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624269;
	bh=Z9oiAoHsY/VT0v1s8kddmHtx10x7XbiWkzROQ+TFwmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jejO28XhSCIh1I3mAC2L9A/zhSu2uGKLosam0PlkPxCFi/xdzvtsCBLSuzawcoZ9M
	 ED1H92MoZsBFc+8T2ZCysyAghCmH7CpBwhoaayJITlvgVqnJt7TXLF2xQyBvc1nJDR
	 7FZ8YLuVQdH+4M51MWBCUY4dosirja7fDjkyZExxnayrgOr8J8bzE0LRnuwFrrdmkV
	 76PaJw8yXDN8yD/QxVatrglqC2e9Tkntf08QRtEUYoODPyeMR0z42KcyGhoAG++0jY
	 AVHfFXggHMQ0g6xfUlYrVh72h71YnnfqULT+OysMbuApmozskIBthwHN8oTXPlHB0c
	 j3GT+JdcKV1MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] PCI: rockchip: drive at 2.5 GT/s, error other
 speeds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <7421df7a7b7778ee99363cccfdfabbfa8aa6ab5e.1781622998.git.geraldogabriel@gmail.com>
References: <7421df7a7b7778ee99363cccfdfabbfa8aa6ab5e.1781622998.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:37:48 +0000
Message-Id: <20260616153748.EA2D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Spurious warning emitted when the optional 'max-link-speed' devi=
ce tree property is absent.
- [Low] The parsed `max-link-speed` value stored in `rockchip->link_gen` is=
 dead code and entirely ignored during link initialization.
--

commit 3b268bac2a052935f203b8d3ae0eea857d63f07b
Author: Geraldo Nascimento <geraldogabriel@gmail.com>
PCI: rockchip: drive at 2.5 GT/s, error other speeds

This commit configures the Rockchip PCIe core to drive at a maximum link
speed of 2.5 GT/s to prevent potential data loss or hardware issues. It
ignores other configured speeds with a warning and removes 5.0 GT/s defines.

Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock=
-chips.com/

> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/control=
ler/pcie-rockchip.c
> index 0f88da3788054..456dcfd676ed7 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockc=
hip)
>  	}
> =20
>  	rockchip->link_gen =3D of_pci_get_max_link_speed(node);
> -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> -		rockchip->link_gen =3D 2;
> +	if (rockchip->link_gen < 0 || rockchip->link_gen >=3D 2) {
> +		rockchip->link_gen =3D 1;
> +		dev_warn(dev, "invalid max-link-speed, limited to 2.5 GT/s\n");
> +	}

[Severity: Medium]
Since the max-link-speed device tree property is optional,
of_pci_get_max_link_speed() will return a negative error code such as -EINV=
AL
when it is absent. Does this mean the rockchip->link_gen < 0 check will cau=
se
a spurious warning on every boot for perfectly valid device trees that
omit this property?

> =20
>  	for (i =3D 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
>  		rockchip->pm_rsts[i].id =3D rockchip_pci_pm_rsts[i];

[ ... ]

> @@ -147,12 +149,8 @@ int rockchip_pcie_init_port(struct rockchip_pcie *ro=
ckchip)
>  		goto err_exit_phy;
>  	}
> =20
> -	if (rockchip->link_gen =3D=3D 2)
> -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
> -				    PCIE_CLIENT_CONFIG);
> -	else
> -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> -				    PCIE_CLIENT_CONFIG);
> +	rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
> +			    PCIE_CLIENT_CONFIG);

[Severity: Low]
Does this unconditional write make the rockchip->link_gen value parsed in
rockchip_pcie_parse_dt() obsolete? If link_gen is no longer used during link
initialization, could the device tree parsing logic and state be removed
entirely to simplify the code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781622998.gi=
t.geraldogabriel@gmail.com?part=3D3
