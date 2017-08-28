Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:20431
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751234AbdH1LKS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 07:10:18 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 4/9] PCI: layerscape: move ls1021 specific host_init behind the common one
Date: Mon, 28 Aug 2017 18:52:56 +0800
Message-ID: <20170828105301.8511-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
References: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

To prepare for calling the common host_init in ls1021 spceific
host_init, moves ls1021 specific host_init behind the common
host_init function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
---
V5:
 - New patch, split from 4/9 patch v4

 drivers/pci/dwc/pci-layerscape.c | 64 ++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 3aa34214643c..160035efa4d9 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -108,6 +108,38 @@ static int ls1021_pcie_link_up(struct dw_pcie *pci)
 	return 1;
 }
 
+static int ls_pcie_link_up(struct dw_pcie *pci)
+{
+	struct ls_pcie *pcie = to_ls_pcie(pci);
+	u32 state;
+
+	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
+		 pcie->drvdata->ltssm_shift) &
+		 LTSSM_STATE_MASK;
+
+	if (state < LTSSM_PCIE_L0)
+		return 0;
+
+	return 1;
+}
+
+static int ls_pcie_host_init(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct ls_pcie *pcie = to_ls_pcie(pci);
+
+	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
+	ls_pcie_fix_class(pcie);
+	ls_pcie_clear_multifunction(pcie);
+	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
+
+	ls_pcie_drop_msg_tlp(pcie);
+
+	dw_pcie_setup_rc(pp);
+
+	return 0;
+}
+
 static int ls1021_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -144,38 +176,6 @@ static int ls1021_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int ls_pcie_link_up(struct dw_pcie *pci)
-{
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-	u32 state;
-
-	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
-		 pcie->drvdata->ltssm_shift) &
-		 LTSSM_STATE_MASK;
-
-	if (state < LTSSM_PCIE_L0)
-		return 0;
-
-	return 1;
-}
-
-static int ls_pcie_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-
-	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
-	ls_pcie_fix_class(pcie);
-	ls_pcie_clear_multifunction(pcie);
-	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
-
-	ls_pcie_drop_msg_tlp(pcie);
-
-	dw_pcie_setup_rc(pp);
-
-	return 0;
-}
-
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
 				 struct msi_controller *chip)
 {
-- 
2.14.1
