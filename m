Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:34176 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932622AbcHXU6f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2016 16:58:35 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 7/9] PCI: PCIe xilinx-nwl: make host code explicitly non-modular
Date: Wed, 24 Aug 2016 16:57:50 -0400
Message-ID: <20160824205752.12024-8-paul.gortmaker@windriver.com>
In-Reply-To: <20160824205752.12024-1-paul.gortmaker@windriver.com>
References: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_XILINX_NWL
drivers/pci/host/Kconfig:       bool "NWL PCIe Core"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and it allows us to drop the ".remove"
code for non-modular drivers.  Several functions only used by the
remove function are also deleted here.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: "Sören Brinkmann" <soren.brinkmann@xilinx.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 53 +++-----------------------------------
 1 file changed, 3 insertions(+), 50 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 0b597d9190b4..df7fb8b69658 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -15,7 +15,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -459,40 +459,6 @@ static const struct irq_domain_ops dev_msi_domain_ops = {
 	.free   = nwl_irq_domain_free,
 };
 
-static void nwl_msi_free_irq_domain(struct nwl_pcie *pcie)
-{
-	struct nwl_msi *msi = &pcie->msi;
-
-	if (msi->irq_msi0)
-		irq_set_chained_handler_and_data(msi->irq_msi0, NULL, NULL);
-	if (msi->irq_msi1)
-		irq_set_chained_handler_and_data(msi->irq_msi1, NULL, NULL);
-
-	if (msi->msi_domain)
-		irq_domain_remove(msi->msi_domain);
-	if (msi->dev_domain)
-		irq_domain_remove(msi->dev_domain);
-
-	kfree(msi->bitmap);
-	msi->bitmap = NULL;
-}
-
-static void nwl_pcie_free_irq_domain(struct nwl_pcie *pcie)
-{
-	int i;
-	u32 irq;
-
-	for (i = 0; i < INTX_NUM; i++) {
-		irq = irq_find_mapping(pcie->legacy_irq_domain, i + 1);
-		if (irq > 0)
-			irq_dispose_mapping(irq);
-	}
-	if (pcie->legacy_irq_domain)
-		irq_domain_remove(pcie->legacy_irq_domain);
-
-	nwl_msi_free_irq_domain(pcie);
-}
-
 static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 {
 #ifdef CONFIG_PCI_MSI
@@ -867,25 +833,12 @@ error:
 	return err;
 }
 
-static int nwl_pcie_remove(struct platform_device *pdev)
-{
-	struct nwl_pcie *pcie = platform_get_drvdata(pdev);
-
-	nwl_pcie_free_irq_domain(pcie);
-	platform_set_drvdata(pdev, NULL);
-	return 0;
-}
-
 static struct platform_driver nwl_pcie_driver = {
 	.driver = {
 		.name = "nwl-pcie",
+		.suppress_bind_attrs = true,
 		.of_match_table = nwl_pcie_of_match,
 	},
 	.probe = nwl_pcie_probe,
-	.remove = nwl_pcie_remove,
 };
-module_platform_driver(nwl_pcie_driver);
-
-MODULE_AUTHOR("Xilinx, Inc");
-MODULE_DESCRIPTION("NWL PCIe driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(nwl_pcie_driver);
-- 
2.8.4

