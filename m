Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:52046 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933201Ab3CMT7L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Mar 2013 15:59:11 -0400
Date: Wed, 13 Mar 2013 13:59:01 -0600
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
Message-ID: <20130313195901.GA26550@obsidianresearch.com>
References: <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
 <20130313170205.GB24042@obsidianresearch.com>
 <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130313192628.GA28714@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 13, 2013 at 08:26:28PM +0100, Thierry Reding wrote:

> As Mitch already said there's very little chance that the specification
> update will be ratified through IEEE, so I think that we might just as
> well put a corresponding text somewhere below Documentation/devicetree.

Sure, I'm fine with that.
 
> Also note that this has absolutely nothing to do with ECAM. All I'm
> proposing is to allow the reg property of a root port to be translated
> into a CPU addressable memory region through the ranges property. This
> turns out to actually work properly with the current OF core in Linux.

ECAM is the only standard based mechanism that could possibly use this
new config space ranges concept. Whatever you do for tegra shouldn't
stomp on the possibility of making that work in the future. So at
least think about how ECAM could be modeled for a few mins before
going ahead.

Tegra is the non-standard unusual case here, an update to the PCI OF
binding should be of general use.

> > Anyhow, I think this has been hashed to death, as long as your final
> > binding has the 'device_type = pci' on the pcie-controller node I
> > think it will be fine.
> 
> No. The pcie-controller is *not* a PCI device. It is a PCI host bridge.
> It is the instance that translates from the platform to the PCI bus. Why
> should it be device_type = "pci"? 

Spec says so, Mitch said so, other PCI host bridge bindings in the
tree work like this. Do a grep in the powerpc tree, for instance.

arch/x86/platform/ce4100/falconfalls.dts is a pretty comprehensive
example.

> And we've also been over this before, making that change stops the
> proposed binding from working properly because the entry in the reg
> property can't be translated into a CPU addressable memory region.

Sigh, that's because the change makes things follow the OF PCI
spec. The Linux OF core follows the spec. Config space ranges binding
is specifically *defined to not work* in the spec. Why should it work
today?

You have to deal with this problem somehow, and omitting the top level
device_type is not a solution.

Jason
