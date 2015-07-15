Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56344 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbbGOVRA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 17:17:00 -0400
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: corbet@lwn.net, vinod.koul@intel.com, bhelgaas@google.com,
	Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
	mmarek@suse.cz
Cc: sean.stalley@intel.com, akpm@linux-foundation.org,
	bigeasy@linutronix.de, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	cocci@systeme.lip6.fr
Subject: [PATCH 0/4] mm: add dma_pool_zalloc() & pci_pool_zalloc()
Date: Wed, 15 Jul 2015 14:14:39 -0700
Message-Id: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently a call to dma_pool_alloc() with a ___GFP_ZERO flag returns
a non-zeroed memory region.

This patchset adds support for the ___GFP_ZERO flag to dma_pool_alloc(),
adds 2 wrapper functions for allocing zeroed memory from a pool, 
and provides a coccinelle script for finding & replacing instances of
dma_pool_alloc() followed by memset(0) with a single dma_pool_zalloc() call.

Sean O. Stalley (4):
  mm: Add support for __GFP_ZERO flag to dma_pool_alloc()
  mm: Add dma_pool_zalloc() call to DMA API
  pci: mm: Add pci_pool_zalloc() call
  coccinelle: mm: scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci

 Documentation/DMA-API.txt                          |  7 ++
 include/linux/dmapool.h                            |  6 ++
 include/linux/pci.h                                |  2 +
 mm/dmapool.c                                       |  6 +-
 .../coccinelle/api/alloc/pool_zalloc-simple.cocci  | 84 ++++++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci

-- 
1.9.1

