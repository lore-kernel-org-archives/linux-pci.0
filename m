Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3A384CED;
	Thu, 27 Aug 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850704; cv=none; b=UELXg0X0HoKiYPDFdMtowlw2RWZrzqG+ZRd2Rf3YN/pImkgl1cRoL2s8hw3gk9/55vAt7TM2P4bH3jEQqPjckCVaM16y/9E5eFPiDYbsJ49BRbu/8Etsz5G+BKVca51fqGZpIfGrwk/fA2tuQEkhh6/NJh+z0uU7O0WWby+mCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850704; c=relaxed/simple;
	bh=86ZT2IGdd+PIBUlBJtEqWTdUTpXMHqL7yEPDDjtRa4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHYC9Sf8WgG52aK8t6im9SZE9Q3m8mNcqDpo9jXd6SlQ1FkekjqCwpsEBRTIBCZpFB9HvD4EIbckY5DBdI1G7YpoF3LVuMCoNuam73xmBZDPKNzSh2ZUtt1idMB7QKCYnhMT4EwTH/OLDDeKJcX1C7k+/UpLeo++aCDkYcUAzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgP1XOGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgP1XOGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C4F1F000E9;
	Thu, 27 Aug 2026 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850703;
	bh=9SIWsWNZtyk+ocf2n57ttbETYT/nmYA8uXU6Y6VqOds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fgP1XOGhxvruys1kK1AA6zGdarHWRG4G7rTbGHsb4aGi8AkseCXBzzc6DFERwJeMR
	 kXgUjI514VV83dfD5IAogfHeVBhomQEzWDF9HELACxXXHm1Lhq15SXSWgiWUtKhRu4
	 QZCqnBj+3KWMjyfSxUTKdS4Esm2L5PZK+myIqVNIzgNPJ8PXTwFFVtphYYhWZ3n8l4
	 fFtC9/SZ0UN8J2cvE850muyzpYTqWMKfD3cDZR+WCzKXY4LQWzwrW47132sq+D/E8a
	 n/CFVQUr5XJkM+JfmMvQl0msx0xKTqqslzOQdtoKLSr0tm8ileJD5JhJCRG/FPp4um
	 71PCZwseyhO2A==
Date: Thu, 27 Aug 2026 19:11:40 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linmao Li <lilinmao@kylinos.cn>, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	jonathanh@nvidia.com, mmaddireddy@nvidia.com, linux-tegra@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
Message-ID: <apBviM9V7LuhBQ6s@orome>
References: <20260827093919.2825467-1-lilinmao@kylinos.cn>
 <20260827170358.GA1610989@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zfknovasfm7vepdt"
Content-Disposition: inline
In-Reply-To: <20260827170358.GA1610989@bhelgaas>


--zfknovasfm7vepdt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] PCI: tegra264: Fix Link Capabilities register offset
MIME-Version: 1.0

On Thu, Aug 27, 2026 at 12:03:58PM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 27, 2026 at 05:39:19PM +0800, Linmao Li wrote:
> > The PCI Express Link Capabilities and Link Status registers are at offs=
ets
> > 0x0c and 0x12 from the capability header, respectively.  Since the driv=
er
> > uses 0x5a for Link Status, Link Capabilities starts at 0x54, not 0x56.
> >=20
> > Reading a 16-bit value at 0x56 returns the upper half of the Link
> > Capabilities register.  When a hotplug-capable port has no link during
> > probe, tegra264_pcie_icc_set() consequently derives the maximum speed a=
nd
> > width from unrelated bits and requests the wrong interconnect bandwidth.
> >=20
> > Use the correct Link Capabilities offset.
> >=20
> > Fixes: 01c3c27a0ef6 ("PCI: tegra264: Add Tegra264 support")
> > Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> > ---
> >  drivers/pci/controller/pcie-tegra264.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/contr=
oller/pcie-tegra264.c
> > index 653136db401e0..3a672d18c4d2d 100644
> > --- a/drivers/pci/controller/pcie-tegra264.c
> > +++ b/drivers/pci/controller/pcie-tegra264.c
> > @@ -49,7 +49,7 @@
> >  #define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
> > =20
> >  /* XTL registers */
> > -#define XTL_RC_PCIE_CFG_LINK_CAPS		0x56
> > +#define XTL_RC_PCIE_CFG_LINK_CAPS		0x54
> >  #define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
>=20
> If this is a standard PCIe Capability, and since we use the standard
> #defines like PCI_EXP_LNKSTA_CLS and PCI_EXP_LNKCAP_SLS for values
> read from it, it appears to be, I think these XTL_RC* #defines should
> somehow be based on the existing PCI_EXP_LNKSTA and PCI_EXP_LNKCAP.
>=20
> E.g., we could read from pcie->ecam + XTL_RC_PCIE_CAP + PCI_EXP_LNKSTA.
> That way grep would be more useful.

That's a good point. And, yes, this does look like a regular PCIe
capability, so I'll try to rework this using the standard defines.

Thierry

--zfknovasfm7vepdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqQb8wACgkQ3SOs138+
s6ExbxAAgOICpQPLCVLTSkHurvtlJtIlgp8PBBIqr2JuBkCNSMLevtDCtPDbdKDN
aNFJuGv/PS2uEmCkSC3U1m/tgdWXLmToY3Uy+8EyWZNnA8JxlDnli6R+xLVOEJhp
TG4AfsuVvC3Vvs3tRNXrtcaPt6p5DIlgpPcWIycMoC/naXEYYX3Q4qjTeTIshiZ3
9KidHj0m3MT3SsClmovcVV1WVFP/vq1YFt+74UexUUd9E5CMIMbhVjxgq5P3zBkR
bTpb4I8aewF3cf+BMJT3JqTVwJsQdjqvtGwCQehj7ZkMbs8OibypFIzfdAyTwGUJ
NmVuGuddGSvSrJMQVa0wgpgH9eqOtlTLWDgmkWGkh61UFQlDdmBFJ+ciYojlE4ea
1HTuYl0a6pbmUVCXaOohfKWyDBYe+GZqCICgQYSh8TUK4VQs/2gfJAXrMbHSpGo8
Nz14l2VxPBBfaqyRPwbmpM9RbSrDCYEC0D8r/YbXD0E8YJ+z3LhPnl6mx2Y04lbw
CcsvkIfDPmIU41WBgvpcW5P2Vg02P2lB5wRdoUfF6Zb84JLOz2LG5YPRAozrRuTH
9joMBhQZoA9Wp2ty4VNogC3KvJm82lKZSQ5mQi8apl7W2LoZ4sIenonM7A9OvvLa
/sp9BEQ5/o1rYMHFlmTwJCfymu/5ScLYLhQrAHya/Esb0weGTE8=
=jFS0
-----END PGP SIGNATURE-----

--zfknovasfm7vepdt--
