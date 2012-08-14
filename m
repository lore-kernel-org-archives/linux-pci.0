Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50268 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab2HNG37 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 02:29:59 -0400
Date: Tue, 14 Aug 2012 08:29:45 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Message-ID: <20120814062945.GD16181@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
 <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
 <50294BCA.1070807@wwwdotorg.org>
 <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
In-Reply-To: <CAErSpo7og1XgOSv_mFCQ=hP7pq0j3gXWh2QFL2wBJjz7kcAq=g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2012 at 04:18:16PM -0700, Bjorn Helgaas wrote:
> On Mon, Aug 13, 2012 at 11:47 AM, Stephen Warren <swarren@wwwdotorg.org> =
wrote:
> > On 08/13/2012 11:40 AM, Thierry Reding wrote:
> >> On Mon, Aug 06, 2012 at 01:42:21PM -0600, Stephen Warren wrote:
> >>> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> >>>> This patch series adds support for device tree based probing of
> >>>> the PCIe controller found on Tegra SoCs.
> >>>
> >>> Thierry, I just tested all Tegra boards in v3.6-rc1, and noticed
> >>> that PCIe doesn't work on TrimSlice when booting use device tree.
> >>> I think I found the cause, and I can't see why the same problem
> >>> doesn't affect this series. Perhaps you can enlighten me?
> > ...
> >>> PCI: Device 0000:01:00.0 not available because of resource
> >>> collisions
> > ...
> >> I've looked into this a bit, and it seems like ARM is using an
> >> open- coded version of the pci_enable_resources() function here,
> >> with the only difference being the unconditional enabling of both
> >> I/O and memory- mapped access for bridges. On Tegra there is
> >> already a PCI fixup to do this, so pci_enable_resources() can be
> >> used as-is.
>=20
> I'd prefer that bridge I/O & memory access enabling be done in a
> mainline path, not in a fixup.  Fixups are intended for working around
> defects in specific devices, not for the normal path.  I know various
> architectures have fixups that are used in the normal path, but I've
> been working on eliminating them.

I understand. Perhaps it should be added to the pci_enable_resources()
function?

> > The patch did alter the behavior a little for TrimSlice, but didn't
> > solve the problem. The old error messages:
> >
> >> [    2.173971] PCI: Device 0000:01:00.0 not available because of resou=
rce collisions
> >> [    2.181453] r8169 0000:01:00.0: (unregistered net_device): enable f=
ailure
> >> [    2.188254] r8169: probe of 0000:01:00.0 failed with error -22
> >
> > Were replaced with the following with your patch:
> >
> >> [    2.174010] r8169 0000:01:00.0: device not available (can't reserve=
 [io  0x0000-0x00ff])
