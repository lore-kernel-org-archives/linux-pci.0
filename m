Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59537 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297Ab3BMSyN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 13:54:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
Date: Wed, 13 Feb 2013 18:53:14 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de> <201302122305.28467.arnd@arndb.de> <20130213003224.GA32535@obsidianresearch.com>
In-Reply-To: <20130213003224.GA32535@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302131853.14617.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 13 February 2013, Jason Gunthorpe wrote:
> On Tue, Feb 12, 2013 at 11:05:28PM +0000, Arnd Bergmann wrote:
> > On Tuesday 12 February 2013, Jason Gunthorpe wrote:
> > > PCI-E hotplug can be supported through the generic /sys/bus/pci/rescan
> > > mechanism, which forces a rediscovery/re-evaluation of all the buses
> > > in the system. The PCI core is smart enough to know what it can/can
> > > not reassign and can move the bridge windows around (IIRC most of the
> > > issues here are resolved these days?).
> > > 
> > > For PCI-E, the root port bridge can be placed anywhere in the host
> > > aperture, so as long as the host aperture isn't filled the core can
> > > allocate a memory region for the now active port.
> > > 
> > > Thomas's driver should support this as the regions and windows are all
> > > properly dynamic.
> > 
> > Ah, so you only allow hotplugging into the root ports, but not behind
> > additional bridges that have active devices on them, right?
>  
> > I guess that is a common limitation for PCIe hotplugging.
> 
> In all the cases I've worked with, it has been a root port hot plug,
> but I could imagine something like ExpressCard requiring a second
> bridge.

Ok, I see.

> The standard answer is to leave appropriate gaps. My *guess* on this
> matter is that on x86 the gaps are left, as appropriate, by the boot
> firmware. Eg an ExpressCard slot will always have a window assigned to
> its bridge and Linux would typically not reassign it (or similar).
> 
> PCI core support for firmware-less embedded will someday need to do
> something similar, eg via a special DT attribute on hot plug capable
> ports.

I saw that the PCI core reserves 2MB memory space and 256 bytes of
I/O space per hotplug capable bridge by default, and you can override
these at boot time if you need more. I wonder if this means that
we end up using two of the precious address space windows for each
unused root port to already map these at boot time, and it certainly
works for most adapters, but this does not seem better than assigning
static windows of the same size at boot time for each port.

> Just to circle back on this whole thread - Thomas's solution is pretty
> good, it covers pretty much all the use cases. I think it is a good
> place to start, and as the firmware-less 'drivers/pci/host' concept
> develops the right support will eventually come, as everyone is now
> aware of the need to control the host bridge aperture from the core
> PCI code.

I agree the solution is not all that bad, I just want to be convinced
that it actually has advantages over the simpler approaches.

	Arnd
