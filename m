Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:53539
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751223AbdHCIke (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 04:40:34 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 5/6] PCI: layerscape: Disable the outbound windows configured by bootloader
Date: Thu, 3 Aug 2017 16:23:39 +0800
Message-ID: <1501748620-42866-6-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Disable the outbound windows configured by bootloader to avoid
one transaction hitting multiple outbound windows because the
function dw_pcie_setup_rc will re-configure the outbound windows
which maybe confict with the bootloader configured.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - New patch split from patch v1 3/3.

 drivers/pci/dwc/pci-layerscape.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 3533a8c..ad68894 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -34,6 +34,8 @@
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
 
+#define PCIE_IATU_NUM		6
+
 struct ls_pcie_drvdata {
 	u32 lut_offset;
 	u32 ltssm_shift;
@@ -90,6 +92,14 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
 }
 
+static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
+{
+	int i;
+
+	for (i = 0; i < PCIE_IATU_NUM; i++)
+		dw_pcie_disable_atu(pcie->pci, DW_PCIE_REGION_OUTBOUND, i);
+}
+
 static int ls1021_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 state;
@@ -127,6 +137,13 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
+	/*
+	 * Disable the outbound windows configured by bootloader to avoid
+	 * one transaction hitting multiple outbound windows and the function
+	 * dw_pcie_setup_rc will re-configure the outbound windows.
+	 */
+	ls_pcie_disable_outbound_atus(pcie);
+
 	dw_pcie_dbi_ro_wr_en(pci);
 	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
-- 
2.1.0.27.g96db324
