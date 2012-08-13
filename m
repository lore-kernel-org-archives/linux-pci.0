Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56136 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab2HMUdX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Aug 2012 16:33:23 -0400
Date: Mon, 13 Aug 2012 22:33:00 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-tegra@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Message-ID: <20120813203300.GA8891@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
 <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
 <50294BCA.1070807@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
In-Reply-To: <50294BCA.1070807@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--QTprm0S8XgL7H0Dt
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2012 at 12:47:38PM -0600, Stephen Warren wrote:
> On 08/13/2012 11:40 AM, Thierry Reding wrote:
> > On Mon, Aug 06, 2012 at 01:42:21PM -0600, Stephen Warren wrote:
> >> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> >>> This patch series adds support for device tree based probing of
> >>> the PCIe controller found on Tegra SoCs.
> >>=20
> >> Thierry, I just tested all Tegra boards in v3.6-rc1, and noticed
> >> that PCIe doesn't work on TrimSlice when booting use device tree.
> >> I think I found the cause, and I can't see why the same problem
> >> doesn't affect this series. Perhaps you can enlighten me?
> ...
> >> PCI: Device 0000:01:00.0 not available because of resource
> >> collisions
> ...
> > I've looked into this a bit, and it seems like ARM is using an
> > open- coded version of the pci_enable_resources() function here,
> > with the only difference being the unconditional enabling of both
> > I/O and memory- mapped access for bridges. On Tegra there is
> > already a PCI fixup to do this, so pci_enable_resources() can be
> > used as-is. I came up with the attached patch but haven't been able
> > to test it yet.
>=20
> Thanks very much for looking into this.
>=20
> The patch did alter the behavior a little for TrimSlice, but didn't
> solve the problem. The old error messages:
>=20
> > [    2.173971] PCI: Device 0000:01:00.0 not available because of resour=
ce collisions
> > [    2.181453] r8169 0000:01:00.0: (unregistered net_device): enable fa=
ilure
> > [    2.188254] r8169: probe of 0000:01:00.0 failed with error -22
>=20
> Were replaced with the following with your patch:
>=20
> > [    2.174010] r8169 0000:01:00.0: device not available (can't reserve =
[io  0x0000-0x00ff])
> > [    2.182098] r8169 0000:01:00.0: (unregistered net_device): enable fa=
ilure
> > [    2.188900] r8169: probe of 0000:01:00.0 failed with error -22
>=20
> This message appears from drivers/pci/setup-res.c pci_enable_resources()
> due to:
>=20
> > 		if (!r->parent) {
> > 			dev_err(&dev->dev, "device not available "
> > 				"(can't reserve %pR)\n", r);
> > 			return -EINVAL;
> > 		}

Looking at the code some more, this may be caused by the pci_remap_io()
patch series, so you might want to revert that patch and see if it fixes
the I/O resources.

> That check doesn't appear in ARM's custom pcibios_enable_device().
> Disabling that check yields:
>=20
> > [    2.174192] r8169 0000:01:00.0: enabling device (0140 -> 0143)
> > [    2.180041] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x00000000=
-0x00000fff 64bit pref]
> > [    2.188386] r8169 0000:01:00.0: (unregistered net_device): could not=
 request regions
> > [    2.196140] r8169: probe of 0000:01:00.0 failed with error -16
>=20
> I think that's because the pci_dev's resources are initially assigned
> PCI-aperture-relative addresses, and then these are later patched up to
> take account of where the aperture is mapped into the CPU's address space.
>=20
> Boot log using board files:
>=20
> > [    1.146145] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
> > [    1.151745] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64b=
it pref]
> > [    1.159007] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64b=
it pref]
> > [    1.166270] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pre=
f]
> ...
> > [    1.217829] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa001=
ffff pref]
> > [    1.225264] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa002=
3fff 64bit pref]
> > [    1.233236] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa002=
4fff 64bit pref]
> > [    1.241206] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> ... (I added some extra printks:)
> > [    1.488007] r8169 0000:01:00.0: BAR 0: requesting [io  0x1000-0x10ff]
> > [    1.501483] r8169 0000:01:00.0: BAR 2: requesting [mem 0xa0024000-0x=
a0024fff 64bit pref]
> > [    1.516611] r8169 0000:01:00.0: BAR 4: requesting [mem 0xa0020000-0x=
a0023fff 64bit pref]
>=20
> whereas for a device tree boot:
>=20
> (same):
> > [    2.112217] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
> > [    2.117635] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64b=
it pref]
> > [    2.124690] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64b=
it pref]
> > [    2.131731] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pre=
f]
> ... (request region happens early)
> > [    2.179838] r8169 0000:01:00.0: BAR 0: requesting [io  0x0000-0x00ff]
> > [    2.193312] r8169 0000:01:00.0: BAR 2: requesting [mem 0x00000000-0x=
00000fff 64bit pref]
> > [    2.201397] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x00000000=
-0x00000fff 64bit pref]
> > [    2.209742] r8169 0000:01:00.0: (unregistered net_device): could not=
 request regions
