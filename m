Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49509 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001Ab3BMJlG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 04:41:06 -0500
Date: Wed, 13 Feb 2013 10:40:51 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP
 systems
Message-ID: <20130213104051.07bcffe0@skate>
In-Reply-To: <201302130929.21326.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<201302122259.54073.arnd@arndb.de>
	<20130213092358.4991ba43@skate>
	<201302130929.21326.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Wed, 13 Feb 2013 09:29:21 +0000, Arnd Bergmann wrote:

> > Hum, why not, but I would definitely prefer to wait for the conversion
> > of older platforms instead of duplicating this code. But if you feel
> > like it's the right solution, I'll do it.
> 
> It's not something we do a lot, but in this case, I think it's better
> if it lets us avoid adding the platform specific include path, which I
> really want to avoid here.

Ok.

> > The arch/arm/mach-mvebu/addr-map.c depends on
> > arch/arm/plat-orion/addr-map.c, so any change on this will affect
> > mach-kirkwood, mach-orion5x, mach-dove and mach-mv78xx0. As you can
> > see, we have to take into account the existing code, and I don't think
> > it's realistic to have a perfect solution immediately.
> 
> Yes, I realize this. I was thinking we would move all at least the
> file from plat-orion, and the header file. I don't care much whether
> we also move the platform specific setup from mach-*/addr-map.c,
> it works either way.

Ok.


> We don't need to do a complete overhaul of that code right now, but
> if we agree on a place where it can go, then I think we should
> move it now as just one extra patch to get rid of the header
> dependency. In the worst case, moving just the header file to
> include/linux would work, too.

I'll try to cook something for this.

> > Indeed. So maybe I should mark this resource as being IORESOURCE_MEM
> > in the DT.
> 
> The DT seems fine here, just the code that interprets it is a little
> unusual. Maybe you can change the calling convention of that function
> to pass the type of resource you want as an argument?

Erm? The type of the resource is encoded into the DT:

+				  0x81000000 0 0	  0xc0000000 0 0x00010000   /* downstream I/O */
+				  0x82000000 0 0	  0xc1000000 0 0x08000000>; /* non-prefetchable memory */

>From http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge:

     phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr
    phys.mid cell: hhhhhhhh hhhhhhhh hhhhhhhh hhhhhhhh
    phys.low cell: llllllll llllllll llllllll llllllll 

 ss: space code

    00: configuration space
    01: I/O space
    10: 32 bit memory space
    11: 64 bit memory space 

So the 0x81 at the beginning of the first line means I/O space, the
0x82 at the beginning of the second line means 32 bits memory space.
The of_pci_process_ranges() function simply decodes those informations
and fills the struct resource it returns with the appropriate resource
type.

So passing the resource type as argument to of_pci_process_ranges()
doesn't make much sense to me.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
