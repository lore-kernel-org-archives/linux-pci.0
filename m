Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3217FC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E8020825
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBSz3NOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfDONbt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:31:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34763 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDONbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 09:31:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so21999907wrq.1;
        Mon, 15 Apr 2019 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGsUisZAEX27rhAN0Px0SQL+0EN91IteQj1txo8iXCE=;
        b=CBSz3NOtdkQA9G8+0cZfVyz0faVqinB42hr8nVly/4Prc1zkFt5QcYFiFjj3V5vrB/
         HKMTxW/6BKvFaDKrc1Ux5FjpaiKM13AQ28bPFKZm42KshaLfrJBWlo0BRzSxuGWmEozr
         Js+19I5EAATk0cQpw05mgmq00y50vAySlgyMZNRrl4ml6cMv+g41Yo12wlgTdk3BvR0d
         r+CIVMNBniZLo/8sDwI87UqObMeBYt3RKFRHT1Yx2uqSVTJzouKEVnXxufXHpBxO7JYj
         rasyznx6mdXk1v+0nXD1KD46NRXCVJtxEX1/8v26mhz2LlfdAkg65ptPeNB+KhrjplIg
         Wsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGsUisZAEX27rhAN0Px0SQL+0EN91IteQj1txo8iXCE=;
        b=C7V76idGOZfnMIU3gb6ZvBVg8loNO2r7A6lJiUnu5EU2GFsAzy8kUoXzcL/exHnSaI
         38HA8fwak79xyCpNkqF4XQ+I8qr1QkDs0h4T+ObK/mEg6gBRCCdtrbEaNbt21cMzFALB
         cp2jobjWqtRuBX0YRP9jYV5RkMFR+2AkltAQgiVaN0WfJFJ4F9RHF9sEaF9+BKASY56y
         soHyIGtnHIiqH5TnWk1N4O3iN5/HmWW5Mv/jWJCAqDIhVZOwaPfyAwXTLihQksncthtM
         G2xA/YID4G86M6jqNAVOGl/CNFs4iTCSMSO8J+1iK36N3B5dnhd0UIF4XASc/DkwoxNz
         oksA==
X-Gm-Message-State: APjAAAWFNgIok5vQZefN3gocWSpsxSp/C3XMDyKPsFkSMOr78M1w2W0s
        fuMOo5XII/MJwt2wtdoyVUI=
X-Google-Smtp-Source: APXvYqzE2c4IXRsRVCflDOiVpg9VbjXQKL5aJd27gpQWEGZRmi0q3DLTpt9w4e0NA2Js0ALb2Hoxqw==
X-Received: by 2002:adf:db05:: with SMTP id s5mr49263926wri.247.1555335106706;
        Mon, 15 Apr 2019 06:31:46 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id 10sm18069505wmd.23.2019.04.15.06.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 06:31:45 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:31:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 20/30] PCI: tegra: Add AFI_PEX2_CTRL reg offset as part
 of soc struct
