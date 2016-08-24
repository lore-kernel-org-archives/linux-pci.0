Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <kristen.c.accardi@intel.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH 9/9] PCI: hotplug: make PCIe core code explicitly non-modular
Date: Wed, 24 Aug 2016 16:57:52 -0400
Message-ID: <20160824205752.12024-10-paul.gortmaker@windriver.com>
In-Reply-To: <20160824205752.12024-1-paul.gortmaker@windriver.com>
References: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Makefile fragments currently controlling compilation of this code are:

obj-$(CONFIG_HOTPLUG_PCI_PCIE)          += pciehp.o
 [...]
pciehp-objs                             := pciehp_core.o   \

The Kconfig currently controlling compilation of this code is:

drivers/pci/pcie/Kconfig:config HOTPLUG_PCI_PCIE
drivers/pci/pcie/Kconfig:       bool "PCI Express Hotplug driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.  However
one could argue that we should use subsys_initcall() here, but for
now we stick with runtime equivalence.

We delete module.h but we keep the moduleparam.h include, since we are
keeping the module_param() that the file has as-is for now.

We also delete the MODULE_LICENSE tag etc since all that information
is still contained higher up in the file via the DEFINE lines which
now serve as documentation only.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: kristen.c.accardi@intel.com
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/hotplug/pciehp_core.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ac531e674a05..fb0f86335158 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -27,7 +27,6 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -47,10 +46,10 @@ static bool pciehp_force;
 #define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
 #define DRIVER_DESC	"PCI Express Hot Plug Controller Driver"
 
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-
+/*
+ * not really modular, but the easiest way to keep compat with existing
+ * bootargs behaviour is to continue using module_param here.
+ */
 module_param(pciehp_debug, bool, 0644);
 module_param(pciehp_poll_mode, bool, 0644);
 module_param(pciehp_poll_time, int, 0644);
@@ -337,13 +336,4 @@ static int __init pcied_init(void)
 
 	return retval;
 }
-
-static void __exit pcied_cleanup(void)
-{
-	dbg("unload_pciehpd()\n");
-	pcie_port_service_unregister(&hpdriver_portdrv);
-	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
-}
-
-module_init(pcied_init);
-module_exit(pcied_cleanup);
+device_initcall(pcied_init);
-- 
2.8.4
