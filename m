Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63090 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab2HNGOS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2012 02:14:18 -0400
Date: Tue, 14 Aug 2012 08:14:08 +0200
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Rob Herring <robherring2@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
Message-ID: <20120814061408.GC16181@avionic-0098.mockup.avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <50201E1D.5060200@wwwdotorg.org>
 <20120813174003.GA2527@avionic-0098.mockup.avionic-design.de>
 <50294BCA.1070807@wwwdotorg.org>
 <20120813203300.GA8891@avionic-0098.mockup.avionic-design.de>
 <502973E5.6000303@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
In-Reply-To: <502973E5.6000303@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2012 at 04:38:45PM -0500, Rob Herring wrote:
> On 08/13/2012 03:33 PM, Thierry Reding wrote:
> > On Mon, Aug 13, 2012 at 12:47:38PM -0600, Stephen Warren wrote:
> >> On 08/13/2012 11:40 AM, Thierry Reding wrote:
> >>> On Mon, Aug 06, 2012 at 01:42:21PM -0600, Stephen Warren wrote:
> >>>> On 07/26/2012 01:55 PM, Thierry Reding wrote:
> >>>>> This patch series adds support for device tree based probing of
> >>>>> the PCIe controller found on Tegra SoCs.
> >>>>
> >>>> Thierry, I just tested all Tegra boards in v3.6-rc1, and noticed
> >>>> that PCIe doesn't work on TrimSlice when booting use device tree.
> >>>> I think I found the cause, and I can't see why the same problem
> >>>> doesn't affect this series. Perhaps you can enlighten me?
> >> ...
> >>>> PCI: Device 0000:01:00.0 not available because of resource
> >>>> collisions
> >> ...
> >>> I've looked into this a bit, and it seems like ARM is using an
> >>> open- coded version of the pci_enable_resources() function here,
> >>> with the only difference being the unconditional enabling of both
> >>> I/O and memory- mapped access for bridges. On Tegra there is
> >>> already a PCI fixup to do this, so pci_enable_resources() can be
> >>> used as-is. I came up with the attached patch but haven't been able
> >>> to test it yet.
> >>
> >> Thanks very much for looking into this.
> >>
> >> The patch did alter the behavior a little for TrimSlice, but didn't
> >> solve the problem. The old error messages:
> >>
> >>> [    2.173971] PCI: Device 0000:01:00.0 not available because of reso=
urce collisions
> >>> [    2.181453] r8169 0000:01:00.0: (unregistered net_device): enable =
failure
> >>> [    2.188254] r8169: probe of 0000:01:00.0 failed with error -22
> >>
> >> Were replaced with the following with your patch:
> >>
> >>> [    2.174010] r8169 0000:01:00.0: device not available (can't reserv=
e [io  0x0000-0x00ff])
> >>> [    2.182098] r8169 0000:01:00.0: (unregistered net_device): enable =
failure
> >>> [    2.188900] r8169: probe of 0000:01:00.0 failed with error -22
> >>
> >> This message appears from drivers/pci/setup-res.c pci_enable_resources=
()
> >> due to:
> >>
> >>> 		if (!r->parent) {
> >>> 			dev_err(&dev->dev, "device not available "
> >>> 				"(can't reserve %pR)\n", r);
> >>> 			return -EINVAL;
> >>> 		}
> >=20
> > Looking at the code some more, this may be caused by the pci_remap_io()
> > patch series, so you might want to revert that patch and see if it fixes
> > the I/O resources.
> >=20
>=20
> Humm... But this patch deals with the i/o space and it is failing below
> on the memory space.

But above it also fails for I/O. Looking at this some more, it seems
like your patch isn't at fault. Rather there seems to be a general
resource assignment problem.

