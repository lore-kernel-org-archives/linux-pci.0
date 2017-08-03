Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0081.outbound.protection.outlook.com ([104.47.34.81]:10598
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751213AbdHCIkh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 04:40:37 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 6/6] PCI: layerscape: remove the duplicate Class field fix code
Date: Thu, 3 Aug 2017 16:23:40 +0800
Message-ID: <1501748620-42866-7-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The Class Code will be fixed by function dw_pcie_setup_rc.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - New patch split from patch v1 3/3.

 drivers/pci/dwc/pci-layerscape.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index ad68894..bf52825 100644
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
@@ -145,7 +137,6 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	ls_pcie_disable_outbound_atus(pcie);
 
 	dw_pcie_dbi_ro_wr_en(pci);
-	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
 	dw_pcie_dbi_ro_wr_dis(pci);
 
-- 
2.1.0.27.g96db324
