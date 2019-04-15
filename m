Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DEDC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769622075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwveMJNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfDOPg4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:36:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43952 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfDOPgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:36:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so17882179wrx.10;
        Mon, 15 Apr 2019 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gr3YtSUj1TrX69+fUEeyHni6Ey3jsHXXZfZB/FinZzw=;
        b=JwveMJNRRubx4e5CdDkWMjmfbWFiCkIQ3da1/jJZakBRFjSu+WUJrFywZ+fgvg+Bfq
         u7V1NeGBMkf+v+z+CdpBUyzuWJyhqOKWdvmRRYgmWPn0NwH/PHkZX1UiWG04SIZNX9Df
         nX56Y3LuBXWcu2AZ03PKyA3cPQExk+KCQiA0O9tuiBt3cMPF6i48Q56TiOZxqTHSCfBO
         hWioQtb6L9ApV56Up3+AwOMtwjud9e1YIUWs+8s9N/4GGrwK5WA1eER/09cMloXZdGs7
         lw26jk/cxWWQhuBd8vt40ZpRJsz62/QNi7KevtDc6pZ4enrLGtwFEOuSGyQAMwyCYGw1
         xWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gr3YtSUj1TrX69+fUEeyHni6Ey3jsHXXZfZB/FinZzw=;
        b=NH5WcfY+KurM07UnQU0th9+8TQNAz/pLWst5PU/KmP4qg6Adh4DFD6NWkezodMO9Po
         4XkxrqhHEq+Cyl8eamzUjTBE5krRh9n2oGz8hN6CuxEISM/VBpTs1zlS4DI8FTHOgtuy
         x5SX3Nccu6mtUmHFzIDKjmPHFWXjB6vohIpQ7KBXf6spwLXIW+QMWBn66yVfVAVfKExo
         TXPG0JM4uHe8cgmbBi89YoVo9rIIfb+AZLFAoA2gPzAkAIg6EkVD0yDCF8nbykKsdzoz
         lrrVtQpcLBKvVs/wPKlO5gULhz3Zkj4G8KyVOnGsQCHQ+sbcAXdat7mS8/JVM6uv2xE7
         vaiA==
X-Gm-Message-State: APjAAAWYdVOQEBlKxBqzUEpS5Fis1WGlc9Dm8QsjyJQ3l5n8QlAcU7zs
        599d0dcJmGKORWk/9sbdruw=
X-Google-Smtp-Source: APXvYqx0GnUlFQJkKj3blz/ORvLrTB/U8f1rnXvAa5jk48Jqvl7uIOFHOMOhKCBDO3u2RnX4fD/oOg==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr1856439wru.34.1555342612825;
        Mon, 15 Apr 2019 08:36:52 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id o20sm17044727wmh.21.2019.04.15.08.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:36:51 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:36:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, lorenzo.pieralisi@arm.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 04/30] PCI: tegra: Add PCIe Gen2 link speed support
Message-ID: <20190415153651.GL29254@ulmo>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-5-mmaddireddy@nvidia.com>
 <20190415112108.GE29254@ulmo>
 <5b3b5882-b841-658b-57dd-1572f20dab69@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibe32dcbQs37CEZO"
Content-Disposition: inline
In-Reply-To: <5b3b5882-b841-658b-57dd-1572f20dab69@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ibe32dcbQs37CEZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 08:17:02PM +0530, Manikanta Maddireddy wrote:
>=20
>=20
> On 15-Apr-19 4:51 PM, Thierry Reding wrote:
> > On Thu, Apr 11, 2019 at 10:33:29PM +0530, Manikanta Maddireddy wrote:
> >> Tegra124, 132, 210 and 186 support Gen2 link speed. After PCIe link is=
 up
> >> in Gen1, set target link speed as Gen2 and retrain link. Link switches=
 to
