Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52731 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab2FNJTa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2012 05:19:30 -0400
Date: Thu, 14 Jun 2012 11:19:06 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
References: <4FD763C5.3090500@wwwdotorg.org>
 <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de>
 <4FD7A36B.9090409@wwwdotorg.org>
 <4FD7B085.1020006@firmworks.com>
 <20120613064519.GD31001@avionic-0098.mockup.avionic-design.de>
 <4FD84133.4060401@firmworks.com>
 <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de>
 <4FD849CF.4030009@firmworks.com>
 <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <4FD85127.8050301@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <4FD85127.8050301@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2012 at 10:36:55PM -1000, Mitch Bradley wrote:
> On 6/12/2012 10:19 PM, Thierry Reding wrote:
> >On Tue, Jun 12, 2012 at 10:05:35PM -1000, Mitch Bradley wrote:
> >>On 6/12/2012 9:52 PM, Thierry Reding wrote:
> >>>I think the configuration spaces and downstream I/O ranges need to be =
in the
> >>>pcie-controller's reg property because they are remapped and used by t=
he
> >>>controller driver, not by the individual ports.
> >>>
> >>>That's probably not really necessary but rather a result of how the dr=
iver
> >>>was written. Perhaps the driver should handle them differently instead,
> >>>listing the regions in the ranges property of the parent and listing t=
he
> >>>corresponding partitions in the ranges properties of the pci child nod=
es.
> >>>
> >>>Like in the following, where the ranges property of the ports partitio=
n the
> >>>ranges passed from the parent evenly:
> >>>
> >>>	pcie-controller {
> >>>		compatible =3D "nvidia,tegra20-pcie";
> >>>		reg =3D<0x80003000 0x00000800   /* PADS registers */
> >>>		       0x80003800 0x00000200>; /* AFI registers */
> >>>		interrupts =3D<0 98 0x04   /* controller interrupt */
> >>>			      0 99 0x04>; /* MSI interrupt */
> >>>		status =3D "disabled";
> >>>
> >>>		ranges =3D<0x80000000 0x80000000 0x00002000   /* 2 root ports */
> >>>			  0x80004000 0x80004000 0x00100000   /* configuration space */
> >>>			  0x80104000 0x80100000 0x00100000   /* extended configuration spac=
e */
> >>>			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
> >>>			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
> >>>			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */
> >>>
> >>>		#address-cells =3D<1>;
> >>>		#size-cells =3D<1>;
> >>>
> >>>		pci@80000000 {
> >>>			reg =3D<0x80000000 0x00001000>;
> >>>			status =3D "disabled";
> >>>
> >>>			#address-cells =3D<3>;
> >>>			#size-cells =3D<2>;
> >>>
> >>>			ranges =3D<0x80400000 0x80400000 0x00008000   /* I/O */
> >>>				  0x90000000 0x90000000 0x08000000   /* non-prefetchable memory */
> >>>				  0xa0000000 0xa0000000 0x08000000>; /* prefetchable memory */
> >>
> >>You are on the right track here, but the format of the child-address
> >>portion of the above ranges property is incorrect.  Since the child
> >>address space is the PCI address space, the child-address portion
> >>needs to be 3 cells.  It's not a linear address but rather a triple.
> >>The first cell identifies the address type (config, I/O, memory..)
> >>and the second and third cells are offsets within that subspace.
> >>The second and third cells will typically be 0.  The PCI binding has
> >>details.
>=20
> Also, the size field in ranges is specified according to the child
> address space, so there must be 2 size cells in the ranges at this
> level.  Each ranges entry at this level is:
>=20
> <child_address_space, child_address_high, child_address_low,
> parent_address, child_size_high, child_size_low>
>=20
> The above should be:
>=20
> 			ranges =3D<0x81000000 0 0  0x80400000  0 0x00008000   /* I/O */
> 				 0x82000000 0 0  0x90000000  0 0x08000000   /* non-prefetchable memor=
y */
> 				 0xc2000000 0 0  0xa0000000  0 0x08000000>; /* prefetchable memory */
>=20
>=20

Okay, so the new pcie-controller node looks like this:

	pcie-controller {
		compatible =3D "nvidia,tegra20-pcie", "simple-bus";
		reg =3D <0x80003000 0x00000800   /* PADS registers */
		       0x80003800 0x00000200   /* AFI registers */
		       0x80004000 0x00100000   /* configuration space */
		       0x80104000 0x00100000>; /* extended configuration space */
		interrupts =3D <0 98 0x04   /* controller interrupt */
		              0 99 0x04>; /* MSI interrupt */
		status =3D "disabled";

		ranges =3D <0x80000000 0x80000000 0x00002000   /* 2 root ports */
			  0x80400000 0x80400000 0x00010000   /* downstream I/O */
			  0x90000000 0x90000000 0x10000000   /* non-prefetchable memory */
			  0xa0000000 0xa0000000 0x10000000>; /* prefetchable memory */

		#address-cells =3D <1>;
		#size-cells =3D <1>;

		pci@80000000 {
			compatible =3D "nvidia,tegra20-pcie-port";
			reg =3D <0x80000000 0x00001000>;
			status =3D "disabled";

			#address-cells =3D <3>;
			#size-cells =3D <2>;

			ranges =3D <0x81000000 0 0 0x80400000 0 0x00008000   /* I/O */
				  0x82000000 0 0 0x90000000 0 0x08000000   /* non-prefetchable memory */
				  0xc2000000 0 0 0xa0000000 0 0x08000000>; /* prefetchable memory */

			nvidia,ctrl-offset =3D <0x110>;
			nvidia,num-lanes =3D <2>;
		};

		pci@80001000 {
			compatible =3D "nvidia,tegra20-pcie-port";
			reg =3D <0x80001000 0x00001000>;
			status =3D "disabled";

			#address-cells =3D <3>;
			#size-cells =3D <2>;

			ranges =3D <0x81000000 0 0 0x80408000 0 0x00008000   /* I/O */
				  0x82000000 0 0 0x98000000 0 0x08000000   /* non-prefetchable memory */
				  0xc2000000 0 0 0xa8000000 0 0x08000000>; /* prefetchable memory */

			nvidia,ctrl-offset =3D <0x118>;
			nvidia,num-lanes =3D <2>;
		};
	};

While looking into some more code, trying to figure out how to hook this all
up with the device tree I ran into a problem. I need to actually create a
'struct device' for each of the ports, so I added the "simple-bus" to the
pcie-controller's "compatible" property. Furthermore, each PCI root port now
becomes a platform_device, which are supported by a new tegra-pcie-port
driver. I'm not sure if "port" is very common in PCI speek, so something li=
ke
tegra-pcie-bridge (compatible =3D "nvidia,tegra20-pcie-bridge") may be more
appropriate?

Using real platform devices is not only more straightforward (each bridge is
after all a separate parent for the PCI endpoints) but it also has the
advantage that the bridges are properly hooked up with the device tree. If I
read the code correctly, passing the 'struct device' to pci_scan_root_bus()
will allow the PCI core code to set up the proper pointers that allow busses
and endpoints below each bridge to be matched to the corresponding DT nodes.

However this causes other problems with the initialization of the PCIe
controller. The translations cannot be setup and the controller shouldn't be
enabled until after all the ports have been probed because it isn't clear
which of them are really active and which are not. For the DT case this can
probably be done by parsing the device tree and collecting the information,
but for the non-DT case this will probably be more difficult.

To solve this for both cases I could probably use device_for_each_child() a=
nd
check that all children have been properly probed before setting up the
translations and enabling the controller. That leaves the question of how to
verify that a device has been correctly probed. The easiest would probably =
be
to check if dev_get_drvdata() !=3D NULL, but I'm still trying to decide whe=
ther
that's too ugly or not. I don't know of any other way to determine that
probing was successful. In addition it may still be useful to continue if o=
ne
of the devices failed to initialize (the link on only one of two enabled
ports is up).

Thierry

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/ZrIkACgkQZ+BJyKLjJp9VUACfctmGLalLNVYfIILgqwdCVGUt
r74AnRiTHWG0qNAkv2dY1Doxkdn037Lh
=Cdse
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
