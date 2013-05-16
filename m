Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40592 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753483Ab3EPOLB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 10:11:01 -0400
Date: Thu, 16 May 2013 10:11:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
cc: Xenia Ragiadakou <burzalodowa@gmail.com>,
	<linux-usb@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [OPW kernel] dma_set_coherent_mask
In-Reply-To: <20130515224206.GF17398@xanatos>
Message-ID: <Pine.LNX.4.44L0.1305161002340.1096-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 15 May 2013, Sarah Sharp wrote:

> > If you're using 64-bit DMA then you almost certainly do want to call
> > dma_set_coherent_mask().  On the plus side, it is guaranteed that if
> > dma_set_mask() succeeds with a particular mask value then
> > dma_set_coherent_mask() for the same mask value will also succeed.
> 
> So we need to call both dma_set_coherent_mask() and dma_set_mask()?  Or
> just dma_set_coherent_mask()?

It depends on what kind of DMA transfers you're going to do.  For
streaming transfers (the ones that use dma_map_single() or
dma_map_sg(), for example), you need to call dma_set_mask().  For
coherent transfers (the ones that use dma_alloc_coherent() or
dma_pool_create()), you need to call dma_set_coherent_mask().

If you want to do both kinds of transfers then you need to call both 
routines.

Alan Stern

