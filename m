Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0060.outbound.protection.outlook.com ([104.47.37.60]:22134
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751234AbdH1LK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 07:10:28 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 7/9] PCI: designware: add accessors for write permission of DBI read-only registers
Date: Mon, 28 Aug 2017 18:52:59 +0800
Message-ID: <20170828105301.8511-8-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
References: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The read-only DBI registers can be written over when set the "Write
to RO Registers Using DBI" (DBI_RO_WR_EN) field of the register
MISC_CONTROL_1_OFF. And change to use the accessors instead accessing
the register MISC_CONTROL_1_OFF directly.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
---
V5:
 - Squashed patch v4 6/9 and 7/9 together

 drivers/pci/dwc/pci-layerscape.c  |  5 ++---
 drivers/pci/dwc/pcie-designware.h | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 8b5083aedf16..65f5d543fe89 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -33,7 +33,6 @@
 
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
-#define PCIE_DBI_RO_WR_EN	0x8bc /* DBI Read-Only Write Enable Register */
 
 #define PCIE_IATU_NUM		6
 
@@ -145,10 +144,10 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	 */
 	ls_pcie_disable_outbound_atus(pcie);
 
-	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
+	dw_pcie_dbi_ro_wr_en(pci);
 	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
-	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	ls_pcie_drop_msg_tlp(pcie);
 
diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index 7366c8167404..0c5f874345f6 100644
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -76,6 +76,9 @@
 #define PCIE_ATU_FUNC(x)		(((x) & 0x7) << 16)
 #define PCIE_ATU_UPPER_TARGET		0x91C
 
+#define PCIE_MISC_CONTROL_1_OFF		0x8BC
+#define PCIE_DBI_RO_WR_EN		(0x1 << 0)
+
 /*
  * iATU Unroll-specific register definitions
  * From 4.80 core version the address translation will be made by unroll
@@ -279,6 +282,28 @@ static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
 	return __dw_pcie_read_dbi(pci, pci->dbi_base2, reg, 0x4);
 }
 
+static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
+{
+	u32 reg;
+	u32 val;
+
+	reg = PCIE_MISC_CONTROL_1_OFF;
+	val = dw_pcie_readl_dbi(pci, reg);
+	val |= PCIE_DBI_RO_WR_EN;
+	dw_pcie_writel_dbi(pci, reg, val);
+}
+
+static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
+{
+	u32 reg;
+	u32 val;
+
+	reg = PCIE_MISC_CONTROL_1_OFF;
+	val = dw_pcie_readl_dbi(pci, reg);
+	val &= ~PCIE_DBI_RO_WR_EN;
+	dw_pcie_writel_dbi(pci, reg, val);
+}
+
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
-- 
2.14.1
