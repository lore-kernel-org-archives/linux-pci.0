Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36527 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753431AbcK3Rsq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2016 12:48:46 -0500
Date: Wed, 30 Nov 2016 18:48:40 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Tomasz Nowicki <tn@semihalf.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 10/10] arm64: tegra: Enable PCIe on Jetson TX1
Message-ID: <20161130174840.GB20246@ulmo.ba.sec>
References: <20161125105718.3866-1-thierry.reding@gmail.com>
 <20161125105718.3866-10-thierry.reding@gmail.com>
 <613fbc8c-07d9-d63d-bfb0-7e713dcac4f1@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
In-Reply-To: <613fbc8c-07d9-d63d-bfb0-7e713dcac4f1@kapsi.fi>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 28, 2016 at 06:54:44PM +0200, Mikko Perttunen wrote:
> Testing this series with a Jetson TX1 + r8168e PCI-E card, it /almost/
> works.. Relevant parts of bootlog:
>=20
> [    1.876191] tegra-pcie 1003000.pcie-controller: 4x1, 1x1 configuration
> [    1.884200] tegra-pcie 1003000.pcie-controller: probing port 0, using 4
> lanes
> [    1.893368] tegra-pcie 1003000.pcie-controller: Slot present pin chang=
e,
> signature: 00000008
> [    1.948049] tegra-pcie 1003000.pcie-controller: probing port 1, using 1
> lanes
> [    1.957209] tegra-pcie 1003000.pcie-controller: Slot present pin chang=
e,
> signature: 00000000
> [    2.367748] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
> [    2.778307] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
> [    3.188888] tegra-pcie 1003000.pcie-controller: link 1 down, retrying
> [    3.197344] tegra-pcie 1003000.pcie-controller: link 1 down, ignoring
> [    3.203931] tegra-pcie 1003000.pcie-controller: PCI host bridge to bus
> 0000:00
> [    3.211160] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    3.217343] pci_bus 0000:00: root bus resource [mem
> 0x13000000-0x1fffffff]
> [    3.224218] pci_bus 0000:00: root bus resource [mem 0x20000000-0x3ffff=
fff
> pref]
> [    3.231525] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    3.237380] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00=
]),
> reconfiguring
> [    3.254499] pci 0000:00:01.0: BAR 14: assigned [mem
> 0x13000000-0x130fffff]
> [    3.261389] pci 0000:00:01.0: BAR 15: assigned [mem 0x20000000-0x200ff=
fff
> 64bit pref]
> [    3.269220] pci 0000:00:01.0: BAR 13: assigned [io  0x1000-0x1fff]
> [    3.275412] pci 0000:01:00.0: BAR 4: assigned [mem 0x20000000-0x20003f=
ff
> 64bit pref]
> [    3.283172] pci 0000:01:00.0: BAR 2: assigned [mem 0x13000000-0x13000f=
ff
> 64bit]
> [    3.290498] pci 0000:01:00.0: BAR 0: assigned [io  0x1000-0x10ff]
> [    3.296596] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    3.301568] pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
> [    3.307666] pci 0000:00:01.0:   bridge window [mem 0x13000000-0x130fff=
ff]
> [    3.314454] pci 0000:00:01.0:   bridge window [mem 0x20000000-0x200fff=
ff
> 64bit pref]
> [    3.322213] pci 0000:00:01.0: nv_msi_ht_cap_quirk didn't locate host
> bridge
> [    3.329257] pcieport 0000:00:01.0: enabling device (0000 -> 0003)
> [    3.335572] pcieport 0000:00:01.0: Signaling PME through PCIe PME
> interrupt
> [    3.342537] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
> [    3.349256] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    3.354858] r8169 0000:01:00.0: enabling device (0000 -> 0003)
> [    3.361460] r8169 0000:01:00.0 eth0: RTL8168e/8111e at
> 0xffff000008eae000, 98:de:d0:04:25:14, XID 0c200000 IRQ 348
> [    3.371812] r8169 0000:01:00.0 eth0: jumbo features [frames: 9200 byte=
s,
> tx checksumming: ko]
>=20
> then
>=20
> [    3.706240] tegra-mc 70019000.memory-controller: afiw: write
> @0x000000007a484000: EMEM address decode error (EMEM decode error)
> [    3.717747] r8169 0000:01:00.0 eth0: link down

Hmm... that's very odd. It seems like for some reason the PCIe
controller wants to access memory that's below the DRAM. Do you happen
to have the SMMU enabled for PCIe? Can you try adding some debug prints
to the networking driver to find out where this address is coming from?

> The card is alive though, the transfer LED is blinking according to incom=
ing
> traffic, I assume; we can also see that the driver is able to access the =
hw
> to some extent. The kernel version is 4.9rc7 with just this series on top.
> The same board/card also works in U-boot.

I've tested this on a recent linux-next, so perhaps that's something
else to try out. I wouldn't expect v4.9-rc7 to have any issues with a
PCI network driver, but who knows.

Thanks,
Thierry

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIbBAABCAAGBQJYPxD0AAoJEN0jrNd/PrOh4jAP+MmKg86vQZbvHHbpjLRdg4c6
I9YC808YWWl0nDFuBSeoYdb66utg3ZhXZJBhvJmnofP9mUwWAL15Dxl/W8rlxqFC
PcViwqZKXo9pAOLFpUKOD8uzLTe4fA+jiEm8ShwglP+IRWvreLDmAiwm+Do2/sAR
mWd6kiyJa/iFKPX4Mykv2+8Tv1KdUTd7nlVxq0WhgaZUaobcJdOzkq8zyoIFNDxR
1DRe4v3VZOwOxcsSDfM1j9F+g4mlEuR9E8Rq9jFVCBvX/SCd53mU+2LurQhBaOds
gv8ZDCm8u62cOtHmfKG/lG85M+WGwPehiNcbn0tnhWMk1VcuKoh7ajUGyr2rrwL9
weZjnx7XbZ2I0OJQlduZoCkaeqGp/PpEREu4Q8GJ8FZJdHc/bbgYF2Z15Kko6RRL
jbtmil4fbOJH8389vrAH/lb34r8j6HDVuzI8vIKgH58giqjVXdBoCzZf9wxp+c3C
WOcTKVQBg/Uz9Bf46rruGdkzqvjTsN/WEkjBcxNKgrTUIeWWKLuCQasUWukadKmg
YnCz6Z+LPEzbBESwE3tJcnTaQREEtDM7zfF1YmOVrCrqYLIrKVCHPgtjuQhsUlSf
V6i9xmZ6w/kLWQ/6drXWe42qiaWy1a768ubgvO4pdZgtkNupZ/xhIs7zOwznax8A
sxc4zqUEHeuodQQ27xY=
=jrkW
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
