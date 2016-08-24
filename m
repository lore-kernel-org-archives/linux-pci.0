Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Long Nguyen <tom.l.nguyen@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 3/9] PCI: PCIe aerdrv: make it explicitly non-modular
Date: Wed, 24 Aug 2016 16:57:46 -0400
Message-ID: <20160824205752.12024-4-paul.gortmaker@windriver.com>
In-Reply-To: <20160824205752.12024-1-paul.gortmaker@windriver.com>
References: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Makefile fragments currently controlling compilation of this code are:

obj-$(CONFIG_PCIEAER) += aerdriver.o
aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o

The Kconfig currently controlling compilation of this code is:

drivers/pci/pcie/aer/Kconfig:config PCIEAER
drivers/pci/pcie/aer/Kconfig:   bool "Root Port Advanced Error Reporting support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't replace module.h with init.h since the file already has that.

We also delete the MODULE_LICENSE tag etc since all that information
is already contained earlier in the file.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tom Long Nguyen <tom.l.nguyen@intel.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/pcie/aer/aerdrv.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 48d21e0edd56..49805a48b81c 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -15,7 +15,6 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
 #include <linux/sched.h>
@@ -37,9 +36,6 @@
 #define DRIVER_VERSION "v1.0"
 #define DRIVER_AUTHOR "tom.l.nguyen@intel.com"
 #define DRIVER_DESC "Root Port Advanced Error Reporting Driver"
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
 
 static int aer_probe(struct pcie_device *dev);
 static void aer_remove(struct pcie_device *dev);
@@ -417,16 +413,4 @@ static int __init aer_service_init(void)
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
-
-/**
- * aer_service_exit - unregister AER root service driver
- *
- * Invoked when AER root service driver is unloaded.
- */
-static void __exit aer_service_exit(void)
-{
-	pcie_port_service_unregister(&aerdriver);
-}
-
-module_init(aer_service_init);
-module_exit(aer_service_exit);
+device_initcall(aer_service_init);
-- 
2.8.4
