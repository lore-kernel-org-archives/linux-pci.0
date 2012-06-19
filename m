Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62578 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab2FSNa1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jun 2012 09:30:27 -0400
Date: Tue, 19 Jun 2012 15:30:01 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de>
References: <4FD84133.4060401@firmworks.com>
 <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de>
 <4FD849CF.4030009@firmworks.com>
 <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de>
 <4FD85127.8050301@firmworks.com>
 <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de>
 <4FDA2DDA.1030704@wwwdotorg.org>
 <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de>
 <4FDA40A0.4030206@wwwdotorg.org>
 <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
In-Reply-To: <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2012 at 08:12:36AM +0200, Thierry Reding wrote:
> On Thu, Jun 14, 2012 at 01:50:56PM -0600, Stephen Warren wrote:
> > On 06/14/2012 01:29 PM, Thierry Reding wrote:
> > > On Thu, Jun 14, 2012 at 12:30:50PM -0600, Stephen Warren wrote:
> > >> On 06/14/2012 03:19 AM, Thierry Reding wrote:
> > ...
> > >>> #address-cells =3D <1>; #size-cells =3D <1>;
> > >>>=20
> > >>> pci@80000000 {
> > >>=20
> > >> I'm still not convinced that using the address of the port's
> > >> registers is the correct way to represent each port. The port
> > >> index seems much more useful.
> > >>=20
> > >> The main reason here is that there are a lot of registers that
> > >> contain fields for each port - far more than the combination of
> > >> this node's reg and ctrl-offset (which I assume is an address
> > >> offset for just one example of this issue) properties can
> > >> describe. The bit position and bit stride of these fields isn't
> > >> necessarily the same in each register. Do we want a property like
> > >> ctrl-offset for every single type of field in every single shared
> > >> register that describes the location of the relevant data, or
> > >> just a single "port ID" bit that can be applied to anything?
> > >>=20
> > >> (Perhaps this isn't so obvious looking at the TRM since it
> > >> doesn't document all registers, and I'm also looking at the
> > >> Tegra30 documentation too, which might be more exposed to this -
> > >> I haven't correlated all the documentation sources to be sure
> > >> though)
> > >=20
> > > I agree that maybe adding properties for each bit position or
> > > register offset may not work out too well. But I think it still
> > > makes sense to use the base address of the port's registers (see
> > > below). We could of course add some code to determine the index
> > > from the base address at initialization time and reuse the index
> > > where appropriate.
> >=20
> > To me, working back from address to ID then using the ID to calculate
> > some other addresses seems far more icky than just calculating all the
> > addresses based off of one ID. But, I suppose this doesn't make a huge
> > practical difference.
>=20
> This really depends on the device vs. no device decision below. If we can
> make it work without needing an extra device for it, then using the index
> is certainly better. However, if we instantiate devices from the DT, then
> we have the address anyway and adding the index as a property would be
> redundant and error prone (what happens if somebody sets the index of the
> port at address 0x80000000 to 2?).

An additional problem with this is that we'd have to add the following
to the pcie-controller node:

	#address-cells =3D <1>;
	#size-cells =3D <0>;

This will conflict with the "ranges" property, because suddenly we can
no longer map the regions properly. Maybe Mitch can comment on whether
this is possible or not?

