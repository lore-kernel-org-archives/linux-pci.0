Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53681 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab2CIGbi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Mar 2012 01:31:38 -0500
Date: Fri, 9 Mar 2012 07:31:16 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
Message-ID: <20120309063115.GA25208@avionic-0098.mockup.avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <4F59253D.7070100@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 03/08/2012 07:51 AM, Thierry Reding wrote:
> > This commit adds support for instantiating the Tegra PCIe controller
> > from a device tree.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>=20
> > diff --git a/Documentation/devicetree/bindings/pci/tegra-pcie.txt b/Doc=
umentation/devicetree/bindings/pci/tegra-pcie.txt
>=20
> > +NVIDIA Tegra PCIe controller
> > +
> > +Required properties:
> > +- compatible: "nvidia,tegra20-pcie"
> > +- reg: physical base address and length of the controller's registers
> > +- interrupts: the interrupt outputs of the controller
> > +
> > +Optional properties:
> > +- pex-clk-supply: supply voltage for internal reference clock
> > +- vdd-supply: power supply for controller (1.05V)
>=20
> Mark, Liam,
>=20
> Should those *-supply properties really be optional? I got the
> impression talking to Mark in a different thread that all regulators
> should exist, although their implementation may be via a fixed
> regulator, with no GPIO, as determined by the board design.

If I read the TrimSlice code correctly, there is no regulator setup required
to make PCIe work there presumably because they hardwire the proper voltage=
s.
On the other hand, maybe a better solution in this case would be to use the
dummy regulator in those cases.

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9Zo7MACgkQZ+BJyKLjJp+/iwCgiDXU0dcQ1FjrN2HsjdQOr5t/
9GEAn0zL3ekkbOzXL9+9lWi7StLwDECy
=000z
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
