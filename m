Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:34336
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753168AbdGFGuF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jul 2017 02:50:05 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 1/3] PCI: designware: add accessors for write permission of DBI read-only registers
Date: Thu, 6 Jul 2017 14:33:47 +0800
Message-ID: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The read-only DBI registers can be written over the DBI when set
the "Write to RO Registers Using DBI" (DBI_RO_WR_EN) field of the
MISC_CONTROL_1_OFF register.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/dwc/pcie-designware.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware.h b/drivers/pci/dwc/pcie-designware.h
index b4d2a89..bbdf35b 100644
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
2.1.0.27.g96db324
