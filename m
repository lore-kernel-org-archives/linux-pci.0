Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: corbet@lwn.net, vinod.koul@intel.com, bhelgaas@google.com,
	Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
	mmarek@suse.cz
Cc: sean.stalley@intel.com, akpm@linux-foundation.org,
	bigeasy@linutronix.de, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	cocci@systeme.lip6.fr
Subject: [PATCH 1/4] mm: Add support for __GFP_ZERO flag to dma_pool_alloc()
Date: Wed, 15 Jul 2015 14:14:40 -0700
Message-Id: <1436994883-16563-2-git-send-email-sean.stalley@intel.com>
In-Reply-To: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
References: <1436994883-16563-1-git-send-email-sean.stalley@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently the __GFP_ZERO flag is ignored by dma_pool_alloc().
Make dma_pool_alloc() zero the memory if this flag is set.

Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 mm/dmapool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index fd5fe43..449a5d09 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -334,7 +334,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	/* pool_alloc_page() might sleep, so temporarily drop &pool->lock */
 	spin_unlock_irqrestore(&pool->lock, flags);
 
-	page = pool_alloc_page(pool, mem_flags);
+	page = pool_alloc_page(pool, mem_flags & (~__GFP_ZERO));
 	if (!page)
 		return NULL;
 
@@ -375,6 +375,10 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	memset(retval, POOL_POISON_ALLOCATED, pool->size);
 #endif
 	spin_unlock_irqrestore(&pool->lock, flags);
+
+	if (mem_flags & __GFP_ZERO)
+		memset(retval, 0, pool->size);
+
 	return retval;
 }
 EXPORT_SYMBOL(dma_pool_alloc);
-- 
1.9.1

