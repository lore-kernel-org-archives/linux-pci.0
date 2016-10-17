Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35006 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757588AbcJQO7P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:59:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id s8so12933806pfj.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Oct 2016 07:59:15 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: bhelgaas@google.com, michal.simek@xilinx.com,
        soren.brinkmann@xilinx.com, po.liu@nxp.com,
        christophe.jaillet@wanadoo.fr, paul.gortmaker@windriver.com,
        bharat.kumar.gogada@xilinx.com, rgummal@xilinx.com, arnd@arndb.de
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH -next] PCI: xilinx: Add missing of_node_put() in xilinx_pcie_init_irq_domain()
Date: Mon, 17 Oct 2016 14:59:04 +0000
Message-Id: <1476716344-1050-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

This node pointer is returned by of_get_next_child() with refcount
incremented in this function. of_node_put() on it before exitting
this function on error.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/host/pcie-xilinx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index c8616fa..7100ee5 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -529,6 +529,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 						 port);
 	if (!port->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		of_node_put(pcie_intc_node);
 		return -ENODEV;
 	}
 
@@ -540,6 +541,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 							 &xilinx_pcie_msi_chip);
 		if (!port->msi_domain) {
 			dev_err(dev, "Failed to get a MSI IRQ domain\n");
+			of_node_put(pcie_intc_node);
 			return -ENODEV;
 		}