> ... (same, just happens too late)
> > [    2.236818] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa001=
ffff pref]
> > [    2.244027] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa002=
3fff 64bit pref]
> > [    2.251794] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa002=
4fff 64bit pref]
> > [    2.259542] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
>=20
> I suspect this is all still related to the PCI devices themselves being
> probed much earlier in the overall PCI initialization sequence when the
> PCI controller is probed later in the boot sequence, whereas PCI device
> probe is deferred until the overall PCI initialization sequence is
> complete if the PCI controller is probed very early in the boot sequence.
>=20
> Does anyone know where/what that "probe now" vs. "probe later" decision
> point is? I'll try and track it down if nobody beats me to it.

There's the io_offset and mem_offset fields that I've completely ignored
up to now. Can you try the patch below to see if it changes anything?
I'm sorry but I can't test any of this myself right now.

Thierry

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pcie.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 3463fb5..9b9b3e0 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -395,7 +395,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data=
 *sys)
 	pp->res[0].flags =3D IORESOURCE_MEM;
 	if (request_resource(&iomem_resource, &pp->res[0]))
 		panic("Request PCIe Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[0], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &pp->res[0], pp->res[0].start);
=20
 	/*
 	 * IORESOURCE_MEM | IORESOURCE_PREFETCH
@@ -414,7 +414,7 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data=
 *sys)
 	pp->res[1].flags =3D IORESOURCE_MEM | IORESOURCE_PREFETCH;
 	if (request_resource(&iomem_resource, &pp->res[1]))
 		panic("Request PCIe Prefetch Memory resource failed\n");
-	pci_add_resource_offset(&sys->resources, &pp->res[1], sys->mem_offset);
+	pci_add_resource_offset(&sys->resources, &pp->res[1], pp->res[1].start);
=20
 	return 1;
 }

--azLHFNyN32YCQGCU--

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKWR8AAoJEN0jrNd/PrOhuBsP/Rp+FqmWeJJcPAZ+DpHx9Ket
uViw0SWGWAvvxvHF7FcwgV4c38LHC1CZIGDJiLG/V7ZVOfUsU+cvqRRexf9MqIXg
CeeDgAcvrZq2Rw1R7xff9E+slUWn8AFalc0vOjiIn27/fRAlIIZwtuF3KWbBA4vq
yZJkbNQXGSnrujH9FV7zYvbDfBVkboqHbt+gAucot/l2H8KxFg0Pev5BQyiQxeXw
ClwZz7w5ANsh3FIKZ5Q1N131aKt4O+BIrMimov1t9unN0HdWlgDvHlMcPEsDvuyk
g0xcPiN6Ltzgz7MICNGBUbAQrO57Kdj/7uNuYkz9x1cVIk16VyLSCOj5l6HGLrN/
l0d1orqOfc8BixVwbfZ6yWd0xiXtYHk3LE2U0LjWhTl6lN+I3n5sxOZplIUfSPL1
j2VMaTydoHhrhka2aXShCOdTRVJqa1pyMW8mjgkGDOVWrO1DoRXTYtreOiLnz1xL
sCd4MuhEYEahvsl/4cCe+BImedndAwk9NTSmCLtHoowyygC/iBVq+gTopHoN9QKE
euMxfC5T3XIvtu+CD9qKO5VWkp/7VHVSWR6/zu5oOVmvvrgmf2LxtnPxFGeinCac
qaHo0iOtvdeOjBiwho8Ys0p19OheZao5xkU33Mmlf8+wDgYP7P+j3luFn1o+OZKX
J64pHGWUWNeJluBklKLj
=aQfm
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
