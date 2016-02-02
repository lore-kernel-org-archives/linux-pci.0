Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/5] PCI: Move pci_set_flags() from asm-generic/pci-bridge.h
 to linux/pci.h
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 02 Feb 2016 13:38:34 -0600
Message-ID: <20160202193834.9258.64377.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI flag management constants and functions were previously declared in
include/asm-generic/pci-bridge.h.  But they are not specific to bridges,
and arches did not include pci-bridge.h consistently.

Move the following interfaces and related constants to include/linux/pci.h
and remove pci-bridge.h:

  pci_set_flags()
  pci_add_flags()
  pci_clear_flags()
  pci_has_flag()

This fixes these warnings when building for some arches:

  drivers/pci/host/pcie-designware.c:562:20: error: 'PCI_PROBE_ONLY' undeclared (first use in this function)
  drivers/pci/host/pcie-designware.c:562:7: error: implicit declaration of function 'pci_has_flag' [-Werror=implicit-function-declaration]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c              |    7 ++++
 include/asm-generic/pci-bridge.h |   65 --------------------------------------
 include/linux/pci.h              |   22 +++++++++++++
 3 files changed, 29 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..ead1ac1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1803,6 +1803,13 @@ static int only_one_child(struct pci_bus *bus)
 		return 0;
 	if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
 		return 1;
+
+	/*
+	 * PCIe downstream ports are bridges that normally lead to only a
+	 * device 0, but if PCI_SCAN_ALL_PCIE_DEVS is set, scan all
+	 * possible devices, not just device 0.  See PCIe spec r3.0,
+	 * sec 7.3.1.
+	 */
 	if (parent->has_secondary_link &&
 	    !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
 		return 1;
diff --git a/include/asm-generic/pci-bridge.h b/include/asm-generic/pci-bridge.h
index 20db2e5..1b1d82f 100644
--- a/include/asm-generic/pci-bridge.h
+++ b/include/asm-generic/pci-bridge.h
@@ -6,69 +6,4 @@
  */
 #ifndef _ASM_GENERIC_PCI_BRIDGE_H
 #define _ASM_GENERIC_PCI_BRIDGE_H
-
-#ifdef __KERNEL__
-
-enum {
-	/* Force re-assigning all resources (ignore firmware
-	 * setup completely)
-	 */
-	PCI_REASSIGN_ALL_RSRC	= 0x00000001,
-
-	/* Re-assign all bus numbers */
-	PCI_REASSIGN_ALL_BUS	= 0x00000002,
-
-	/* Do not try to assign, just use existing setup */
-	PCI_PROBE_ONLY		= 0x00000004,
-
-	/* Don't bother with ISA alignment unless the bridge has
-	 * ISA forwarding enabled
-	 */
-	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
-
-	/* Enable domain numbers in /proc */
-	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,
-	/* ... except for domain 0 */
-	PCI_COMPAT_DOMAIN_0	= 0x00000020,
-
-	/* PCIe downstream ports are bridges that normally lead to only a
-	 * device 0, but if this is set, we scan all possible devices, not
-	 * just device 0.
-	 */
-	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,
-};
-
-#ifdef CONFIG_PCI
-extern unsigned int pci_flags;
-
-static inline void pci_set_flags(int flags)
-{
-	pci_flags = flags;
-}
-
-static inline void pci_add_flags(int flags)
-{
-	pci_flags |= flags;
-}
-
-static inline void pci_clear_flags(int flags)
-{
-	pci_flags &= ~flags;
-}
-
-static inline int pci_has_flag(int flag)
-{
-	return pci_flags & flag;
-}
-#else
-static inline void pci_set_flags(int flags) { }
-static inline void pci_add_flags(int flags) { }
-static inline void pci_clear_flags(int flags) { }
-static inline int pci_has_flag(int flag)
-{
-	return 0;
-}
-#endif	/* CONFIG_PCI */
-
-#endif	/* __KERNEL__ */
 #endif	/* _ASM_GENERIC_PCI_BRIDGE_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..3d371c1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -746,9 +746,26 @@ struct pci_driver {
 	.vendor = PCI_VENDOR_ID_##vend, .device = (dev), \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0
 
+enum {
+	PCI_REASSIGN_ALL_RSRC	= 0x00000001,	/* ignore firmware setup */
+	PCI_REASSIGN_ALL_BUS	= 0x00000002,	/* reassign all bus numbers */
+	PCI_PROBE_ONLY		= 0x00000004,	/* use existing setup */
+	PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,	/* don't do ISA alignment */
+	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* enable domains in /proc */
+	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
+	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* scan all, not just dev 0 */
+};
+
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
+extern unsigned int pci_flags;
+
+static inline void pci_set_flags(int flags) { pci_flags = flags; }
+static inline void pci_add_flags(int flags) { pci_flags |= flags; }
+static inline void pci_clear_flags(int flags) { pci_flags &= ~flags; }
+static inline int pci_has_flag(int flag) { return pci_flags & flag; }
+
 void pcie_bus_configure_settings(struct pci_bus *bus);
 
 enum pcie_bus_config_types {
@@ -1405,6 +1422,11 @@ void pci_register_set_vga_state(arch_set_vga_state_t func);
 
 #else /* CONFIG_PCI is not enabled */
 
+static inline void pci_set_flags(int flags) { }
+static inline void pci_add_flags(int flags) { }
+static inline void pci_clear_flags(int flags) { }
+static inline int pci_has_flag(int flag) { return 0; }
+
 /*
  *  If the system does not have PCI, clearly these return errors.  Define
  *  these as simple inline functions to avoid hair in drivers.
