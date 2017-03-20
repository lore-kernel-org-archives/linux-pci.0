Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 3/4] asm-generic/io.h: Simplify ioremap() comments
From: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Date: Mon, 20 Mar 2017 13:43:00 -0500
Message-ID: <20170320184300.4858.47081.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170320182014.4858.22352.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simplify ioremap() comments to make it clear that arches with an MMU *must*
implement ioremap() and iounmap(), and that the default implementations
only apply to non-MMU arches.  It's obvious how to override the defaults;
no need to educate people here.  Remove the ancient "struct page" comment
that doesn't seem related to anything here.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/io.h |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e0a331a22346..3f8a7e589071 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -780,8 +780,7 @@ static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 #endif /* CONFIG_GENERIC_IOMAP */
 
 /*
- * Change virtual addresses to physical addresses and vv.
- * These are pretty trivial
+ * Change virtual addresses to physical addresses and vice versa.
  */
 #ifndef virt_to_phys
 #define virt_to_phys virt_to_phys
@@ -802,18 +801,11 @@ static inline void *phys_to_virt(unsigned long address)
 /**
  * DOC: ioremap() and ioremap_*() variants
  *
- * If you have an MMU your architecture is expected to have both ioremap()
- * and iounmap() implemented otherwise the asm-generic helpers will provide a
- * direct mapping.
+ * If you have an MMU, your architecture must implement both ioremap() and
+ * iounmap().
  *
- * There are ioremap_*() call variants, if you have no MMU we naturally will
- * default to direct mapping for all of them, you can override these defaults.
- * If you have an MMU you are highly encouraged to provide your own
- * ioremap variant implementation as there currently is no safe architecture
- * agnostic default. To avoid possible improper behaviour default asm-generic
- * ioremap_*() variants all return NULL when an MMU is available. If you've
- * defined your own ioremap_*() variant you must then declare your own
- * ioremap_*() variant as defined to itself to avoid the default NULL return.
+ * It must also implement variants such as ioremap_uc().  The default
+ * implementation here returns failure (NULL) to avoid improper behavior.
  */
 
 #ifdef CONFIG_MMU
@@ -829,10 +821,8 @@ static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
 #else /* !CONFIG_MMU */
 
 /*
- * Change "struct page" to physical address.
- *
- * This implementation is for the no-MMU case only... if you have an MMU
- * you'll need to provide your own definitions.
+ * If you don't have an MMU, the default implementations here provide
+ * direct identity mapping.  You can override these if necessary.
  */
 
 #ifndef ioremap
