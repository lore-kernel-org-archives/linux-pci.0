Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=dBQP=LC=wunner.de=lukas@kernel.org>
Message-Id: <193526253c60c453f771824407c2fe05794e1060.1534686485.git.lukas@wunner.de>
In-Reply-To: <cover.1534686484.git.lukas@wunner.de>
References: <cover.1534686484.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 19 Aug 2018 16:29:00 +0200
Subject: [PATCH 2/9] PCI: pciehp: Drop unnecessary includes
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

Drop the following includes from pciehp source files which no longer use
any of the included symbols:

* <linux/sched/signal.h> in pciehp.h
  <linux/signal.h> in pciehp_hpc.c
  Added by commit de25968cc87c ("fix more missing includes") to
  accommodate for a call to signal_pending().
  The call was removed by commit 262303fe329a ("pciehp: fix wait command
  completion").

* <linux/interrupt.h> in pciehp_core.c
  Added by historic commit f308a2dfbe63 ("PCI: add PCI Express Port Bus
  Driver subsystem") to accommodate for a call to free_irq():
  https://git.kernel.org/tglx/history/c/f308a2dfbe63
  The call was removed by commit 407f452b05f9 ("pciehp: remove
  unnecessary free_irq").

* <linux/time.h> in pciehp_core.c and pciehp_hpc.c
  Added by commit 34d03419f03b ("PCIEHP: Add Electro Mechanical
  Interlock (EMI) support to the PCIE hotplug driver."),
  which was reverted by commit bd3d99c17039 ("PCI: Remove untested
  Electromechanical Interlock (EMI) support in pciehp.").

* <linux/module.h> in pciehp_ctrl.c, pciehp_hpc.c and pciehp_pci.c
  Added by historic commit c16b4b14d980 ("PCI Hotplug: Add SHPC and PCI
  Express hot-plug drivers"):
  https://git.kernel.org/tglx/history/c/c16b4b14d980
  Module-related symbols were neither used back then in those files,
  nor are they used today.

* <linux/slab.h> in pciehp_ctrl.c
  Added by commit 5a0e3ad6af86 ("include cleanup: Update gfp.h and
  slab.h includes to prepare for breaking implicit slab.h inclusion from
  percpu.h") to accommodate for calls to kmalloc().
  The calls were removed by commit 0e94916e6091 ("PCI: pciehp: Handle
  events synchronously").

* "../pci.h" in pciehp_ctrl.c
  Added by historic commit 67f4660b72f2 ("PCI: ASPM patch for") to
  accommodate for usage of the global variable pcie_mch_quirk:
  https://git.kernel.org/tglx/history/c/67f4660b72f2
  The global variable was removed by commit 0ba379ec0fb1 ("PCI: Simplify
  hotplug mch quirk").

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      | 1 -
 drivers/pci/hotplug/pciehp_core.c | 2 --
 drivers/pci/hotplug/pciehp_ctrl.c | 3 ---
 drivers/pci/hotplug/pciehp_hpc.c  | 3 ---
 drivers/pci/hotplug/pciehp_pci.c  | 1 -
 5 files changed, 10 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 39c9c8815a35..337f2a5a303f 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -19,7 +19,6 @@
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/delay.h>
-#include <linux/sched/signal.h>		/* signal_pending() */
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/workqueue.h>
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ec48c9433ae5..e77e17106f52 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -23,8 +23,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include "pciehp.h"
-#include <linux/interrupt.h>
-#include <linux/time.h>
 
 #include "../pci.h"
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index c283253d2cd7..ffaf0976e6af 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -13,13 +13,10 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
-#include "../pci.h"
 #include "pciehp.h"
 
 /* The following routines constitute the bulk of the
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7136e3430925..16a56aa20a6b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -13,15 +13,12 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/types.h>
-#include <linux/signal.h>
 #include <linux/jiffies.h>
 #include <linux/kthread.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
-#include <linux/time.h>
 #include <linux/slab.h>
 
 #include "../pci.h"
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 0322bd4f0a7a..8da87931bd45 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -13,7 +13,6 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-- 
2.18.0
