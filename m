Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:5892 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062AbaAHFBs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2014 00:01:48 -0500
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Zang Roy-R61911 <r61911@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: [PATCH 04/12][v4] pci: fsl: add early PCI indirect access support
Date: Wed, 8 Jan 2014 13:01:55 +0800
Message-ID: <1389157323-3088-4-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1389157323-3088-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver needs to read/write PCI configuration very early, at
that time architecture-specific PCI controller structure and
PCI bus have not been created. The patch provides an interface
fsl_arch_fake_pci_bus which should be implemented in
architecture-specific PCI driver to fake a PCI controller structure
and PCI bus. Using the fake PCI controller and PCI bus, the patch
provides the early indirect read/write functions.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
change log:
v4:
no change
v1-v3:
Derived from http://patchwork.ozlabs.org/patch/278965/

Based on upstream master.
Based on the discussion of RFC version here
http://patchwork.ozlabs.org/patch/274487/

 drivers/pci/host/pci-fsl-common.c | 26 ++++++++++++++++++++++++++
 include/linux/fsl/pci-common.h    |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/host/pci-fsl-common.c b/drivers/pci/host/pci-fsl-common.c
index d1846ee..a706100 100644
--- a/drivers/pci/host/pci-fsl-common.c
+++ b/drivers/pci/host/pci-fsl-common.c
@@ -198,6 +198,32 @@ static struct pci_ops fsl_indirect_pci_ops = {
 	.write = fsl_indirect_write_config,
 };
 
+#define EARLY_FSL_PCI_OP(rw, size, type)				\
+int early_fsl_##rw##_config_##size(struct fsl_pci *pci, int bus,	\
+				   int devfn, int offset, type value)	\
+{									\
+	return pci_bus_##rw##_config_##size(fsl_arch_fake_pci_bus(pci, bus),\
+					    devfn, offset, value);	\
+}
+
+EARLY_FSL_PCI_OP(read, byte, u8 *)
+EARLY_FSL_PCI_OP(read, word, u16 *)
+EARLY_FSL_PCI_OP(read, dword, u32 *)
+EARLY_FSL_PCI_OP(write, byte, u8)
+EARLY_FSL_PCI_OP(write, word, u16)
+EARLY_FSL_PCI_OP(write, dword, u32)
+
+static int early_fsl_find_capability(struct fsl_pci *pci,
+				     int busnr, int devfn, int cap)
+{
+	struct pci_bus *bus = fsl_arch_fake_pci_bus(pci, busnr);
+
+	if (!bus)
+		return 0;
+
+	return pci_bus_find_capability(bus, devfn, cap);
+}
+
 static int setup_one_atmu(struct ccsr_pci __iomem *pci,
 	unsigned int index, const struct resource *res,
 	resource_size_t offset)
diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
index 726f27b..fd6c497 100644
--- a/include/linux/fsl/pci-common.h
+++ b/include/linux/fsl/pci-common.h
@@ -156,5 +156,12 @@ bool fsl_pci_check_link(struct fsl_pci *pci);
 /* To avoid touching specified devices */
 int fsl_arch_pci_exclude_device(struct fsl_pci *pci, u8 bus, u8 devfn);
 
+/*
+ * To fake a PCI bus
+ * it is called by early_fsl_*(), at that time the architecture-dependent
+ * pci controller and pci bus have not been created.
+ */
+extern struct pci_bus *fsl_arch_fake_pci_bus(struct fsl_pci *pci, int busnr);
+
 #endif /* __PCI_COMMON_H */
 #endif /* __KERNEL__ */
-- 
1.8.1.2


