Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0075.outbound.protection.outlook.com ([104.47.32.75]:18080
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753057AbdHWG0y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Aug 2017 02:26:54 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 5/9] PCI: layerscape: Disable the outbound windows configured by bootloader
Date: Wed, 23 Aug 2017 14:08:52 +0800
Message-ID: <20170823060856.9387-6-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Disable all the outbound windows to avoid one transaction hitting
multiple outbound windows, because the function dw_pcie_setup_rc
will re-configure the outbound windows which maybe confict with
the bootloader configured.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V4:
 - no change

 drivers/pci/dwc/pci-layerscape.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 57b86a0cd2c8..44a603db217a 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -35,6 +35,8 @@
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
 #define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
 
+#define PCIE_IATU_NUM		6
+
 struct ls_pcie_drvdata {
 	u32 lut_offset;
 	u32 ltssm_shift;
@@ -91,6 +93,14 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
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
@@ -128,6 +138,13 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct ls_pcie *pcie = to_ls_pcie(pci);
 
+	/*
+	 * Disable the outbound windows configured by bootloader to avoid
+	 * one transaction hitting multiple outbound windows and the function
+	 * dw_pcie_setup_rc will re-configure the outbound windows.
+	 */
+	ls_pcie_disable_outbound_atus(pcie);
+
 	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
 	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
-- 
2.14.1
