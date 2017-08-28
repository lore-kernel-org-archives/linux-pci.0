Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:11740
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751234AbdH1LKV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 07:10:21 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 5/9] PCI: layerscape: refactor the host_init function
Date: Mon, 28 Aug 2017 18:52:57 +0800
Message-ID: <20170828105301.8511-6-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
References: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Make the ls1021a specific host_init reuse layerscape platform
common host_init function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
---
V5:
 - Removed ls1021 host_init moving part from this patch

 drivers/pci/dwc/pci-layerscape.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index 160035efa4d9..27234dae4cba 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -164,16 +164,7 @@ static int ls1021_pcie_host_init(struct pcie_port *pp)
 	}
 	pcie->index = index[1];
 
-	dw_pcie_setup_rc(pp);
-
-	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
-	ls_pcie_fix_class(pcie);
-	ls_pcie_clear_multifunction(pcie);
-	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
-
-	ls_pcie_drop_msg_tlp(pcie);
-
-	return 0;
+	return ls_pcie_host_init(pp);
 }
 
 static int ls_pcie_msi_host_init(struct pcie_port *pp,
-- 
2.14.1