> >> Gen2 speed if Gen2 capable end point is connected, else link stays in =
Gen1.
> >>
> >> Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait =
for
> >> PCIe LTSSM to come back from recovery before retraining the link.
> >>
> >> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> >> ---
> >>  drivers/pci/controller/pci-tegra.c | 61 ++++++++++++++++++++++++++++++
> >>  1 file changed, 61 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controll=
er/pci-tegra.c
> >> index a61ce9d475b4..6ccda82735f8 100644
> >> --- a/drivers/pci/controller/pci-tegra.c
> >> +++ b/drivers/pci/controller/pci-tegra.c
> >> @@ -191,6 +191,8 @@
> >>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
> >>  #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
> >> =20
> >> +#define RP_LINK_CONTROL_STATUS_2		0x000000b0
> >> +
> >>  #define PADS_CTL_SEL		0x0000009c
> >> =20
> >>  #define PADS_CTL		0x000000a0
> >> @@ -2096,6 +2098,62 @@ static void tegra_pcie_apply_pad_settings(struc=
t tegra_pcie *pcie)
> >>  		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
> >>  }
> >> =20
> >> +#define LINK_RETRAIN_TIMEOUT 100000
> > This is oddly placed. I think this should go somewhere near the top of
> > the file. We already have PME_ACK_TIMEOUT there.
> >
> > But to be honest, I wouldn't even bother with the #define. This is used
> > exactly twice and is much longer to type than the actual number.
> I will move #define to top of the file. Macro name tells us what this tim=
eout,
> so I will keep the macro intact.
> >
> >> +
> >> +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
> >> +{
> >> +	struct device *dev =3D pcie->dev;
> >> +	struct tegra_pcie_port *port, *tmp;
> >> +	ktime_t deadline;
> >> +	u32 val;
> > The driver uses u32 value for register values elsewhere. It'd be good to
> > stay consistent with that convention.
> Do you mean "unsigned long"? I observed this discrepancy, in few places u=
32 is used
> and in some places "unsigned long" is used to store register value. I am =
continuing
> to u32 and we need a new patch to change all "unsigned long" variables to=
 u32
> which are used to store register values.

I meant to say that we spell out "value" everywhere else and don't use
the abbreviation.

Thierry

--ibe32dcbQs37CEZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0pRIACgkQ3SOs138+
s6E+nA/9H+C986Imhbwm6cj3MeW7zZ1emzTswJYQwPC6fDRVSUppKOsey4Y2y1K6
FhaO6r7UnSw3VFCnp/Kc0kOeY2bo5CTuZ4VGktkI9nIi17yySNYGRVC81lAcyPkT
IpQzo0HAMworCbsZehB+eTXwAz4NNERicfam6trwTVqvFA9fka59uO2DVkNfD7fL
IuZDYmokaimD9cGx/Pice8TWNAiLLBwD1zuvcPGlfP89M5jaqhH9oD6XmjWNbcuj
wn3qEiYXQjLa1JUIgAUCJp5Ad3Ret2Xc4Y2FxDUn9dD6qYLuKjCVVLk0OCs2/QxN
4F04rwW+iWF6uz/D1JZU9FZKhaPE5Dn6MlWJYAaycyxZCEYPdRcgA2vlFxbERQVw
Fk/zjaZZ0MAxpps7jDa4SuOfpUsBQLvhszDcbGYkWSfbx8MDuN6RHpn/0NuXpQeh
8VH1Ue69DkHvAEHuVyZSLtLIqcAoPm7QNz1+deQ8twWw8n6f3MWdifNhVRzWRqxV
Wq69V+Pi+Y+MdslS4/P9FUMrZVMdIkkU2xZ5kp+uEhXG9Kvfzp64DeqmOnzA02h8
tKtl6pVSr3tkS32Ps3etT/odU5b+YdmOND8JsVjgtm4AGPIbJTLX47FboyrKM1NI
84/ZIVDmO2VdjEMVjWM+XmQw4qyZyWSYPD9dK2rCiEAE2SoF93o=
=4VFJ
-----END PGP SIGNATURE-----

--ibe32dcbQs37CEZO--
