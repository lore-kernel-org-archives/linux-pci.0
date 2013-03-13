Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51317 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234Ab3CMWDa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2013 18:03:30 -0400
Date: Wed, 13 Mar 2013 23:02:35 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130313220235.GA29895@avionic-0098.mockup.avionic-design.de>
References: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
 <5140E85A.3040900@firmworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
In-Reply-To: <5140E85A.3040900@firmworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 13, 2013 at 10:58:02AM -1000, Mitch Bradley wrote:
[...]
> But then you run into the problem that the pci variant of struct of_bus
> uses "assigned-addresses" instead of "reg".  So it still doesn't work
> as-is.  To make it work, you would need to add an "assigned-addresses"
> property to each root port node.  That property value could be in
> non-relocatable memory space, translatable via normal rules, in which
> case the "map config space to MMIO via ranges" discussion is moot for
> Marvell.

So if I understand all of the above correctly, the Tegra binding should
look like this:

	pcie-controller {
		compatible = "nvidia,tegra20-pcie";
		device_type = "pci";
		reg = <0x80003000 0x00000800   /* PADS registers */
		       0x80003800 0x00000200   /* AFI registers */
		       0x90000000 0x10000000>; /* configuration space */
		reg-names = "pads", "afi", "cs";
		interrupts = <0 98 0x04   /* controller interrupt */
		              0 99 0x04>; /* MSI interrupt */
		interrupt-names = "intr", "msi";

		bus-range = <0x00 0xff>;
		#address-cells = <3>;
		#size-cells = <2>;

		ranges = <0x82000800 0 0 0x80000000 0 0x00001000   /* port 0 registers */
			  0x82001000 0 0 0x80001000 0 0x00001000   /* port 1 registers */
			  0x81000000 0 0 0x82000000 0 0x00010000   /* downstream I/O */
			  0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory */
			  0xc2000000 0 0 0xb0000000 0 0x10000000>; /* prefetchable memory */

		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>,
			 <&tegra_car 118>;
		clock-names = "pex", "afi", "pcie_xclk", "pll_e";
		status = "disabled";

		pci@1,0 {
			device_type = "pci";
			assigned-addresses = <0x82000800 0 0 0x80000000 0x1000>;
			reg = <0x000800 0 0 0 0>;
			status = "disabled";

			#address-cells = <3>;
			#size-cells = <2>;

			nvidia,num-lanes = <2>;
		};

		pci@2,0 {
			device_type = "pci";
			assigned-addresses = <0x82001000 0 0 0x80001000 0x1000>;
			reg = <0x001000 0 0 0 0>;
			status = "disabled";

			#address-cells = <3>;
			#size-cells = <2>;

			nvidia,num-lanes = <2>;
		};
	};

Does that look about correct?

One problem I see is that now the ranges property contains three entries
for 32-bit memory space:

	0x82000800 0 0 0x80000000 0 0x00001000   /* port 0 registers */
	0x82001000 0 0 0x80001000 0 0x00001000   /* port 1 registers */
	0x82000000 0 0 0xa0000000 0 0x10000000   /* non-prefetchable memory */

But we used to rely on the ss field to parse the ranges property and
configure the windows in the controller properly so that accesses to
these regions will generate the correct transactions.

Now the code will actually match the first entry and assume that it
represents the non-prefetchable 32-bit memory space and program the
controller to forward accesses to the 0x80000000-0x80000fff region
as PCI memory write transactions.

I suppose we could add a check to verify that devfn == 0. However does
the above ranges property not imply that the brige on bus 0, device 1
has a 32-bit memory space from 0x80000000 to 0x80000fff and the bridge
on bus 0, device 2 has a 32-bit memory space from 0x80001000 to
0x80001fff? Which matches with the wording in the spec that the
"assigned-addresses" correspond to the bridge's BARs.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQPd7AAoJEN0jrNd/PrOhRNcP/iraYCwX+KmGOOQlo9PHgmk8
7GjF/A5uZYpq6AQWDlr9yMAdraCYHOQDH8LgGfkxiMb+6E7hkToO+frqqdwHEnyn
csxQ6FKiWdyp1hiV0diUdEXaV0wKOmyYC24S105VFaX4MZnI9eIvsk6eBubd/B0j
E+J0b46QzpGP53KOBtLUgSxoDr6IzF4Afvxkl1V7GK9M1mufMhoNE7EYuhPjJwnY
OAHOnSXnjvZIClWnJaEeJ3hZ6wzAhfjY27xLWaqy2Lt2zWgdJfn/tZZNZnI/meQw
ziK6uyQfmyEF3N9u6FnYEbtpCMtiW5hCTgbK3+GBBGy7jTEYvWszmTytzJTvys7h
bsQmTC2NE5Z0/iqg0w7Ci/F8RWli2U/PRvfJcBtKecJwjTwU9lW+7gl6Gq1+DPUQ
04hptJlEbU8XmDR7HWqL33G/CQuwI43vWtjI2jdRlWPBmdDBLHVtlIduQio711qK
Wo6E8zLZe9kqSanhDUhLiKgz6Ac1jGToIRW2ev00kkBlNFPLNIhIoFgHlY6QQBLd
0c0EfL7o5z4AiLUSO3RBTIsZkQHa6b4RWNbunq7bWpXECko5H0ltmNJGNahYy5bR
rOI84J+TvXdRX+UkKFpkTYfCQBbzd8MO+M84RKHr7pougk+4oUsXSkV18O6VBK0c
YzQj/++qBYC+z7rifCp3
=L5o1
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
