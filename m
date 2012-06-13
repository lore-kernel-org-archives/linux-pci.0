Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59439 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab2FMGe1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2012 02:34:27 -0400
Date: Wed, 13 Jun 2012 08:34:22 +0200
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
Message-ID: <20120613063422.GC31001@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de>
 <4FD66410.7090001@wwwdotorg.org>
 <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de>
 <4FD763C5.3090500@wwwdotorg.org>
 <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de>
 <4FD7A36B.9090409@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
In-Reply-To: <4FD7A36B.9090409@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 06/12/2012 11:20 AM, Thierry Reding wrote:
> ...
> > I came up with the following alternative:
> >=20
> > 	pci {
> > 		compatible =3D "nvidia,tegra20-pcie";
> > 		reg =3D <0x80003000 0x00000800   /* PADS registers */
> > 		       0x80003800 0x00000200   /* AFI registers */
> > 		       0x80004000 0x00100000   /* configuration space */
> > 		       0x80104000 0x00100000   /* extended configuration space */
> > 		       0x80400000 0x00010000   /* downstream I/O */
> > 		       0x90000000 0x10000000   /* non-prefetchable memory */
> > 		       0xa0000000 0x10000000>; /* prefetchable memory */
> > 		interrupts =3D <0 98 0x04   /* controller interrupt */
> > 		              0 99 0x04>; /* MSI interrupt */
> > 		status =3D "disabled";
> >=20
> > 		ranges =3D <0x80000000 0x80000000 0x00002000   /* 2 root ports */
> > 			  0x80004000 0x80004000 0x00100000   /* configuration space */
> > 			  0x80104000 0x80104000 0x00100000   /* extended configuration space=
 */
> > 			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
> > 			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
> > 			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
> >=20
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> >=20
> > 		port@80000000 {
> > 			reg =3D <0x80000000 0x00001000>;
> > 			status =3D "disabled";
> > 		};
> >=20
> > 		port@80001000 {
> > 			reg =3D <0x80001000 0x00001000>;
> > 			status =3D "disabled";
> > 		};
> > 	};
> >=20
> > The "ranges" property can probably be cleaned up a bit, but the most
> > interesting part is the port@ children, which can simply be enabled in =
board
> > DTS files by setting the status property to "okay". I find that somewha=
t more
> > intuitive to the variant with an "enable-ports" property.
> >=20
> > What do you think of this?
>=20
> As a general concept, this kind of design seems OK to me.
>=20
> The "port" child nodes I think should be named "pci@..." given Mitch's
> comments, I think.
>=20
> The port nodes probably need two entries in reg, given the following in
> our downstream driver:
>=20
> >         int rp_offset =3D 0;
> >         int ctrl_offset =3D AFI_PEX0_CTRL;
> ...
> >         for (port =3D 0; port < MAX_PCIE_SUPPORTED_PORTS; port++) {
> >                 ctrl_offset +=3D (port * 8);
> >                 rp_offset =3D (rp_offset + 0x1000) * port;
> >                 if (tegra_pcie.plat_data->port_status[port])
> >                         tegra_pcie_add_port(port, rp_offset, ctrl_offse=
t);
> >         }
>=20
> (which actually looks likely to be horribly buggy for port>1 and only
> accidentally correct for port=3D=3D1, but anyway...)

Yeah, I currently have code that gets the port index and the reset register
offset (ctrl_offset above) from the port address. It feels rather hackish,
though.

> But instead, I'd be tempted to make the top-level node say:
>=20
> 	#address-cells =3D <1>;
> 	#size-cells =3D <0>;
>=20
> ... so that the child nodes' reg is just the port ID. The parent node
> can calculate the addresses/offsets of the per-port registers within the
> PCIe controller's register space based on the ID using code roughly like
> what I quoted above:
>=20
> 	pci@0 {
> 		reg =3D <0>;
> 		status =3D "disabled";
> 	};
>=20
> 	pci@1 {
> 		reg =3D <0>;
> 		status =3D "disabled";
> 	};
>=20
> That would save having to put 2 entries in the reg, and perhaps remove
> the need for any ranges property.
>=20
> I think you also need a property to specify the exact port layout; the
> Tegra20 controller supports:
>=20
> 1 x4 port
> 2 x2 ports (you can choose to use only 1 of these I assume)
>=20
> So just because only 1 of the ports is enabled, doesn't imply it's x4;
> it could still be x2.
>=20
> Tegra30 has more options.

Both the upstream and downstream drivers currently hard-code this to dual a=
nd
411 (I assume that means 1x4, 2x1?) configurations for Tegra20 and Tegra30
respectively. Unfortunately the register AFI_PCIE_CONFIG isn't documented on
Tegra20 at all and for Tegra30 lists only the valid configurations (see
28.4.1.5 PCIe CONFIG) but not the corresponding encodings.

Maybe a good name for the new property would be "num-lanes". I also wonder =
if
this property would be better off in the parent node, which would make it
easier to check for valid configurations. Otherwise the code would have to
collect the settings of all the ports and check if the combination is valid.
Then again, having num-lanes in the parent with one cell for each controller
isn't very nice if each controller can be individually disabled.

One other thing: in addition to the device tree binding, this will all have=
 to
be represented in the platform data as well to support the legacy board
definitions currently in the tree. But instead of adding all of these chang=
es
to the patch that converts the code to a driver, I'm thinking it might be
better to split these additions off into one or more separate patches. Do y=
ou
have any objections?

Thierry

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/YNG4ACgkQZ+BJyKLjJp/CTACeOqvpFDgcIv5ngk3kKDHk59uR
/rUAn1asCjK2yW4mnNRJhKvkM4NU6jJh
=J+yo
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
