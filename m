Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FEAC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4761220833
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 11:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDIVjEzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDOLhI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:37:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38577 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDOLhI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 07:37:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so21505292wro.5;
        Mon, 15 Apr 2019 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AF7ZNZOb8MylgxUXKuvtE8j0T9rHRh90LgvbVWYlxAE=;
        b=QDIVjEzOMTrtK6u4WRkTVLL+SCKDTlXhkmI4r6tst1wJCQyML0/c5nO14xCQRFsw1v
         WhmfwTo62jxwlbKv/TJRqSTQD6WDyGMvg10ME73gqtHHhedTXazcGlAqNMYE+KV8ae0L
         gXVxdX/E9WF3LK9C6J2ilr7/esP7LXW9+sK51Zvh0WaSRC7w1OhrP5PLfZZSgpOEjBZa
         fLJFwX6R/UNOU3m4AZJRbP/4WCJcirj2sLjZicYxZXIj8mwvGwOHKBF2GO89oV4NvsYY
         I/ALVebhPfSOPbiDuSGjyu+xXOSTaNqkOYAiuzKmkYDVCL+Fu3lHVXXFGADVPGBOuLh6
         he4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AF7ZNZOb8MylgxUXKuvtE8j0T9rHRh90LgvbVWYlxAE=;
        b=HJD8psX5VoU6xuhvujL1ewFvKBofD9SadPdUul1BYp80Zrz6k7U4bDBS3KVYvND3YT
         DQMnB49gxGa0N9gBtgNAPeMPIQpDwokEQLqMG3e6QMy2Z4j31volz3mRQfIszqp2yhUm
         024UMaj6jTz88rN1DvN+evPvIFwkJMUPGXUvGkSGhrhBfWLmiX9u77H2bEIYs2OqBW08
         hkg8YgLH/P2GI6kyTeSlI6jD1kBcUevlaNUQffn1Q30KytkNa3P/npwkqVD+528CWMVu
         71bcnAI3X+PLZZ4mSUS3qAIZJKnHaOfx7OgCWh0dWRZSqkQbE8+j9VPgVNeyrHrvIjI+
         juwg==
X-Gm-Message-State: APjAAAW0vrrAOgF5Wd74rPRy0mcjeGxWIzt+pmwRirhoxdG+5Bsod1DP
        VDLoM+9UM8tHUoBk5sNo5UmFBClw
X-Google-Smtp-Source: APXvYqyqnGF1rK8Ya/u3rowpJCrpoZHvmfQ7jXag3yKcc+ngikyH7uJNFcc0VLuWIFWpH4h4VsfZWw==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr48976843wrx.24.1555328225565;
        Mon, 15 Apr 2019 04:37:05 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id x18sm70498617wrw.14.2019.04.15.04.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 04:37:04 -0700 (PDT)
Date:   Mon, 15 Apr 2019 13:37:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 10/30] PCI: tegra: Enable PCIe xclk clock clamping
Message-ID: <20190415113703.GK29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-11-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-11-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:35PM +0530, Manikanta Maddireddy wrote:
> Enable xclk clock clamping when entering L1. Clamp threshold will
> determine the time spent waiting for clock module to turn on xclk after
> signalling it. Default threshold value in Tegra124 and 210 is not enough

Perhaps spell out Tegra210.

> to turn ON xlck clock. Increase the clamp threshold to meet the clock

s/ON/on/, s/xlck/xclk/

> module timing in Tegra124 and 210, default threshold value is sufficient

Spell out Tegra210. Also, maybe make the part after the , a separate
sentence? And maybe also mention Tegra20 and Tegra30.

Thierry