Message-ID: <20190415133144.GT29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-21-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2wYUONsACSj9OMJp"
Content-Disposition: inline
In-Reply-To: <20190411170355.6882-21-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--2wYUONsACSj9OMJp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 10:33:45PM +0530, Manikanta Maddireddy wrote:
> Tegra186 and Tegra30 have three PCIe root ports. AFI_PEX2_CTRL register
> is defined for third root port. Offset of this register in Tegra186 is
> different from Tegra30, so add offset as part of soc data structure.
>=20
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/=
pci-tegra.c
> index 11be88a394e3..8fdc7934d4c9 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -169,7 +169,6 @@
> =20
>  #define AFI_PEX0_CTRL			0x110
>  #define AFI_PEX1_CTRL			0x118
> -#define AFI_PEX2_CTRL			0x128
>  #define  AFI_PEX_CTRL_RST		(1 << 0)
>  #define  AFI_PEX_CTRL_CLKREQ_EN		(1 << 1)
>  #define  AFI_PEX_CTRL_REFCLK_EN		(1 << 3)
> @@ -307,6 +306,7 @@ struct tegra_pcie_soc {
>  	unsigned int num_ports;
>  	const struct tegra_pcie_port_soc *ports;
>  	unsigned int msi_base_shift;
> +	unsigned long afi_pex2_ctrl;
>  	u32 pads_pll_ctl;
>  	u32 tx_ref_sel;
>  	u32 pads_refclk_cfg0;
> @@ -516,6 +516,7 @@ static struct pci_ops tegra_pcie_ops =3D {
> =20
>  static unsigned long tegra_pcie_port_get_pex_ctrl(struct tegra_pcie_port=
 *port)
>  {
> +	const struct tegra_pcie_soc *soc =3D port->pcie->soc;
>  	unsigned long ret =3D 0;
> =20
>  	switch (port->index) {
> @@ -528,7 +529,7 @@ static unsigned long tegra_pcie_port_get_pex_ctrl(str=
uct tegra_pcie_port *port)
>  		break;
> =20
>  	case 2:
> -		ret =3D AFI_PEX2_CTRL;
> +		ret =3D soc->afi_pex2_ctrl;
>  		break;
>  	}
> =20
> @@ -2439,6 +2440,7 @@ static const struct tegra_pcie_soc tegra20_pcie =3D=
 {
>  	.num_ports =3D 2,
>  	.ports =3D tegra20_pcie_ports,
>  	.msi_base_shift =3D 0,
> +	.afi_pex2_ctrl =3D 0x128,
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA20,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_DIV10,
>  	.pads_refclk_cfg0 =3D 0xfa5cfa5c,
> @@ -2548,6 +2550,7 @@ static const struct tegra_pcie_soc tegra186_pcie =
=3D {
>  	.num_ports =3D 3,
>  	.ports =3D tegra186_pcie_ports,
>  	.msi_base_shift =3D 8,
> +	.afi_pex2_ctrl =3D 0x19c,
>  	.pads_pll_ctl =3D PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel =3D PADS_PLL_CTL_TXCLKREF_BUF_EN,
>  	.pads_refclk_cfg0 =3D 0x80b880b8,
> --=20
> 2.17.1
>=20

--2wYUONsACSj9OMJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0h8AACgkQ3SOs138+
s6HcvRAAuPosCZSsiaNrAsPsKj5JdLdBSkQSa+kIKANfg/dontJT5KWNmwVIcTKe
x2R17zFUOUSL5W49kmtbYVzISiM05gyCDJv59D6HUSJbODob6oA8h9imRMwz+8nY
4VydqeF3r5GwplUChZrDmRNFKY7SPIssgLjaGArFQ0xv/qoY00Qc6u5tkK9WEWX/
aGdsDQ6wChrAhDhc8LR6xngRHOFYO4EWdpEGmlP/Y4KOxiNmWlmlo9Q0QXhXZ8Dr
WZSJeoYqmPI9oQX6JnR1bYwRUqPfP0nMcyLIZG7MEbFbjs7SrM7GPiqVEvYUOpJo
BMEEorS4Jo5B6KXKsHGM48dEdXT487OPpIonDSLvGNipTVsE0uGhcI96DMNMyUTA
w7kkTG+3JLT8uNsPR3SDEii2SCNzxL/Nd3eUoTpvLj7NX2twj40OCh/D/ZPxnUT3
iVXPVFbrXZwkHa2WqQVkbhie6iq36m704WN3JWZnxA1TlzC/r99tKwJSUk7SMRui
fltlxugdo1hejV5rbS/d4FvuSCvyTAhnrbqSGEzN08aLF2vSpFBn+gC2AcWHf66Z
1HhyPcKjuPkrVaowZoJByfZHn/azvW1wK+Hsn7cmsP9cUb2kclpi8sHR2t1rOdsC
+AwkwN7MdmZEJWQa0/SlhlaovkcvgdUiAJeL7PG51r7crFT7FPE=
=1fJC
-----END PGP SIGNATURE-----

--2wYUONsACSj9OMJp--
