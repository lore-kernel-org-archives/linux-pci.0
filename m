Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77437EFE2
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140805; cv=none; b=Z/ST1gMe9vVPPjeX6oOpMtvzKZ2ejWKTE1Sjs7ORu3vIQTyq+gGlmBg6hlsTikdOOpAmvr+h/fi9nD94RTo6WS3l3YDM0+EXX6hA+MQTEsBalrcqardxK4pJpUZAjfMhrr0DMSnmtiTb5SvW47B+2cVYddQenyHC2jo6vwH8clc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140805; c=relaxed/simple;
	bh=Y9z3Gag4RVPz5yJ68hMHVKmLAv3951NtoVNOMhr9gpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TtCL9R6QZ8jYpMtKRlL3PDj+SBbagQIYSiEvXipnbXwb4WAngKguCo9QJCvploxw95XVqUVQOKfeI308OZvEEkSm6ePIqGkspYKnUVyFY9Eu8kkupy4ucG019HurcHnDJb3LARSCklOYWfp8Fp9Q5cbuLWn9Lm24tio3CN8Xltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwFkEzGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwFkEzGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EB1C2BCC9;
	Thu,  7 May 2026 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140804;
	bh=Y9z3Gag4RVPz5yJ68hMHVKmLAv3951NtoVNOMhr9gpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OwFkEzGOOwok1wwnf+opft4KtsNMFL+MhYoxp6ev5IFcJ9f5rZlIsMn6nUtCt6phq
	 cNKJI3OeUTjTVB4JWu81rIsl+lRzar9NkhJ1OKAIkaYOlpHH2LvLQO6INmWyStq7Zy
	 V6SVuC4Ob0SwNyM5KziISKJpK60uTG1sQPpiLFiJymi4xGSTKKYSgPMwWdQp7xIR/L
	 qetKFnigHdvdzUDDNMAkDVEenf46SnV6dFYZyNZLf+MakcFTCLrgWdFTekwL6s0Z5M
	 kfVdcm+5uvNpThSGWT55NYe9vxIRYC/CAvLTNAMKEQR4xOn7acugb+Sny5A54R5eab
	 yv4MBjrXQSHeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 15/31] drm/rockchip: dw_hdmi: avoid direct
 dereference of phy->dev.of_node
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260505100523.1922388-16-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-16-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:03 +0000
Message-Id: <20260507080003.E8EB1C2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] A PHY specifier is parsed and passed directly to a Clock framework =
API, conflating two different DT domains.
--

commit 6a42fe45756ea5f0b8615efd6d337d5e679b8587
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

drm/rockchip: dw_hdmi: avoid direct dereference of phy->dev.of_node

The commit refactors dw_hdmi_rockchip_bind() to perform a manual phandle
lookup on the hdmi PHY index within the controller's DT node, avoiding a
direct dereference of hdmi->phy->dev.of_node.

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/dr=
m/rockchip/dw_hdmi-rockchip.c
> index 0dc1eb5d2ae39..7abb42e486c02 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c

[ ... ]

> @@ -588,13 +589,17 @@ static int dw_hdmi_rockchip_bind(struct device *dev=
, struct device *master,
>  		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
>  	}
> =20
> -	if (hdmi->phy) {
> +	index =3D of_property_match_string(np, "phy-names", "hdmi");
> +	if (index >=3D 0) {
>  		struct of_phandle_args clkspec;
> =20
> -		clkspec.np =3D hdmi->phy->dev.of_node;
> -		hdmi->hdmiphy_clk =3D of_clk_get_from_provider(&clkspec);
> -		if (IS_ERR(hdmi->hdmiphy_clk))
> -			hdmi->hdmiphy_clk =3D NULL;
> +		if (!of_parse_phandle_with_args(np, "phys", "#phy-cells", index,
> +						&clkspec)) {
> +			hdmi->hdmiphy_clk =3D of_clk_get_from_provider(&clkspec);

This isn't a bug, but does this pass a PHY specifier directly to a Clock
framework API?

of_parse_phandle_with_args() parses the phys property using #phy-cells,
populating clkspec as a PHY specifier. This is then passed to
of_clk_get_from_provider() which expects a Clock specifier governed by
#clock-cells.

While this does not cause a runtime failure here because the Rockchip HDMI
PHY clock provider uses of_clk_src_simple_get and ignores the specifier
arguments, it appears to conflate two different DT domains.

Would it be better to retrieve the device node using of_parse_phandle()
and explicitly synthesize a 0-cell clock specifier to maintain the API
abstraction?

> +			of_node_put(clkspec.np);
> +			if (IS_ERR(hdmi->hdmiphy_clk))
> +				hdmi->hdmiphy_clk =3D NULL;
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D15
