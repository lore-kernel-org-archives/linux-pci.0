Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33294 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757865AbcJQOy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2016 10:54:57 -0400
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: dra7xx: Add missing of_node_put() in dra7xx_pcie_init_irq_domain()
Date: Mon, 17 Oct 2016 14:54:37 +0000
Message-Id: <1476716077-30379-1-git-send-email-weiyj.lk@gmail.com>
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
 drivers/pci/host/pci-dra7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 9595fad..79297e9 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -177,6 +177,7 @@ static int dra7xx_pcie_init_irq_domain(struct pcie_port *pp)
 					       &intx_domain_ops, pp);
 	if (!pp->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
+		of_node_put(pcie_intc_node);
 		return -ENODEV;
 	}

