Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:57700 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab3HBRnz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 2 Aug 2013 13:43:55 -0400
Date: Fri, 2 Aug 2013 11:43:50 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3.11-rc] pci: mvebu: disable prefetchable memory support
 in PCI-to-PCI bridge
Message-ID: <20130802174350.GA15787@obsidianresearch.com>
References: <1375364659-3228-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375364659-3228-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 01, 2013 at 03:44:19PM +0200, Thomas Petazzoni wrote:
> The Marvell PCIe driver uses an emulated PCI-to-PCI bridge to be able
> to dynamically set up MBus address decoding windows for PCI I/O and
> memory regions depending on the PCI devices enumerated by Linux.
> 
> However, this emulated PCI-to-PCI bridge logic makes the Linux PCI
> core believe that prefetchable memory regions are supported (because
> the registers are read/write), while in fact no adress decoding window
> is ever created for such regions. Since the Marvell MBus address
> decoding windows do not distinguish memory regions and prefetchable
> memory regions, this patch takes a simple approach: change the
> PCI-to-PCI bridge emulation to let the Linux PCI core know that we
> don't support prefetchable memory regions.
> 
> To achieve this, we simply make the prefetchable memory base a
> read-only register that always returns 0. Reading/writing all the
> other prefetchable memory related registers has no effect.

Looks good to me. It is very good that you were able to merge the
downstream prefetchable BARs into the normal MMIO window.

Though looking at the original thread I really wonder if something
else is wrong here as well. The ethernet should not have only
prefetchable BARs.

For instance, I found this link:

https://bugzilla.redhat.com/show_bug.cgi?id=448712

Which shows a more resonable arrangement:

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
        Region 0: I/O ports at e800 [size=256]
        Region 2: Memory at dffff000 (64-bit, non-prefetchable) [size=4K]
        Region 4: Memory at deff0000 (64-bit, prefetchable) [size=64K]
        Expansion ROM at dffc0000 [disabled] [size=128K]

vs Finn's:

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev)
         Subsystem: Realtek Semiconductor Co., Ltd. TEG-ECTX Gigabit PCI-E Adapter [Trendnet]
         Flags: bus master, fast devsel, latency 0, IRQ 9
         I/O ports at 10000 [size=256]
         Memory at e0014000 (64-bit, prefetchable) [size=4K]
         Memory at e0010000 (64-bit, prefetchable) [size=16K]

Regards,
Jason
