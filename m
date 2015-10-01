Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38296 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994AbbJAHrC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2015 03:47:02 -0400
Received: by wiclk2 with SMTP id lk2so15523504wic.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2015 00:47:01 -0700 (PDT)
Date: Thu, 1 Oct 2015 09:46:59 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Duc Dang <dhdang@apm.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Ray Jui <rjui@broadcom.com>, Tanmay Inamdar <tinamdar@apm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_generic_config_write32() access size problem
Message-ID: <20151001074659.GB3070@ulmo>
References: <20150928220854.GA16110@localhost>
 <CAL_JsqL_O2qqESs69spQCPuDfKG5g8_GZkhiYFo-+U8ttxnJng@mail.gmail.com>
 <20150928230532.GG21513@n2100.arm.linux.org.uk>
 <CAL_JsqLVxtcgcTK55cY32=s24Nuv378X2aKZhYKHFEKO9wh3mw@mail.gmail.com>
 <CADaLNDndQ6qZ2yuGuff6=cTm565in5e75AjkcX8MJmH2BCwyEw@mail.gmail.com>
 <CAL_JsqJni3nB3OTevG8VSZoJ7ndnxSYHV6Yfpn6TwvghCxhHxg@mail.gmail.com>
 <CADaLNDmjv+SkRxtGDToUTxo4DKFF+yd2LRmte=k4-HRsGOHYVg@mail.gmail.com>
 <CAL_JsqLrkbXQu2uf9RzqRRu17Rp+sVuCoPb-RSk7aVsuVPpibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
In-Reply-To: <CAL_JsqLrkbXQu2uf9RzqRRu17Rp+sVuCoPb-RSk7aVsuVPpibw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 04:53:00PM -0500, Rob Herring wrote:
> On Wed, Sep 30, 2015 at 4:47 PM, Duc Dang <dhdang@apm.com> wrote:
> > On Wed, Sep 30, 2015 at 2:30 PM, Rob Herring <robh@kernel.org> wrote:
> >> On Wed, Sep 30, 2015 at 4:17 PM, Duc Dang <dhdang@apm.com> wrote:
> >>> On Tue, Sep 29, 2015 at 9:47 AM, Rob Herring <robh@kernel.org> wrote:
> >>>> + several affected driver maintainers
> >>>>
> >>>> On Mon, Sep 28, 2015 at 6:05 PM, Russell King - ARM Linux
> >>>> <linux@arm.linux.org.uk> wrote:
> >>>>> On Mon, Sep 28, 2015 at 05:42:20PM -0500, Rob Herring wrote:
> >>>>>> On Mon, Sep 28, 2015 at 5:08 PM, Bjorn Helgaas <helgaas@kernel.org=
> wrote:
> >>>>>> > Hi Rob,
> >>>>>> >
> >>>>>> > Russell pointed out a problem with 1f94a94f67e1 ("PCI: Add gener=
ic config
> >>>>>> > accessors").  pci_generic_config_write32() does a read/modify/wr=
ite if the
> >>>>>> > size is less than 32 bits, so I think we have problem if this is=
 used with
> >>>>>> > 8- or 16-bit registers that contain RW1C bits.  Any thoughts on =
how we can
> >>>>>> > fix this?
> >>>>>>
> >>>>>> My series didn't change access sizes unless I made a made a mistake
> >>>>>> somewhere, so the problem should have existed before.
> >>>>>>
> >>>>>> Is it known addresses we need to deal with? We could do special ca=
se
> >>>>>> handling of certain addresses to mask out RW1C bits. This could be=
 in
> >>>>>> the generic functions or in wrappers around the generic functions.
> >>>>>> There's already some similar examples of special address handling
> >>>>>> IIRC.
> >>>>>
> >>>>> I think this originally came into being because Intel decided that =
their
> >>>>> IOP platforms wouldn't support anything except 32-bit accesses, and
> >>>>> cargo cult programming took over.  I complained about it on the Int=
el IOP
> >>>>> platforms, but obviously if the hardware doesn't support anything e=
lse
> >>>>> then your stuck with it.
> >>>>
> >>>> What about SA1100 nanoengine?
> >>>>
> >>>> Others are Tegra, XGene, iproc, and maybe rcar. These are all
> >>>> relatively active platforms, so hopefully some testing can be done.
> >>>
> >>> On X-Gene, so far I don't see anything strange after switching to use
> >>> pci_generic_config_write32 with all the cards that I can test.
> >>
> >> You mean switching to use pci_generic_config_write, right?
> > Hi Rob,
> >
> > I meant even using pci_generic_config_write32 , all the cards that I
> > have right now are still running fine.
>=20
> No doubt. I would hope your driver was already tested to some level.
>=20
> The question is can you switch to pci_generic_config_write? Is there
> some h/w bug like hanging the bus or garbage data that prevents 8 and
> 16 bit accesses from working?

It seems like at least on Tegra there is a hardware bug that prevents 8
and 16 bit accesses from working. I've tried next-20151001 on Jetson TK1
(I have root on NFS, and the network card is on PCIe) and I see this:

	[    1.535877] tegra-pcie 1003000.pcie-controller: probing port 0, using 2=
 lanes
	[    1.545099] tegra-pcie 1003000.pcie-controller: Slot present pin change=
, signature: 00000008
	[    1.985057] tegra-pcie 1003000.pcie-controller: link 0 down, retrying
	[    2.420307] tegra-pcie 1003000.pcie-controller: link 0 down, retrying
	[    2.856198] tegra-pcie 1003000.pcie-controller: link 0 down, retrying
	[    2.864783] tegra-pcie 1003000.pcie-controller: link 0 down, ignoring
	[    2.871296] tegra-pcie 1003000.pcie-controller: probing port 1, using 1=
 lanes
	[    2.880794] tegra-pcie 1003000.pcie-controller: Slot present pin change=
, signature: 00000000
	[    2.898441] tegra-pcie 1003000.pcie-controller: PCI host bridge to bus =
0000:00
	[    2.905718] pci_bus 0000:00: root bus resource [mem 0x13000000-0x1fffff=
ff]
	[    2.912587] pci_bus 0000:00: root bus resource [mem 0x20000000-0x3fffff=
ff pref]
	[    2.919905] pci_bus 0000:00: root bus resource [bus 00-ff]
	[    2.925386] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
	[    2.931625] pci 0000:00:02.0: [10de:0e13] type 01 class 0x060400
	[    2.937733] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot D3cold
	[    2.945062] PCI: bus0: Fast back to back transfers disabled
	[    2.950649] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]=
), reconfiguring
	[    2.959096] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
	[    2.965148] pci 0000:01:00.0: reg 0x10: [io  0x0000-0x00ff]
	[    2.970762] pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x00000fff 64bi=
