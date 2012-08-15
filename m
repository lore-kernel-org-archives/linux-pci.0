Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59593 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab2HOGhc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 02:37:32 -0400
Date: Wed, 15 Aug 2012 08:37:18 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
Message-ID: <20120815063718.GA15665@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-11-git-send-email-thierry.reding@avionic-design.de>
 <20120814201215.GA10542@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6Awbx9-DWM3V02HUg7Xv4tWAhcLO7UKuT_0uXbpZ+nKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <CAErSpo6Awbx9-DWM3V02HUg7Xv4tWAhcLO7UKuT_0uXbpZ+nKw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 14, 2012 at 04:50:26PM -0700, Bjorn Helgaas wrote:
> On Tue, Aug 14, 2012 at 1:12 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Thu, Jul 26, 2012 at 09:55:12PM +0200, Thierry Reding wrote:
> >> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra2=
0.dtsi
> >> index a094c97..c886dff 100644
> >> --- a/arch/arm/boot/dts/tegra20.dtsi
> >> +++ b/arch/arm/boot/dts/tegra20.dtsi
> >> @@ -199,6 +199,68 @@
> >>               #size-cells =3D <0>;
> >>       };
> >>
> >> +     pcie-controller {
> >> +             compatible =3D "nvidia,tegra20-pcie";
> >> +             reg =3D <0x80003000 0x00000800   /* PADS registers */
> >> +                    0x80003800 0x00000200   /* AFI registers */
> >> +                    0x81000000 0x01000000   /* configuration space */
> >> +                    0x90000000 0x10000000>; /* extended configuration=
 space */
> >> +             interrupts =3D <0 98 0x04   /* controller interrupt */
> >> +                           0 99 0x04>; /* MSI interrupt */
> >> +             status =3D "disabled";
> >> +
> >> +             ranges =3D <0 0 0  0x80000000 0x00001000   /* root port =
0 */
> >> +                       0 1 0  0x81000000 0x00800000   /* port 0 confi=
g space */
> >> +                       0 2 0  0x90000000 0x08000000   /* port 0 ext c=
onfig space */
> >> +                       0 3 0  0x82000000 0x00010000   /* port 0 downs=
tream I/O */
> >> +                       0 4 0  0xa0000000 0x08000000   /* port 0 non-p=
refetchable memory */
> >> +                       0 5 0  0xb0000000 0x08000000   /* port 0 prefe=
tchable memory */
> >> +
> >> +                       1 0 0  0x80001000 0x00001000   /* root port 1 =
*/
> >> +                       1 1 0  0x81800000 0x00800000   /* port 1 confi=
g space */
> >> +                       1 2 0  0x98000000 0x08000000   /* port 1 ext c=
onfig space */
> >> +                       1 3 0  0x82010000 0x00010000   /* port 1 downs=
tream I/O */
> >> +                       1 4 0  0xa8000000 0x08000000   /* port 1 non-p=
refetchable memory */
> >> +                       1 5 0  0xb8000000 0x08000000>; /* port 1 prefe=
tchable memory */
> >
> > I've been thinking about this some more. The translations for both the
> > regular and extended configuration spaces are configured in the top-
> > level PCIe controller. It is therefore wrong how they are passed to the
> > PCI host bridges via the ranges property.
> >
> > I remember Mitch saying that it should be passed down to the children
> > because it is partitioned among them, but since the layout is compatible
> > with ECAM, the partitioning isn't as simple as what's in the tree. In
> > fact the partitions will be dependent on the number of devices attached
> > to the host bridges.
>=20
> I don't understand this last bit about the number of devices attached
> to the host bridges.  Logically, the host bridge has a bus number
> aperture that you can know up front, even before you know anything
> about what devices are below it.  On x86, for example, the ACPI _CRS
> method has something like "[bus 00-7f]" in it, which means that any
> buses in that range are below this bridge.  That doesn't tell us
> anything about which buses actually have devices on them, of course;
> it's just analogous to the secondary and subordinate bus number
> registers in a P2P bridge.

That's one of the issues I still need to take care of. Currently no bus
resource is attached to the individual bridges (nor the PCI controller
for that matter), so the PCI core will assign them dynamically. If this
range is known at boot time we could assign ECAM ranges based on the bus
numbers. Standard ECAM ranges, that is. On Tegra this won't work because
as Stephen mentioned in a previous mail, the bus field is not the top
field in the ECAM addresses. Basically what you have is this:

	[27:24] upper 4 bits of the register address for extended
	        configuration space
	[23:16] bus number
	[15:11] device number
	[10: 8] device function
	[ 8: 0] register

So the ECAM space cannot be partitioned by bus number.

Thierry

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQK0OeAAoJEN0jrNd/PrOh6iIQAL0V0gBkvqgHGnr/26kjXhtX
6h06I20vrEGvYv8iB3Z5CcBk4/aUgpyhWajMbQqDLHJ4Cdy/grasFvpP9BeywlfK
SFFRsx2cJs0LUz+b7t8RpKCKCxyEmWYE2XpCfVw5F/gAWh4O75wuxkafFu7bQDlM
5nZaNwYZElIuq3FpOrd1Y/68yJVmdsbiDbz2acsueMVaBdQZ+GoVi19/ADbfP1BN
FpCacaUmzg+IqlcrrJf1Jmxf78EkOQEdoxFkXIMzxX4UKqJD6OgPLeQvPNsQCpXE
Ska47BvZuNETfcJtmoU5mKRc9k6IM8LOP/+6ydd8HzPO6ZVM1AKh/qrzgImrWDbf
O/ohn7Zgmxyu6XIdP2lMnNwFVvcchsVGvD2faZapT3uswWJJrvzKDIZCRFC11yWi
ScXK0v2B+WjX9vd3SUcIpF4FiZUwruv4MMkhj2mMxIljjyk1zf6zUP6FKvEm3J+O
8wptN80OvEpZMocsYaJmela31ujOQWWFH5RHSRYKLcLv3rAKBYDLWPZAUhbWDulU
ID/mZSLEPTmf95EBuYqVe+bjcw8NMCSUg3z5xTO6Y7Rw1/xeyok1wwFB5illveJT
+Fsy+pYfE3DAS73oNtqB/7tEMYhxYbRlL8SehCJf4clg8/Ef8ssNvCdMJ0rZ+AzN
YYTUBXh7cJwj6qfSXcMG
=NDBv
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
