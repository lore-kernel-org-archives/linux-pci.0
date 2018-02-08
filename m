Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:40657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeBHMUt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Feb 2018 07:20:49 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
        torvalds@linux-foundation.org, ruscur@russell.cc,
        bryantly@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com
Subject: [PATCH] PCI/AER: Move pci_uevent_ers() out of pci.h
Date: Thu,  8 Feb 2018 23:20:35 +1100
Message-Id: <20180208122035.9305-1-mpe@ellerman.id.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no reason pci_uevent_ers() needs to be inline in pci.h, so
move it out to a C file.

Given it's used by AER the obvious location would be somewhere in
drivers/pci/pcie/aer, but because it's also used by powerpc EEH code
unfortunately that doesn't work in the case where EEH is enabled but
PCIEPORTBUS is not.

So for now put it in pci-driver.c, next to pci_uevent(), with an
appropriate #ifdef so it's not built if AER and EEH are both disabled.

While we're moving it also fix up the kernel doc comment for @pdev to
be accurate.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/pci/pci-driver.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pci.h      | 38 +++-----------------------------------
 2 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3bed6beda051..f21e8b1bef80 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1517,6 +1517,42 @@ static int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
+/**
+ * pci_uevent_ers - emit a uevent during recovery path of pci device
+ * @pdev: pci device undergoing error recovery
+ * @err_type: type of error event
+ */
+void pci_uevent_ers(struct pci_dev *pdev, enum pci_ers_result err_type)
+{
+	int idx = 0;
+	char *envp[3];
+
+	switch (err_type) {
+	case PCI_ERS_RESULT_NONE:
+	case PCI_ERS_RESULT_CAN_RECOVER:
+		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
+		envp[idx++] = "DEVICE_ONLINE=0";
+		break;
+	case PCI_ERS_RESULT_RECOVERED:
+		envp[idx++] = "ERROR_EVENT=SUCCESSFUL_RECOVERY";
+		envp[idx++] = "DEVICE_ONLINE=1";
+		break;
+	case PCI_ERS_RESULT_DISCONNECT:
+		envp[idx++] = "ERROR_EVENT=FAILED_RECOVERY";
+		envp[idx++] = "DEVICE_ONLINE=0";
+		break;
+	default:
+		break;
+	}
+
+	if (idx > 0) {
+		envp[idx++] = NULL;
+		kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
+	}
+}
+#endif
+
 static int pci_bus_num_vf(struct device *dev)
 {
 	return pci_num_vf(to_pci_dev(dev));
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..19c1dbcff0c6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2280,41 +2280,9 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 	return false;
 }
 
-/**
- * pci_uevent_ers - emit a uevent during recovery path of pci device
- * @pdev: pci device to check
- * @err_type: type of error event
- *
- */
-static inline void pci_uevent_ers(struct pci_dev *pdev,
-				  enum  pci_ers_result err_type)
-{
-	int idx = 0;
-	char *envp[3];
-
-	switch (err_type) {
-	case PCI_ERS_RESULT_NONE:
-	case PCI_ERS_RESULT_CAN_RECOVER:
-		envp[idx++] = "ERROR_EVENT=BEGIN_RECOVERY";
-		envp[idx++] = "DEVICE_ONLINE=0";
-		break;
-	case PCI_ERS_RESULT_RECOVERED:
-		envp[idx++] = "ERROR_EVENT=SUCCESSFUL_RECOVERY";
-		envp[idx++] = "DEVICE_ONLINE=1";
-		break;
-	case PCI_ERS_RESULT_DISCONNECT:
-		envp[idx++] = "ERROR_EVENT=FAILED_RECOVERY";
-		envp[idx++] = "DEVICE_ONLINE=0";
-		break;
-	default:
-		break;
-	}
-
-	if (idx > 0) {
-		envp[idx++] = NULL;
-		kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, envp);
-	}
-}
+#if defined(CONFIG_PCIEAER) || defined(CONFIG_EEH)
+void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
+#endif
 
 /* Provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
-- 
2.14.1
