Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0083.outbound.protection.outlook.com ([104.47.38.83]:16256
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751271AbdH1LKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 07:10:35 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 9/9] PCI: dwc: remove the obsolete fixups
Date: Mon, 28 Aug 2017 18:53:01 +0800
Message-ID: <20170828105301.8511-10-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
References: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Now, the dw_pcie_setup_rc() works well, so remove the obsolete fixups:
Remove the Class field fix code from layerscape pcie driver.
Remove the line to enable write permission of DBI RO register from
artpec6 pcie driver.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
---
V5:
 - No change

 drivers/pci/dwc/pci-layerscape.c | 9 ---------
 drivers/pci/dwc/pcie-artpec6.c   | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 65f5d543fe89..c24dd77c6424 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -73,14 +73,6 @@ static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
 	iowrite8(PCI_HEADER_TYPE_BRIDGE, pci->dbi_base + PCI_HEADER_TYPE);
 }
 
-/* Fix class value */
-static void ls_pcie_fix_class(struct ls_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-
-	iowrite16(PCI_CLASS_BRIDGE_PCI, pci->dbi_base + PCI_CLASS_DEVICE);
-}
-
 /* Drop MSG TLP except for Vendor MSG */
 static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 {
@@ -145,7 +137,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	ls_pcie_disable_outbound_atus(pcie);
 
 	dw_pcie_dbi_ro_wr_en(pci);
-	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
diff --git a/drivers/pci/dwc/pcie-artpec6.c b/drivers/pci/dwc/pcie-artpec6.c
index 5d81f1d884e3..d153491f600f 100644
--- a/drivers/pci/dwc/pcie-artpec6.c
+++ b/drivers/pci/dwc/pcie-artpec6.c
@@ -141,12 +141,6 @@ static int artpec6_pcie_establish_link(struct artpec6_pcie *artpec6_pcie)
 	artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
 	usleep_range(100, 200);
 
-	/*
-	 * Enable writing to config regs. This is required as the Synopsys
-	 * driver changes the class code. That register needs DBI write enable.
-	 */
-	dw_pcie_writel_dbi(pci, MISC_CONTROL_1_OFF, DBI_RO_WR_EN);
-
 	/* setup root complex */
 	dw_pcie_setup_rc(pp);
 
-- 
2.14.1
