Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964852AbcJGQh5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Oct 2016 12:37:57 -0400
Subject: [PATCH 08/11] PCI: hisi: Replace hisi_apb_readl() with
 dw_pcie_readl_rc()
To: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 07 Oct 2016 11:37:50 -0500
Message-ID: <20161007163750.25540.95889.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163654.25540.29741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The dw_pcie_readl_rc() and dw_pcie_writel_rc() interfaces do the same as
hisi_apb_readl() and hisi_apb_writel(), and they also give us a clue that
we're using the DesignWare-generic functionality.  Use the dw_*()
interfaces and remove the hisi-specific ones.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-hisi.c |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index c6b0459..707dafd 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -43,27 +43,16 @@ struct hisi_pcie {
 	struct pcie_soc_ops *soc_ops;
 };
 
-static u32 hisi_apb_readl(struct hisi_pcie *hisi, u32 reg)
-{
-	return readl(hisi->pp.dbi_base + reg);
-}
-
-static void hisi_apb_writel(struct hisi_pcie *hisi, u32 reg, u32 val)
-{
-	writel(val, hisi->pp.dbi_base + reg);
-}
-
 /* HipXX PCIe host only supports 32-bit config access */
 static int hisi_cfg_read(struct pcie_port *pp, int where, int size, u32 *val)
 {
-	struct hisi_pcie *hisi = to_hisi_pcie(pp);
 	u32 reg;
 	u32 reg_val;
 	void *walker = &reg_val;
 
 	walker += (where & 0x3);
 	reg = where & ~0x3;
-	reg_val = hisi_apb_readl(hisi, reg);
+	reg_val = dw_pcie_readl_rc(pp, reg);
 
 	if (size == 1)
 		*val = *(u8 __force *) walker;
@@ -80,7 +69,6 @@ static int hisi_cfg_read(struct pcie_port *pp, int where, int size, u32 *val)
 /* HipXX PCIe host only supports 32-bit config access */
 static int hisi_cfg_write(struct pcie_port *pp, int where, int  size, u32 val)
 {
-	struct hisi_pcie *hisi = to_hisi_pcie(pp);
 	u32 reg_val;
 	u32 reg;
 	void *walker = &reg_val;
@@ -88,15 +76,15 @@ static int hisi_cfg_write(struct pcie_port *pp, int where, int  size, u32 val)
 	walker += (where & 0x3);
 	reg = where & ~0x3;
 	if (size == 4)
-		hisi_apb_writel(hisi, reg, val);
+		dw_pcie_writel_rc(pp, reg, val);
 	else if (size == 2) {
-		reg_val = hisi_apb_readl(hisi, reg);
+		reg_val = dw_pcie_readl_rc(pp, reg);
 		*(u16 __force *) walker = val;
-		hisi_apb_writel(hisi, reg, reg_val);
+		dw_pcie_writel_rc(pp, reg, reg_val);
 	} else if (size == 1) {
-		reg_val = hisi_apb_readl(hisi, reg);
+		reg_val = dw_pcie_readl_rc(pp, reg);
 		*(u8 __force *) walker = val;
-		hisi_apb_writel(hisi, reg, reg_val);
+		dw_pcie_writel_rc(pp, reg, reg_val);
 	} else
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
@@ -116,7 +104,7 @@ static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi)
 {
 	u32 val;
 
-	val = hisi_apb_readl(hisi, PCIE_HIP06_CTRL_OFF + PCIE_SYS_STATE4);
+	val = dw_pcie_readl_rc(&hisi->pp, PCIE_HIP06_CTRL_OFF + PCIE_SYS_STATE4);
 
 	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
 }

