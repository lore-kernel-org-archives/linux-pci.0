Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794247449;
	b=XRneDcH/fdUqiO/mB6q6v31ThTEY43nOI0SO4RzHvQKBqgrLl09WFABdmW+CxdM5XpPO
	 /Re08bjE/v9AgCPG9y23amhy7zErESXNoAeYPqnLA/IiVcyRjXq39xnCn6QcC98mCAoKx
	 +xssYVE8C8Q0uu2MdBvjPzijJKYcnhQYA3NoGyZZjpbw3y56zQ4vAgb3tzXKWWuhqPyDv
	 2v6LsGizpPr6jvJeud82/F261In5sj2rNhHZvOLhI+6stl7jDLyhD3XY88Tvxu01NkhBI
	 EIfJhR8Jdx6GIng1uCS0NGfcB2Tz27BIYiAbqH0vqLSHImgXLIiwixsYKKWxTkDPtGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247449;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=GEK25Zy3sFFqw428awFqsQCshEU6Oj5m/3/9wtN089s=;
	b=PXXaqvhorQYCDxWMGYTtHQYbXrgg4wk9Ftte/T5yM/8xpaUPGeoiSgemH7+MBLtA0LUl
	 ZkVClyBedhmPPTCAOFYXZoX0JcezY3b0QLOxgRu7cJVJrX/z+56XwHmpaGHvuZqT4dNRQ
	 B7udMXZYj0Q3DhqRbFszITPrbLZUeo5XvDI9V/LvqHic7AVNoXE9qkYmg7NvwZWNToaR+
	 qB4KmDEV88YrjrG6r7acvTO9KqqL8X7Evofne1f+/qDI5LuDUUMDYHUscyC2jitZqfJD+
	 Xf/jNe34yDW0HIDR94947urVgljilLNq5EPpbxIykE5dpDnNB5nHIw/Lq1hpOXIiU5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="E2/LHiXz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6007606A31C;
	Mon,  9 Nov 2026 18:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6007606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=E2/LHiXz
ARC-Seal: i=1; a=rsa-sha256; t=1794247409; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LGXErlNc2MViOsg+sBbACIsfieOYbD6JAOs4hpGhyln8li2sF6cR8/yQ3WxjVdSVfoutIl0dYrrQHQSsxCF69mD9p6smkbFgh8sg1KnXevDHZY59WzA5pvmQEG5TgL455fiXdMuaWNgUtlwfoSPMK88R4HKwR1RmIIZkLA/3PK0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794247409; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GEK25Zy3sFFqw428awFqsQCshEU6Oj5m/3/9wtN089s=; 
	b=WTHobyn4+/b60WlNVuyJV+PSJaYi7JYwz2i8Q2XoSr012E+23nezqXHdoEECVcP0aFRQFmso8eUIf0zMefu7ihtDAc523LWOAhQ7PrZlvBdTg6laqyFwMNGFMETsoB9Ix6UFEq6pBxo29KWMQ8fPa0I04moV4eJlF5v1i8dG0qo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=E2/LHiXzQPa2l/fMj7c24x/7Ro5+6yGnkj6ucD8Ls63q69MFmjBOPafYwZ9AOLMLa27Ew22yZrw99ZwYbNy2GkNh7mVm8WXXhcvofz8id5lHnMNMiBPdLJHPKwEykhnk/svxT60SeC48X8DBKiOTRdAR9AXsHH/9SxRfC2ZfGx4=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=GEK25Zy3sFFqw428awFqsQCshEU6Oj5m/3/9wtN089s=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794247406959126.89806918353611;
	Mon, 9 Nov 2026 10:03:26 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id B0DA8180317; Mon, 09 Nov 2026 19:03:21 +0100 (CET)
Date: Mon, 9 Nov 2026 19:03:21 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v9 1/9] PCI: dw-rockchip: Fix LTSSM set functions
Message-ID: <avIIMccXQyJiGiH6@venus>
References: <20261105-rockchip-pcie-system-suspend-v9-1-a2e55846649e@collabora.com>
 <20261109173329.GA252206@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paljnoslhkxoag7v"
