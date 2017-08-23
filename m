Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:43584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753301AbdHWG1I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Aug 2017 02:27:08 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 8/9] PCI: designware: enable write permission before updating DBI RO registers
Date: Wed, 23 Aug 2017 14:08:55 +0800
Message-ID: <20170823060856.9387-9-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
References: <20170823060856.9387-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The existing fix doesn't actually work because the Class register and
interrupt PIN register are read-only, so it must enable the write
permission before writing the correct value to these registers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-By: Joao Pinto <jpinto@synopsys.com>
---
V4:
 - no change

 drivers/pci/dwc/pcie-designware-host.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 157621175147..582f5cc3cd96 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -597,10 +597,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
 
 	/* setup interrupt pins */
+	dw_pcie_dbi_ro_wr_en(pci);
 	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
 	val &= 0xffff00ff;
 	val |= 0x00000100;
 	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	/* setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
@@ -637,8 +639,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
 
+	/* Enable write permission for the DBI read-only register */
+	dw_pcie_dbi_ro_wr_en(pci);
 	/* program correct class for RC */
 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
+	/* Better disable write permission right after the update */
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	dw_pcie_rd_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, &val);
 	val |= PORT_LOGIC_SPEED_CHANGE;
-- 
2.14.1
