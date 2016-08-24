Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:34181 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbcHXU6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2016 16:58:49 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 4/9] PCI: dra7xx: make host code explicitly non-modular
Date: Wed, 24 Aug 2016 16:57:47 -0400
Message-ID: <20160824205752.12024-5-paul.gortmaker@windriver.com>
In-Reply-To: <20160824205752.12024-1-paul.gortmaker@windriver.com>
References: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_DRA7XX
drivers/pci/host/Kconfig:       bool "TI DRA7xx PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-dra7xx.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 81b3949a26db..19223ed2e619 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -15,7 +15,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
@@ -443,25 +443,6 @@ err_phy:
 	return ret;
 }
 
-static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
-{
-	struct dra7xx_pcie *dra7xx = platform_get_drvdata(pdev);
-	struct pcie_port *pp = &dra7xx->pp;
-	struct device *dev = &pdev->dev;
-	int count = dra7xx->phy_count;
-
-	if (pp->irq_domain)
-		irq_domain_remove(pp->irq_domain);
-	pm_runtime_put(dev);
-	pm_runtime_disable(dev);
-	while (count--) {
-		phy_power_off(dra7xx->phy[count]);
-		phy_exit(dra7xx->phy[count]);
-	}
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int dra7xx_pcie_suspend(struct device *dev)
 {
@@ -545,19 +526,13 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 	{ .compatible = "ti,dra7-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, of_dra7xx_pcie_match);
 
 static struct platform_driver dra7xx_pcie_driver = {
-	.remove		= __exit_p(dra7xx_pcie_remove),
 	.driver = {
 		.name	= "dra7-pcie",
 		.of_match_table = of_dra7xx_pcie_match,
+		.suppress_bind_attrs = true,
 		.pm	= &dra7xx_pcie_pm_ops,
 	},
 };
-
-module_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
-
-MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_DESCRIPTION("TI PCIe controller driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
-- 
2.8.4

