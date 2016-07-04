Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46446 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932681AbcGDJ4a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Jul 2016 05:56:30 -0400
Date: Mon, 4 Jul 2016 10:56:27 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Message-ID: <20160704095627.GG8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com>
 <4061641.rLdO1g8OBR@wuerfel>
 <20160701160923.GF8609@e106497-lin.cambridge.arm.com>
 <3872522.jdXcQClxV5@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3872522.jdXcQClxV5@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 01, 2016 at 06:30:24PM +0200, Arnd Bergmann wrote:
> On Friday, July 1, 2016 5:09:23 PM CEST Liviu Dudau wrote:
> > > > > 
> > > > > The main idea is to pull the allocation of 'struct pci_host_bridge' out
> > > > > of the registration, and let individual host drivers and architecture
> > > > > code fill the members before calling the registration function.
> > > > 
> > > > That's how we got into the arch/arm mess that we currently have. The host driver
> > > > should not drive the instantiation of the pci_host_bridge structure because it
> > > > will prevent you from having two drivers running at the same time.
> > > 
> > > Can you clarify that? I don't see what prevents two drivers from each
> > > creating a pci_host_bridge structure and passing it into
> > > pci_host_bridge_register().
> > 
> > Maybe I'm exagerating a bit, but I always disliked the pci_common_init() function and
> > the way it is creating a pci_host_bridge while relying on hw_pci hooks to get
> > things ready. I'm pretty sure there are still issues around the fact that a lot of
> > platform drivers have a subsys_initcall() function that calls pci_common_init(). I
> > don't want us to go down that path again.
> 
> I see what you mean now, and I agree we don't want to do this like
> pci_common_init(), but the patch here does a number of things very
> differently:
> 
> - it's not architecture specific
> - it is not tied into architecture specific pcibios_* functions
> - it does not create multiple bridges at once
> - it does not have three levels of callbacks going back and forth,
>   the idea is to eventually end up with one structure for the
>   callback pointers including those that today are done as __weak
>   functions.
> 
> Today we only have four callers of pci_common_init_dev that probe the
> PCI host from DT: cns3xxx, versatile, mvebu and rcar-gen2. I hope
> we can replace all of them with the new method here directly and
> not take any intermediate steps.
> 
> The users of pci_common_init() (not _dev) are limited to board files
> on really old platforms that are either not getting updated (ixp, iop,
> footbridge, ks8695, mv78xx0, sa1100) or that have DT based replacement
> code coming (dove, orion5x, cns3xxx, integrator).
> 
> > Don't get me wrong, clearly someone needs to create an instance of pci_host_bridge.
> > What I want people to accept is that in the PCI(e) architecture there is nothing that
> > stops a piece of HW that used to be the bridge between host and underlying bus into
> > becoming the bridge between a higher PCI(e) bus and the bus underneath. If the writes
> > to the configuration registers happens somehow, the Host Bridge doesn't even know if
> > it is talking to the actual host. Can the driver in that case make sure it did not made
> > assumptions that were tied to a specific SoC implementation?
> 
> Sorry, I'm not really following what you mean with that, or what the
> consequence is for the Linux implementation. Can you try to rephrase this?

I'm thinking drivers expecting to drive the bridge between the host and the PCI bus.
When that HW is used to bridge between another bus (PCI or PCIe) because the
functionality was there all the time in terms of signals, the driver's assumptions
break down. But maybe I'm being too theoretical and such beasts don't exist? (I remember
seeing a network card that had native PCI chip plus an added PCIe-to-PCI bridge and
the driver was tripping badly, but I can't remember the exact details.

Best regards,
Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
