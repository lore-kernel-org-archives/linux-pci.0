Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:61422
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbdHPFOA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Aug 2017 01:14:00 -0400
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <Joao.Pinto@synopsys.com>
CC: <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <svarbanov@mm-sol.com>, <niklas.cassel@axis.com>,
        <jesper.nilsson@axis.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 2/9] PCI: layerscape: move STRFMR1 access out from the DBI write-enable bracket
Date: Wed, 16 Aug 2017 12:56:52 +0800
Message-ID: <1502859419-33696-3-git-send-email-Zhiqiang.Hou@nxp.com>
In-Reply-To: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
References: <1502859419-33696-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The STRFMR1 is not a DBI read-only register, so move it out from the
write-enable bracket.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - New patch separated from 3/6 patch set v2.

 drivers/pci/dwc/pci-layerscape.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
index aebefb4..c169400 100644
--- a/drivers/pci/dwc/pci-layerscape.c
+++ b/drivers/pci/dwc/pci-layerscape.c
@@ -162,9 +162,10 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(1, pci->dbi_base + PCIE_DBI_RO_WR_EN);
 	ls_pcie_fix_class(pcie);
 	ls_pcie_clear_multifunction(pcie);
-	ls_pcie_drop_msg_tlp(pcie);
 	iowrite32(0, pci->dbi_base + PCIE_DBI_RO_WR_EN);
 
+	ls_pcie_drop_msg_tlp(pcie);
+
 	dw_pcie_setup_rc(pp);
 
 	return 0;
-- 
2.1.0.27.g96db324
