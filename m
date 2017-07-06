Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0087.outbound.protection.outlook.com ([104.47.36.87]:10160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753177AbdGFGuG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jul 2017 02:50:06 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 2/3] PCI: designware: enable write permission before updating class code
Date: Thu, 6 Jul 2017 14:33:48 +0800
Message-ID: <1499322829-23018-2-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1499322829-23018-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index d29c020..6e10cda 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -634,8 +634,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
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
2.1.0.27.g96db324
