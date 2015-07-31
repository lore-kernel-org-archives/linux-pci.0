Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46592 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbbGaTi4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 31 Jul 2015 15:38:56 -0400
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: corbet@lwn.net, vinod.koul@intel.com, bhelgaas@google.com,
	Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
	mmarek@suse.cz, akpm@linux-foundation.org
Cc: sean.stalley@intel.com, bigeasy@linutronix.de,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, cocci@systeme.lip6.fr
Subject: [PATCH v2 0/4] mm: add dma_pool_zalloc() & pci_pool_zalloc()
Date: Fri, 31 Jul 2015 12:36:40 -0700
Message-Id: <1438371404-3219-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently a call to dma_pool_alloc() with a ___GFP_ZERO flag returns
a non-zeroed memory region.

This patchset adds support for the __GFP_ZERO flag to dma_pool_alloc(),
adds 2 wrapper functions for allocing zeroed memory from a pool, 
and provides a coccinelle script for finding & replacing instances of
dma_pool_alloc() followed by memset(0) with a single dma_pool_zalloc() call.

Changes from v1 to v2:
	- don't memset() POOL_POISON_ALLOCATED in dma_pool_alloc() if
	  __GFP_ZERO is set
	- Ran test to see how often pool_alloc_page() is called


There was some concern that this always calls memset() to zero,
instead of passing __GFP_ZERO into the page allocator.
[https://lkml.org/lkml/2015/7/15/881]

I ran a test on my system to get an idea of how often dma_pool_alloc()
calls into pool_alloc_page().

After Boot:	[   30.119863] alloc_calls:541, page_allocs:7
After an hour:	[ 3600.951031] alloc_calls:9566, page_allocs:12
After copying 1GB file onto a USB drive:
		[ 4260.657148] alloc_calls:17225, page_allocs:12

It doesn't look like dma_pool_alloc() calls down to the page allocator
very often (at least on my system).


Sean O. Stalley (4):
  mm: Add support for __GFP_ZERO flag to dma_pool_alloc()
  mm: Add dma_pool_zalloc() call to DMA API
  pci: mm: Add pci_pool_zalloc() call
  coccinelle: mm: scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci

 Documentation/DMA-API.txt                          |  7 ++
 include/linux/dmapool.h                            |  6 ++
 include/linux/pci.h                                |  2 +
 mm/dmapool.c                                       |  9 ++-
 .../coccinelle/api/alloc/pool_zalloc-simple.cocci  | 84 ++++++++++++++++++++++
 5 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci

-- 
1.9.1

