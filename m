Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ley Foon Tan <lftan@altera.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>,
	<lftan.linux@gmail.com>
Subject: [PATCH v2 1/4] asm-generic: add pci required defines and functions
Date: Wed, 14 Oct 2015 14:31:41 +0800
Message-ID: <1444804304-5213-2-git-send-email-lftan@altera.com>
In-Reply-To: <1444804304-5213-1-git-send-email-lftan@altera.com>
References: <1444804304-5213-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add the generic #define and functions that required by the PCI framework.
Architecture pci.h can overwrite with their implementation if needed.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 include/asm-generic/pci.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index f24bc51..2771b32 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -21,4 +21,38 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 #define PCI_DMA_BUS_IS_PHYS	(1)
 #endif
 
+#ifdef CONFIG_PCI
+
+#ifndef PCIBIOS_MIN_IO
+#define PCIBIOS_MIN_IO	(0UL)
+#endif
+
+#ifndef PCIBIOS_MIN_MEM
+#define PCIBIOS_MIN_MEM	(0UL)
+#endif
+
+#ifndef pcibios_assign_all_busses
+#define pcibios_assign_all_busses()	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
+#endif
+
+#ifndef pci_proc_domain
+#define pci_proc_domain pci_proc_domain
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+	return pci_domain_nr(bus);
+#else
+	return 1;
+#endif
+}
+#endif
+
+extern int isa_dma_bridge_buggy;
+
+#else
+
+#define isa_dma_bridge_buggy	(0)
+
+#endif /* CONFIG_PCI */
+
 #endif /* _ASM_GENERIC_PCI_H */
-- 
1.8.2.1

