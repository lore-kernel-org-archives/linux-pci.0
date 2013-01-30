Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:60940 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab3A3EM3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 23:12:29 -0500
Date: Tue, 29 Jan 2013 21:12:19 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
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
Message-ID: <20130130041219.GA5734@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo6ajS87mh7u58sLeN6oL5ixiPhaD7O7BrH1Av28mTk=qQ@mail.gmail.com>
 <201301292306.14012.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301292306.14012.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 11:06:13PM +0000, Arnd Bergmann wrote:
> On Tuesday 29 January 2013, Bjorn Helgaas wrote:
> > If you need this, it can be done in architecture code, can't it?  It's
> > true that there's nothing architecture-specific in this patch (other
> > than the fact that ARM is the only arch that needs it), but I'm not
> > sure there's anything useful for sharing here.
> 
> Since we're moving the host bridge code to drivers/pci/host now, I think
> this code should live in the same place. It's entirely possible that
> it will be shared between arch/arm and arch/arm64, although I would
> hope that we can do away with the emulated bridge code entirely.

This sounds right to me, this is part of the host bridge driver for
various Marvell SOCs, so these days it should live in the
drivers/pci/host or related, not arch/arm.
 
> > In fact, it seems like what you're after is not so much an emulated
> > bridge that has no corresponding hardware, as it is a wrapper that
> > presents a standard PCIe interface to hardware that exists but doesn't
> > conform to the PCIe spec.  If you really do need to ultimately connect
> > this pci_sw_pci_bridge to a piece of hardware, that will certainly be
> > arch-specific.
> 
> As Jason Gunthorpe suggested, we might not need this at all, if the
> Linux PCI code can be convinced not to need a configuration space
> for the devices that in case of the Marvell hardware don't provide
> one.

To be clear, that isn't what I was talking about.. Just to clarify a
few things in the last couple emails:

The PCI 'host bridge configuration space' software emulation code in
patch #7 is not necessary. Bjorn and Thierry both confirm this.

In several places when Bjorn/Arnd talked about a 'host bridge' this is
referring to (more or less) the PCI host *driver* and its attachment
to the kernel interfaces. Specifically a configuration access
mechanism and the resource ranges to allocate against. It has nothing
to do with the bus 0, device 0, function 0 host bridge config space.

Arnd's suggestion to use multiple domains would be broadly equivilent
to the first iteration of this driver - essentially the driver would
manage one link and there would be multiple instances. This gets us
back to where Thomas started - there is currently no code to do cross
domain resource allocation, and static allocation is not possible with
so many links on the chip.

Bjorn is quite right, the purpose of the PCI-PCI SW layer is to bind
the non-standard registers in the Marvell SOC to the standard PCI-E
config interface so the kernel can control it normally. This corrects
what is, IMHO, a defect in the Marvell hardware.

The alternative is to add some kind of cross-domain resource
allocation (or similar) to the PCI core code - however this would
*only* be required to support hardware broken in the same way as
Marvell, so I feel a bit leery about doing that kind of work before we
know if other chips require this. (early on in the discussion there
was some thought that Tegra might also be similary broken, but it
turned out to be pretty much fine, with a bit of driver work)

So, I still think using a SW layer to provide a compliant PCI-PCI
bridge configuration space for the Marvell hardware is the best way
forward..

Jason
