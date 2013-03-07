Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:60111 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756100Ab3CGRuJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Mar 2013 12:50:09 -0500
Date: Thu, 7 Mar 2013 10:49:55 -0700
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
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130307174955.GC20840@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
 <20130306105441.4d24033e@skate>
 <20130306121118.GA17079@avionic-0098.mockup.avionic-design.de>
 <20130306180946.GA2433@obsidianresearch.com>
 <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130307080832.GD3451@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 07, 2013 at 09:08:32AM +0100, Thierry Reding wrote:

> Actually I do use device_type = "pciex" for the pci@1,0 and pci@2,0
> nodes which was suggested back when I first posted this series. Yet the
> address translation still works properly. And it should since they are
> translated to the parent bus which is used to access the configuration
> space window for each root port.

Right - pciex != pci - as you note:

> Looking at the code it looks indeed like the OF core only matches on
> "pci" (and "vci"), but not "pciex". Perhaps I should change both nodes
> to device_type = "pci" and see what the results are.

The string 'pci' engages the special behavior, pciex isn't a valid
keyword.

This is why I keep saying these bindings need to use 'device_type = "pci"' :)

> > Both have various problems, but I think I prefer the first one as it
> > doesn't conflate the contoller registers and host apertures in a
> > single ranges..
> 
> I think a better alternative would be (and this matches what Thomas has
> said elsewhere) to use something like the first alternative but move the
> regs property into the pcie@0,X nodes. That would save us from having to
> index a property in the parent. At least from a DT point of view I find
> that to be a more consistent representation.

You are thinking a new property 'host-controller-regs' or the like?

> However that would probably not work out-of-the-box with the current OF
> core because of_address_to_resource() won't know how to find the new
> property. The assigned-addresses alternative seems to be the only one
> that would work on the current OF core and achieve proper address
> translation. But it doesn't seem like a good solution either since it
> repurposes the meaning of the property and therefore isn't any better
> than encoding the same information in the reg property.

Except that reg is specifically not supposed to be handling CPU bus
addresses and assigned-addresses is.

Adding a hidden non-standard BAR to model the hidden non-standard
memory region associated with the bridge is a stretch, but it is not a
very big stretch...

In any event, regs should not be used, and something needs to be
decided!

Regards,
Jason
