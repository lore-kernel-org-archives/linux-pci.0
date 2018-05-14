Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:37929 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeENPGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 May 2018 11:06:43 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 700441E044E
        for <linux-pci@vger.kernel.org>; Mon, 14 May 2018 17:06:42 +0200 (CEST)
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com
Cc: linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] PCI: dwc: Define maximum number of vectors
Date: Mon, 14 May 2018 16:06:33 +0100
Message-Id: <cec63daa3d1090699816819c39292577016dab03.1526310065.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a callback to define the maximum number of vectors used by the RC.

Since this is a parameter associated to each SoC IP setting, makes sense
to be configurable and easily visible to future modifications.

Set DesignWare driver vectors number maximum to 256.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/pci/dwc/pcie-designware-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
index 5416aa8..80a2782 100644
--- a/drivers/pci/dwc/pcie-designware-plat.c
+++ b/drivers/pci/dwc/pcie-designware-plat.c
@@ -38,8 +38,14 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static void dw_plat_set_num_vectors(struct pcie_port *pp)
+{
+	pp->num_vectors = MAX_MSI_IRQS;
+}
+
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
 	.host_init = dw_plat_pcie_host_init,
+	.set_num_vectors = dw_plat_set_num_vectors,
 };
 
 static int dw_plat_add_pcie_port(struct pcie_port *pp,
-- 
2.7.4
