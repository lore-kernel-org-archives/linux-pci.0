Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36801 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752668AbcK3SPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2016 13:15:10 -0500
Date: Wed, 30 Nov 2016 19:14:09 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 10/10] arm64: tegra: Enable PCIe on Jetson TX1
Message-ID: <20161130181409.GA29576@ulmo.ba.sec>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
 <20161125105718.3866-10-thierry.reding@gmail.com>
 <613fbc8c-07d9-d63d-bfb0-7e713dcac4f1@kapsi.fi>
 <20161130174840.GB20246@ulmo.ba.sec>
 <13197e02-a83a-c9d8-13fa-7b21f664a12c@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <13197e02-a83a-c9d8-13fa-7b21f664a12c@kapsi.fi>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2016 at 08:06:45PM +0200, Mikko Perttunen wrote:
> On 11/30/2016 07:48 PM, Thierry Reding wrote:
> > On Mon, Nov 28, 2016 at 06:54:44PM +0200, Mikko Perttunen wrote:
> > > Testing this series with a Jetson TX1 + r8168e PCI-E card, it /almost/
> > > works.. Relevant parts of bootlog:
> > >=20
> > > [    1.876191] tegra-pcie 1003000.pcie-controller: 4x1, 1x1 configura=
tion
> > > [    1.884200] tegra-pcie 1003000.pcie-controller: probing port 0, us=
ing 4
> > > lanes
> > > [    1.893368] tegra-pcie 1003000.pcie-controller: Slot present pin c=
hange,
> > > signature: 00000008
> > > [    1.948049] tegra-pcie 1003000.pcie-controller: probing port 1, us=
ing 1
> > > lanes
> > > [    1.957209] tegra-pcie 1003000.pcie-controller: Slot present pin c=
hange,
> > > signature: 00000000
> > > [    2.367748] tegra-pcie 1003000.pcie-controller: link 1 down, retry=
ing
> > > [    2.778307] tegra-pcie 1003000.pcie-controller: link 1 down, retry=
ing
> > > [    3.188888] tegra-pcie 1003000.pcie-controller: link 1 down, retry=
ing
> > > [    3.197344] tegra-pcie 1003000.pcie-controller: link 1 down, ignor=
ing
> > > [    3.203931] tegra-pcie 1003000.pcie-controller: PCI host bridge to=
 bus
> > > 0000:00
> > > [    3.211160] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > > [    3.217343] pci_bus 0000:00: root bus resource [mem
> > > 0x13000000-0x1fffffff]
> > > [    3.224218] pci_bus 0000:00: root bus resource [mem 0x20000000-0x3=
fffffff
> > > pref]
> > > [    3.231525] pci_bus 0000:00: root bus resource [bus 00-ff]
> > > [    3.237380] pci 0000:00:01.0: bridge configuration invalid ([bus 0=
0-00]),
> > > reconfiguring
> > > [    3.254499] pci 0000:00:01.0: BAR 14: assigned [mem
> > > 0x13000000-0x130fffff]
> > > [    3.261389] pci 0000:00:01.0: BAR 15: assigned [mem 0x20000000-0x2=
00fffff
> > > 64bit pref]
> > > [    3.269220] pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
> > > [    3.275412] pci 0000:01:00.0: BAR 4: assigned [mem 0x20000000-0x20=
003fff
> > > 64bit pref]
> > > [    3.283172] pci 0000:01:00.0: BAR 2: assigned [mem 0x13000000-0x13=
000fff
> > > 64bit]
> > > [    3.290498] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> > > [    3.296596] pci 0000:00:01.0: PCI bridge to [bus 01]
> > > [    3.301568] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
> > > [    3.307666] pci 0000:00:01.0:   bridge window [mem 0x13000000-0x13=
0fffff]
> > > [    3.314454] pci 0000:00:01.0:   bridge window [mem 0x20000000-0x20=
0fffff
> > > 64bit pref]
> > > [    3.322213] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate ho=
st
> > > bridge
> > > [    3.329257] pcieport 0000:00:01.0: enabling device (0000 -> 0003)
> > > [    3.335572] pcieport 0000:00:01.0: Signaling PME through PCIe PME
> > > interrupt
> > > [    3.342537] pci 0000:01:00.0: Signaling PME through PCIe PME inter=
rupt
> > > [    3.349256] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> > > [    3.354858] r8169 0000:01:00.0: enabling device (0000 -> 0003)
> > > [    3.361460] r8169 0000:01:00.0 eth0: RTL8168e/8111e at
> > > 0xffff000008eae000, 98:de:d0:04:25:14, XID 0c200000 IRQ 348
> > > [    3.371812] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 =
bytes,
> > > tx checksumming: ko]
> > >=20
> > > then
> > >=20
> > > [    3.706240] tegra-mc 70019000.memory-controller: afiw: write
> > > @0x000000007a484000: EMEM address decode error (EMEM decode error)
> > > [    3.717747] r8169 0000:01:00.0 eth0: link down
> >=20
> > Hmm... that's very odd. It seems like for some reason the PCIe
> > controller wants to access memory that's below the DRAM. Do you happen
> > to have the SMMU enabled for PCIe? Can you try adding some debug prints
> > to the networking driver to find out where this address is coming from?
>=20
> SMMU is disabled; I'll try adding debug prints. The behavior certainly lo=
oks
> pretty strange.

Maybe you can also find out if at any point in the above the driver is
actually accessing the I/O ports. I don't think we've ever tested that
particular part very much.

I seem to be using a very similar card to yours, which makes it all the
more surprising that it isn't working for you.

Thierry

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYPxbuAAoJEN0jrNd/PrOhrpcP/1Eym5Vlzrvapn4cIWfLyXPM
ryp1b0CI0KwahL4foAUD4vka4kOkfOzdW0M/0M1CKVLN/31tSPE94VJyrK4LzIRP
i2xeePvC6Cc2hwKkHpIbTBmUy98Q4h2uCGmYV077x+en89mNpUExOOdj78/oemHE
KTb8Q+Z3nFO5VkpaVa9BFKtxWkV42PhSjy99qJYLZEIIx1gVi6pj4GpIWHFrYVjS
ywwE+5EAcgpwAh928F8+jgQlJD7zx/bfYFbzS9BJGh8odWkPfRYPngr4QGLFUKnA
QDahrjLO3f2+WUtaDYzuUDrMh/TYsxOsRC5J0JnfXuRbiCr7Engd5hYb94Fw5e1q
SrRrSgNEpB59GPY8oHU67A7Q7ddj/mDufxFoHOGxzbBeaVCJbCqF5HeQs/1STLZW
ypiL+i5x65XqI9p1P9bpYFn8e3aPfkOSht8IiOEAD7p/djKKtlrsETBgUdNwoq6F
GmOWPjSjYXXNnFN1OCjvhXfu7O9fGDkZ4giFAXnUAgPGZuHFluLciQBUbjiBrXPw
J2CZP5m0F0yOnzdk9JT0jMNI+InBG0NedZxhYxwWWWE8QVoHJ/RF1R9UrB8hGeGL
P9DIXYGykJrZ9EtKCScvToumPjWooBJXKh8OGD5fFVN80Lvzh1Y5owQ4uWgyNvZP
yHMh9X6hevgsCq8i4hUe
=g5u/
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
