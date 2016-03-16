Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-Id: <d90c3d66a193e4c01b8b74532c2b98c5b5aec89a.1458126755.git.lukas@wunner.de>
In-Reply-To: <cover.1458126755.git.lukas@wunner.de>
References: <cover.1458126755.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 16 Mar 2016 15:50:35 +0100
Subject: [RFC 3/4] thunderbolt: Move pm code to separate file
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No code changes.

Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/thunderbolt/Makefile |  3 +--
 drivers/thunderbolt/nhi.c    | 33 +--------------------------------
 drivers/thunderbolt/power.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/power.h  | 14 ++++++++++++++
 4 files changed, 57 insertions(+), 34 deletions(-)
 create mode 100644 drivers/thunderbolt/power.c
 create mode 100644 drivers/thunderbolt/power.h

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index 5d1053c..03c7ba5 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,3 +1,2 @@
 obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
-thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o eeprom.o
-
+thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o eeprom.o power.o
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 36be23b..fa89160 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -7,7 +7,6 @@
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
  */
 
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/pci.h>
@@ -17,6 +16,7 @@
 
 #include "nhi.h"
 #include "nhi_regs.h"
+#include "power.h"
 #include "tb.h"
 
 #define RING_TYPE(ring) ((ring)->is_tx ? "TX ring" : "RX ring")
@@ -493,22 +493,6 @@ static irqreturn_t nhi_msi(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int nhi_suspend_noirq(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct tb *tb = pci_get_drvdata(pdev);
-	thunderbolt_suspend(tb);
-	return 0;
-}
-
-static int nhi_resume_noirq(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct tb *tb = pci_get_drvdata(pdev);
-	thunderbolt_resume(tb);
-	return 0;
-}
-
 static void nhi_shutdown(struct tb_nhi *nhi)
 {
 	int i;
@@ -615,21 +599,6 @@ static void nhi_remove(struct pci_dev *pdev)
 	nhi_shutdown(nhi);
 }
 
-/*
- * The tunneled pci bridges are siblings of us. Use resume_noirq to reenable
- * the tunnels asap. A corresponding pci quirk blocks the downstream bridges
- * resume_noirq until we are done.
- */
-static const struct dev_pm_ops nhi_pm_ops = {
-	.suspend_noirq = nhi_suspend_noirq,
-	.resume_noirq = nhi_resume_noirq,
-	.freeze_noirq = nhi_suspend_noirq, /*
-					    * we just disable hotplug, the
-					    * pci-tunnels stay alive.
-					    */
-	.restore_noirq = nhi_resume_noirq,
-};
-
 static struct pci_device_id nhi_ids[] = {
 	/*
 	 * We have to specify class, the TB bridges use the same device and
diff --git a/drivers/thunderbolt/power.c b/drivers/thunderbolt/power.c
new file mode 100644
index 0000000..1095ad0
--- /dev/null
+++ b/drivers/thunderbolt/power.c
@@ -0,0 +1,41 @@
+/*
+ * Thunderbolt Cactus Ridge driver - power management
+ *
+ * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+
+#include "tb.h"
+
+static int nhi_suspend_noirq(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tb *tb = pci_get_drvdata(pdev);
+	thunderbolt_suspend(tb);
+	return 0;
+}
+
+static int nhi_resume_noirq(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct tb *tb = pci_get_drvdata(pdev);
+	thunderbolt_resume(tb);
+	return 0;
+}
+
+/*
+ * The tunneled pci bridges are siblings of us. Use resume_noirq to reenable
+ * the tunnels asap. A corresponding pci quirk blocks the downstream bridges
+ * resume_noirq until we are done.
+ */
+const struct dev_pm_ops nhi_pm_ops = {
+	.suspend_noirq = nhi_suspend_noirq,
+	.resume_noirq  = nhi_resume_noirq,
+	.freeze_noirq  = nhi_suspend_noirq, /*
+					     * we just disable hotplug, the
+					     * pci-tunnels stay alive.
+					     */
+	.restore_noirq = nhi_resume_noirq,
+};
diff --git a/drivers/thunderbolt/power.h b/drivers/thunderbolt/power.h
new file mode 100644
index 0000000..99cb900
--- /dev/null
+++ b/drivers/thunderbolt/power.h
@@ -0,0 +1,14 @@
+/*
+ * Thunderbolt Cactus Ridge driver - power management
+ *
+ * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ */
+
+#ifndef POWER_H
+#define POWER_H
+
+#include <linux/pm_runtime.h>
+
+extern const struct dev_pm_ops nhi_pm_ops;
+
+#endif
-- 
2.7.0

