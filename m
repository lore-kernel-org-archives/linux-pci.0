Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 5/9] PCI: PCIe qcom: make host code explicitly non-modular
Date: Wed, 24 Aug 2016 16:57:48 -0400
Message-ID: <20160824205752.12024-6-paul.gortmaker@windriver.com>
In-Reply-To: <20160824205752.12024-1-paul.gortmaker@windriver.com>
References: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_QCOM
drivers/pci/host/Kconfig:       bool "Qualcomm PCIe controller"

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
was (or is now) contained at the top of the file in the comments.

Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-qcom.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
index f2f90c50f75d..5ec2d440a6b7 100644
--- a/drivers/pci/host/pcie-qcom.c
+++ b/drivers/pci/host/pcie-qcom.c
@@ -1,7 +1,11 @@
 /*
+ * Qualcomm PCIe root complex driver
+ *
  * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
  * Copyright 2015 Linaro Limited.
  *
+ * Author: Stanimir Varbanov <svarbanov@mm-sol.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -19,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
@@ -570,37 +574,19 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int qcom_pcie_remove(struct platform_device *pdev)
-{
-	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
-
-	qcom_ep_reset_assert(pcie);
-	phy_power_off(pcie->phy);
-	phy_exit(pcie->phy);
-	pcie->ops->deinit(pcie);
-
-	return 0;
-}
-
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_v0 },
 	{ .compatible = "qcom,pcie-apq8064", .data = &ops_v0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &ops_v1 },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, qcom_pcie_match);
 
 static struct platform_driver qcom_pcie_driver = {
 	.probe = qcom_pcie_probe,
-	.remove = qcom_pcie_remove,
 	.driver = {
 		.name = "qcom-pcie",
+		.suppress_bind_attrs = true,
 		.of_match_table = qcom_pcie_match,
 	},
 };
-
-module_platform_driver(qcom_pcie_driver);
-
-MODULE_AUTHOR("Stanimir Varbanov <svarbanov@mm-sol.com>");
-MODULE_DESCRIPTION("Qualcomm PCIe root complex driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(qcom_pcie_driver);
-- 
2.8.4
