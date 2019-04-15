Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C06C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B037020833
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxn8kO8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDOLrI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:47:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53259 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOLrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:47:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so20244399wmj.3;
        Mon, 15 Apr 2019 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aAayXojDGbp2QkZi1nfH8enEpOyxRzs8KGlHopzV9SU=;
        b=Jxn8kO8SqM24CIrvUgy81rKRe5TVNhp0aKC+c8DYg0JAGBRs7UhVaALtSfrjHkgCGq
         67seKDBm0cILYAKrs0RVj2n08OiqsUO6PyKE2KX5w9Xhx6XNqzTvsqOdqppoTjzVl4MO
         rP6boRRM3I/78YX6vPW0s9ncWXABdVvKVX5eTEfyAW4Ij+y8pwp0fXdFah6fmuWaBGjP
         jppvJaMpNwCfdANZAR77YPbk75UCWOq6TnUFWgMBAOw6HLdQ7E+DZHNA6njpGsamWkgS
         heyYiL4OBQNm1PdN+CGSNjA2Uqb/A3U4FPck/FVGAq7kNZzaHxpcKUnuO3jvZXbiyAr5
         IvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aAayXojDGbp2QkZi1nfH8enEpOyxRzs8KGlHopzV9SU=;
        b=EjO5xy68lLMl6H+1w/873AS/zgh83RZc4NHc3jLukJwXcKmE3ywBo8nRZYdnJvVa0g
         M73SYFIjoVZApUW3SxqbWlRtSU1Nl1Dn09e3IMEETlK+vBigSZ4nk1vj3NSVanFB2Wf0
         jbgpWZ4hJoLBDxO3vN1qb0xg1k0PTtSGmrs/1m8jY5j6zc6/alk/ING2SQ4BBMXue9lS
         oUffvjgJSrUVjPUEG098+RT0/2pFsUJSU6+fOjmqbUmTG2R+Wga5CBRxppco6pzR9iaf
         yodisE0QCpjVYnKWUG/pRmSNq27ezSbqNx+YMLx9E/+EyL83nzq23XrUE/+gbf/olwI8
         AeFQ==
X-Gm-Message-State: APjAAAW54eH89LEdcUNiikhww9XsXfRF8q2CVnXoQ/GEDOB507bTZL9d
        bNFIVZ34IzP1R/lej0RbYwg=
X-Google-Smtp-Source: APXvYqwE4YDwAfe1ca3Ghr7zpjEh/b3/kQkUPQB5UQHs+N4DcGyEuc2ecv/jr1eEgQGVXRRe8avMjg==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr22793740wmd.59.1555328824690;
        Mon, 15 Apr 2019 04:47:04 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id f10sm60368788wrs.17.2019.04.15.04.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:47:04 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:47:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 13/30] PCI: tegra: Update flow control threshold in
 Tegra210
Message-ID: <20190415114703.GO29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-14-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="96dIhm/ZjrNld+BP"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-14-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--96dIhm/ZjrNld+BP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:38PM +0530, Manikanta Maddireddy wrote:
> Recommended update FC threshold in Tegra210 is 0x60 for best performance
> of x1 link. Setting this to 0x60 provides the best balance between number
> of UpdateFC and read data sent over the link.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Looks to me like part of this patch ended up in 12/30?

