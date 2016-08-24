Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:36402 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933064AbcHXU60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Aug 2016 16:58:26 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Scott Murray <scott@spiteful.org>,
        <kristen.c.accardi@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 8/9] PCI: hotplug_core: make it explicitly non-modular
Date: Wed, 24 Aug 2016 16:57:51 -0400
Message-ID: <20160824205752.12024-9-paul.gortmaker@windriver.com>
In-Reply-To: <20160824205752.12024-1-paul.gortmaker@windriver.com>
References: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Makefile bits currently controlling compilation of this code are:

obj-$(CONFIG_HOTPLUG_PCI)           += pci_hotplug.o
  [...]
pci_hotplug-objs                    := pci_hotplug_core.o

and the Kconfig is:

drivers/pci/hotplug/Kconfig:menuconfig HOTPLUG_PCI
drivers/pci/hotplug/Kconfig:    bool "Support for PCI Hotplug"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

This makes an exit function in cpci_hotplug_core.c orphaned, so we
remove it here at the same time.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.  However
one could argue that we should use subsys_initcall() here, but for
now we stick with runtime equivalence.

We would delete module.h and just keep the moduleparam.h include (since
the file does use module_param), but there is a try_module_get and
module_put pairing that prevents us from doing that.

We also delete the MODULE_LICENSE tag etc since all that information
is already contained higher up in the file.

Cc: Scott Murray <scott@spiteful.org>
Cc: kristen.c.accardi@intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/hotplug/cpci_hotplug.h      |  2 --
 drivers/pci/hotplug/cpci_hotplug_core.c | 10 ----------
 drivers/pci/hotplug/pci_hotplug_core.c  | 18 ++++++------------
 3 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 555bcde3b196..60e66e027ebc 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -101,10 +101,8 @@ int cpci_unconfigure_slot(struct slot *slot);
 
 #ifdef CONFIG_HOTPLUG_PCI_CPCI
 int cpci_hotplug_init(int debug);
-void cpci_hotplug_exit(void);
 #else
 static inline int cpci_hotplug_init(int debug) { return 0; }
-static inline void cpci_hotplug_exit(void) { }
 #endif
 
 #endif	/* _CPCI_HOTPLUG_H */
diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index 7d3866c47312..7ec8a8f72c69 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -719,13 +719,3 @@ cpci_hotplug_init(int debug)
 	cpci_debug = debug;
 	return 0;
 }
-
-void __exit
-cpci_hotplug_exit(void)
-{
-	/*
-	 * Clean everything up.
-	 */
-	cpci_hp_stop();
-	cpci_hp_unregister_controller(controller);
-}
diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 9acd1997c6fe..fea0b8b33589 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -25,7 +25,7 @@
  *
  */
 
-#include <linux/module.h>
+#include <linux/module.h>	/* try_module_get & module_put */
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -537,17 +537,11 @@ static int __init pci_hotplug_init(void)
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	return result;
 }
+device_initcall(pci_hotplug_init);
 
-static void __exit pci_hotplug_exit(void)
-{
-	cpci_hotplug_exit();
-}
-
-module_init(pci_hotplug_init);
-module_exit(pci_hotplug_exit);
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
+/*
+ * not really modular, but the easiest way to keep compat with existing
+ * bootargs behaviour is to continue using module_param here.
+ */
 module_param(debug, bool, 0644);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-- 
2.8.4

