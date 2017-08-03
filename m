Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:47948
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751213AbdHCIkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 04:40:22 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 1/6] PCI: designware: add accessors for write permission of DBI read-only registers
Date: Thu, 3 Aug 2017 16:23:35 +0800
Message-ID: <1501748620-42866-2-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
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
V2:
 - None

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
