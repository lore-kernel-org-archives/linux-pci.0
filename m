Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13409 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755102Ab3FGPIu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 11:08:50 -0400
Date: Fri, 7 Jun 2013 11:08:14 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: Re: [PATCH v2 0/8] MSI support for Marvell EBU PCIe driver
Message-ID: <20130607150814.GU23859@titan.lakedaemon.net>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606185110.GP23859@titan.lakedaemon.net>
 <20130607102304.3c42773b@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130607102304.3c42773b@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 07, 2013 at 10:23:04AM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Thu, 6 Jun 2013 14:51:10 -0400, Jason Cooper wrote:
> > > Thierry Reding (1):
> > >   PCI: Introduce new MSI chip infrastructure
> > > 
> > > Thomas Petazzoni (7):
> > >   PCI: Add registry of MSI chips
> > >   irqchip: armada-370-xp: properly request resources
> > >   irqchip: armada-370-xp: implement MSI support
> > >   arm: mvebu: the MPIC now provides MSI controller features
> > >   pci: mvebu: add support for MSI
> > >   arm: mvebu: indicate that this platform supports MSI
> > >   arm: mvebu: link PCIe controllers to the MSI controller
> > > 
> > 
> > Is there a reason why the following breakdown wouldn't work?
> 
> No, it should work. And it's actually possible with how the patches are
> organized currently.

Ok.  good.

> > >  arch/arm/boot/dts/armada-370-xp.dtsi     |   1 +
> > >  arch/arm/boot/dts/armada-370.dtsi        |   1 +
> > >  arch/arm/boot/dts/armada-xp-mv78230.dtsi |   1 +
> > >  arch/arm/boot/dts/armada-xp-mv78260.dtsi |   1 +
> > >  arch/arm/boot/dts/armada-xp-mv78460.dtsi |   1 +
> > 
> > through mvebu/arm-soc
> 
> Patches 5 and 8.
> 
> > 
> > >  arch/arm/mach-mvebu/Kconfig              |   1 +
> > 
> > through mvebu/arm-soc after the other three have landed (v3.11-rc1)
> 
> Patch 7.
> 
> > >  drivers/irqchip/irq-armada-370-xp.c      | 186 ++++++++++++++++++++++++++++++-
> > 
> > through tglx
> 
> Patches 3 and 4.
> 
> > 
> > >  drivers/pci/host/pci-mvebu.c             |  21 ++++
> > >  drivers/pci/msi.c                        |  59 +++++++++-
> > >  drivers/pci/probe.c                      |   1 +
> > >  include/linux/msi.h                      |  22 ++++
> > >  include/linux/pci.h                      |   1 +
> > 
> > through Bjorn
> 
> Patches 1, 2 and 6.
> 
> So as you can see, the patches are already broken down in a way that
> allows each maintainer to pick its part. But I admit I could probably
> reorder them in the following way:
> 
>  1. PCI: Introduce new MSI chip infrastructure
>  2. PCI: Add registry of MSI chips
>  3. pci: mvebu: add support for MSI
>  4. irqchip: armada-370-xp: properly request resources
>  5. irqchip: armada-370-xp: implement MSI support
>  6. arm: mvebu: the MPIC now provides MSI controller features
>  7. arm: mvebu: link PCIe controllers to the MSI controller
>  8. arm: mvebu: indicate that this platform supports MSI
> 
> 1-3 through Bjorn, 4-5 through tglx, 6-8 through you.
> 
> The only problem that I see is that 'irqchip: armada-370-xp: implement
> MSI support' (which goes through tglx) has a build dependency on 'PCI:
> Add registry of MSI chips' (which goes through Bjorn). This is due to
> the IRQ controller using the msi_chip_add() function that is introduced
> earlier in the PCI core.

Yeah, that's what I was afraid of...

> How would you solve that?

Let me take a closer look at it later today or this weekend.  I just
wanted to make sure that we always defer to the appropriate maintainers
first, and merge all through arm-soc as a last resort.

> In any case, at this point I'd like first to have the ACK from Bjorn
> Helgaas and Arnd Bergmann on the general approach.

Of course.

thx,

Jason.
