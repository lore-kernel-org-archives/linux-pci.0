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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F68AC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8E52147C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWpR3FVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfDOPiT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:38:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34839 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOPiS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:38:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so9261635wmd.0;
        Mon, 15 Apr 2019 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LMGA+cchN6By4AHsxKlDJIzTA8Z8X/K3IdS+6RwwPnw=;
        b=gWpR3FVu6CZ+sxa2iAzzUPnnrxSgqwriFslXPe1iN172Ur9aifq07XwXYRClNG2qJ9
         LeeH2S25Ma9clgZPJaXHjGgahDDMZlpB5O3s54fWBP2LzP4fAGvWIl1WpA+p0nB4e0XK
         4tYbE9xS+roAJGRUQpKnVisGNpL9aWBx6xlk7oF33o7rfxek3WYruHf3NQjZJqjS2u7S
         KYimvnySfriudlgWlp6zGaM+3sWR1JRZ0r/HAPCi4LKu3MoeGI22ibcdLBuW5h18TMte
         NdMKO0SHHoZ3N7foYpaQcuYdKlFXleWasksySdZnv1pe6U1Vf1xyATg4gEkx3pCdatuA
         3hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LMGA+cchN6By4AHsxKlDJIzTA8Z8X/K3IdS+6RwwPnw=;
        b=QMsD1zZk8sNljebqNxQeOYVk364IcIbSDimV6Gb/RyfWEV5qUA+xuk2ISJUp6KVHRN
         nQipDxIQy3C3QL2kllcOhtHcoK08C9zg6VAaVtt2Ov/C97XgeKr+q4MlfjGfXsAvZioO
         D4ncfRUKZ7jnnt4gyGX1rF9BjwObTtFtxlN22aaJdHJ2Jiw552oq2V4WyREbVo1BmE1W
         xSIyIIYSa7s9eXARLploRC0URbMIOaSzPMciaGvEOBv5ue+7yHu21VJcB4hMhAN+NUSQ
         cX94r67WQ4G3ecfk0A41Vf6+Zr+HgMHrl2GLZojPuYdQ75baagqCqzRqeLUGbv3bcSvd
         fhfQ==
X-Gm-Message-State: APjAAAUmtwDQ846BovuMnxJAOLYU37+1f1N5x8IemyL31XlfGbsNv5cX
        BDwM/+J6loJado56iJcsGCvFgpNu
X-Google-Smtp-Source: APXvYqy1mlkBl02SS3PwABIQWwqdniZW5UEmNCq0DO/YCp/YVjiALG7o30nisrOUQdgL0vM7qBXUHg==
X-Received: by 2002:a1c:9ec7:: with SMTP id h190mr23628687wme.105.1555342696049;
        Mon, 15 Apr 2019 08:38:16 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id o12sm50514730wrx.92.2019.04.15.08.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:38:15 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:38:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 06/30] PCI: tegra: Program UPHY electrical settings for
 Tegra210
Message-ID: <20190415153814.GM29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-7-mmaddireddy@nvidia.com>
 <20190415112922.GG29254@ulmo>
 <f8c52bea-4e78-0f50-54ee-d8b41ec1b3d1@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DMotDPdpQlD4ewOK"
