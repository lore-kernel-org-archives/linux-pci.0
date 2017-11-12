Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:51058 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdKLM3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Nov 2017 07:29:00 -0500
From: Johan Hovold <johan@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] PCI: keystone: fix interrupt-controller-node lookup
Date: Sun, 12 Nov 2017 13:28:50 +0100
Message-Id: <20171112122850.30804-1-johan@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix child-node lookup during initialisation, which ended up searching
the whole device tree depth-first starting at the parent rather than
just matching on its children.

To make things worse, the parent pci node was prematurely freed, while
the child interrupt-controller node was leaked.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Cc: stable <stable@vger.kernel.org>     # 3.18
Cc: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/pci/dwc/pci-keystone.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pci-keystone.c b/drivers/pci/dwc/pci-keystone.c
index 5bee3af47588..39405598b22d 100644
--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -178,7 +178,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 	}
 
 	/* interrupt controller is in a child node */
-	*np_temp = of_find_node_by_name(np_pcie, controller);
+	*np_temp = of_get_child_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
 		return -EINVAL;
@@ -187,6 +187,7 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 	temp = of_irq_count(*np_temp);
 	if (!temp) {
 		dev_err(dev, "No IRQ entries in %s\n", controller);
+		of_node_put(*np_temp);
 		return -EINVAL;
 	}
 
@@ -204,6 +205,8 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 			break;
 	}
 
+	of_node_put(*np_temp);
+
 	if (temp) {
 		*num_irqs = temp;
 		return 0;
-- 
2.15.0
