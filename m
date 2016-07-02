Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:32940 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbcGBXOH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2016 19:14:07 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH 01/14] PCI: armada8k: make it explicitly non-modular
Date: Sat, 2 Jul 2016 19:13:21 -0400
Message-ID: <20160702231334.26684-2-paul.gortmaker@windriver.com>
In-Reply-To: <20160702231334.26684-1-paul.gortmaker@windriver.com>
References: <20160702231334.26684-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_ARMADA_8K
drivers/pci/host/Kconfig:       bool "Marvell Armada-8K PCIe controller"

...meaning that it currently is not being built as a module by anyone.

Lets remove the few trace uses of modular code and macros, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-armada8k.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
index 55723567b5d4..0f4f570068e3 100644
--- a/drivers/pci/host/pcie-armada8k.c
+++ b/drivers/pci/host/pcie-armada8k.c
@@ -5,6 +5,9 @@
  *
  * Copyright (C) 2016 Marvell Technology Group Ltd.
  *
+ * Author: Yehuda Yitshak <yehuday@marvell.com>
+ * Author: Shadi Ammouri <shadi@marvell.com>
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
@@ -14,7 +17,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
@@ -244,7 +247,6 @@ static const struct of_device_id armada8k_pcie_of_match[] = {
 	{ .compatible = "marvell,armada8k-pcie", },
 	{},
 };
-MODULE_DEVICE_TABLE(of, armada8k_pcie_of_match);
 
 static struct platform_driver armada8k_pcie_driver = {
 	.probe		= armada8k_pcie_probe,
@@ -253,10 +255,4 @@ static struct platform_driver armada8k_pcie_driver = {
 		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
 	},
 };
-
-module_platform_driver(armada8k_pcie_driver);
-
-MODULE_DESCRIPTION("Armada 8k PCIe host controller driver");
-MODULE_AUTHOR("Yehuda Yitshak <yehuday@marvell.com>");
-MODULE_AUTHOR("Shadi Ammouri <shadi@marvell.com>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(armada8k_pcie_driver);
-- 
2.8.4

