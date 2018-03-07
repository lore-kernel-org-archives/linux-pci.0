Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52638 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754359AbeCGK6L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 05:58:11 -0500
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: Joao.Pinto@synopsys.com, bhelgaas@google.com, jg1.han@samsung.com,
        lorenzo.pieralisi@arm.com, kishon@ti.com
Cc: linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com
Subject: [PATCH 1/4] PCI: dwc: designware: Define maximum number of vectors
Date: Wed,  7 Mar 2018 10:57:57 +0000
Message-Id: <e5a16a821627c1aa7b2ad6f97a84b6d3d639d1ab.1520419084.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
References: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
References: <cover.1520419084.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add callback that defines the maximum number of vectors to make it easy to
change the value in the future.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 5416aa8..83e316e 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -38,8 +38,14 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static void dw_plat_set_num_vectors(struct pcie_port *pp)
+{
+	pp->num_vectors = MSI_DEF_NUM_VECTORS;
+}
+
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
+	.set_num_vectors = dw_plat_set_num_vectors,
 };
 
 static int dw_plat_add_pcie_port(struct pcie_port *pp,
-- 
2.7.4