> in Tegra186.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index e40df52e46a7..f785ecae2f6b 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -219,8 +219,14 @@
>  #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
> =20
>  #define RP_PRIV_MISC	0x00000fe0
> -#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT (0xe << 0)
> -#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT (0xf << 0)
> +#define  RP_PRIV_MISC_PRSNT_MAP_EP_PRSNT		(0xe << 0)
> +#define  RP_PRIV_MISC_PRSNT_MAP_EP_ABSNT		(0xf << 0)
> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 16)
> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD		(0xf << 16)
> +#define  RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE		(1 << 23)
> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK	(0x7f << 24)
> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD		(0xf << 24)
> +#define  RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE		(1 << 31)
> =20
>  #define RP_LINK_CONTROL_STATUS			0x00000090
>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
> @@ -297,6 +303,7 @@ struct tegra_pcie_soc {
>  	bool has_gen2;
>  	bool force_pca_enable;
>  	bool program_uphy;
> +	bool update_clamp_threshold;
>  	struct {
>  		struct {
>  			u32 rp_ectl_2_r1;
> @@ -528,6 +535,7 @@ static void tegra_pcie_port_reset(struct tegra_pcie_p=
ort *port)
> =20
>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>  {
> +	const struct tegra_pcie_soc *soc =3D port->pcie->soc;
>  	u32 value;
> =20
>  	/* Enable AER capability */
> @@ -548,6 +556,17 @@ static void tegra_pcie_enable_rp_features(struct teg=
ra_pcie_port *port)
>  	value =3D readl(port->base + RP_VEND_XP_BIST);
>  	value |=3D RP_VEND_XP_BIST_GOTO_L1_L2_AFTER_DLLP_DONE;
>  	writel(value, port->base + RP_VEND_XP_BIST);
> +
> +	value =3D readl(port->base + RP_PRIV_MISC);
> +	value |=3D RP_PRIV_MISC_CTLR_CLK_CLAMP_ENABLE;
> +	value |=3D RP_PRIV_MISC_TMS_CLK_CLAMP_ENABLE;
> +	if (soc->update_clamp_threshold) {

Blank line between the above two.

> +		value &=3D ~(RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD_MASK |
> +				RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD_MASK);
> +		value |=3D RP_PRIV_MISC_CTLR_CLK_CLAMP_THRESHOLD |
> +			RP_PRIV_MISC_TMS_CLK_CLAMP_THRESHOLD;
> +	}
> +	writel(value, port->base + RP_PRIV_MISC);

Ditto.

Thierry

>  }
> =20
>  static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *por=
t)
> @@ -2337,6 +2356,7 @@ static const struct tegra_pcie_soc tegra20_pcie =3D=
 {
>  	.has_gen2 =3D false,
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D true,
> +	.update_clamp_threshold =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2361,6 +2381,7 @@ static const struct tegra_pcie_soc tegra30_pcie =3D=
 {
>  	.has_gen2 =3D false,
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D true,
> +	.update_clamp_threshold =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2378,6 +2399,7 @@ static const struct tegra_pcie_soc tegra124_pcie =
=3D {
>  	.has_gen2 =3D true,
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D true,
> +	.update_clamp_threshold =3D true,
>  	.ectl.enable =3D false,
>  };
> =20
> @@ -2395,6 +2417,7 @@ static const struct tegra_pcie_soc tegra210_pcie =
=3D {
>  	.has_gen2 =3D true,
>  	.force_pca_enable =3D true,
>  	.program_uphy =3D true,
> +	.update_clamp_threshold =3D true,
>  	.ectl.regs.rp_ectl_2_r1 =3D 0x0000000f,
>  	.ectl.regs.rp_ectl_4_r1 =3D 0x00000067,
>  	.ectl.regs.rp_ectl_5_r1 =3D 0x55010000,
> @@ -2427,6 +2450,7 @@ static const struct tegra_pcie_soc tegra186_pcie =
=3D {
>  	.has_gen2 =3D true,
>  	.force_pca_enable =3D false,
>  	.program_uphy =3D false,
> +	.update_clamp_threshold =3D false,
>  	.ectl.enable =3D false,
>  };
> =20
> --=20
> 2.17.1
>=20

--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0bN8ACgkQ3SOs138+
s6H8YBAAsTXy+U8ia2sdUCtCg1580iAPmXmMxuJJv1Fb1GAROej2sAEtNWyusJBi
BieronjNR2tOmt7EiPo9u0wRRzVdv4PzvFyQme8PKR5I6yDYfFRF19dvzFMesGCT
1SkcdiC7OlvDSSdCUj4jQjIDDafzyOr2xtbgZrr0jd5GyizRSYJZTdajHPsjMukZ
a3Q0XkeYM5qTX8F3KMFncRj3jNjzMMQgl4t3Vj9LBwO2HO9QqQ3qgYP/fRzN0jYj
s56jIkS61Q8hQMQFNx2TvhgDrLOsSGx81q97+3nTYYoghdepVDP+ZbGmRY+8hWfL
2ZidY9kfSnUu5+8aU77QoOk9uUFHUAzJabfZq+M5s08gLcQEONW3X1tRI++62SQg
E6UBtLT/+7WifmPR88uyleNIwA/mcuH7ZDMK2Oru4fpFi5tbMry3llkZuR7G1R7u
vT3al5xJEO4FxsF2TeeULWK/uijt+kCNKpwVAz6a0fF9vSAihXbTyTOjHcbCRUWJ
PJaXIvQ/zyWQhQbxjPP0Gxm2EIKDzgfL/tv+ZE5urrid5cK+V0S+fqKCMoHwm5NM
VGlwNuj34YlignkFw0wqw8XUgQZwgwtAcU3PivbqlBCRkMD6GxL4yeyYJFHiYB0O
pyQjZMQPG5dGUAFylz8f1PHlXvNeUPtW/CZ7GPUstc0y8RyNdsc=
=pHTi
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--