Content-Disposition: inline
In-Reply-To: <20261109173329.GA252206@bhelgaas>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.7.7.1.5.4/291.452.71
X-ZohoMailClient: External


--paljnoslhkxoag7v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 1/9] PCI: dw-rockchip: Fix LTSSM set functions
MIME-Version: 1.0

Hi,

On Mon, Nov 09, 2026 at 11:33:29AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 05, 2026 at 02:33:09PM +0100, Sebastian Reichel wrote:
> > Before the Rockchip PCIe driver has been switched over to the
> > FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
> > PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc =3D 0b11=
00,
> > which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
> > with bit 3 being handled by a separate define named
> > PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
> > of this new macros resulting in the third bit not being set.
> >=20
> > Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro=
")
>=20
> This commit appeared in v6.18, so this looks like it might be a
> candidate for a stable tag?

IDK if its worth backporting. I mainly did not add the tag, since I
found this by chance while rebasing code around it. For my basic
tests I didn't notice any problems even without the bit. Also nobody
reported anything since v6.18. The bit was originally set since the
driver had been introduced. Maybe Shawn can say if its worth backporting?

Greetings,

-- Sebastian

>=20
> > Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pc=
i/controller/dwc/pcie-dw-rockchip.c
> > index bd86e32cc2b1..c35c5583c797 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -322,14 +322,16 @@ static void rockchip_pcie_ltssm_trace(struct rock=
chip_pcie *rockchip,
> > =20
> >  static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
> >  {
> > -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> > -				 PCIE_CLIENT_GENERAL_CON);
> > +	u32 val =3D PCIE_CLIENT_ENABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
> > +
> > +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
> >  }
> > =20
> >  static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
> >  {
> > -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
> > -				 PCIE_CLIENT_GENERAL_CON);
> > +	u32 val =3D PCIE_CLIENT_DISABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
> > +
> > +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
> >  }
> > =20
> >  static bool rockchip_pcie_link_up(struct dw_pcie *pci)
> >=20
> > --=20
> > 2.53.0
> >=20

--paljnoslhkxoag7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmryCuYACgkQ2O7X88g7
+pogbxAAp7uNHMud1soRc7aXKsYq8Hhj71CnA/0igLKhPz2fe9QBAQVtTB89jIcU
brCPZy3/1yY4VdnZkFZWxaCip+XoK2JzI5QKdzoT9YK5KQ5o28Qi0JeJEgi5BdPm
CMTLEg6ctaPRBpKllRV3Bn+2WiYatx+CnDSsRyWvnE+4oXg2mqsIHpJaUTVfN+Tp
JdAr1mSvTZVUw6MfOqk6Of8MFngTOB294cqYq7a65l27Snz+xG6kIGkGcYn04ffa
saelnMsjj70mS+h3qYtLVo2MOiUMYqEabJXlN++qnt3eTIdfT0zRItDztDKEdE/x
qsQ/Vo4hpfvBH2YjwCPPwt30iZwmCs8zOifkQz+Hb7FzyzRg39G7sMw69aO7qVit
Y8U4b6GiAXGZC9+bQ7hcURgdpH3Aq+qJtsb2tPs2MGmPCWYlMMMcHdxYHLG9l1yd
VVg1eSWEruxled/h6TU79ZuUWC5qO0asV6aookwlekGo2hgMrdLpIvTUr+3XygGI
SGaPsuLhSAveEXkoqGGFO0gXWN3aY3aDnSxvksZEjiTygaw9pmF1bBvfeo4tso9V
VCAVzrmkDsab86TF1qy89KOuaWAzXXNJ6lGMuGHCeEXPssT/cdA8vEIpbErYPaFi
oZIXu8VaDL1jTPN3YxbyTPnLw15ijtb2W/Dhv2NGJx/y2PBXnGQ=
=ATM0
-----END PGP SIGNATURE-----

--paljnoslhkxoag7v--
