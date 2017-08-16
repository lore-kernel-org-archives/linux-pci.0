Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0076.outbound.protection.outlook.com ([104.47.33.76]:15854
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbdHPFOU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 01:14:20 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 7/9] PCI: layerscape: use accessors to enable/disable DBI RO registers' write permission
Date: Wed, 16 Aug 2017 12:56:57 +0800
Message-ID: <1502859419-33696-8-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Use the accessors instead accessing the DBI read-only write enable
register directly.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - No change

 drivers/pci/dwc/pci-layerscape.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 44a603d..0c1330f 100644
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
 
-- 
2.1.0.27.g96db324
