Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49001C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC822087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQOehgtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDOLjW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:39:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37857 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDOLjW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:39:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so21532400wrm.4;
        Mon, 15 Apr 2019 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hoOQHUt0ccg23DSOgokgS+7IPCuiAa1pF70krMSlvJM=;
        b=EQOehgtGzNcV3Gae0OSaIe6ug0V6yz28obWQoU9bXkc6q89lE9TOZYY27EaHXr6Qv0
         k0fVzD5Rlr9MUKR8WVrDOwKAoM+Om6Rl3mUiIS6SXd/pMGdrpp9Y+oD8az2Gwye9m1G+
         oW22Nu9Kjnthnok1Bdm5jO+4/P9EQz1kWsTcoMmZz7ee09OlBnAXG4AEMNO7gAkZHqoW
         ZbFn+Gc0WqjQBJGvKBtXJuqxpGE+B6/ls11GkT40TiAN4+VV+XwjuLJs9bs+ewwwqFy+
         +cJYph814ocpX3o+VY/scuFQrKwthGQdDPCu13um9PR3yt+72qKyljFqVRtUf/796BYY
         bVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hoOQHUt0ccg23DSOgokgS+7IPCuiAa1pF70krMSlvJM=;
        b=jQ5/r/gKB+AuqXPFL26Rq2vdF6HIrGPo13/Z1m5P3v6EignXuflZnFczT3tU8Rlnhf
         epU3MBlGUGRh81SG6unbmVPOPeFA8Iaa2ftkHNIP2qFkkbbo8DTXzU7qPYPByQuAbrmY
         L6AGFnvc8SPBKJyfLg8dzeK8UbKDLqffShcBQbGol+tXupQqX3saEoVNceCL+EXehO0i
         CktO2d7u8oRBHivtOzk9Ancn9hRsp89pYzCig38j33KzkhVYeUSNeMVO/agjA9X/1nx2
         cISNGO3eZ83pRAltHfFC3yeRf3/v6lyVL2W300lJIFLtG2zTQLD8FRCZ+e4pqzxM4ZM+
         lPJQ==
X-Gm-Message-State: APjAAAW3qjIeFWh7wTB0QpxbhfRn7xnruJ71JncP7oKycy6dhZGiF76f
        +jSST7jqSSJ5j6xFBpMISYLjS3h1
X-Google-Smtp-Source: APXvYqy98mwSzLFpFkHoapCrQy3O2566Ed5WnH6UZxyJ6ch9e8O4KFbdOX937/1M+TT4b0Ib2vXlgg==
X-Received: by 2002:adf:e591:: with SMTP id l17mr45665605wrm.238.1555328359729;
        Mon, 15 Apr 2019 04:39:19 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id u8sm48924599wrt.69.2019.04.15.04.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:39:18 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:39:18 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 11/30] PCI: tegra: Increase the deskew retry time
Message-ID: <20190415113918.GL29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-12-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-12-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:36PM +0530, Manikanta Maddireddy wrote:
> Some times link speed change from Gen2 to Gen1 fails due to instability

"Sometimes"

