Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50008 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756511AbcHVWAM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2016 18:00:12 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <rfi@lists.rocketboards.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 1/8] PCI: altera: make msi explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:41 -0400
Message-ID: <20160822215948.27251-2-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_ALTERA_MSI
drivers/pci/host/Kconfig:       bool "Altera PCIe MSI feature"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: rfi@lists.rocketboards.org
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-altera-msi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pcie-altera-msi.c b/drivers/pci/host/pcie-altera-msi.c
index 99177f4ccde2..369e033449c6 100644
--- a/drivers/pci/host/pcie-altera-msi.c
+++ b/drivers/pci/host/pcie-altera-msi.c
@@ -1,4 +1,8 @@
 /*
+ * Altera PCIe MSI support
+ *
+ * Author: Ley Foon Tan <lftan@altera.com>
+ *
  * Copyright Altera Corporation (C) 2013-2015. All rights reserved
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -16,7 +20,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -308,7 +312,3 @@ static int __init altera_msi_init(void)
 	return platform_driver_register(&altera_msi_driver);
 }
 subsys_initcall(altera_msi_init);
-
-MODULE_AUTHOR("Ley Foon Tan <lftan@altera.com>");
-MODULE_DESCRIPTION("Altera PCIe MSI support");
-MODULE_LICENSE("GPL v2");
-- 
2.8.4

