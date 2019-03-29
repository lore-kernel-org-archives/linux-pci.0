Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A4DC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91B12075E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 15:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfC2PkZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:40:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:13645 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbfC2PkZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 11:40:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 08:40:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="156424704"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2019 08:40:23 -0700
Subject: [PATCH 4/6] lib/genalloc: Introduce chunk owners
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 08:27:44 -0700
Message-ID: <155387326480.2443841.4506646109682116121.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The p2pdma facility enables a provider to publish a pool of dma
addresses for a consumer to allocate. A genpool is used internally by
p2pdma to collect dma resources, 'chunks', to be handed out to
consumers. Whenever a consumer allocates a resource it needs to pin the
'struct dev_pagemap' instance that backs the chunk selected by
pci_alloc_p2pmem().

Currently that reference is taken globally on the entire provider
device. That sets up a lifetime mismatch whereby the p2pdma core needs
to maintain hacks to make sure the percpu_ref is not released twice.

This lifetime mismatch also stands in the way of a fix to
devm_memremap_pages() whereby devm_memremap_pages_release() must wait
for the percpu_ref ->release() callback to complete before it can
proceed to teardown pages.

So, towards fixing this situation, introduce the ability to store a
'chunk owner' at gen_pool_add() time, and a facility to retrieve the
owner at gen_pool_{alloc,free}() time. For p2pdma this will be used to
store and recall individual dev_pagemap reference counter instances
per-chunk.

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/genalloc.h |   55 +++++++++++++++++++++++++++++++++++++++++-----
 lib/genalloc.c           |   51 +++++++++++++++++++++----------------------
 2 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index dd0a452373e7..a337313e064f 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -75,6 +75,7 @@ struct gen_pool_chunk {
 	struct list_head next_chunk;	/* next chunk in pool */
 	atomic_long_t avail;
 	phys_addr_t phys_addr;		/* physical starting address of memory chunk */
+	void *owner;			/* private data to retrieve at alloc time */
 	unsigned long start_addr;	/* start address of memory chunk */
 	unsigned long end_addr;		/* end address of memory chunk (inclusive) */
 	unsigned long bits[0];		/* bitmap for allocating memory chunk */
@@ -96,8 +97,15 @@ struct genpool_data_fixed {
 
 extern struct gen_pool *gen_pool_create(int, int);
 extern phys_addr_t gen_pool_virt_to_phys(struct gen_pool *pool, unsigned long);
-extern int gen_pool_add_virt(struct gen_pool *, unsigned long, phys_addr_t,
-			     size_t, int);
+extern int gen_pool_add_owner(struct gen_pool *, unsigned long, phys_addr_t,
+			     size_t, int, void *);
+
+static inline int gen_pool_add_virt(struct gen_pool *pool, unsigned long addr,
+		phys_addr_t phys, size_t size, int nid)
+{
+	return gen_pool_add_owner(pool, addr, phys, size, nid, NULL);
+}
+
 /**
  * gen_pool_add - add a new chunk of special memory to the pool
  * @pool: pool to add new memory chunk to
@@ -116,12 +124,47 @@ static inline int gen_pool_add(struct gen_pool *pool, unsigned long addr,
 	return gen_pool_add_virt(pool, addr, -1, size, nid);
 }
 extern void gen_pool_destroy(struct gen_pool *);
-extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
-extern unsigned long gen_pool_alloc_algo(struct gen_pool *, size_t,
-		genpool_algo_t algo, void *data);
+unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t size,
+		genpool_algo_t algo, void *data, void **owner);
+
+static inline unsigned long gen_pool_alloc_owner(struct gen_pool *pool,
+		size_t size, void **owner)
+{
+	return gen_pool_alloc_algo_owner(pool, size, pool->algo, pool->data,
+			owner);
+}
+
+static inline unsigned long gen_pool_alloc_algo(struct gen_pool *pool,
+		size_t size, genpool_algo_t algo, void *data)
+{
+	return gen_pool_alloc_algo_owner(pool, size, algo, data, NULL);
+}
+
+/**
+ * gen_pool_alloc - allocate special memory from the pool
+ * @pool: pool to allocate from
+ * @size: number of bytes to allocate from the pool
+ *
+ * Allocate the requested number of bytes from the specified pool.
+ * Uses the pool allocation function (with first-fit algorithm by default).
+ * Can not be used in NMI handler on architectures without
+ * NMI-safe cmpxchg implementation.
+ */
+static inline unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
+{
+	return gen_pool_alloc_algo(pool, size, pool->algo, pool->data);
+}
+
 extern void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size,
 		dma_addr_t *dma);
-extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
+extern void gen_pool_free_owner(struct gen_pool *pool, unsigned long addr,
+		size_t size, void **owner);
+static inline void gen_pool_free(struct gen_pool *pool, unsigned long addr,
+                size_t size)
+{
+	gen_pool_free_owner(pool, addr, size, NULL);
+}
+
 extern void gen_pool_for_each_chunk(struct gen_pool *,
 	void (*)(struct gen_pool *, struct gen_pool_chunk *, void *), void *);
 extern size_t gen_pool_avail(struct gen_pool *);
diff --git a/lib/genalloc.c b/lib/genalloc.c
index 7e85d1e37a6e..770c769d7cb7 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -168,20 +168,21 @@ struct gen_pool *gen_pool_create(int min_alloc_order, int nid)
 EXPORT_SYMBOL(gen_pool_create);
 
 /**
- * gen_pool_add_virt - add a new chunk of special memory to the pool
+ * gen_pool_add_owner- add a new chunk of special memory to the pool
  * @pool: pool to add new memory chunk to
  * @virt: virtual starting address of memory chunk to add to pool
  * @phys: physical starting address of memory chunk to add to pool
  * @size: size in bytes of the memory chunk to add to pool
  * @nid: node id of the node the chunk structure and bitmap should be
  *       allocated on, or -1
+ * @owner: private data the publisher would like to recall at alloc time
  *
  * Add a new chunk of special memory to the specified pool.
  *
  * Returns 0 on success or a -ve errno on failure.
  */
-int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, phys_addr_t phys,
-		 size_t size, int nid)
+int gen_pool_add_owner(struct gen_pool *pool, unsigned long virt, phys_addr_t phys,
+		 size_t size, int nid, void *owner)
 {
 	struct gen_pool_chunk *chunk;
 	int nbits = size >> pool->min_alloc_order;
@@ -195,6 +196,7 @@ int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, phys_addr_t phy
 	chunk->phys_addr = phys;
 	chunk->start_addr = virt;
 	chunk->end_addr = virt + size - 1;
+	chunk->owner = owner;
 	atomic_long_set(&chunk->avail, size);
 
 	spin_lock(&pool->lock);
@@ -203,7 +205,7 @@ int gen_pool_add_virt(struct gen_pool *pool, unsigned long virt, phys_addr_t phy
 
 	return 0;
 }
-EXPORT_SYMBOL(gen_pool_add_virt);
+EXPORT_SYMBOL(gen_pool_add_owner);
 
 /**
  * gen_pool_virt_to_phys - return the physical address of memory
@@ -260,35 +262,20 @@ void gen_pool_destroy(struct gen_pool *pool)
 EXPORT_SYMBOL(gen_pool_destroy);
 
 /**
- * gen_pool_alloc - allocate special memory from the pool
- * @pool: pool to allocate from
- * @size: number of bytes to allocate from the pool
- *
- * Allocate the requested number of bytes from the specified pool.
- * Uses the pool allocation function (with first-fit algorithm by default).
- * Can not be used in NMI handler on architectures without
- * NMI-safe cmpxchg implementation.
- */
-unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
-{
-	return gen_pool_alloc_algo(pool, size, pool->algo, pool->data);
-}
-EXPORT_SYMBOL(gen_pool_alloc);
-
-/**
- * gen_pool_alloc_algo - allocate special memory from the pool
+ * gen_pool_alloc_algo_owner - allocate special memory from the pool
  * @pool: pool to allocate from
  * @size: number of bytes to allocate from the pool
  * @algo: algorithm passed from caller
  * @data: data passed to algorithm
+ * @owner: optionally retrieve the chunk owner
  *
  * Allocate the requested number of bytes from the specified pool.
  * Uses the pool allocation function (with first-fit algorithm by default).
  * Can not be used in NMI handler on architectures without
  * NMI-safe cmpxchg implementation.
  */
-unsigned long gen_pool_alloc_algo(struct gen_pool *pool, size_t size,
-		genpool_algo_t algo, void *data)
+unsigned long gen_pool_alloc_algo_owner(struct gen_pool *pool, size_t size,
+		genpool_algo_t algo, void *data, void **owner)
 {
 	struct gen_pool_chunk *chunk;
 	unsigned long addr = 0;
@@ -299,6 +286,9 @@ unsigned long gen_pool_alloc_algo(struct gen_pool *pool, size_t size,
 	BUG_ON(in_nmi());
 #endif
 
+	if (owner)
+		*owner = NULL;
+
 	if (size == 0)
 		return 0;
 
@@ -326,12 +316,14 @@ unsigned long gen_pool_alloc_algo(struct gen_pool *pool, size_t size,
 		addr = chunk->start_addr + ((unsigned long)start_bit << order);
 		size = nbits << order;
 		atomic_long_sub(size, &chunk->avail);
+		if (owner)
+			*owner = chunk->owner;
 		break;
 	}
 	rcu_read_unlock();
 	return addr;
 }
-EXPORT_SYMBOL(gen_pool_alloc_algo);
+EXPORT_SYMBOL(gen_pool_alloc_algo_owner);
 
 /**
  * gen_pool_dma_alloc - allocate special memory from the pool for DMA usage
@@ -367,12 +359,14 @@ EXPORT_SYMBOL(gen_pool_dma_alloc);
  * @pool: pool to free to
  * @addr: starting address of memory to free back to pool
  * @size: size in bytes of memory to free
+ * @owner: private data stashed at gen_pool_add() time
  *
  * Free previously allocated special memory back to the specified
  * pool.  Can not be used in NMI handler on architectures without
  * NMI-safe cmpxchg implementation.
  */
-void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
+void gen_pool_free_owner(struct gen_pool *pool, unsigned long addr, size_t size,
+		void **owner)
 {
 	struct gen_pool_chunk *chunk;
 	int order = pool->min_alloc_order;
@@ -382,6 +376,9 @@ void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
 	BUG_ON(in_nmi());
 #endif
 
+	if (owner)
+		*owner = NULL;
+
 	nbits = (size + (1UL << order) - 1) >> order;
 	rcu_read_lock();
 	list_for_each_entry_rcu(chunk, &pool->chunks, next_chunk) {
@@ -392,6 +389,8 @@ void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
 			BUG_ON(remain);
 			size = nbits << order;
 			atomic_long_add(size, &chunk->avail);
+			if (owner)
+				*owner = chunk->owner;
 			rcu_read_unlock();
 			return;
 		}
@@ -399,7 +398,7 @@ void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
 	rcu_read_unlock();
 	BUG();
 }
-EXPORT_SYMBOL(gen_pool_free);
+EXPORT_SYMBOL(gen_pool_free_owner);
 
 /**
  * gen_pool_for_each_chunk - call func for every chunk of generic memory pool