t]
	[    2.977575] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bi=
t pref]
	[    2.984879] pci 0000:01:00.0: supports D1 D2
	[    2.989162] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
	[    3.015680] PCI: bus1: Fast back to back transfers disabled
	[    3.021261] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
	[    3.028012] pci 0000:00:02.0: BAR 8: assigned [mem 0x13000000-0x130ffff=
f]
	[    3.034796] pci 0000:00:02.0: BAR 9: assigned [mem 0x20000000-0x200ffff=
f 64bit pref]
	[    3.042574] pci 0000:00:02.0: BAR 7: assigned [io  0x1000-0x1fff]
	[    3.048715] pci 0000:01:00.0: BAR 4: assigned [mem 0x20000000-0x20003ff=
f 64bit pref]
	[    3.056491] pci 0000:01:00.0: BAR 2: assigned [mem 0x13000000-0x13000ff=
f 64bit]
	[    3.063807] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
	[    3.070021] pci 0000:00:02.0: PCI bridge to [bus 01]
	[    3.074984] pci 0000:00:02.0:   bridge window [io  0x1000-0x1fff]
	[    3.081093] pci 0000:00:02.0:   bridge window [mem 0x13000000-0x130ffff=
f]
	[    3.087890] pci 0000:00:02.0:   bridge window [mem 0x20000000-0x200ffff=
f 64bit pref]
	[    3.095668] pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host br=
idge
	[    3.102813] pcieport 0000:00:02.0: enabling device (0140 -> 0143)
	[    3.109455] pcieport 0000:00:02.0: Signaling PME through PCIe PME inter=
