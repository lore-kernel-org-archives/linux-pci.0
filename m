Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:46944 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779Ab3A3E5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 23:57:01 -0500
Date: Tue, 29 Jan 2013 21:56:55 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130130045655.GE5734@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129155820.GB23505@n2100.arm.linux.org.uk>
 <20130129172055.0ca5f341@skate>
 <201301291645.08040.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301291645.08040.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 04:45:07PM +0000, Arnd Bergmann wrote:
> On Tuesday 29 January 2013, Thomas Petazzoni wrote:
> > And the Linux PCI resource allocation code complies with this, so that
> > if I have two PCI-to-PCI bridges (each having downstream a device with
> > an I/O BAR), then the first PCI-to-PCI bridge gets its I/O base address
> > register set to ADDR + 0x0, and the second bridge gets its I/O base
> > address set to ADDR + 0x1000. And this doesn't play well with the
> > requirements of Marvell address decoding windows for PCIe I/O regions,
> > which must be 64 KB aligned.
> 
> But we normally only assign a 64 KB I/O window to each PCI host bridge.
> Requiring PCI bridges to be space 64 KB apart would mean that we cannot
> actually support bridges at all.

The PCI resource code uses full 32 bit integers when it handles IO
addresses, so this actually does sort of work out.

However, Thomas how did you recover the high bits of the
IO window address from the bridge configuration? Are you reading the
struct resource directly? That probably causes problems with
hotplug/etc...

If you look back in your old emails I outlined a solution to this
using the MMU.

Jason
