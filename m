Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:48710 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667AbbLEAgS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2015 19:36:18 -0500
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v7 4/7] PCI: Add fwnode_handle to pci_sysdata
Date: Sat,  5 Dec 2015 00:36:03 +0000
Message-Id: <1449275767-1510-5-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1449275767-1510-1-git-send-email-jakeo@microsoft.com>
References: <1449275767-1510-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch adds an fwnode_handle to struct pci_sysdata, which is
used by the next patch in the series when trying to locate an
IRQ domain associated with a root PCI bus.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/x86/include/asm/pci.h | 15 +++++++++++++++
 include/asm-generic/pci.h  |  4 ++++
 2 files changed, 19 insertions(+)

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
diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index f24bc51..4092886 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -21,4 +21,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 #define PCI_DMA_BUS_IS_PHYS	(1)
 #endif
 
+#ifndef pci_root_bus_fwnode
+#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
+#endif
+
 #endif /* _ASM_GENERIC_PCI_H */
-- 
1.9.1

