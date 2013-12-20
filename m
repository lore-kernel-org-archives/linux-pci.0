Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:53369
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756797Ab3LTKHK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Dec 2013 05:07:10 -0500
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <rjw@rjwysocki.net>, <bhelgaas@google.com>
CC: <roy.zang@freescale.com>, <scottwood@freescale.com>,
	<galak@kernel.crashing.org>, <linux-pm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	Wang Dongsheng <dongsheng.wang@freescale.com>
Subject: [RFC] linux/pci: move pci_platform_pm_ops to linux/pci.h
Date: Fri, 20 Dec 2013 18:03:52 +0800
Message-ID: <1387533832-34554-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

make Freescale platform use pci_platform_pm_ops struct.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---

If device's not set power state, we will use this interface to put the
device's into the correct state.

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9c91ecc..48f8b1a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -33,36 +33,6 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 #endif
 int pci_probe_reset_function(struct pci_dev *dev);
 
-/**
- * struct pci_platform_pm_ops - Firmware PM callbacks
- *
- * @is_manageable: returns 'true' if given device is power manageable by the
- *                 platform firmware
- *
- * @set_state: invokes the platform firmware to set the device's power state
- *
- * @choose_state: returns PCI power state of given device preferred by the
- *                platform; to be used during system-wide transitions from a
- *                sleeping state to the working state and vice versa
- *
- * @sleep_wake: enables/disables the system wake up capability of given device
- *
- * @run_wake: enables/disables the platform to generate run-time wake-up events
- *		for given device (the device's wake-up capability has to be
- *		enabled by @sleep_wake for this feature to work)
- *
- * If given platform is generally capable of power managing PCI devices, all of
- * these callbacks are mandatory.
- */
-struct pci_platform_pm_ops {
-	bool (*is_manageable)(struct pci_dev *dev);
-	int (*set_state)(struct pci_dev *dev, pci_power_t state);
-	pci_power_t (*choose_state)(struct pci_dev *dev);
-	int (*sleep_wake)(struct pci_dev *dev, bool enable);
-	int (*run_wake)(struct pci_dev *dev, bool enable);
-};
-
-int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1084a15..20e07b8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -365,6 +365,37 @@ struct pci_dev {
 	size_t romlen; /* Length of ROM if it's not from the BAR */
 };
 
+/**
+ * struct pci_platform_pm_ops - Firmware PM callbacks
+ *
+ * @is_manageable: returns 'true' if given device is power manageable by the
+ *                 platform firmware
+ *
+ * @set_state: invokes the platform firmware to set the device's power state
+ *
+ * @choose_state: returns PCI power state of given device preferred by the
+ *                platform; to be used during system-wide transitions from a
+ *                sleeping state to the working state and vice versa
+ *
+ * @sleep_wake: enables/disables the system wake up capability of given device
+ *
+ * @run_wake: enables/disables the platform to generate run-time wake-up events
+ *		for given device (the device's wake-up capability has to be
+ *		enabled by @sleep_wake for this feature to work)
+ *
+ * If given platform is generally capable of power managing PCI devices, all of
+ * these callbacks are mandatory.
+ */
+struct pci_platform_pm_ops {
+	bool (*is_manageable)(struct pci_dev *dev);
+	int (*set_state)(struct pci_dev *dev, pci_power_t state);
+	pci_power_t (*choose_state)(struct pci_dev *dev);
+	int (*sleep_wake)(struct pci_dev *dev, bool enable);
+	int (*run_wake)(struct pci_dev *dev, bool enable);
+};
+
+int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
+
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
-- 
1.8.5


