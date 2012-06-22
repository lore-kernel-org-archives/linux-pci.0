Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60631 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761708Ab2FVIkp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 04:40:45 -0400
Date: Fri, 22 Jun 2012 08:06:57 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 08/10] ARM: tegra: harmony: Initialize regulators from
 DT
Message-ID: <20120622060657.GA15213@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
 <4FE3815C.8030505@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <4FE3815C.8030505@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2012 at 02:17:32PM -0600, Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > Device tree support for the TPS6586x PMU used on Harmony has recently
> > been added. This commit adds the required device tree nodes to probe the
> > PMU from the device tree.
>=20
> > diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/te=
gra-harmony.dts
>=20
> > +		tps6586x@34 {
> > +			compatible =3D "ti,tps6586x";
> > +			reg =3D <0x34>;
> > +			interrupts =3D <0 88 0x4>;
>=20
> I believe that should be interrupt 86 not 88.

Yes, you're absolutely correct.

Thierry

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP5AuBAAoJEN0jrNd/PrOhqVoQAJErzxQ2EbOzIBdTW1+AX91n
Oe5Y0gkjUBzBCbzqsgurvcXWOv8MxGLrSy3rBA+Zlf9pAiROBXQ4vdymVFLTnbh5
Zuj7aUxDKGeKwYzChBVVHLqc05pn5snEl/rVN/30w+9z3fv0f8OSGn1x9Ppn4vWN
cJUS0SRZ5GQRo7qidgcuKkYeIeenwf1bYZ0fczMO07S8x8BkzD+iVN2fVx49DtWm
Nw3A71ajsBYdZs82C0G1vQomvJJNsi8Sg1IKBAZ9/kn8DC+dbiMZXZaLi2YMFS3X
9Wzd913HDNn9ItJQmOvI2NzHGQkV/4GEk1fTD6BvlpgPBBtqJ80r0c6c0pXnUguD
+7+dGoGRiBgPuGLzFuGKLAsusTqzFRvso3evqZFJxamQRJqXWGO1QuUY3cW0DVWj
NfjwdDmFNg7yiR0dgNcu7BZDegKGp8qyiIRvHxAlu1qRkYVQMBj2K8f5s3zeXxev
DK5FvN7TSVE8opIjnamZrsCw7OUFjZH6PKDRy/wd/ULL4aRfsEWlxZGRaW5Y7nJw
WiNkP5BVQhZqEpqhfBIyKd8GBBOayRLsmrfnK9UP8x/D+z8BiP69ADPPUjP36e4z
S/NZA8hrJs7u54nYu5t3h4DNS4BGAbKWPSUaVKFDiV6pvGguI/7jhyb2FHk+CUAW
6ioOczican+2SbYSk4ch
=S7s2
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