> in deskew logic on lane-0 in Tegra210. Increase the deskew retry time
> to resolve this issue.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index f785ecae2f6b..9e61da68cfae 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -209,6 +209,10 @@
>  #define  RP_VEND_XP_OPPORTUNISTIC_ACK		(1 << 27)
>  #define  RP_VEND_XP_OPPORTUNISTIC_UPDATEFC	(1 << 28)
> =20
> +#define RP_VEND_CTL0	0x00000f44
> +#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK	(0xf << 12)
> +#define  RP_VEND_CTL0_DSK_RST_PULSE_WIDTH	(0x9 << 12)
> +
>  #define RP_VEND_CTL1	0x00000f48
>  #define  RP_VEND_CTL1_ERPT	(1 << 13)
> =20
> @@ -304,6 +308,7 @@ struct tegra_pcie_soc {
>  	bool force_pca_enable;
>  	bool program_uphy;
>  	bool update_clamp_threshold;
> +	bool program_deskew_time;
>  	struct {
>  		struct {
>  			u32 rp_ectl_2_r1;
> @@ -615,6 +620,23 @@ static void tegra_pcie_program_ectl_settings(struct =
tegra_pcie_port *port)
>  	writel(val, port->base + RP_ECTL_6_R2);
>  }
> =20
> +static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
> +{
> +	const struct tegra_pcie_soc *soc =3D port->pcie->soc;
> +	u32 value;
> +
> +	/*
> +	 * Tune deskew retry time to take care of Gen2 -> Gen1
> +	 * link speed change error in corner cases
> +	 */
> +	if (soc->program_deskew_time) {
> +		value =3D readl(port->base + RP_VEND_CTL0);
> +		value &=3D ~RP_VEND_CTL0_DSK_RST_PULSE_WIDTH_MASK;
> +		value |=3D RP_VEND_CTL0_DSK_RST_PULSE_WIDTH;
> +		writel(value, port->base + RP_VEND_CTL0);
> +	}
> +}
> +
>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>  {
>  	unsigned long ctrl =3D tegra_pcie_port_get_pex_ctrl(port);
> @@ -643,6 +665,7 @@ static void tegra_pcie_port_enable(struct tegra_pcie_=
port *port)
>  	tegra_pcie_enable_rp_features(port);
>  	if (soc->ectl.enable)
>  		tegra_pcie_program_ectl_settings(port);
> +	tegra_pcie_apply_sw_fixup(port);

Blank line between the above two for readability.

Thierry

>  }
> =20
>  static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
> @@ -2357,6 +2380,7 @@ static const struct tegra_pcie_soc tegra20_pcie =3D=
 {
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D true,
>  	.update_clamp_threshold =3D false,
> +	.program_deskew_time =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2382,6 +2406,7 @@ static const struct tegra_pcie_soc tegra30_pcie =3D=
 {
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D true,
>  	.update_clamp_threshold =3D false,
> +	.program_deskew_time =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2400,6 +2425,7 @@ static const struct tegra_pcie_soc tegra124_pcie =
=3D {
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D true,
>  	.update_clamp_threshold =3D true,
> +	.program_deskew_time =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2418,6 +2444,7 @@ static const struct tegra_pcie_soc tegra210_pcie =
=3D {
>  	.force_pca_enable =3D true,
>  	.program_uphy =3D true,
>  	.update_clamp_threshold =3D true,
> +	.program_deskew_time =3D true,
>  	.ectl.regs.rp_ectl_2_r1 =3D 0x0000000f,
>  	.ectl.regs.rp_ectl_4_r1 =3D 0x00000067,
>  	.ectl.regs.rp_ectl_5_r1 =3D 0x55010000,
> @@ -2451,6 +2478,7 @@ static const struct tegra_pcie_soc tegra186_pcie =
=3D {
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D false,
>  	.update_clamp_threshold =3D false,
> +	.program_deskew_time =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> --=20
> 2.17.1
>=20

--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0bWUACgkQ3SOs138+
s6H3aRAAui4fKyf5HV4PmHv7bi0C1FhnlFQWIQ4KmJImOj4zkEqEYuVsQ3CY0j1F
JQCk4/9m7bIzxfK3wDQzyCd6nujr81JME+iWPgHvqTU40bLd4GaE9N3uH8cH4bqB
qJFfS74sdiKmWjJO3IiEYKa1WVqs5xRPhh25bXHzH4rrrQSjZPHqI+nJQCrB1DbE
pJTu7S58/7vCkEti4EYUFhpFtg8VpmlEZ/4bwk3xwhNdLtKcoiLgItPw5dYbJDvs
FibxO4lPij/vsa73O4zZWAb1LkukosASnqq6C0H3dsX9tVwnAPWXkkP0BKi0Y1Rm
GfyHAiSnVnGcb/dorrefbrmkgjCj0U+OPWKyDaM1w/PLeCvRM2LsTmCkxQWKZ9Lt
iEhNIgEKas/U0EjwLor0AYQ2v5K8dDwzHe/wntWpXBMTkXmyck++nD4swBq/5/8A
D8Ay7lE+AiePNvhHo0oC6x0j2vdSFgJJyHuEZ5t1svsr8Dr0Y79rv653BprEotiw
ptkX1xECSBpKVcZAEF3GnZTS/AU2JcyQaxAyUhbLUQoi6KR2f3+c3XwrJ7W1sTZF
g5HDy9b8vVg5viTHaEybJIx2rzSOL27rcjdDmAC8jvgHWEnZrup+NRpJXmNlWRGE
PftsYBQYHRpQTb8k+zzej7H1zvtlcYxJCGLFb4b4Ox7qOcsr8Yc=
=p8CP
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--
