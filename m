Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:3236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933672AbcIFWA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 18:00:26 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 1/4] pci: Add is_removed state
Date: Tue,  6 Sep 2016 16:00:16 -0600
Message-Id: <1473199219-3369-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
References: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a new state for devices that were once in the system, but
unexpectedly removed. This is so device teardown functions can observe
the device is not accessible so it may skip attempting to initialize
the hardware.

The pciehp and pcie-dpc drivers are aware of when the link is down, so
they explicitly set this flag when its handlers detect the device is gone.

The flag is also cached any time pci_device_is_present returns false. The
function checks the flag first to avoid additional config accesses to
removed devices.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_pci.c | 2 ++
 drivers/pci/pci.c                | 9 ++++++++-
 drivers/pci/pcie/pcie-dpc.c      | 1 +
 include/linux/pci.h              | 1 +
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 9e69403..299ea5e 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -109,6 +109,8 @@ int pciehp_unconfigure_device(struct slot *p_slot)
 				break;
 			}
 		}
+		if (!presence)
+			dev->is_removed = 1;
 		pci_stop_and_remove_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..010e5f6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4924,7 +4924,14 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
-	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
+	if (pdev->is_removed)
+		return false;
+
+	if (!pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0)) {
+		pdev->is_removed = 1;
+		return false;
+	}
+	return true;
 }
 EXPORT_SYMBOL_GPL(pci_device_is_present);
 
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 9811b14..2e5876c5 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -46,6 +46,7 @@ static void interrupt_event_handler(struct work_struct *work)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
+		dev->is_removed = 1;
 		pci_stop_and_remove_bus_device(dev);
 		pci_dev_put(dev);
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7256f33..865d3ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,7 @@ struct pci_dev {
 	unsigned int	multifunction:1;/* Part of multi-function device */
 	/* keep track of device state */
 	unsigned int	is_added:1;
+	unsigned int	is_removed:1;	/* device was surprise removed */
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
-- 
2.7.2