To make it clearer what I'm talking about, here's the DT snippet again
(with the compatible property removed from the pci@ nodes because they
are no longer probed by a driver, the "simple-bus" removed from the
pcie-controller node's compatible property removed and its #address-
and #size-cells properties adjusted as described above).

	pcie-controller {
		compatible =3D "nvidia,tegra20-pcie";
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
		#size-cells =3D <0>;

		pci@0 {
			reg =3D <2>;
			status =3D "disabled";

			#address-cells =3D <3>;
			#size-cells =3D <2>;

			ranges =3D <0x81000000 0 0 0x80400000 0 0x00008000   /* I/O */
				  0x82000000 0 0 0x90000000 0 0x08000000   /* non-prefetchable memory */
				  0xc2000000 0 0 0xa0000000 0 0x08000000>; /* prefetchable memory */

			nvidia,ctrl-offset =3D <0x110>;
			nvidia,num-lanes =3D <2>;
		};

		pci@1 {
			reg =3D <1>;
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

AIUI none of the ranges properties are valid anymore, because the bus
represented by pcie-controller no longer reflects the truth, namely that
it translates the CPU address space to the PCI address space.

> > >>> compatible =3D "nvidia,tegra20-pcie-port"; reg =3D <0x80000000=20
> > >>> 0x00001000>; status =3D "disabled";
> > >>>=20
> > >>> #address-cells =3D <3>; #size-cells =3D <2>;
> > >>>=20
> > >>> ranges =3D <0x81000000 0 0 0x80400000 0 0x00008000   /* I/O */=20
> > >>> 0x82000000 0 0 0x90000000 0 0x08000000   /* non-prefetchable
> > >>> memory */ 0xc2000000 0 0 0xa0000000 0 0x08000000>; /*
> > >>> prefetchable memory */
> > >>=20
> > >> The values here appear identical for both ports. Surely they
> > >> should describe just the parts of the overall address space that
> > >> have been assigned/delegated to the individual port/bridge?
> > >=20
> > > They're not identical. Port 0 gets the first half and port 1 gets
> > > the second half of the ranges specified in the parent.
> >=20
> > Oh right, I missed some 8s and 0s that looked the same!
> >=20
> > >>> While looking into some more code, trying to figure out how to
> > >>> hook this all up with the device tree I ran into a problem. I
> > >>> need to actually create a 'struct device' for each of the
> > >>> ports, so I added the "simple-bus" to the pcie-controller's
> > >>> "compatible" property. Furthermore, each PCI root port now
> > >>> becomes a platform_device, which are supported by a new
> > >>> tegra-pcie-port driver. I'm not sure if "port" is very common
> > >>> in PCI speek, so something like tegra-pcie-bridge (compatible =3D
> > >>> "nvidia,tegra20-pcie-bridge") may be more appropriate?
> > >>=20
> > >> What is it that drives the need for each port to be a 'struct
> > >> device'? The current driver supports 2 host ports, yet there's
> > >> only a single struct device for it. Does the DT code assume a 1:1
> > >> mapping between struct device and DT node that represents the
> > >> child bus? If so, perhaps it'd be better to rework that code to
> > >> accept a DT node as a parameter and call it multiple times,
> > >> rather than accept a struct device as a parameter and hence need
> > >> multiple devices?
> > >=20
> > > It's not so much the DT code, but rather the PCI core and
> > > ultimately the device model that requires it. Each port is
> > > basically a PCI host bridge that provides a root PCI bus and the
> > > device model is used to represent the hierachy of the busses.
> > > Providing just the DT node isn't going to be enough.
> >=20
> > But the existing driver works without /any/ devices, let alone one per
> > port.
>=20
> That doesn't necessarily mean it is correct. The representation of the
> device tree (as in the Linux kernel device tree) isn't quite accurate
> because you're missing the link of the host bridge to the parent PCIe
> controller. It also means that the representation of the kernel device
> tree doesn't match the DT representation.
>=20
> Additionally, if you look at how PCI busses and devices are matched to
> their respective DT nodes, the code in drivers/pci/of.c provides a
> default implementation of pcibios_get_phb_of_node(), which matches the
> struct pci_bus up with the device_node of the parent device.
>=20
> If we keep the current implementation that passes NULL as parent to the
> pci_scan_root_bus() function, then we'll have to provide a custom
> implementation of pcibios_get_phb_of_node() which has to go through
> similar hoops as the x86 version (see arch/x86/kernel/devicetree.c).
> That of course will not contribute to improving the current state of
> fragmentation in the PCI subsystem.

I suppose this could work if we passed the 'struct device' of the pcie-
controller node as the parent for all ports instead of requiring a
separate device for each port. That way the pcie-controller would get to
be a parent for two/three bridges on Tegra20/30.

I'll have a go at the implementation, but I'm busy with other stuff and
it will probably be some time before I can get back on it.

Thierry

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/gftkACgkQZ+BJyKLjJp8zvgCglqoX0wk6Z7o2HhmNU46uxbwu
FnMAoJhq/3WIxO2hUg/hqFPeifpb2EqU
=vdDv
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