> >> [    2.182098] r8169 0000:01:00.0: (unregistered net_device): enable f=
ailure
> >> [    2.188900] r8169: probe of 0000:01:00.0 failed with error -22
> >
> > This message appears from drivers/pci/setup-res.c pci_enable_resources()
> > due to:
> >
> >>               if (!r->parent) {
> >>                       dev_err(&dev->dev, "device not available "
> >>                               "(can't reserve %pR)\n", r);
> >>                       return -EINVAL;
> >>               }
> >
> > That check doesn't appear in ARM's custom pcibios_enable_device().
> > Disabling that check yields:
> >
> >> [    2.174192] r8169 0000:01:00.0: enabling device (0140 -> 0143)
> >> [    2.180041] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x0000000=
0-0x00000fff 64bit pref]
> >> [    2.188386] r8169 0000:01:00.0: (unregistered net_device): could no=
t request regions
> >> [    2.196140] r8169: probe of 0000:01:00.0 failed with error -16
> >
> > I think that's because the pci_dev's resources are initially assigned
> > PCI-aperture-relative addresses, and then these are later patched up to
> > take account of where the aperture is mapped into the CPU's address spa=
ce.
>=20
> We definitely shouldn't be calling the driver probe routine before the
> device BARs are assigned.
>=20
> > Boot log using board files:
> >
> >> [    1.146145] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
> >> [    1.151745] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64=
bit pref]
> >> [    1.159007] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64=
bit pref]
> >> [    1.166270] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pr=
ef]
> > ...
> >> [    1.217829] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa00=
1ffff pref]
> >> [    1.225264] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa00=
23fff 64bit pref]
> >> [    1.233236] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa00=
24fff 64bit pref]
> >> [    1.241206] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> > ... (I added some extra printks:)
> >> [    1.488007] r8169 0000:01:00.0: BAR 0: requesting [io  0x1000-0x10f=
f]
> >> [    1.501483] r8169 0000:01:00.0: BAR 2: requesting [mem 0xa0024000-0=
xa0024fff 64bit pref]
> >> [    1.516611] r8169 0000:01:00.0: BAR 4: requesting [mem 0xa0020000-0=
xa0023fff 64bit pref]
> >
> > whereas for a device tree boot:
> >
> > (same):
> >> [    2.112217] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
> >> [    2.117635] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 64=
bit pref]
> >> [    2.124690] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 64=
bit pref]
> >> [    2.131731] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff pr=
ef]
> > ... (request region happens early)
> >> [    2.179838] r8169 0000:01:00.0: BAR 0: requesting [io  0x0000-0x00f=
f]
> >> [    2.193312] r8169 0000:01:00.0: BAR 2: requesting [mem 0x00000000-0=
x00000fff 64bit pref]
> >> [    2.201397] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x0000000=
0-0x00000fff 64bit pref]
> >> [    2.209742] r8169 0000:01:00.0: (unregistered net_device): could no=
t request regions
> > ... (same, just happens too late)
> >> [    2.236818] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa00=
1ffff pref]
> >> [    2.244027] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa00=
23fff 64bit pref]
> >> [    2.251794] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa00=
24fff 64bit pref]
> >> [    2.259542] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> >
> > I suspect this is all still related to the PCI devices themselves being
> > probed much earlier in the overall PCI initialization sequence when the
> > PCI controller is probed later in the boot sequence, whereas PCI device
> > probe is deferred until the overall PCI initialization sequence is
> > complete if the PCI controller is probed very early in the boot sequenc=
e.
>=20
> I don't know what to apply your patches to (they don't apply cleanly
> to v3.6-rc2), so I can't see exactly what you're doing.  But it looks
> like you might be calling pci_bus_add_devices() before
> pci_bus_assign_resource(), which isn't going to work.

The patch was on top of this series, which in turn is based on -next.
However the patch doesn't actually change anything in the ordering of
the initialization sequence, it just replaces the ARM implementation
of pcibios_enable_device() to reuse pci_enable_resources().

ARM's main PCI entry point, arch/arm/kernel/bios32.c:pci_common_init(),
does call the correct sequence: pci_bus_assign_resources() followed by
pci_bus_add_devices(), so the sequence looks correct. However, judging
by the logs Stephen posted, the BAR assignment is too late, after the
driver has been probed.

> I don't know what it means to probe PCI devices before probing the PCI
> controller (the host bridge) -- that shouldn't happen either.  In
> order to probe PCI devices, we have to first know about the host
> bridge so we know how to do config accesses and what the bridge
> apertures are.

Right. I don't think this can happen. If the bridge hasn't been probed,
then the devices shouldn't be there anyway.

Thierry

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKfBZAAoJEN0jrNd/PrOhsRUP/1OleixK6rHAyjmt0fQKMKhb
1E49yAsgjP6fUFWj443PHe10W9xhsjK1h1oe+xkL6R+JytVtzK2jbXJ/iqse9Pjr
g7WA35/fi4gOO9x8Hvmi7yRs+UDcbe5kw8+0giLP01xlQvmnERCeAISmAEfpap1f
I+lDExueP3tArfVcmt7mYCr9iWMbP0m22p1OEMtz4RuwjsaEy5h1hr66fK3O/3k2
DLKEVLPWATN7YnIIyKhou+FdSzlK0++NVDs6kps5dUkcxskBDBwKcdyh1HUD02uA
6m38Ajg37isz4ZidmRYjCbiUgMfEFJNh6AkGs76S4DPNFyoa9WlSzVfbNx8IuRxj
rDeCQj8Z61hI73e44pEdrL/3AqEtVIVfo9skV1ZU1u8gP0fpu0HiWhydwGxhh8AY
mMU9svqVkaUdRwSp5/+D0sZN/mClCebrG4kOARYBHlJB8QymdK4yls/UKIhIP6i+
kh65dersEuLrtxw8tGQ9a3XbW/vg1lXC+RI112oqpFDlnp4+LdlNgNsPflYTjgKu
CQt3tIwASMab3Dv4s5pkGE/9Nl6rX51ofdnvzcPuvqVmaDPpZHpn7VTct2+1QNj3
gx3I3kRotA70x/9EnhqjjqlNT41Epl/L3FTtRxjxM3fEsGVh9SppiQlAKQS+gALT
gsVDfkiJWcivxOFtduKb
=gdiA
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
