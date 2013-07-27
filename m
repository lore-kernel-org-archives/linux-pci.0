Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24665 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3G0PLc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Jul 2013 11:11:32 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
Date: Sat, 27 Jul 2013 08:11:06 -0700
Message-Id: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
(PCI: Simplify IOV implementation and fix reference count races)
broke the pcie native hotplug with SRIOV enabled: PF is not freed
during hot-remove, and later hot-add do not work as old pci_dev
is still around, and can not create new pci_dev.

That commit need VFs to be removed via pci_disable_sriov/virtfn_remove
to make sure ref to PF is put back.

So we can not call stop_and_remove for VF before PF, that will
make VF get removed directly before PF's driver try to use
pci_disable_sriov/virtfn_remove to do it.

Solution is separating stop and remove in two iterations.

In first iteration, we stop VF driver at first with iterating devices
reversely, and later during stop PF driver, disable_sriov will use
virtfn_remove to remove VFs.

Also some driver (like mlx4_core) need VF's driver get stopped before PF's.

Need this one for v3.11.

-v2: separate VGA checking to another patch according to Bjorn.
     and after patches that make pciehp to be built-in

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>

---
 drivers/pci/hotplug/pciehp_pci.c |   15 +++++++++++++--
 drivers/pci/pci.h                |    3 +++
 drivers/pci/remove.c             |    4 ++--
 3 files changed, 18 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_pci.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_pci.c
@@ -109,6 +109,13 @@ int pciehp_unconfigure_device(struct slo
 	}
 
 	/*
+	 * Now VF need to be removed via virtfn_remove to make
+	 * sure ref to PF is put back. Some driver (mlx4_core) need
+	 * VF's driver get stopped before PF.
+	 * So we need to stop VF driver at first, that means
+	 * loop reversely, and later during stop PF driver,
+	 * disable_sriov will use virtfn_remove to remove VFs.
+	 *
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
 	 * which will update the bus->devices list and confuse the
 	 * iterator.  Therefore, iterate in reverse so we remove the VFs
@@ -116,8 +123,7 @@ int pciehp_unconfigure_device(struct slo
 	 */
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
-		pci_dev_get(dev);
-		pci_stop_and_remove_bus_device(dev);
+		pci_stop_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
 		 * the device.
@@ -128,6 +134,11 @@ int pciehp_unconfigure_device(struct slo
 			command |= PCI_COMMAND_INTX_DISABLE;
 			pci_write_config_word(dev, PCI_COMMAND, command);
 		}
+	}
+
+	list_for_each_entry_safe(dev, temp, &parent->devices, bus_list) {
+		pci_dev_get(dev);
+		pci_remove_bus_device(dev);
 		pci_dev_put(dev);
 	}
 
Index: linux-2.6/drivers/pci/remove.c
===================================================================
--- linux-2.6.orig/drivers/pci/remove.c
+++ linux-2.6/drivers/pci/remove.c
@@ -56,7 +56,7 @@ void pci_remove_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_remove_bus);
 
-static void pci_stop_bus_device(struct pci_dev *dev)
+void pci_stop_bus_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->subordinate;
 	struct pci_dev *child, *tmp;
@@ -76,7 +76,7 @@ static void pci_stop_bus_device(struct p
 	pci_stop_dev(dev);
 }
 
-static void pci_remove_bus_device(struct pci_dev *dev)
+void pci_remove_bus_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->subordinate;
 	struct pci_dev *child, *tmp;
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -317,4 +317,7 @@ static inline int pci_dev_specific_reset
 }
 #endif
 
+void pci_stop_bus_device(struct pci_dev *dev);
+void pci_remove_bus_device(struct pci_dev *dev);
+
 #endif /* DRIVERS_PCI_H */
