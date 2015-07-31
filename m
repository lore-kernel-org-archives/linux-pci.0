Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: corbet@lwn.net, vinod.koul@intel.com, bhelgaas@google.com,
	Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
	mmarek@suse.cz, akpm@linux-foundation.org
Cc: sean.stalley@intel.com, bigeasy@linutronix.de,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, cocci@systeme.lip6.fr
Subject: [PATCH v2 3/4] pci: mm: Add pci_pool_zalloc() call
Date: Fri, 31 Jul 2015 12:36:43 -0700
Message-Id: <1438371404-3219-4-git-send-email-sean.stalley@intel.com>
In-Reply-To: <1438371404-3219-1-git-send-email-sean.stalley@intel.com>
References: <1438371404-3219-1-git-send-email-sean.stalley@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a wrapper function for pci_pool_alloc() to get zeroed memory.

Signed-off-by: Sean O. Stalley <sean.stalley@intel.com>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 755a2cd..e6ec7d9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1176,6 +1176,8 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		dma_pool_create(name, &pdev->dev, size, align, allocation)
 #define	pci_pool_destroy(pool) dma_pool_destroy(pool)
 #define	pci_pool_alloc(pool, flags, handle) dma_pool_alloc(pool, flags, handle)
+#define	pci_pool_zalloc(pool, flags, handle) \
+		dma_pool_zalloc(pool, flags, handle)
 #define	pci_pool_free(pool, vaddr, addr) dma_pool_free(pool, vaddr, addr)
 
 enum pci_dma_burst_strategy {
-- 
1.9.1

