Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33787 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab3EPRT0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 May 2013 13:19:26 -0400
Date: Thu, 16 May 2013 10:19:25 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Xenia Ragiadakou <burzalodowa@gmail.com>,
	linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [OPW kernel] dma_set_coherent_mask
Message-ID: <20130516171925.GA4700@xanatos>
References: <20130515224206.GF17398@xanatos>
 <Pine.LNX.4.44L0.1305161002340.1096-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1305161002340.1096-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 10:11:00AM -0400, Alan Stern wrote:
> On Wed, 15 May 2013, Sarah Sharp wrote:
> 
> > > If you're using 64-bit DMA then you almost certainly do want to call
> > > dma_set_coherent_mask().  On the plus side, it is guaranteed that if
> > > dma_set_mask() succeeds with a particular mask value then
> > > dma_set_coherent_mask() for the same mask value will also succeed.
> > 
> > So we need to call both dma_set_coherent_mask() and dma_set_mask()?  Or
> > just dma_set_coherent_mask()?
> 
> It depends on what kind of DMA transfers you're going to do.  For
> streaming transfers (the ones that use dma_map_single() or
> dma_map_sg(), for example), you need to call dma_set_mask().  For
> coherent transfers (the ones that use dma_alloc_coherent() or
> dma_pool_create()), you need to call dma_set_coherent_mask().
> 
> If you want to do both kinds of transfers then you need to call both 
> routines.

I think we need the host to be able to do DMA to URB buffers that are
mapped with dma_map_single() or dma_map_sg(), since that's what
usb_hcd_submit_urb() uses.  So the driver needs to call dma_set_mask(),
which it does.

The xHCI endpoint rings are allocated from DMA pools, so we need to
call dma_set_coherent_mask() as well.  Missing that call explains why
I've never seen 64-bit endpoint rings, but I have seen 64-bit URB buffer
pointers.

Ksenia, do you want to add code to add the call to
dma_set_coherent_mask() in those two places in xhci_gen_setup()?  As I
mentioned, let's add this function call first, and then have a separate
commit refactor the copy-paste code into a new function.

Again, thanks for catching this and asking questions!

Sarah Sharp
