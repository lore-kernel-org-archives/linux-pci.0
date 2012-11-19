Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41663 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab2KSSiG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2012 13:38:06 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 015/493] PCI: move pci_uevent into pci-driver.c
Date: Mon, 19 Nov 2012 13:19:24 -0500
Message-Id: <1353349642-3677-15-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With the demise of CONFIG_HOTPLUG as an option, the pci_uevent
function located in hotplug.c will now always be used and doesn't need
special treatment in the Makefile.  Move pci_uevent into pci-driver.c
and remove hotplug.c

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-pci@vger.kernel.org 
---
 drivers/pci/Makefile     |  2 --
 drivers/pci/hotplug.c    | 37 -------------------------------------
 drivers/pci/pci-driver.c | 33 +++++++++++++++++++++++++++++++++
 drivers/pci/pci.h        |  1 -
 4 files changed, 33 insertions(+), 40 deletions(-)
 delete mode 100644 drivers/pci/hotplug.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 8d688b2..36f119d 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -15,8 +15,6 @@ obj-$(CONFIG_PCIEPORTBUS) += pcie/
 
 obj-$(CONFIG_PCI_IOAPIC) += ioapic.o
 
-obj-$(CONFIG_HOTPLUG) += hotplug.o
-
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 ifdef CONFIG_HOTPLUG_PCI
diff --git a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
deleted file mode 100644
index 2b5352a..0000000
--- a/drivers/pci/hotplug.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/module.h>
-#include "pci.h"
-
-int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct pci_dev *pdev;
-
-	if (!dev)
-		return -ENODEV;
-
-	pdev = to_pci_dev(dev);
-	if (!pdev)
-		return -ENODEV;
-
-	if (add_uevent_var(env, "PCI_CLASS=%04X", pdev->class))
-		return -ENOMEM;
-
-	if (add_uevent_var(env, "PCI_ID=%04X:%04X", pdev->vendor, pdev->device))
-		return -ENOMEM;
-
-	if (add_uevent_var(env, "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor,
-			   pdev->subsystem_device))
-		return -ENOMEM;
-
-	if (add_uevent_var(env, "PCI_SLOT_NAME=%s", pci_name(pdev)))
-		return -ENOMEM;
-
-	if (add_uevent_var(env, "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x",
-			   pdev->vendor, pdev->device,
-			   pdev->subsystem_vendor, pdev->subsystem_device,
-			   (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
-			   (u8)(pdev->class)))
-		return -ENOMEM;
-	return 0;
-}
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 498e66a..f7b96cb 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1215,6 +1215,39 @@ void pci_dev_put(struct pci_dev *dev)
 		put_device(&dev->dev);
 }
 
+static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct pci_dev *pdev;
+
+	if (!dev)
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+	if (!pdev)
+		return -ENODEV;
+
+	if (add_uevent_var(env, "PCI_CLASS=%04X", pdev->class))
+		return -ENOMEM;
+
+	if (add_uevent_var(env, "PCI_ID=%04X:%04X", pdev->vendor, pdev->device))
+		return -ENOMEM;
+
+	if (add_uevent_var(env, "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor,
+			   pdev->subsystem_device))
+		return -ENOMEM;
+
+	if (add_uevent_var(env, "PCI_SLOT_NAME=%s", pci_name(pdev)))
+		return -ENOMEM;
+
+	if (add_uevent_var(env, "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x",
+			   pdev->vendor, pdev->device,
+			   pdev->subsystem_vendor, pdev->subsystem_device,
+			   (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),
+			   (u8)(pdev->class)))
+		return -ENOMEM;
+	return 0;
+}
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ae06da4..e851829 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -8,7 +8,6 @@
 
 /* Functions internal to the PCI core code */
 
-extern int pci_uevent(struct device *dev, struct kobj_uevent_env *env);
 extern int pci_create_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 #if !defined(CONFIG_DMI) && !defined(CONFIG_ACPI)
-- 
1.8.0

