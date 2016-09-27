Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932573AbcI0UMp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Sep 2016 16:12:45 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Lukas Wunner <lukas@wunner.de>,
        Wei Zhang <wzhang@fb.com>, Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 2/5] pci: Add is_removed state
Date: Tue, 27 Sep 2016 16:23:32 -0400
Message-Id: <1475007815-28354-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
References: <1475007815-28354-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds a new state for devices that were once in the system, but
unexpectedly removed. This is so device tear down functions can observe
the device is not accessible so it may skip attempting to initialize
the hardware.

The pciehp and pcie-dpc drivers are aware of when the link is down,
so these explicitly set this flag when its handlers detect the device
is gone.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_pci.c | 2 ++
 drivers/pci/pcie/pcie-dpc.c      | 1 +
 include/linux/pci.h              | 1 +
 3 files changed, 4 insertions(+)

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
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 250f878..756eae4 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -44,6 +44,7 @@ static void interrupt_event_handler(struct work_struct *work)
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
+		dev->is_removed = 1;
 		pci_stop_and_remove_bus_device(dev);
 		pci_dev_put(dev);
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c81fbf7..36b759c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -337,6 +337,7 @@ struct pci_dev {
 	unsigned int	multifunction:1;/* Part of multi-function device */
 	/* keep track of device state */
 	unsigned int	is_added:1;
+	unsigned int	is_removed:1;	/* device was surprise removed */
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
-- 
2.7.2

