Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754898AbcJLNm4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:42:56 -0400
Subject: [PATCH v2 3/8] PCI: hisi: Name private struct pointer "hisi_pcie"
 consistently
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 08:42:51 -0500
Message-ID: <20161012134251.28562.36477.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012133904.28562.74066.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most struct hisi_pcie pointers are already called "hisi_pcie".  Change
the rest of them to match.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index d4a5812..28c95b8 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -33,7 +33,7 @@
 struct hisi_pcie;
 
 struct pcie_soc_ops {
-	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
+	int (*hisi_pcie_link_up)(struct hisi_pcie *hisi_pcie);
 };
 
 struct hisi_pcie {
@@ -44,15 +44,15 @@ struct hisi_pcie {
 	struct pcie_soc_ops *soc_ops;
 };
 
-static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie,
+static inline void hisi_pcie_apb_writel(struct hisi_pcie *hisi_pcie,
 					u32 val, u32 reg)
 {
-	writel(val, pcie->reg_base + reg);
+	writel(val, hisi_pcie->reg_base + reg);
 }
 
-static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *pcie, u32 reg)
+static inline u32 hisi_pcie_apb_readl(struct hisi_pcie *hisi_pcie, u32 reg)
 {
-	return readl(pcie->reg_base + reg);
+	return readl(hisi_pcie->reg_base + reg);
 }
 
 /* HipXX PCIe host only supports 32-bit config access */
@@ -61,12 +61,12 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int size,
 {
 	u32 reg;
 	u32 reg_val;
-	struct hisi_pcie *pcie = to_hisi_pcie(pp);
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
 	void *walker = &reg_val;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = hisi_pcie_apb_readl(pcie, reg);
+	reg_val = hisi_pcie_apb_readl(hisi_pcie, reg);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -86,21 +86,21 @@ static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int  size,
 {
 	u32 reg_val;
 	u32 reg;
-	struct hisi_pcie *pcie = to_hisi_pcie(pp);
+	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
 	void *walker = &reg_val;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		hisi_pcie_apb_writel(pcie, val, reg);
+		hisi_pcie_apb_writel(hisi_pcie, val, reg);
 	else if (size == 2) {
-		reg_val = hisi_pcie_apb_readl(pcie, reg);
+		reg_val = hisi_pcie_apb_readl(hisi_pcie, reg);
 		*(u16 __force *) walker = val;
-		hisi_pcie_apb_writel(pcie, reg_val, reg);
+		hisi_pcie_apb_writel(hisi_pcie, reg_val, reg);
 	} else if (size == 1) {
-		reg_val = hisi_pcie_apb_readl(pcie, reg);
+		reg_val = hisi_pcie_apb_readl(hisi_pcie, reg);
 		*(u8 __force *) walker = val;
-		hisi_pcie_apb_writel(pcie, reg_val, reg);
+		hisi_pcie_apb_writel(hisi_pcie, reg_val, reg);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 

