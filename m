Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 03/34] alpha/PCI: replace pci_probe_only with pci_flags
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org
Date: Wed, 07 Mar 2012 15:32:19 -0700
Message-ID: <20120307223219.25669.83793.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some architectures (alpha, mips, powerpc) have an arch-specific
"pci_probe_only" flag.  Others use PCI_PROBE_ONLY in pci_flags for
the same purpose.  This moves alpha to the pci_flags approach so
generic code can use the same test across all architectures.

CC: linux-alpha@vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/alpha/include/asm/pci.h   |    1 +
 arch/alpha/kernel/pci.c        |   15 +++++++--------
 arch/alpha/kernel/pci_impl.h   |    3 ---
 arch/alpha/kernel/sys_marvel.c |    3 ++-
 arch/alpha/kernel/sys_titan.c  |    3 ++-
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
index 28d0497..6a3fe07 100644
--- a/arch/alpha/include/asm/pci.h
+++ b/arch/alpha/include/asm/pci.h
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <asm/scatterlist.h>
 #include <asm/machvec.h>
+#include <asm-generic/pci-bridge.h>
 
 /*
  * The following structure is used to manage multiple PCI busses.
diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 8c723c1..3a5cdf2 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -43,12 +43,10 @@ const char *const pci_mem_names[] = {
 
 const char pci_hae0_name[] = "HAE0";
 
-/* Indicate whether we respect the PCI setup left by console. */
 /*
- * Make this long-lived  so that we know when shutting down
- * whether we probed only or not.
+ * If PCI_PROBE_ONLY in pci_flags is set, we don't change any PCI resource
+ * assignments.
  */
-int pci_probe_only;
 
 /*
  * The PCI controller list.
@@ -215,7 +213,7 @@ pdev_save_srm_config(struct pci_dev *dev)
 	struct pdev_srm_saved_conf *tmp;
 	static int printed = 0;
 
-	if (!alpha_using_srm || pci_probe_only)
+	if (!alpha_using_srm || pci_has_flag(PCI_PROBE_ONLY))
 		return;
 
 	if (!printed) {
@@ -242,7 +240,7 @@ pci_restore_srm_config(void)
 	struct pdev_srm_saved_conf *tmp;
 
 	/* No need to restore if probed only. */
-	if (pci_probe_only)
+	if (pci_has_flag(PCI_PROBE_ONLY))
 		return;
 
 	/* Restore SRM config. */
@@ -283,7 +281,7 @@ pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev = bus->self;
 
-	if (pci_probe_only && dev &&
+	if (pci_has_flag(PCI_PROBE_ONLY) && dev &&
  		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
  		pci_read_bridge_bases(bus);
  		pcibios_fixup_device_resources(dev, bus);
@@ -374,7 +372,8 @@ pcibios_claim_one_bus(struct pci_bus *b)
 
 			if (r->parent || !r->start || !r->flags)
 				continue;
-			if (pci_probe_only || (r->flags & IORESOURCE_PCI_FIXED))
+			if (pci_has_flag(PCI_PROBE_ONLY) ||
+			    (r->flags & IORESOURCE_PCI_FIXED))
 				pci_claim_resource(dev, i);
 		}
 	}
diff --git a/arch/alpha/kernel/pci_impl.h b/arch/alpha/kernel/pci_impl.h
index 85457b2..2b0ac42 100644
--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -173,9 +173,6 @@ extern void pci_restore_srm_config(void);
 extern struct pci_controller *hose_head, **hose_tail;
 extern struct pci_controller *pci_isa_hose;
 
-/* Indicate that we trust the console to configure things properly.  */
-extern int pci_probe_only;
-
 extern unsigned long alpha_agpgart_size;
 
 extern void common_init_pci(void);
diff --git a/arch/alpha/kernel/sys_marvel.c b/arch/alpha/kernel/sys_marvel.c
index 95cfc83..fc8b125 100644
--- a/arch/alpha/kernel/sys_marvel.c
+++ b/arch/alpha/kernel/sys_marvel.c
@@ -384,7 +384,8 @@ marvel_init_pci(void)
 
 	marvel_register_error_handlers();
 
-	pci_probe_only = 1;
+	/* Indicate that we trust the console to configure things properly */
+	pci_set_flags(PCI_PROBE_ONLY);
 	common_init_pci();
 	locate_and_init_vga(NULL);
 
diff --git a/arch/alpha/kernel/sys_titan.c b/arch/alpha/kernel/sys_titan.c
index f47b30a..b8eafa0 100644
--- a/arch/alpha/kernel/sys_titan.c
+++ b/arch/alpha/kernel/sys_titan.c
@@ -331,7 +331,8 @@ titan_init_pci(void)
  	 */
  	titan_late_init();
  
-	pci_probe_only = 1;
+	/* Indicate that we trust the console to configure things properly */
+	pci_set_flags(PCI_PROBE_ONLY);
 	common_init_pci();
 	SMC669_Init(0);
 	locate_and_init_vga(NULL);

