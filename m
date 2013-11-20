Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5639 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab3KTR1T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Nov 2013 12:27:19 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCH] PCI: add function reset callback to pci_driver
Date: Wed, 20 Nov 2013 10:26:57 -0700
Message-Id: <1384968417-31856-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A user can issue a pci function level reset to a device using sysfs
entry /sys/bus/pci/devices/.../reset. A kernel driver handling the
pci device probably would like to know that such a reset has occured,
so this patch adds a callback in to pci_driver's pci_error_handler.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
Assuming this is a good idea, is this the right place to invoke the
reset callback, or should it be up the call stack closer to the sysfs
reset entry point? Or somewhere else entirely?

 drivers/pci/pci.c   |    6 ++++++
 include/linux/pci.h |    3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b127fbda..5ee6fc0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3435,6 +3435,12 @@ static int __pci_dev_reset(struct pci_dev *dev, int probe)
 
 	rc = pci_parent_bus_reset(dev, probe);
 done:
+	if (rc != -ENOTTY && !probe) {
+		struct pci_error_handlers *err_handler =
+				dev->driver ? dev->driver->err_handler : NULL;
+		if (err_handler && err_handler->function_reset)
+			err_handler->function_reset(dev);
+	}
 	return rc;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835ec7b..d1f100e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -605,6 +605,9 @@ struct pci_error_handlers {
 	/* PCI slot has been reset */
 	pci_ers_result_t (*slot_reset)(struct pci_dev *dev);
 
+	/* PCI function has been reset */
+	pci_ers_result_t (*function_reset)(struct pci_dev *dev);
+
 	/* Device driver may resume normal operations */
 	void (*resume)(struct pci_dev *dev);
 };
-- 
1.7.10.4

