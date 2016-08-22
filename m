Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60458 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756595AbcHVWAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2016 18:00:21 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <rfi@lists.rocketboards.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 2/8] PCI: altera: make it explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:42 -0400
Message-ID: <20160822215948.27251-3-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_ALTERA
drivers/pci/host/Kconfig:       bool "Altera PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: rfi@lists.rocketboards.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-altera.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 2b7837650db8..48f2736a10cd 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -1,6 +1,9 @@
 /*
  * Copyright Altera Corporation (C) 2013-2015. All rights reserved
  *
+ * Author: Ley Foon Tan <lftan@altera.com>
+ * Description: Altera PCIe host controller driver
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -17,7 +20,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -568,7 +571,6 @@ static const struct of_device_id altera_pcie_of_match[] = {
 	{ .compatible = "altr,pcie-root-port-1.0", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, altera_pcie_of_match);
 
 static struct platform_driver altera_pcie_driver = {
 	.probe		= altera_pcie_probe,
@@ -583,8 +585,4 @@ static int altera_pcie_init(void)
 {
 	return platform_driver_register(&altera_pcie_driver);
 }
-module_init(altera_pcie_init);
-
-MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
-MODULE_DESCRIPTION("Altera PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
+device_initcall(altera_pcie_init);
-- 
2.8.4

