Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	haiyangz@microsoft.com, marc.zyngier@arm.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
Date: Tue,  2 Feb 2016 17:41:41 +0000
Message-Id: <1454434903-1680-2-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1454434903-1680-1-git-send-email-jakeo@microsoft.com>
References: <1454434903-1680-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch adds an fwnode_handle to struct pci_sysdata, which is
used by the next patch in the series when trying to locate an
IRQ domain associated with a root PCI bus.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/pci.h | 15 +++++++++++++++
 drivers/pci/probe.c        |  1 +
 include/linux/pci.h        |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 4625943..6fc3c7c 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -20,6 +20,9 @@ struct pci_sysdata {
 #ifdef CONFIG_X86_64
 	void		*iommu;		/* IOMMU private data */
 #endif
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+	void		*fwnode;	/* IRQ domain for MSI assignment */
+#endif
 };
 
 extern int pci_routeirq;
@@ -32,6 +35,7 @@ extern int noioapicreroute;
 static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	struct pci_sysdata *sd = bus->sysdata;
+
 	return sd->domain;
 }
 
@@ -41,6 +45,17 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif
 
+#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
+static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
+{
+	struct pci_sysdata *sd = bus->sysdata;
+
+	return sd->fwnode;
+}
+
+#define pci_root_bus_fwnode	_pci_root_bus_fwnode
+#endif
+
 /* Can be used to override the logic in pci_scan_bus for skipping
    already-configured bus numbers - to be used for buggy BIOSes
    or architectures with incomplete PCI setup by the loader */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 6d7ab9b..b207e74 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -15,6 +15,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
+#include <linux/irqdomain.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 27df4a6..cd05a8e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1515,6 +1515,10 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 
 #include <asm/pci.h>
 
+#ifndef pci_root_bus_fwnode
+#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
+#endif
+
 /* these helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info */
 #define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-- 
1.9.1
