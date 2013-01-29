Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:51235 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab3A2RmG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jan 2013 12:42:06 -0500
Date: Tue, 29 Jan 2013 10:42:05 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Maen Suleiman <maen@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
Message-ID: <20130129174205.GD25646@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de>
 <5106F5CB.8050304@wwwdotorg.org>
 <20130128220904.GA21446@obsidianresearch.com>
 <20130128231829.6b205c3c@skate>
 <20130128222348.GA21628@obsidianresearch.com>
 <20130128233048.2ab6a6d2@skate>
 <20130128225105.GA21935@obsidianresearch.com>
 <20130129110119.07cb9ef3@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130129110119.07cb9ef3@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 29, 2013 at 11:01:19AM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Mon, 28 Jan 2013 15:51:05 -0700, Jason Gunthorpe wrote:
> 
> > > > I'm refering to your earlier question about what PCI IDs to use for
> > > > the SW emulated devices. If there is no need for the host bridge then
> > > > you only need 1 PCI ID (for the root port bridge) and you can probably
> > > > fairly safely re-use the one in the Marvell config space of the HW.
> > > 
> > > Ah, ok, I see. But isn't a host bridge needed to bind all the
> > > PCI-to-PCI bridges under a single bus, in order to get the global
> > > resource assignment I was referring to?
> > 
> > The PCI-E spec requires it, but AFAIK it doesn't actually *do*
> > anything on Linux, and Linux doesn't require it.
> > 
> > I thought Thierry did this experiment and decided it wasn't necessary:
> 
> Could you detail what would be visible PCI bus topology if I remove the
> emulated PCI host bridge? (And keeping one PCI-to-PCI bridge per PCIe
> interface) ?

So if this is what you have now...

-[0000:00]-+-00.0 <- Host bridge
           +-10.0 <- Bridge
           +-11.0 <- Bridge
           +-12.0 <- Bridge

Then removing the config space at 00.0 (ie the host bridge) will give
you:

-[0000:00]-+-10.0 <- Bridge
           +-11.0 <- Bridge
           +-12.0 <- Bridge

The 'host bridge' isn't a bridge in the PCI-PCI sense, it is just a
normal device at bus 0, device 0, function 0.

Jason
