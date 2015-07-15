Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56353 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753347AbbGOVRA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Subject: [PATCH 2/4] mm: Add dma_pool_zalloc() call to DMA API
Date: Wed, 15 Jul 2015 14:14:41 -0700
Message-Id: <1436994883-16563-3-git-send-email-sean.stalley@intel.com>
In-Reply-To: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
References: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a wrapper function for dma_pool_alloc() to get zeroed memory.

Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 Documentation/DMA-API.txt | 7 +++++++
 include/linux/dmapool.h   | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 5208840..988f757 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -104,6 +104,13 @@ crossing restrictions, pass 0 for alloc; passing 4096 says memory allocated
 from this pool must not cross 4KByte boundaries.
 
 
+	void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
+			      dma_addr_t *handle)
+
+Wraps dma_pool_alloc() and also zeroes the returned memory if the
+allocation attempt succeeded.
+
+
 	void *dma_pool_alloc(struct dma_pool *pool, gfp_t gfp_flags,
 			dma_addr_t *dma_handle);
 
diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index 022e34f..6d8079b 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -22,6 +22,12 @@ void dma_pool_destroy(struct dma_pool *pool);
 void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		     dma_addr_t *handle);
 
+static inline void *dma_pool_zalloc(struct dma_pool *pool, gfp_t mem_flags,
+				    dma_addr_t *handle)
+{
+	return dma_pool_alloc(pool, mem_flags | __GFP_ZERO, handle);
+}
+
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
 
 /*
-- 
1.9.1

