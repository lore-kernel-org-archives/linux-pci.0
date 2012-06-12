Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51297 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab2FLRUy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 13:20:54 -0400
Date: Tue, 12 Jun 2012 19:20:41 +0200
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
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
 <4FD66410.7090001@wwwdotorg.org>
 <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de>
 <4FD763C5.3090500@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <4FD763C5.3090500@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/12/2012 12:21 AM, Thierry Reding wrote:
> > * Stephen Warren wrote:
> >> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> >>> This commit adds support for instantiating the Tegra PCIe
> >>> controller from a device tree.
> >>=20
> >>> +++ b/Documentation/devicetree/bindings/pci/tegra-pcie.txt
> >>=20
> >> Can we please name this nvidia,tegra20-pcie.txt to match the
> >> naming of all the other Tegra bindings.
> >=20
> > Yes, will do.
> >=20
> >>> +Required properties: +- compatible: "nvidia,tegra20-pcie" +-
> >>> reg: physical base address and length of the controller's
> >>> registers
> >>=20
> >> Since there's more than one range now, that should specify how
> >> many entries are required and what they represent.
> >=20
> > Okay.
> >=20
> >>> +Optional properties: +- pex-clk-supply: supply voltage for
> >>> internal reference clock +- vdd-supply: power supply for
> >>> controller (1.05V)
> >>=20
> >> Those shouldn't be optional. If the board has no regulator, the
> >> board's .dts should provide a fixed always-on regulator that
> >> those properties can refer to, so that the driver can always
> >> get() those regulators.
> >=20
> > That'll add more dummy regulators and I don't think sprinkling them
> > across the DTS is going to work very well. Maybe collecting them
> > under a top-level "regulators" node is a good option. If you have a
> > better alternative, I'm all open for it.
> >=20
> >>> diff --git a/arch/arm/boot/dts/tegra20.dtsi
> >>> b/arch/arm/boot/dts/tegra20.dtsi
> >>=20
> >>> +	pci {
> >> ...
> >>> +		status =3D "disable";
> >>=20
> >> That should be "disabled"; sorry for providing a bad example.
> >=20
> > Yes.
> >=20
> >>> diff --git a/arch/arm/mach-tegra/pcie.c
> >>> b/arch/arm/mach-tegra/pcie.c
> >>=20
> >>> +static struct tegra_pcie_pdata *tegra_pcie_parse_dt(struct
> >>> platform_device *pdev)
> >>=20
> >>> +	if (of_find_property(node, "vdd-supply", NULL)) {
> >>=20
> >> As mentioned above, that if statement should be removed, since
> >> the regulators shouldn't be optional.
> >=20
> > Okay.
> >=20
> >>> +		pcie->vdd_supply =3D regulator_get(&pdev->dev, "vdd");
> >>=20
> >> Those could be devm_regulator_get(). Then tegra_pcie_remove()
> >> wouldn't have to put() them.
> >=20
> > Okay.
> >=20
> >>> +	for (i =3D 0; i < TEGRA_PCIE_MAX_PORTS; i++) +
> >>> pdata->enable_ports[i] =3D true;
> >>=20
> >> Shouldn't the DT indicate which ports are used? I assume there's
> >> some reason that the existing driver allows that to be
> >> configured, rather than always enabling all ports. At least,
> >> enumeration time wasted on non-existent ports springs to mind,
> >> and perhaps attempting to enable port 1 when port 0 is x4 and
> >> using all the lanes would cause errors in port 0?
> >=20
> > Yes, that's been on my mind as well. I'm not sure about the best
> > binding for this. Perhaps something like:
> >=20
> > pci { enable-ports =3D <0 1 2>; };
> >=20
> > Would do?
>=20
> That seems reasonable, although since the property is presumably
> something specific to the Tegra PCIe binding, not generic, I think it
> should be nvidia,enable-ports.

I came up with the following alternative:

	pci {
		compatible =3D "nvidia,tegra20-pcie";
		reg =3D <0x80003000 0x00000800   /* PADS registers */
		       0x80003800 0x00000200   /* AFI registers */
		       0x80004000 0x00100000   /* configuration space */
		       0x80104000 0x00100000   /* extended configuration space */
		       0x80400000 0x00010000   /* downstream I/O */
		       0x90000000 0x10000000   /* non-prefetchable memory */
		       0xa0000000 0x10000000>; /* prefetchable memory */
		interrupts =3D <0 98 0x04   /* controller interrupt */
		              0 99 0x04>; /* MSI interrupt */
		status =3D "disabled";

		ranges =3D <0x80000000 0x80000000 0x00002000   /* 2 root ports */
			  0x80004000 0x80004000 0x00100000   /* configuration space */
			  0x80104000 0x80104000 0x00100000   /* extended configuration space */
			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */

		#address-cells =3D <1>;
		#size-cells =3D <1>;

		port@80000000 {
			reg =3D <0x80000000 0x00001000>;
			status =3D "disabled";
		};

		port@80001000 {
			reg =3D <0x80001000 0x00001000>;
			status =3D "disabled";
		};
	};

The "ranges" property can probably be cleaned up a bit, but the most
interesting part is the port@ children, which can simply be enabled in board
DTS files by setting the status property to "okay". I find that somewhat mo=
re
intuitive to the variant with an "enable-ports" property.

What do you think of this?

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/XemkACgkQZ+BJyKLjJp90rwCfRYTbXWPgQGa/veupCqvN6ZN2
eLgAoKlIwt5emH7f2jggIPM2ckIBOtAb
=cguu
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
