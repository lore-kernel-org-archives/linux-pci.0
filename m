Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61718 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759394Ab3BGXZm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 18:25:42 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
Date: Thu, 7 Feb 2013 23:25:23 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	"Eran Ben-Avi" <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"Russell King - ARM Linux" <linux@arm.linux.org.uk>
References: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com> <20130207183743.5c97d8b8@skate> <20130207182153.GB24688@obsidianresearch.com>
In-Reply-To: <20130207182153.GB24688@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201302072325.23483.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 07 February 2013, Jason Gunthorpe wrote:
> On Thu, Feb 07, 2013 at 06:37:43PM +0100, Thomas Petazzoni wrote:

> Right, someday you can have all 40 interrupts :)
> 
> This interrupt-map stuff is ugly, I looks like it was designed as a
> way for the firmware to communicate the per-device interrupt
> assignment to the OS - using it to describe a HW setup is a bit more
> tortured for sure..

It is usually used for PCI (non-PCIe) systems, where you can have
multiple slots on the same bus and each slot has its own four
interrupt lines routed to an upstream interrupt controller, not
necessarily the same one for each slot.

> Frankly, I think it should not be used in PCI-E drivers *at all*
> beacuse there is no need for an external interrupt routing
> description. [1]
> 
> PCI-E *only* has inband interrupt delivery, so the host driver has
> 100% of the information it needs to convert a INTx signal received on
> a link to a Linux interrupt number.
> 
> So in a PCI-E world translation should look like this:
>  - Start at the source device INTx
>  - Traverse up bridges performing INTx swizzling according to the
>    PCI-E spec
>  - When the host bridge is reached call into the host driver and pass
>    - The INTx number
>    - The bus/device/function of last bridge traversed
>  - The host bridge driver returns a Linux interrupt number.

It's the same as on PCI, except that there you stop when you reach
the slot that is physically connected to the interrupt controller.

> This *always* works for (compliant) PCI-E. An OF interrupt map is
> never, ever, needed. Providing a common mechanism can remove this
> complex OF stuff and ultimately help everyone :)
> 
> However, if interrupt-map is used, I strongly suspect it should be
> placed on each bridge node (as Andrew mentioned), and it should be
> very simple:
> 
> link@0 {
> reg = <0x800 0 0  0 0>; // Bus 0, Dev 0x10, Fn 0
> interrupt-mask = <0x0 0 0 7>;
> interrupt-map = <0x0000 0 0 1 &mpic 58 // INTA
>                  0x0000 0 0 2 &mpic 58 // INTB
>                  0x0000 0 0 3 &mpic 58 // INTC
>                  0x0000 0 0 4 &mpic 58>; // INTD
> }

The interrupt-map property only makes sense for the host bridge,
not for bridges below it, which don't normally get represented
in the device tree.

> Jason
> 1 - For PCI/PCI-X the physical INTx interrupt pins on any device,
>     anywhere in the system could by physically tied to any interrupt
>     ingress in the system. Even if they are behind bridges. It is a
>     total free for all.

I would not be surprised to see system that have a PCIe to
PCI bridge and slots behind that which are directly connected
to an upstream interrupt controller. In fact, I believe I have
worked on a system like that (IBM QS21 and QS22), and thankfully
the interrupt-map property did let us model this correctly.

	Arnd
