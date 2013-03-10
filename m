Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:40891 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab3CJPGU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Mar 2013 11:06:20 -0400
Date: Sun, 10 Mar 2013 16:06:15 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Mitch Bradley <wmb@firmworks.com>
Cc: Rob Herring <robherring2@gmail.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Nadav Haklai <nadavh@marvell.com>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130310160615.14ba099c@skate>
In-Reply-To: <513C1473.60600@firmworks.com>
References: <20130212223511.GB31555@obsidianresearch.com>
	<20130306105441.4d24033e@skate>
	<20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
	<20130306180946.GA2433@obsidianresearch.com>
	<20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
	<20130307174955.GC20840@obsidianresearch.com>
	<20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
	<20130307200235.GB20695@obsidianresearch.com>
	<20130307204726.GB1811@avionic-0098.mockup.avionic-design.de>
	<51392B4D.9040404@gmail.com>
	<20130308071443.GA5772@avionic-0098.mockup.avionic-design.de>
	<513A7044.1020700@gmail.com>
	<513C1473.60600@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Mitch Bradley,

On Sat, 09 Mar 2013 19:04:51 -1000, Mitch Bradley wrote:
 
> As stated in my recent reply to Jason, I thing the correct property is
> "ranges".  "Ranges" translates mappable child address space addresses
> into parent addresses, and that is exactly what is going on.  A specific
> subset of config addresses is mappable into parent MMIO space.

The PCI configuration space is *not* mapped in the MMIO space on
Marvell hardware. In the MMIO space of each PCIe interface, there are
many registers, only *two* of which are dedicated to accessing the PCI
configuration space:

 * One register to set the offset in the PCI configuration space.

 * One register to read or write a value in the PCI configuration, at
   the offset specified in the first register.

See the implementation of mvebu_pcie_hw_rd_conf() and
mvebu_pcie_hw_wr_conf() in the driver.

So really, the values specified in the reg = <...> property are *not*
the PCI configuration spaces mapped in the MMIO space. They represent a
bunch of per PCIe interface registers used to configure them, get the
status of the link... and access, through an indirect mechanism, the
PCI configuration space.

Does this helps?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