Thierry

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index b74408eeb367..7dc728cc5f51 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -319,6 +319,7 @@ struct tegra_pcie_soc {
>  	bool update_clamp_threshold;
>  	bool program_deskew_time;
>  	bool raw_violation_fixup;
> +	bool update_fc_threshold;
>  	struct {
>  		struct {
>  			u32 rp_ectl_2_r1;
> @@ -662,6 +663,13 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_p=
cie_port *port)
>  		value |=3D soc->update_fc_val;
>  		writel(value, port->base + RP_VEND_XP);
>  	}
> +
> +	if (soc->update_fc_threshold) {
> +		value =3D readl(port->base + RP_VEND_XP);
> +		value &=3D ~RP_VEND_XP_UPDATE_FC_THRESHOLD_MASK;
> +		value |=3D soc->update_fc_val;
> +		writel(value, port->base + RP_VEND_XP);
> +	}
>  }
> =20
>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
> @@ -2409,6 +2417,7 @@ static const struct tegra_pcie_soc tegra20_pcie =3D=
 {
>  	.update_clamp_threshold =3D false,
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D false,
> +	.update_fc_threshold =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2436,6 +2445,7 @@ static const struct tegra_pcie_soc tegra30_pcie =3D=
 {
>  	.update_clamp_threshold =3D false,
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D false,
> +	.update_fc_threshold =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2458,6 +2468,7 @@ static const struct tegra_pcie_soc tegra124_pcie =
=3D {
>  	.update_clamp_threshold =3D true,
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D true,
> +	.update_fc_threshold =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2468,6 +2479,8 @@ static const struct tegra_pcie_soc tegra210_pcie =
=3D {
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 =3D 0x90b890b8,
> +	/* FC threshold is bit[25:18] */
> +	.update_fc_val =3D 0x01800000,
>  	.has_pex_clkreq_en =3D true,
>  	.has_pex_bias_ctrl =3D true,
>  	.has_intr_prsnt_sense =3D true,
> @@ -2478,6 +2491,7 @@ static const struct tegra_pcie_soc tegra210_pcie =
=3D {
>  	.update_clamp_threshold =3D true,
>  	.program_deskew_time =3D true,
>  	.raw_violation_fixup =3D false,
> +	.update_fc_threshold =3D true,
>  	.ectl.regs.rp_ectl_2_r1 =3D 0x0000000f,
>  	.ectl.regs.rp_ectl_4_r1 =3D 0x00000067,
>  	.ectl.regs.rp_ectl_5_r1 =3D 0x55010000,
> @@ -2513,6 +2527,7 @@ static const struct tegra_pcie_soc tegra186_pcie =
=3D {
>  	.update_clamp_threshold =3D false,
>  	.program_deskew_time =3D false,
>  	.raw_violation_fixup =3D false,
> +	.update_fc_threshold =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> --=20
> 2.17.1
>=20

--96dIhm/ZjrNld+BP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0bzcACgkQ3SOs138+
s6FC9Q/+NP0IHv6WGcpL1qKW4euVJU1JjqWQIebNKPKDt/h+tEzDDvRoTvy4HCoL
Hhm372Qvjm/U4bLkKniFEcb5HfM8Bjn5RBD8+HJ5O55bRQJ+mH8bverT5Nio+4S8
4tYmj1aIkLRV74pUvMyLbmA5iyWTvRR3f56ag9KYWyUj90AFOq6TOpDYDzOPJTQX
PEzvcxNYC1h6RX8I28JbQa+KM1gq97vs76eeEjqCimp8ZZCOeeoeO7K1amTUibl3
9EdWsh//Oz9QOHDekKx6+obcYeXW5On7Qz3UQfwvQWGIO7ehNQeuCV29i6pYNPnC
Qi75DIzT4YmqgX4B3HdiRPQ4pB3HjzORJmn5HD21l0MNGlceM8h1JAFHXdhmdxQa
vVB172gr0IZTP8ePAwcK8f3S4Qw8GvTL+sx3cVBX8m+2H+p6TPR1vED50nCIdfJT
pMa+HLLtjW8NKdRFtWXnEGe1c1OoFUGO9z19Pm5Mp6FQIf1xWAkJfOUMzNxC0sU2
y5JoJDxloYmfAAXIKxqFbMDVyUkvcHguh/R27JtHAVPElj2mFQNx79FwimgVLXW5
tEQ5H/WsU3dfWMxHdaEpLF0vuDx4qKdIAJwnRCQVqhEdqdYmyl40wTK8HhOIxceR
vepZM2tAiEd5N9qXBIlq7Fz3of82kNQdAPrBUD9r+pprERy+PzI=
=fi8I
-----END PGP SIGNATURE-----

--96dIhm/ZjrNld+BP--
