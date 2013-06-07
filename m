Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:50895 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab3FGRBI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2013 13:01:08 -0400
Date: Fri, 7 Jun 2013 19:00:58 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
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
Message-ID: <20130607190058.112d8d4a@skate>
In-Reply-To: <20130607150814.GU23859@titan.lakedaemon.net>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130606185110.GP23859@titan.lakedaemon.net>
	<20130607102304.3c42773b@skate>
	<20130607150814.GU23859@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Fri, 7 Jun 2013 11:08:14 -0400, Jason Cooper wrote:

> > 1-3 through Bjorn, 4-5 through tglx, 6-8 through you.
> > 
> > The only problem that I see is that 'irqchip: armada-370-xp: implement
> > MSI support' (which goes through tglx) has a build dependency on 'PCI:
> > Add registry of MSI chips' (which goes through Bjorn). This is due to
> > the IRQ controller using the msi_chip_add() function that is introduced
> > earlier in the PCI core.
> 
> Yeah, that's what I was afraid of...
> 
> > How would you solve that?
> 
> Let me take a closer look at it later today or this weekend.  I just
> wanted to make sure that we always defer to the appropriate maintainers
> first, and merge all through arm-soc as a last resort.

Now that I think of it, there is no problem in fact. Until you apply the
patch 'arm: mvebu: indicate that this platform supports MSI', which
modifies Kconfig to say that mvebu supports MSI, there is no way for
the user to enable CONFIG_PCI_MSI.

And since in the IRQ controller driver the MSI code is inside a #ifdef
CONFIG_PCI_MSI, this driver will build perfectly fine, as long as 'arm:
mvebu: indicate that this platform supports MSI' is not merged before
'PCI: Add registry of MSI chips'.

So we can perfectly let Bjorn take the three PCI patches, tglx take the
two IRQ controller patches, and you take the ARM stuff. The only thing
is that the ARM stuff should not surface until both the PCI patches and
the IRQ controller patches have landed in mainline.

But well, before even thinking of merging all this, I'd like to hear
from Bjorn about what he thinks of those patches.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
