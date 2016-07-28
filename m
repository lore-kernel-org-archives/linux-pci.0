Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:42376 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905AbcG1TeJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 15:34:09 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH -next] PCI/PCIe: make DPC explicitly non-modular
Date: Thu, 28 Jul 2016 15:33:03 -0400
Message-ID: <20160728193303.12945-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/pcie/Kconfig:config PCIE_DPC
drivers/pci/pcie/Kconfig:       bool "PCIe Downstream Port Containment support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[This mismatch just appeared in Thursday's linux-next; doesn't matter
 to me if we update it now or I batch it in with other pending PCI
 changes for-4.9 -- either one is fine; choice is up to you folks.]

 drivers/pci/pcie/pcie-dpc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 250f87861786..9811b14d9ad8 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -1,5 +1,7 @@
 /*
  * PCI Express Downstream Port Containment services driver
+ * Author: Keith Busch <keith.busch@intel.com>
+ *
  * Copyright (C) 2016 Intel Corp.
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -9,7 +11,7 @@
 
 #include <linux/delay.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/pcieport_if.h>
 
@@ -143,16 +145,4 @@ static int __init dpc_service_init(void)
 {
 	return pcie_port_service_register(&dpcdriver);
 }
-
-static void __exit dpc_service_exit(void)
-{
-	pcie_port_service_unregister(&dpcdriver);
-}
-
-MODULE_DESCRIPTION("PCI Express Downstream Port Containment driver");
-MODULE_AUTHOR("Keith Busch <keith.busch@intel.com>");
-MODULE_LICENSE("GPL");
-MODULE_VERSION("0.1");
-
-module_init(dpc_service_init);
-module_exit(dpc_service_exit);
+device_initcall(dpc_service_init);
-- 
2.8.4

