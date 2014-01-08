Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:11672
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750796AbaAHFBn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2014 00:01:43 -0500
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Zang Roy-R61911 <r61911@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH 02/12][v4] pci: fsl: add structure fsl_pci
Date: Wed, 8 Jan 2014 13:01:53 +0800
Message-ID: <1389157323-3088-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PowerPC uses structure pci_controller to describe PCI controller,
but ARM uses structure pci_sys_data. In order to support PowerPC
and ARM simultaneously, the patch adds a structure fsl_pci that
contains most of the members of the pci_controller and pci_sys_data.
Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
be implemented in architecture-specific PCI controller driver to
convert pci_controller or pci_sys_data to fsl_pci.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v4:
Added indirect type macro
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 include/linux/fsl/pci-common.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
index 5e4f683..7ea20a1 100644
--- a/include/linux/fsl/pci-common.h
+++ b/include/linux/fsl/pci-common.h
@@ -102,5 +102,53 @@ struct ccsr_pci {
 
 };
 
+/*
+ * Structure of a PCI controller (host bridge)
+ */
+struct fsl_pci {
+	struct list_head node;
+	bool is_pcie;
+	struct device_node *dn;
+	struct device *dev;
+
+	int first_busno;
+	int last_busno;
+	int self_busno;
+	struct resource busn;
+
+	struct pci_ops *ops;
+	struct ccsr_pci __iomem *regs;
+
+#define INDIRECT_TYPE_SET_CFG_TYPE		0x00000001
+#define INDIRECT_TYPE_EXT_REG		0x00000002
+#define INDIRECT_TYPE_SURPRESS_PRIMARY_BUS	0x00000004
+#define INDIRECT_TYPE_NO_PCIE_LINK		0x00000008
+#define INDIRECT_TYPE_BIG_ENDIAN		0x00000010
+#define INDIRECT_TYPE_BROKEN_MRM		0x00000020
+#define INDIRECT_TYPE_FSL_CFG_REG_LINK	0x00000040
+	u32 indirect_type;
+
+	struct resource io_resource;
+	resource_size_t io_base_phys;
+	resource_size_t pci_io_size;
+
+	struct resource mem_resources[3];
+	resource_size_t mem_offset[3];
+
+	int global_number;	/* PCI domain number */
+
+	resource_size_t dma_window_base_cur;
+	resource_size_t dma_window_size;
+
+	void *sys;
+};
+
+/*
+ * Convert architecture specific pci controller structure to fsl_pci
+ * PowerPC uses structure pci_controller and ARM uses structure pci_sys_data
+ * to describe pci controller.
+ */
+extern struct fsl_pci *fsl_arch_sys_to_pci(void *sys);
+
 #endif /* __PCI_COMMON_H */
 #endif /* __KERNEL__ */
-- 
1.8.1.2


