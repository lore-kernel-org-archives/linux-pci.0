Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v2 09/12] powerpc/PCI: make pci_probe_only default to 0
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 23 Feb 2012 12:43:48 -0700
Message-ID: <20120223194348.20708.21214.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
References: <20120223194209.20708.54480.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_probe_only is set on ppc64 to prevent resource re-allocation
by the core. It's meant to be used in very specific circumstances
such as when operating under a hypervisor that may prevent such
re-allocation.

Instead of default to 1, we make it default to 0 and explicitly
set it in the few cases where we need it.

This fixes FSL PCI which wants it clear among others.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/pci_64.c           |    2 +-
 arch/powerpc/platforms/powermac/pci.c  |    3 ---
 arch/powerpc/platforms/powernv/pci.c   |    3 ---
 arch/powerpc/platforms/pseries/setup.c |    3 +++
 arch/powerpc/platforms/wsp/wsp_pci.c   |    1 -
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 3318d39..f627eb7 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -33,7 +33,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 
-unsigned long pci_probe_only = 1;
+unsigned long pci_probe_only = 0;
 
 /* pci_io_base -- the base address from which io bars are offsets.
  * This is the lowest I/O base address (so bar values are always positive),
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 31a7d3a..43bbe1b 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -1059,9 +1059,6 @@ void __init pmac_pci_init(void)
 	}
 	/* pmac_check_ht_link(); */
 
-	/* We can allocate missing resources if any */
-	pci_probe_only = 0;
-
 #else /* CONFIG_PPC64 */
 	init_p2pbridge();
 	init_second_ohare();
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index f92b9ef..94ed056 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -563,9 +563,6 @@ void __init pnv_pci_init(void)
 
 	pci_set_flags(PCI_CAN_SKIP_ISA_ALIGN);
 
-	/* We do not want to just probe */
-	pci_probe_only = 0;
-
 	/* OPAL absent, try POPAL first then RTAS detection of PHBs */
 	if (!firmware_has_feature(FW_FEATURE_OPAL)) {
 #ifdef CONFIG_PPC_POWERNV_RTAS
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f79f127..386e265 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -380,6 +380,9 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
+	/* By default, only probe PCI (can be overriden by rtas_pci */
+	pci_probe_only = 1;
+
 	/* Find and initialize PCI host bridges */
 	init_pci_config_tokens();
 	find_and_init_phbs();
diff --git a/arch/powerpc/platforms/wsp/wsp_pci.c b/arch/powerpc/platforms/wsp/wsp_pci.c
index d24b3ac..763014c 100644
--- a/arch/powerpc/platforms/wsp/wsp_pci.c
+++ b/arch/powerpc/platforms/wsp/wsp_pci.c
@@ -682,7 +682,6 @@ static int __init wsp_setup_one_phb(struct device_node *np)
 	/* XXX Force re-assigning of everything for now */
 	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC |
 		      PCI_ENABLE_PROC_DOMAINS);
-	pci_probe_only = 0;
 
 	/* Calculate how the TCE space is divided */
 	phb->dma32_base		= 0;

