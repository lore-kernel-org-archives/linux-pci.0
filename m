Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57278 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbbGOXPz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 19:15:55 -0400
Date: Wed, 15 Jul 2015 16:13:57 -0700
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: corbet@lwn.net, vinod.koul@intel.com, bhelgaas@google.com,
	Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
	mmarek@suse.cz, bigeasy@linutronix.de, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	cocci@systeme.lip6.fr
Subject: Re: [PATCH 1/4] mm: Add support for __GFP_ZERO flag to
 dma_pool_alloc()
Message-ID: <20150715231356.GA16638@sean.stalley.intel.com>
References: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
 <1436994883-16563-2-git-send-email-sean.stalley@intel.com>
 <20150715142907.ccfd473ea0e039642d46893d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150715142907.ccfd473ea0e039642d46893d@linux-foundation.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the review Andrew, my responses are inline.

-Sean

On Wed, Jul 15, 2015 at 02:29:07PM -0700, Andrew Morton wrote:
> On Wed, 15 Jul 2015 14:14:40 -0700 "Sean O. Stalley" <sean.stalley@intel.com> wrote:
> 
> > Currently the __GFP_ZERO flag is ignored by dma_pool_alloc().
> > Make dma_pool_alloc() zero the memory if this flag is set.
> > 
> > ...
> >
> > --- a/mm/dmapool.c
> > +++ b/mm/dmapool.c
> > @@ -334,7 +334,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
> >  	/* pool_alloc_page() might sleep, so temporarily drop &pool->lock */
> >  	spin_unlock_irqrestore(&pool->lock, flags);
> >  
> > -	page = pool_alloc_page(pool, mem_flags);
> > +	page = pool_alloc_page(pool, mem_flags & (~__GFP_ZERO));
> >  	if (!page)
> >  		return NULL;
> >  
> > @@ -375,6 +375,10 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
> >  	memset(retval, POOL_POISON_ALLOCATED, pool->size);
> >  #endif
> >  	spin_unlock_irqrestore(&pool->lock, flags);
> > +
> > +	if (mem_flags & __GFP_ZERO)
> > +		memset(retval, 0, pool->size);
> > +
> >  	return retval;
> >  }
> >  EXPORT_SYMBOL(dma_pool_alloc);
> 
> hm, this code is all a bit confused.
> 
> We'd really prefer that the __GFP_ZERO be passed all the way to the
> bottom level, so that places which are responsible for zeroing memory
> (eg, the page allocator) can do their designated function.  One reason
> for this is that if someone comes up with a whizzy way of zeroing
> memory on their architecture (eg, non-temporal store) then that will be
> implemented in the core page allocator and the dma code will miss out.

It would be nice if we could use the page allocator for whizzy zeroing.
There are a few reasons why I didn't pass __GFP_ZERO down to the allocator:

 - dma_pool_alloc() reuses blocks of memory that were recently freed by dma_pool_free().
   We have to memset(0) old blocks, since we don't know what's in them.

 - When a new page is alloced, pool_initalize_page() writes an integer to every block.
   So even if we passed __GFP_ZERO down to the allocator, the block would not be empty
   by the time dma_pool_alloc() returns.

 - Assuming a driver is allocing as often as it is freeing,
   once the pool has enough memory it shouldn't call down to the allocator very often,
   so any optimization down in the allocator shouldn't make much of a difference

> Also, and just from a brief look around,
> drivers/base/dma-coherent.c:dma_alloc_from_coherent() is already
> zeroing the memory so under some circumstances I think we'll zero the
> memory twice?  We could fix that by passing the gfp_t to
> dma_alloc_from_coherent() and then changing dma_alloc_from_coherent()
> to *not* zero the memory if __GFP_ZERO, but wouldn't that be peculiar?

I noticed this as well. In this case, we would be zeroing twice.
This is no worse than the current case (where dma_pool_alloc() returns,
then the driver calls memset(0)).

> Also, passing __GFP_ZERO will now cause pool_alloc_page()'s
> memset(POOL_POISON_FREED) to be wiped out.  I guess that's harmless,
> but a bit inefficient?

Inefficient, but no more inefficient than the current case.
I didn't think it would be a problem (since it only happens if dma pool debuging is enabled).
I could add a check to only memset the poison if __GFP_ZERO is not set.