Content-Disposition: inline
In-Reply-To: <f8c52bea-4e78-0f50-54ee-d8b41ec1b3d1@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--DMotDPdpQlD4ewOK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 08:25:48PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 15-Apr-19 4:59 PM, Thierry Reding wrote:
> > On Thu, Apr 11, 2019 at 10:33:31PM +0530, Manikanta Maddireddy wrote:
> >> UPHY electrical programming guidelines are documented in Tegra210 TRM.
> >> Program these electrical settings for proper eye diagram in Gen1 and G=
en2
> >> link speeds.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >>  drivers/pci/controller/pci-tegra.c | 100 +++++++++++++++++++++++++++++
> >>  1 file changed, 100 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controll=
er/pci-tegra.c
> >> index 9ff1a0e2797f..a377245d254d 100644
> >> --- a/drivers/pci/controller/pci-tegra.c
> >> +++ b/drivers/pci/controller/pci-tegra.c
> >> @@ -177,6 +177,32 @@
> >> =20
> >>  #define AFI_PEXBIAS_CTRL_0		0x168
> >> =20
> >> +#define RP_ECTL_2_R1	0x00000e84
> >> +#define  RP_ECTL_2_R1_RX_CTLE_1C_MASK		0xffff
> >> +
> >> +#define RP_ECTL_4_R1	0x00000e8c
> >> +#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
> >> +#define  RP_ECTL_4_R1_RX_CDR_CTRL_1C_SHIFT	16
> >> +
> >> +#define RP_ECTL_5_R1	0x00000e90
> >> +#define  RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK	0xffffffff
> >> +
> >> +#define RP_ECTL_6_R1	0x00000e94
> >> +#define  RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK	0xffffffff
> >> +
> >> +#define RP_ECTL_2_R2	0x00000ea4
> >> +#define  RP_ECTL_2_R2_RX_CTLE_1C_MASK	0xffff
> >> +
> >> +#define RP_ECTL_4_R2	0x00000eac
> >> +#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK	(0xffff << 16)
> >> +#define  RP_ECTL_4_R2_RX_CDR_CTRL_1C_SHIFT	16
> >> +
> >> +#define RP_ECTL_5_R2	0x00000eb0
> >> +#define  RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK	0xffffffff
> >> +
> >> +#define RP_ECTL_6_R2	0x00000eb4
> >> +#define  RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK	0xffffffff
> >> +
> >>  #define RP_VEND_XP	0x00000f00
> >>  #define  RP_VEND_XP_DL_UP	(1 << 30)
> >> =20
> >> @@ -265,6 +291,19 @@ struct tegra_pcie_soc {
> >>  	bool has_gen2;
> >>  	bool force_pca_enable;
> >>  	bool program_uphy;
> >> +	struct {
> >> +		struct {
> >> +			u32 rp_ectl_2_r1;
> >> +			u32 rp_ectl_4_r1;
> >> +			u32 rp_ectl_5_r1;
> >> +			u32 rp_ectl_6_r1;
> >> +			u32 rp_ectl_2_r2;
> >> +			u32 rp_ectl_4_r2;
> >> +			u32 rp_ectl_5_r2;
> >> +			u32 rp_ectl_6_r2;
> >> +		} regs;
> >> +		bool enable;
> >> +	} ectl;
> >>  };
> >> =20
> >>  static inline struct tegra_msi *to_tegra_msi(struct msi_controller *c=
hip)
> >> @@ -491,6 +530,52 @@ static void tegra_pcie_enable_rp_features(struct =
tegra_pcie_port *port)
> >>  	writel(value, port->base + RP_VEND_CTL1);
> >>  }
> >> =20
> >> +static void tegra_pcie_program_ectl_settings(struct tegra_pcie_port *=
port)
> >> +{
> >> +	const struct tegra_pcie_soc *soc =3D port->pcie->soc;
> >> +	u32 val;
> > u32 value for consistency.
> I will take care of it in V2
> >
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_2_R1);
> >> +	val &=3D ~RP_ECTL_2_R1_RX_CTLE_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_2_r1;
> >> +	writel(val, port->base + RP_ECTL_2_R1);
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_4_R1);
> >> +	val &=3D ~RP_ECTL_4_R1_RX_CDR_CTRL_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_4_r1 << RP_ECTL_4_R1_RX_CDR_CTRL_1C_=
SHIFT;
> >> +	writel(val, port->base + RP_ECTL_4_R1);
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_5_R1);
> >> +	val &=3D ~RP_ECTL_5_R1_RX_EQ_CTRL_L_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_5_r1;
> >> +	writel(val, port->base + RP_ECTL_5_R1);
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_6_R1);
> >> +	val &=3D ~RP_ECTL_6_R1_RX_EQ_CTRL_H_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_6_r1;
> >> +	writel(val, port->base + RP_ECTL_6_R1);
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_2_R2);
> >> +	val &=3D ~RP_ECTL_2_R2_RX_CTLE_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_2_r2;
> >> +	writel(val, port->base + RP_ECTL_2_R2);
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_4_R2);
> >> +	val &=3D ~RP_ECTL_4_R2_RX_CDR_CTRL_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_4_r2 << RP_ECTL_4_R2_RX_CDR_CTRL_1C_=
SHIFT;
> >> +	writel(val, port->base + RP_ECTL_4_R2);
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_5_R2);
> >> +	val &=3D ~RP_ECTL_5_R2_RX_EQ_CTRL_L_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_5_r2;
> >> +	writel(val, port->base + RP_ECTL_5_R2);
> >> +
> >> +	val =3D readl(port->base + RP_ECTL_6_R2);
> >> +	val &=3D ~RP_ECTL_6_R2_RX_EQ_CTRL_H_1C_MASK;
> >> +	val |=3D soc->ectl.regs.rp_ectl_6_r2;
> >> +	writel(val, port->base + RP_ECTL_6_R2);
> > There are nice macros that help with this nowadays. See the FIELD_*
> > macros in include/linux/bitfield.h. However, the above is consistent
> > with the rest of the driver, so feel free to leave this as-is.
> I will leave it as-is to be inline with rest of the driver.
> >> +}
> >> +
> >>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
> >>  {
> >>  	unsigned long ctrl =3D tegra_pcie_port_get_pex_ctrl(port);
> >> @@ -517,6 +602,8 @@ static void tegra_pcie_port_enable(struct tegra_pc=
ie_port *port)
> >>  	}
> >> =20
> >>  	tegra_pcie_enable_rp_features(port);
> >> +	if (soc->ectl.enable)
> > An empty line above would help declutter this.
> I will take care of it in V2
> >
> >> +		tegra_pcie_program_ectl_settings(port);
> >>  }
> >> =20
> >>  static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
> >> @@ -2229,6 +2316,7 @@ static const struct tegra_pcie_soc tegra20_pcie =
=3D {
> >>  	.has_gen2 =3D false,
> >>  	.force_pca_enable =3D false,
> >>  	.program_uphy =3D true,
> >> +	.ectl.enable =3D false,
> >>  };
> >> =20
> >>  static const struct tegra_pcie_port_soc tegra30_pcie_ports[] =3D {
> >> @@ -2252,6 +2340,7 @@ static const struct tegra_pcie_soc tegra30_pcie =
=3D {
> >>  	.has_gen2 =3D false,
> >>  	.force_pca_enable =3D false,
> >>  	.program_uphy =3D true,
> >> +	.ectl.enable =3D false,
> >>  };
> >> =20
> >>  static const struct tegra_pcie_soc tegra124_pcie =3D {
> >> @@ -2268,6 +2357,7 @@ static const struct tegra_pcie_soc tegra124_pcie=
 =3D {
> >>  	.has_gen2 =3D true,
> >>  	.force_pca_enable =3D false,
> >>  	.program_uphy =3D true,
> >> +	.ectl.enable =3D false,
> >>  };
> >> =20
> >>  static const struct tegra_pcie_soc tegra210_pcie =3D {
> >> @@ -2284,6 +2374,15 @@ static const struct tegra_pcie_soc tegra210_pci=
e =3D {
> >>  	.has_gen2 =3D true,
> >>  	.force_pca_enable =3D true,
> >>  	.program_uphy =3D true,
> >> +	.ectl.regs.rp_ectl_2_r1 =3D 0x0000000f,
> >> +	.ectl.regs.rp_ectl_4_r1 =3D 0x00000067,
> >> +	.ectl.regs.rp_ectl_5_r1 =3D 0x55010000,
> >> +	.ectl.regs.rp_ectl_6_r1 =3D 0x00000001,
> >> +	.ectl.regs.rp_ectl_2_r2 =3D 0x0000008f,
> >> +	.ectl.regs.rp_ectl_4_r2 =3D 0x000000c7,
> >> +	.ectl.regs.rp_ectl_5_r2 =3D 0x55010000,
> >> +	.ectl.regs.rp_ectl_6_r2 =3D 0x00000001,
> >> +	.ectl.enable =3D true,
> > This should be:
> >
> > 	.ectl =3D {
> > 		.regs =3D {
> > 			...
> > 		}
> > 		.enable =3D true;
> > 	},
> >
> > Do these parameters never differ between board layouts? Are they really
> > fixed per SoC generation?
> >
> > Thierry
> Till now all Tegra210 platform have same UPHY settings. They can differ if
> some components like MUX are added in UPHY routing, but I haven't seen
> such platforms with Tegra210.

Okay, let's leave it as SoC data for now. If we ever need to override
per board we can add that as a backward-compatible change.

Thierry

--DMotDPdpQlD4ewOK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0pWYACgkQ3SOs138+
s6FX3A//Qc9+Pu2MORtUIbIwID4t4WCetQgt4q1TLUkqnO5Hstj7z15eCRK+6xfp
H9CKpqPZqDfDpTex/I9G02STEqvjdxrY/P9Butnd0zjPxcQGFl+dsHd49ccrtea+
Ha6KfrneWkrnCmGALKCPZdsT7Fy4RrMsmE0oinVDpLXT/I+k6Q51HXz/kLy1E1Q5
ecKQfvRFH0pfPI0pQHXqrmkoGl0eWqRBNlwqvYiKk8fFu5wrdx2lA9EQ5+0RdAmm
nGX3IbIqgaXLQoB5mtRD4R2TdPANS5UEsNtuQ08h5z0gSdbjhSTneZEhN2c5VAhU
ed06f51sgDMaOruLqQXSQmOrYoY+b+8jEHd0PmE8zZxzijPKQO3/X0sSMpT2K6v2
7g9SQhd5x48g77IWLn5L3EA8G5CfU5tJoVM8wZiu1hDB0H/PUI7bipd82NAPj8+F
EuaPtxEPbgHKf2dade9GTAMyKUbUS6VRXRS6VqoFq51z9+6MUOVSOTF1wcsllk9k
DHZwmIbWuMBKIfhlrjYUT/vTbKpe4XObMF4r/+Mas//UJtWrlIt6gRpTO2jAQf7A
LyMHjnVBSKXjLZdNE8/OC1k8BBWDXMHsbJPfWbjem+9ALMpL2Oj4w3reyStHZM6P
K2L6nR3wBWZKr5Gg8nDKkwAwGemJFq00EbYOCOhAVwOlqwbNUBo=
=4yX5
-----END PGP SIGNATURE-----

--DMotDPdpQlD4ewOK--
