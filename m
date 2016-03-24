Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
To: <bhelgaas@google.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH next v1 2/2] PCI: keystone: remove unnecessary goto statement
Date: Thu, 24 Mar 2016 18:28:18 -0400
Message-ID: <1458858498-20559-2-git-send-email-m-karicheri2@ti.com>
In-Reply-To: <1458858498-20559-1-git-send-email-m-karicheri2@ti.com>
References: <1458858498-20559-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fix the misuse of goto statement in ks_pcie_get_irq_controller_info()
as simple return is more appropriate for this function. While at
it add an error log for absence of interrupt controller node.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 v1 - same as before initial version
 drivers/pci/host/pci-keystone.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index a2b3ff6..fc153a7 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -181,11 +181,13 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 	*np_temp = of_find_node_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
-		goto out;
+		return ret;
 	}
 	temp = of_irq_count(*np_temp);
-	if (!temp)
-		goto out;
+	if (!temp) {
+		dev_err(dev, "No entries in %s\n", controller);
+		return ret;
+	}
 	if (temp > max_host_irqs)
 		dev_warn(dev, "Too many %s interrupts defined %u\n",
 			(legacy ? "legacy" : "MSI"), temp);
@@ -203,7 +205,6 @@ static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
 		*num_irqs = temp;
 		ret = 0;
 	}
-out:
 	return ret;
 }
 
@@ -231,6 +232,7 @@ static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
 	/* enable error interrupt */
 	if (ks_pcie->error_irq > 0)
 		ks_dw_pcie_enable_error_irq(ks_pcie->va_app_base);
+
 }
 
 /*
-- 
1.9.1
