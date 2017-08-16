Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:3188
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbdHPFN5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 01:13:57 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 1/9] PCI: layerscape: Add dw_pcie_setup_rc to ls-pcie common host init
Date: Wed, 16 Aug 2017 12:56:51 +0800
Message-ID: <1502859419-33696-2-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This function has been added to ls1021a host init function, but lost to
add to layerscape common host init, so other platforms still use the
setups from bootloader.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - New patch separated from 4/6 patch set v2.

 drivers/pci/dwc/pci-layerscape.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 7581490..aebefb4 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -165,6 +165,8 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	ls_pcie_drop_msg_tlp(pcie);
 	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
 
+	dw_pcie_setup_rc(pp);
+
 	return 0;
 }
 
-- 
2.1.0.27.g96db324
