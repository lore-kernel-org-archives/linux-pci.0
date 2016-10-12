Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754953AbcJLNnM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:43:12 -0400
Subject: [PATCH v2 5/8] PCI: hisi: Use generic DesignWare accessors
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:43:07 -0500
Message-ID: <20161012134307.28562.93976.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces already add in
pp->dbi_base, so use those instead of doing it ourselves in the hisi
driver.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index f2bb206..d0e081b 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -43,29 +43,17 @@ struct hisi_pcie {
 	struct pcie_soc_ops *soc_ops;
 };
 
-static inline void hisi_pcie_apb_writel(struct hisi_pcie *hisi_pcie,
-					u32 val, u32 reg)
-{
-	writel(val, hisi_pcie->pp.dbi_base + reg);
-}
-
-static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *hisi_pcie, u32 reg)
-{
-	return readl(hisi_pcie->pp.dbi_base + reg);
-}
-
 /* HipXX PCIe host only supports 32-bit config access */
 static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 			      u32 *val)
 {
 	u32 reg;
 	u32 reg_val;
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
 	void *walker = &reg_val;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = hisi_pcie_apb_readl(hisi_pcie, reg);
+	reg_val = dw_pcie_readl_rc(pp, reg);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -85,21 +73,20 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 {
 	u32 reg_val;
 	u32 reg;
-	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
 	void *walker = &reg_val;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		hisi_pcie_apb_writel(hisi_pcie, val, reg);
+		dw_pcie_writel_rc(pp, reg, val);
 	else if (size == 2) {
-		reg_val = hisi_pcie_apb_readl(hisi_pcie, reg);
+		reg_val = dw_pcie_readl_rc(pp, reg);
 		*(u16 __force *) walker = val;
-		hisi_pcie_apb_writel(hisi_pcie, reg_val, reg);
+		dw_pcie_writel_rc(pp, reg, reg_val);
 	} else if (size == 1) {
-		reg_val = hisi_pcie_apb_readl(hisi_pcie, reg);
+		reg_val = dw_pcie_readl_rc(pp, reg);
 		*(u8 __force *) walker = val;
-		hisi_pcie_apb_writel(hisi_pcie, reg_val, reg);
+		dw_pcie_writel_rc(pp, reg, reg_val);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -118,10 +105,10 @@ static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
 
 static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie)
 {
+	struct pcie_port *pp = &hisi_pcie->pp;
 	u32 val;
 
-	val = hisi_pcie_apb_readl(hisi_pcie, PCIE_HIP06_CTRL_OFF +
-			PCIE_SYS_STATE4);
+	val = dw_pcie_readl_rc(pp, PCIE_HIP06_CTRL_OFF + PCIE_SYS_STATE4);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }

