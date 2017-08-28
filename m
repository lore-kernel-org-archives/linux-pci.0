Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0046.outbound.protection.outlook.com ([104.47.40.46]:20427
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751172AbdH1LKN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 07:10:13 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <niklas.cassel@axis.com>, <jesper.nilsson@axis.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv5 3/9] PCI: layerscape: add class code and multifunction fixups for ls1021a
Date: Mon, 28 Aug 2017 18:52:55 +0800
Message-ID: <20170828105301.8511-4-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
References: <20170828105301.8511-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current code depends on these 2 fixups implemented in bootloader,
this patch is to resolve the dependence.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Roy Zang <tie-fei.zang@freescale.com>
---
V5:
 - No change

 drivers/pci/dwc/pci-layerscape.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index c16940044ed6..3aa34214643c 100644
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
2.14.1