rupt
	[    3.116428] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
	[    3.122950] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
	[    3.130024] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
	[    3.135670] r8169 0000:01:00.0: enabling device (0140 -> 0143)
	[    3.158326] r8169 0000:01:00.0 eth0: RTL8168g/8111g at 0xf08f6000, 00:0=
4:4b:1e:07:bb, XID 0c000800 IRQ 390
	[    3.168015] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 bytes=
, tx checksumming: ko]

The network card is detected and boot continues normally. When I change
the pci_ops to use pci_generic_config_{read,write} the system no longer
boots because the network card never shows up. The kernel log has this:

	[    1.546563] tegra-pcie 1003000.pcie-controller: probing port 0, using 2=
 lanes
	[    1.556137] tegra-pcie 1003000.pcie-controller: Slot present pin change=
, signature: 00000008
	[    1.996905] tegra-pcie 1003000.pcie-controller: link 0 down, retrying
	[    2.432731] tegra-pcie 1003000.pcie-controller: link 0 down, retrying
	[    2.868648] tegra-pcie 1003000.pcie-controller: link 0 down, retrying
	[    2.877241] tegra-pcie 1003000.pcie-controller: link 0 down, ignoring
	[    2.883707] tegra-pcie 1003000.pcie-controller: probing port 1, using 1=
 lanes
	[    2.893239] tegra-pcie 1003000.pcie-controller: Slot present pin change=
, signature: 00000000
	[    2.908770] tegra-pcie 1003000.pcie-controller: PCI host bridge to bus =
0000:00
	[    2.916039] pci_bus 0000:00: root bus resource [mem 0x13000000-0x1fffff=
ff]
	[    2.922906] pci_bus 0000:00: root bus resource [mem 0x20000000-0x3fffff=
ff pref]
	[    2.930225] pci_bus 0000:00: root bus resource [bus 00-ff]
	[    2.935721] pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
	[    2.941935] pci 0000:00:02.0: [10de:0e13] type 00 class 0x060400
	[    2.947958] pci 0000:00:02.0: ignoring class 0x060400 (doesn't match he=
ader type 00)
	[    2.956292] PCI: bus0: Fast back to back transfers disabled

So it seems like it's failing to properly read the header type. That's
retrieved from byte 0xe as an 8 bit access. That said, even with 32-bit
accesses I haven't seen any problems, but that might just be because
none of the devices I've tested with have R1WC bits in problematic
places.

Thierry

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWDOTxAAoJEN0jrNd/PrOhN7QQAKEK6ERfQk+lZTJS1LlXYkBO
Q2aoOiDhikwKGRyxvchtEMt3GsryGjboTu4PJAOIFb3CuM41wJ69qCgNGFSpo8C8
iDrzNadcUmF7tY9IPahcv52rMWBErl4i6L/azCOGJuMUbHasVJ4Kj6o+juFUEkDK
3byoRVloaYpXrufXydDLQQzKcLHZOT91+TYSkE9ktQFPM2+H228jZlOinEGAoRga
OXYv8AlGUhpal8gUvB654P94L/6y7XTlYI15DDv0SObYAymEYtVIQZfOlD8zA2cP
2OQ4/oSs+YBj4zOasfjZVcnqVyFRwDjmGFRUu7+fIijcPcn4JftEWDNkZXcFOFfq
my2BwbCnp8Q9Orn+a2ctYfTARPepM3F+bMXq7XM7JgAqtIlKTz4TK2wCe8b0BBk0
G7aLY+69JOUojP8TFEzoGh11izLW+SnO7ZRpwdS2ERcV5NeQ5c8eQABd9RiSPzF+
MywwFa/4TRkdc8btB5rj2qmg7w6LCXyOcPSq4xr8aPDvdlK9MjtfuMYS+L1cY4dj
LVgwE7HK+PEPbo1Y8r5q6YzeBKfxywgx6SLZOWDPr2RsHuJxMtyv6qYkZojnHGib
PsZaLCxasc34meqD4cLyWdyouZTdCHcO5hzK3sBa+Fp2O4rt98JqJjHdjyT8PevE
H2jca7LOLTJ0D3CMlqtL
=s/wZ
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
