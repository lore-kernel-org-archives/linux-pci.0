Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:50058 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756605AbcHVWAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2016 18:00:21 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Long Nguyen <tom.l.nguyen@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 4/8] PCI: portdrv: make it explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:44 -0400
Message-ID: <20160822215948.27251-5-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Makefile/Kconfig currently controlling compilation of this code is:

pcieportdrv-y               := portdrv_core.o portdrv_pci.o portdrv_bus.o
obj-$(CONFIG_PCIEPORTBUS)   += pcieportdrv.o

drivers/pci/pcie/Kconfig:config PCIEPORTBUS
drivers/pci/pcie/Kconfig:       bool "PCI Express Port Bus support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained earlier up in the file.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tom Long Nguyen <tom.l.nguyen@intel.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/pcie/portdrv_pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 70d7ad8c6d17..85f7afcd6227 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -6,7 +6,6 @@
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
  */
 
-#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -27,9 +26,6 @@
 #define DRIVER_VERSION "v1.0"
 #define DRIVER_AUTHOR "tom.l.nguyen@intel.com"
 #define DRIVER_DESC "PCIe Port Bus Driver"
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
 
 /* If this switch is set, PCIe port native services should not be enabled. */
 bool pcie_ports_disabled;
@@ -341,7 +337,6 @@ static const struct pci_device_id port_pci_ids[] = { {
 	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
 	}, { /* end: all zeroes */ }
 };
-MODULE_DEVICE_TABLE(pci, port_pci_ids);
 
 static const struct pci_error_handlers pcie_portdrv_err_handler = {
 	.error_detected = pcie_portdrv_error_detected,
@@ -406,5 +401,4 @@ static int __init pcie_portdrv_init(void)
  out:
 	return retval;
 }
-
-module_init(pcie_portdrv_init);
+device_initcall(pcie_portdrv_init);
-- 
2.8.4

