Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5274 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbaAMW0e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jan 2014 17:26:34 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, alex.williamson@redhat.com,
	bhelgaas@google.com
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/2] PCI: call pci reset callback to pci_driver on FLR
Date: Mon, 13 Jan 2014 15:26:27 -0700
Message-Id: <1389651988-27392-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
References: <1389651988-27392-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A user can issue a pci function level reset to a device using sysfs
entry /sys/bus/pci/devices/.../reset. A kernel driver handling the
pci device probably would like to know that such a reset has occured,
so this patch calls the pci_driver's slot_reset pci_error_handler.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b127fbda..1bfddc5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3584,6 +3584,12 @@ int pci_reset_function(struct pci_dev *dev)
 
 	pci_dev_restore(dev);
 
+	if (!rc) {
+		const struct pci_error_handlers *err_handler = dev->driver ?
+			dev->driver->err_handler : NULL;
+		if (err_handler && err_handler->slot_reset)
+			err_handler->slot_reset(dev);
+	}
 	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_reset_function);
-- 
1.7.10.4

