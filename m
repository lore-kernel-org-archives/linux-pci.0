Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:52109 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932664Ab3CLVDj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Mar 2013 17:03:39 -0400
Date: Tue, 12 Mar 2013 15:03:28 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Mitch Bradley <wmb@firmworks.com>,
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
Message-ID: <20130312210328.GA22702@obsidianresearch.com>
References: <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 12, 2013 at 09:38:19PM +0100, Thierry Reding wrote:

> I've also verified that things actually do work with the binding that I
> proposed for Tegra, even if I add device_type = "pci" to the root port
> nodes. The reason is that the OF core looks up the type of the *parent*
> node to find a matching bus. This happens to be the pcie-controller node
> which is not a PCI device and therefore the address translation works
> properly.

Mitch pointed out early on that the parent node needs a 'device_type =
"pci"' as well.

The pcie-controller node would be classified as a 'bus node' according
to the spec.

Not going down the of_pci_* code paths for address translation at the
root port bridge nodes is certainly not right.

> ranges = <0x00000800 0 0 0x80000000 0 0x00001000   /* port 0 configuration space */
>           0x00001000 0 0 0x80001000 0 0x00001000   /* port 1 configuration space */

Section 12 says that the 'b,d,f' bits are 0 in ranges, so the above is
in conflict with that language:

 In particular, the phys.hi fields of the child address spaces in the
 "ranges" property for PCI does not contain the same information as
 "reg" property entries within PCI nodes. The only information that is
 present in "ranges" phys.hi entries are the non-relocatable,
 prefetchable and the PCI address space bits for which the entry
 applies. I.e., only the n, p and ss bits are present; the bbbbbbbb,
 ddddd, fff and rrrrrrrr fields are 0.

And the further requirement:

 When an address is to be mapped through a PCI bus bridge node, the
 phys.hi value of the address to be mapped and the child field of a
 "ranges" entry should be masked so that only the ss bits are compared.

Which is embodied by the code in of_bus_pci_map, meaning the OF core
won't even look at the bits in the high DW when searching ranges.

Regards,
Jason
