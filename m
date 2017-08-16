Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0082.outbound.protection.outlook.com ([104.47.37.82]:60064
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbdHPFOE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 01:14:04 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 3/9] PCI: layerscape: add class code and multifunction fixups for ls1021a
Date: Wed, 16 Aug 2017 12:56:53 +0800
Message-ID: <1502859419-33696-4-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current code depends on these 2 fixups implemented in bootloader,
this patch is to resolve the dependence.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - New patch

 drivers/pci/dwc/pci-layerscape.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index c169400..3aa3421 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -134,6 +134,11 @@ static int ls1021_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
+	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
+	ls_pcie_fix_class(pcie);
+	ls_pcie_clear_multifunction(pcie);
+	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
+
 	ls_pcie_drop_msg_tlp(pcie);
 
 	return 0;
-- 
2.1.0.27.g96db324
