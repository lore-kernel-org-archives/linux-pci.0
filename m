Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:21422 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751234AbeFKW00 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jun 2018 18:26:26 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH] PCI/AER: Prevent runtime power management during recovery
Date: Mon, 11 Jun 2018 16:29:18 -0600
Message-Id: <20180611222918.1708-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A bridge that supports D3 but not hotplug will be subject to runtime
power management placing it in a non-operation power state if it doesn't
have any devices attached. This patch will prevent this power management
during error recovery so that the rescan at the end may be successful.

Cc: Oza Pawandeep <poza@codeaurora.org>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/err.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f7ce0cb0b0b7..247b6ce14f0d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/aer.h>
+#include <linux/pm_runtime.h>
 #include "portdrv.h"
 #include "../pci.h"
 
@@ -294,6 +295,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 		udev = dev->bus->self;
 
 	parent = udev->subordinate;
+	pm_runtime_forbid(&udev->dev);
 	pci_lock_rescan_remove();
 	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
 					 bus_list) {
@@ -329,6 +331,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
 	}
 
 	pci_unlock_rescan_remove();
+	pm_runtime_allow(&udev->dev);
 }
 
 /**
-- 
2.14.3
