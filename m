Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:49713 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906Ab3A1Ty6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Jan 2013 14:54:58 -0500
Date: Mon, 28 Jan 2013 12:55:01 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 08/27] pci: implement an emulated PCI-to-PCI bridge
Message-ID: <20130128195501.GD17722@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130128193516.GB17722@obsidianresearch.com>
 <20130128203947.07332698@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130128203947.07332698@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 08:39:47PM +0100, Thomas Petazzoni wrote:

> > In the Marvell case, this capability can be constructed by pulling
> > data from the the Express End Point capability of the PCI-E port:
> 
> I am not sure what you mean by "pulling". Do you mean that I should get
> informations from the real PCIe interface, from within the emulated
> PCI-to-PCI bridge implementation? This would unfortunately not be
> really nice, because until now, the PCI-to-PCI bridge emulation is
> clearly separated from the Marvell PCIe driver itself. Of course, it
> could register a hook or something like that, so that the emulated
> PCI-to-PCI bridge could potentially call back into the Marvell PCIe
> driver.

Yes, a callback would be needed to the main driver and IIRC the driver
can read/write the end port link info config regsiters via MMIO. They
probably need a bit of massaging to be in root port format, but
otherwise it should be straightforward..

> I'll have to dig a little bit more about this capability to see how it
> works exactly.

All ports have registers to report and control the link, but the root
port and end port versions are a bit different, so the goal is to read
the end port formatted registers and map them into the root port
format so that userspace can properly see the link state and
configuration.

Jason
