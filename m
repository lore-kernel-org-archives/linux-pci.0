Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:55144 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755581Ab3CGUCo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Mar 2013 15:02:44 -0500
Date: Thu, 7 Mar 2013 13:02:35 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
Message-ID: <20130307200235.GB20695@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
 <20130307174955.GC20840@obsidianresearch.com>
 <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130307194830.GA1811@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 07, 2013 at 08:48:30PM +0100, Thierry Reding wrote:
> On Thu, Mar 07, 2013 at 10:49:55AM -0700, Jason Gunthorpe wrote:
> > On Thu, Mar 07, 2013 at 09:08:32AM +0100, Thierry Reding wrote:
> [...]
> > > > Both have various problems, but I think I prefer the first one as it
> > > > doesn't conflate the contoller registers and host apertures in a
> > > > single ranges..
> > > 
> > > I think a better alternative would be (and this matches what Thomas has
> > > said elsewhere) to use something like the first alternative but move the
> > > regs property into the pcie@0,X nodes. That would save us from having to
> > > index a property in the parent. At least from a DT point of view I find
> > > that to be a more consistent representation.
> > 
> > You are thinking a new property 'host-controller-regs' or the like?
> 
> Well, something shorter would be nice, but that's the general idea, yes.
> As I mentioned before, for Tegra these registers aren't actually any
> controller specific registers but rather a window to access the PCI
> configuration space for the root ports.

Yes, I understand - but in this DT model configuration space access is
a host controller function, not a PCI-device function. Anyhow I was
also thinking that by the choice of the name it could do translation
from the host-controller scope, not from the bridge scope - so the
extra elements in ranges could be avoided as well. Hence the name..

> I don't think assigned-addresses is a good fit either. The PCI binding
> document is equally specific about it as it is about the reg property.
> So in my opinion a separate property would be a better choice. The only
> big obstacle is that it needs to be somehow hooked up with the OF core
> so that proper address translation can be performed.

Yes, agreed.

My suggestion is to get the OF experts like GKL/Rob H/etc to weigh in
on a preferred approach to this problem with the goal of standardizing
across all PCI host drivers. Seems like there are 2 main options
(outside regs + regnames/etc or new 'regs' in the bridge) and 1 hacky
one (assigned addresses)

> One possible solution that wouldn't be too hard to implement is to
> provide a new function (say of_get_named_address()) similar to
> of_get_address() which doesn't get the name of the register property
> from the struct of_bus but from a parameter and call that function from
> another new function similar to of_address_to_resource() that also gets
> the property name from a parameter. I can't think of a better name for
> the latter than of_named_address_to_resource(), which is rather long.

Seems like a reasonable API, maybe pass in a be32*/length pointer
instead of a name to be more flexible?

Cheers,
Jason
