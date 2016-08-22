Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60465 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756610AbcHVWAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2016 18:00:22 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 5/8] PCI: spear13xx: make it explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:45 -0400
Message-ID: <20160822215948.27251-6-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_SPEAR13XX
drivers/pci/host/Kconfig:       bool "STMicroelectronics SPEAr PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple instances of modular code usage, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-spear13xx.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
index a4060b85ab23..09aed85f275a 100644
--- a/drivers/pci/host/pcie-spear13xx.c
+++ b/drivers/pci/host/pcie-spear13xx.c
@@ -15,7 +15,7 @@
 #include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
@@ -355,7 +355,6 @@ static const struct of_device_id spear13xx_pcie_of_match[] = {
 	{ .compatible = "st,spear1340-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, spear13xx_pcie_of_match);
 
 static struct platform_driver spear13xx_pcie_driver = {
 	.probe		= spear13xx_pcie_probe,
@@ -365,14 +364,8 @@ static struct platform_driver spear13xx_pcie_driver = {
 	},
 };
 
-/* SPEAr13xx PCIe driver does not allow module unload */
-
 static int __init spear13xx_pcie_init(void)
 {
 	return platform_driver_register(&spear13xx_pcie_driver);
 }
-module_init(spear13xx_pcie_init);
-
-MODULE_DESCRIPTION("ST Microelectronics SPEAr13xx PCIe host controller driver");
-MODULE_AUTHOR("Pratyush Anand <pratyush.anand@gmail.com>");
-MODULE_LICENSE("GPL v2");
+device_initcall(spear13xx_pcie_init);
-- 
2.8.4

