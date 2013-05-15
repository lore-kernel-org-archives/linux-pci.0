Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65380 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab3EOWmJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 May 2013 18:42:09 -0400
Date: Wed, 15 May 2013 15:42:06 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Xenia Ragiadakou <burzalodowa@gmail.com>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [OPW kernel] dma_set_coherent_mask
Message-ID: <20130515224206.GF17398@xanatos>
References: <20130515053911.GD17398@xanatos>
 <Pine.LNX.4.44L0.1305151030100.1711-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1305151030100.1711-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 15, 2013 at 10:37:00AM -0400, Alan Stern wrote:
> On Tue, 14 May 2013, Sarah Sharp wrote:
> > We do allocate memory using DMA pools, and we do want 64-bit context
> > addresses if the xHCI host controller can handle it.
> > 
> > The xHCI driver calls dma_set_mask, but not dma_set_coherent_mask():
> > 
> >                 temp = xhci_readl(xhci, &xhci->cap_regs->hcc_params);
> >                 if (HCC_64BIT_ADDR(temp)) {
> >                         xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
> >                         dma_set_mask(hcd->self.controller, DMA_BIT_MASK(64));
> >                 } else {
> >                         dma_set_mask(hcd->self.controller, DMA_BIT_MASK(32));
> >                 }
> > 
> > Alan, should it be calling dma_set_coherent_mask()?  I think I may have
> > noticed the context addresses were never 64-bit addresses, but I didn't
> > think to look whether the host supported 64-bit addresses.  I just
> > assumed it could only handle 32-bit addresses.
> 
> If you're using 64-bit DMA then you almost certainly do want to call
> dma_set_coherent_mask().  On the plus side, it is guaranteed that if
> dma_set_mask() succeeds with a particular mask value then
> dma_set_coherent_mask() for the same mask value will also succeed.

So we need to call both dma_set_coherent_mask() and dma_set_mask()?  Or
just dma_set_coherent_mask()?

Ksenia, thanks for catching this!  You should send a patch to fix it
once Alan clarifies this.

Sarah Sharp
