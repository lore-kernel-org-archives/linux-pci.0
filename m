Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964789AbcJGQg6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:36:58 -0400
Subject: [PATCH 01/11] PCI: hisi: Rename APB accessors
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:36:54 -0500
Message-ID: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename hisi_pcie_apb_readl() to hisi_apb_readl() and hisi_pcie_apb_writel()
to hisi_apb_writel() for consistency with other drivers.  Uninline them;
there's no performance issue here, and the compiler can inline them if it's
worthwhile.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index 7ee9dfc..15a1167 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -44,15 +44,14 @@ struct hisi_pcie {
 	struct pcie_soc_ops *soc_ops;
 };
 
-static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie,
-					u32 val, u32 reg)
+static u32 hisi_apb_readl(struct hisi_pcie *pcie, u32 reg)
 {
-	writel(val, pcie->reg_base + reg);
+	return readl(pcie->reg_base + reg);
 }
 
-static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
+static void hisi_apb_writel(struct hisi_pcie *pcie, u32 val, u32 reg)
 {
-	return readl(pcie->reg_base + reg);
+	writel(val, pcie->reg_base + reg);
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
@@ -66,7 +65,7 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = hisi_pcie_apb_readl(pcie, reg);
+	reg_val = hisi_apb_readl(pcie, reg);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -92,15 +91,15 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		hisi_pcie_apb_writel(pcie, val, reg);
+		hisi_apb_writel(pcie, val, reg);
 	else if (size == 2) {
-		reg_val = hisi_pcie_apb_readl(pcie, reg);
+		reg_val = hisi_apb_readl(pcie, reg);
 		*(u16 __force *) walker = val;
-		hisi_pcie_apb_writel(pcie, reg_val, reg);
+		hisi_apb_writel(pcie, reg_val, reg);
 	} else if (size == 1) {
-		reg_val = hisi_pcie_apb_readl(pcie, reg);
+		reg_val = hisi_apb_readl(pcie, reg);
 		*(u8 __force *) walker = val;
-		hisi_pcie_apb_writel(pcie, reg_val, reg);
+		hisi_apb_writel(pcie, reg_val, reg);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -121,8 +120,7 @@ static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
 {
 	u32 val;
 
-	val = hisi_pcie_apb_readl(hisi_pcie, PCIE_HIP06_CTRL_OFF +
-			PCIE_SYS_STATE4);
+	val = hisi_apb_readl(hisi_pcie, PCIE_HIP06_CTRL_OFF + PCIE_SYS_STATE4);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }

