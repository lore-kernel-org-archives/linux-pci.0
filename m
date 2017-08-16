Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0059.outbound.protection.outlook.com ([104.47.37.59]:51970
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbdHPFO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 01:14:26 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 9/9] PCI: dwc: remove the obsolete fixups
Date: Wed, 16 Aug 2017 12:56:59 +0800
Message-ID: <1502859419-33696-10-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Now, the dw_pcie_setup_rc() works well, so remove the obsolete fixups:
Remove the Class field fix code from layerscape pcie driver.
Remove the implement of .rd_own_conf() from qcom pcie driver, which
is aim to correct the Class code value read from the config space.
Remove the line to enable write permission of DBI RO register from
artpec6 pcie driver.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - Add the removing of the obsolete fixups from qcom and artpec6 pcie driver

 drivers/pci/dwc/pci-layerscape.c |  9 ---------
 drivers/pci/dwc/pcie-artpec6.c   |  6 ------
 drivers/pci/dwc/pcie-qcom.c      | 17 -----------------
 3 files changed, 32 deletions(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 0c1330f..d22ed57 100644
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
index 5d81f1d..d153491 100644
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
 
diff --git a/drivers/pci/dwc/pcie-qcom.c b/drivers/pci/dwc/pcie-qcom.c
index 871e7d9..4fb3ce0d 100644
--- a/drivers/pci/dwc/pcie-qcom.c
+++ b/drivers/pci/dwc/pcie-qcom.c
@@ -948,25 +948,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	return ret;
 }
 
-static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-				 u32 *val)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	/* the device class is not reported correctly from the register */
-	if (where == PCI_CLASS_REVISION && size == 4) {
-		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
-		*val &= 0xff;	/* keep revision id */
-		*val |= PCI_CLASS_BRIDGE_PCI << 16;
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	return dw_pcie_read(pci->dbi_base + where, size, val);
-}
-
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.host_init = qcom_pcie_host_init,
-	.rd_own_conf = qcom_pcie_rd_own_conf,
 };
 
 static const struct qcom_pcie_ops ops_v0 = {
-- 
2.1.0.27.g96db324
