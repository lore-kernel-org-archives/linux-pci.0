Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53368 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753194Ab3HFKgj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 06:36:39 -0400
Date: Tue, 6 Aug 2013 12:36:18 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Finn Hoffmann <finn@uni-bremen.de>
Subject: Re: [PATCH 3.11-rc] pci: mvebu: disable prefetchable memory support
 in PCI-to-PCI bridge
Message-ID: <20130806123618.6b95224e@skate>
In-Reply-To: <20130802174350.GA15787@obsidianresearch.com>
References: <1375364659-3228-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130802174350.GA15787@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Gunthorpe,

On Fri, 2 Aug 2013 11:43:50 -0600, Jason Gunthorpe wrote:

> > To achieve this, we simply make the prefetchable memory base a
> > read-only register that always returns 0. Reading/writing all the
> > other prefetchable memory related registers has no effect.
> 
> Looks good to me. It is very good that you were able to merge the
> downstream prefetchable BARs into the normal MMIO window.

Thanks.

> Though looking at the original thread I really wonder if something
> else is wrong here as well. The ethernet should not have only
> prefetchable BARs.
> 
> For instance, I found this link:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=448712
> 
> Which shows a more resonable arrangement:
> 
> 02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
>         Region 0: I/O ports at e800 [size=256]
>         Region 2: Memory at dffff000 (64-bit, non-prefetchable) [size=4K]
>         Region 4: Memory at deff0000 (64-bit, prefetchable) [size=64K]
>         Expansion ROM at dffc0000 [disabled] [size=128K]
> 
> vs Finn's:
> 
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller (rev)
>          Subsystem: Realtek Semiconductor Co., Ltd. TEG-ECTX Gigabit PCI-E Adapter [Trendnet]
>          Flags: bus master, fast devsel, latency 0, IRQ 9
>          I/O ports at 10000 [size=256]
>          Memory at e0014000 (64-bit, prefetchable) [size=4K]
>          Memory at e0010000 (64-bit, prefetchable) [size=16K]

Right, but Finn had the same output in 3.10, where the old Kirkwood PCI
driver was used. So it doesn't seem to be related to the driver, but
maybe to how the hardware works?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
