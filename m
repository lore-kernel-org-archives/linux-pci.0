Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10355 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbaDHTzh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 15:55:37 -0400
Date: Tue, 8 Apr 2014 21:54:42 +0200
From: Thierry Reding <treding@nvidia.com>
To: Stephen Warren <swarren@wwwdotorg.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Ian Campbell" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC 2/5] ARM: tegra: Add new PCIe regulator properties
Message-ID: <20140408195442.GB21978@ulmo.nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <1396622969-17837-3-git-send-email-treding@nvidia.com>
 <53444B2D.8050209@wwwdotorg.org>
MIME-Version: 1.0
In-Reply-To: <53444B2D.8050209@wwwdotorg.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2014 at 09:17:01PM +0200, Stephen Warren wrote:
> On 04/04/2014 08:49 AM, Thierry Reding wrote:
> > These new properties more accurately reflect the real connections of the
> > boards and therefore make it easier to match them up with schematics.
>=20
> > diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/=
tegra30-cardhu.dtsi
>=20
> >  	pcie-controller@00003000 {
> >  		status =3D "okay";
> > +
> > +		/* AVDD_PEXA and VDD_PEXA are grounded on Cardhu. */
>=20
> Perhaps add the word "inputs" before "are"?

Done. Thanks,

Thierry

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRFQCAAoJEN0jrNd/PrOhqFwP+QGKyQg9Dp/eqINyGpUKlEqs
XzCf7Bs5ZlYqlLpEmFtKRv1xsTC3k7nlb9a4lrj1CNMnVZBIXerDvF0Dzt0DE89g
sqccl86mR4lpprYZV2doHjA1+ASv2qbwfd9BXwUvFoo9F3re4bHlFZ/bwVAoswnA
tzDigrGmysF9cyxBxaHrpZdlK3GxQm4RW7riIeeY3Fv4LJa7RGcrFOkJ29bujSLD
gbgMOCzOgfGmSAxhhDa2KDV2xTu03HoNteI90OYONWsWbuNnSLLeQx/2fob+9r/c
tmwIlruvhNb89xXStlwHu8DvwuFFt2uIyA5oG9fPLLRfz9Xyvc7ar5ofeW4J5qRO
dzDoWjuGKsiaXc0dAfLBVHmJI2WsXHKqJA95l2oJTVFKivBiqegOXyTiQbFXMFBs
40TDMgA1alHheRSyzfgUSNVjaMMudUaEjQdjnnDFm26HCfb8Pz4JVl0OGdG361l5
Fq6gsIFC3N9dc6ytXMYaiDecTjmo3utJvpCMrc/UFedmf3ALyXLuGweZnq1ftM53
L7pW1TMm2FsgB67egthNw/J9141GGZBEZH6Owe94fVBZQgeIAIUdek9skvVDnE25
bqcXTgLLNrFqATKbFWOeKC0Q7PslyPU34rZWiJHuczgJIjUp2rNSHGddxDAzs3lk
1cjHK0GuXyKZjNEO3hyV
=w+ep
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