>=20
> >> That check doesn't appear in ARM's custom pcibios_enable_device().
> >> Disabling that check yields:
> >>
> >>> [    2.174192] r8169 0000:01:00.0: enabling device (0140 -> 0143)
> >>> [    2.180041] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x000000=
00-0x00000fff 64bit pref]
> >>> [    2.188386] r8169 0000:01:00.0: (unregistered net_device): could n=
ot request regions
> >>> [    2.196140] r8169: probe of 0000:01:00.0 failed with error -16
> >>
> >> I think that's because the pci_dev's resources are initially assigned
> >> PCI-aperture-relative addresses, and then these are later patched up to
> >> take account of where the aperture is mapped into the CPU's address sp=
ace.
> >>
> >> Boot log using board files:
> >>
> >>> [    1.146145] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
> >>> [    1.151745] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 6=
4bit pref]
> >>> [    1.159007] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 6=
4bit pref]
> >>> [    1.166270] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff p=
ref]
> >> ...
> >>> [    1.217829] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa0=
01ffff pref]
> >>> [    1.225264] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa0=
023fff 64bit pref]
> >>> [    1.233236] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa0=
024fff 64bit pref]
> >>> [    1.241206] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> >> ... (I added some extra printks:)
> >>> [    1.488007] r8169 0000:01:00.0: BAR 0: requesting [io  0x1000-0x10=
ff]
> >>> [    1.501483] r8169 0000:01:00.0: BAR 2: requesting [mem 0xa0024000-=
0xa0024fff 64bit pref]
> >>> [    1.516611] r8169 0000:01:00.0: BAR 4: requesting [mem 0xa0020000-=
0xa0023fff 64bit pref]
> >>
> >> whereas for a device tree boot:
> >>
> >> (same):
> >>> [    2.112217] pci 0000:01:00.0: reg 10: [io  0x0000-0x00ff]
> >>> [    2.117635] pci 0000:01:00.0: reg 18: [mem 0x00000000-0x00000fff 6=
4bit pref]
> >>> [    2.124690] pci 0000:01:00.0: reg 20: [mem 0x00000000-0x00003fff 6=
4bit pref]
> >>> [    2.131731] pci 0000:01:00.0: reg 30: [mem 0x00000000-0x0001ffff p=
ref]
> >> ... (request region happens early)
> >>> [    2.179838] r8169 0000:01:00.0: BAR 0: requesting [io  0x0000-0x00=
ff]
> >>> [    2.193312] r8169 0000:01:00.0: BAR 2: requesting [mem 0x00000000-=
0x00000fff 64bit pref]
> >>> [    2.201397] r8169 0000:01:00.0: BAR 2: can't reserve [mem 0x000000=
00-0x00000fff 64bit pref]
> >>> [    2.209742] r8169 0000:01:00.0: (unregistered net_device): could n=
ot request regions
> >> ... (same, just happens too late)
> >>> [    2.236818] pci 0000:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa0=
01ffff pref]
> >>> [    2.244027] pci 0000:01:00.0: BAR 4: assigned [mem 0xa0020000-0xa0=
023fff 64bit pref]
> >>> [    2.251794] pci 0000:01:00.0: BAR 2: assigned [mem 0xa0024000-0xa0=
024fff 64bit pref]
> >>> [    2.259542] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> >>
> >> I suspect this is all still related to the PCI devices themselves being
> >> probed much earlier in the overall PCI initialization sequence when the
> >> PCI controller is probed later in the boot sequence, whereas PCI device
> >> probe is deferred until the overall PCI initialization sequence is
> >> complete if the PCI controller is probed very early in the boot sequen=
ce.
> >>
> >> Does anyone know where/what that "probe now" vs. "probe later" decision
> >> point is? I'll try and track it down if nobody beats me to it.
> >=20
> > There's the io_offset and mem_offset fields that I've completely ignored
> > up to now. Can you try the patch below to see if it changes anything?
> > I'm sorry but I can't test any of this myself right now.
>=20
> Arnd and I discussed io_offset some. I don't think either of us can
> figure out when it should be anything but 0 at least if pci i/o bus
> addresses start at 0.
>=20
> I don't think mem_offset is the issue. I think perhaps you need to set
> pcibios_min_mem to the memory window base (0xa0000000), but that's just
> a guess.

I'm having trouble understanding how that's supposed to work for regions
of prefetchable memory. At least on Tegra these can arbitrarily assigned
and I thought I had seen other platforms where this was also the case.

However the pcibios_min_mem (or the equivalent macro PCIBIOS_MIN_MEM) is
used while assigning the resources in the __pci_assign_resources() in
drivers/pci/setup-res.c, so it may influence things.

But I think the more fundamental issue here is that BARs are assigned
properly, only they are assigned too late in the DT case as opposed to
the board files case. I don't understand why that happens.

Thierry

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQKeywAAoJEN0jrNd/PrOh6KYQAL7HB7sNBuySxYY4XTLn42sK
qadLxzaWP+fyjXCALe1FHfbvWiX17SjnwaV/+3XRhm6GD533bgDkOykcw9N+ApZj
eFzAk0sRMcAPJzKDlZ+ojuOPR1R5jth0qYWwXGEQIVitNX/5NCauhvDgnfwzQRKf
f54zRJ1YRkDj+r6/cQXYrurF8ErDP554uAHwAj2v1TXsRh8c6cY6g4o0+K7bWmdo
1IvY0Z6B6uVmq8QejcyBuqbjy3PxiqRAjPLvsllWLm+yiy759PPLqiRzlJBeh8BX
sIhQJ+Vjzot97XskGUT5jDfEOZ6PplFHb9Aa7plaApvoRExgFpGt/p2qNEhXuGea
6FqeqxfKptZU9r1zKb8uXIJXbDGltI8rFzR0n6W8LEyL5Hk5QPQzaEnjijvZ51QM
tK9AZdo+xQmkjysLcr85egAfY9yCL50EvVv5Nh3Dh6OyvNzMm4DXo1G6GcHv6VFY
wVbRxd26JBQmOqUslMDk4NyQGBo3f+8ASYTcxAtl7OufMFS9rahGUBtqenxlRtSo
IL3352sV/7a5Fbat+ejlffZYbbIztCyTNWrSdwZnJgvtD0yQ+yJqPnCM0Aw1pVFX
VPO5R23tiWmpPRZztbM4e+KkO+0D3CLNyiXVkcncdmkQ7Q0lfJ5jDecCrMXB6wIA
wymhc3hu4Sq2HUFweSX9
=ysxE
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
