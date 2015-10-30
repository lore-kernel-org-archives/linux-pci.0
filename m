Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@redhat.com, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v5 5/7] PCI: irqdomain: Look up IRQ domain by fwnode_handle
Date: Fri, 30 Oct 2015 21:11:13 +0000
Message-Id: <1446239475-49480-6-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1446239475-49480-1-git-send-email-jakeo@microsoft.com>
References: <1446239475-49480-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch adds a second way of finding an IRQ domain associated with
a root PCI bus.  After looking to see if one can be found through
the OF tree, it attempts to look up the IRQ domain through an
fwnode_handle stored in the pci_sysdata struct.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/pci.h |  4 +++-
 drivers/pci/probe.c        | 11 +++++++++++
 include/asm-generic/pci.h  |  4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 10213a1..fb74453 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -45,11 +45,13 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #endif
 
 #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
-static inline void *pci_fwnode(struct pci_bus *bus)
+static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
 {
 	struct pci_sysdata *sd = bus->sysdata;
 	return sd->fwnode;
 }
+
+#define pci_root_bus_fwnode	_pci_root_bus_fwnode
 #endif
 
 /* Can be used to override the logic in pci_scan_bus for skipping
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f441d1b..60e50a8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -671,6 +671,17 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
 	 */
 	d = pci_host_bridge_of_msi_domain(bus);
 
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	/*
+	 * If no IRQ domain was found via the OF tree, try looking it up
+	 * directly through the fwnode_handle.
+	 */
+	if (!d && pci_root_bus_fwnode(bus)) {
+		d = irq_find_matching_fwnode(pci_root_bus_fwnode(bus),
+					     DOMAIN_BUS_PCI_MSI);
+	}
+#endif
+
 	return d;
 }
 
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index f24bc51..3fde985 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -21,4 +21,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 #define PCI_DMA_BUS_IS_PHYS	(1)
 #endif
 
+#ifndef pci_root_bus_fwnode
+#define pci_root_bus_fwnode(bus)	((void)(bus),NULL)
+#endif
+
 #endif /* _ASM_GENERIC_PCI_H */
-- 
1.9.1

