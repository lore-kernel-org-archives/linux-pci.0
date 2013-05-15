Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39416 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757201Ab3EOOhB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 May 2013 10:37:01 -0400
Date: Wed, 15 May 2013 10:37:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
cc: Xenia Ragiadakou <burzalodowa@gmail.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [OPW kernel] dma_set_coherent_mask
In-Reply-To: <20130515053911.GD17398@xanatos>
Message-ID: <Pine.LNX.4.44L0.1305151030100.1711-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 14 May 2013, Sarah Sharp wrote:

> On Wed, May 15, 2013 at 05:41:12AM +0300, Xenia Ragiadakou wrote:
> > Hi Sarah, (again)
> > 
> > Also I noticed that  dma_set_coherent_mask() is not called somewhere,
> > which according to DMA-API-HOWTO.txt, means the even if the DMA mask
> > is set to 64 bits by dma_set_mask, dma_alloc_coherent and
> > dma_pool_alloc wont return 64 bit addresses (32 MSbits wont be
> > addressed).
> 
> Another good question for Alan, and the USB and PCI list.

This does sound like a bug.  The PCI core initializes all devices by
default with 32-bit masks for DMA and coherent DMA.  (PCI-E, PCI-X, or
other extensions may have more liberal policies.)  If a larger mask can
work, the driver is responsible for setting it up.

> (Alan, Ksenia is one of the applicants for the FOSS Outreach Program for
> Women that I've been coordinating: http://kernelnewbies.org/OPWIntro)
> 
> We do allocate memory using DMA pools, and we do want 64-bit context
> addresses if the xHCI host controller can handle it.
> 
> The xHCI driver calls dma_set_mask, but not dma_set_coherent_mask():
> 
>                 temp = xhci_readl(xhci, &xhci->cap_regs->hcc_params);
>                 if (HCC_64BIT_ADDR(temp)) {
>                         xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
>                         dma_set_mask(hcd->self.controller, DMA_BIT_MASK(64));
>                 } else {
>                         dma_set_mask(hcd->self.controller, DMA_BIT_MASK(32));
>                 }
> 
> Alan, should it be calling dma_set_coherent_mask()?  I think I may have
> noticed the context addresses were never 64-bit addresses, but I didn't
> think to look whether the host supported 64-bit addresses.  I just
> assumed it could only handle 32-bit addresses.

If you're using 64-bit DMA then you almost certainly do want to call
dma_set_coherent_mask().  On the plus side, it is guaranteed that if
dma_set_mask() succeeds with a particular mask value then
dma_set_coherent_mask() for the same mask value will also succeed.

Ala Stern

