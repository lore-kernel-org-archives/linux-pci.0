Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26775 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3GSTOd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2013 15:14:33 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH] PCI: Separate stop and remove devices in pciehp
Date: Fri, 19 Jul 2013 12:14:17 -0700
Message-Id: <1374261258-23036-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
(PCI: Simplify IOV implementation and fix reference count races)
VF need to be removed via virtfn_remove to make sure ref to PF
is put back.

So we can not call stop_and_remove for VF before PF, that will
make VF get removed directly before PF's driver try to use
virtfn_remove to do it.

Solution is separating stop and remove in two iterations.

In first iteration, we stop VF driver at first with iterating devices
reversely, and later during stop PF driver, disable_sriov will use
virtfn_remove to remove VFs.

Also some driver (like mlx4_core) need VF's driver get stopped before PF.

To make it simple, separate VGA checking out and do that at first,
if there is VGA in the chain, do even try to stop or remove any device
under that bus.

Need this one for v3.11.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>

---
 drivers/pci/hotplug/pciehp_pci.c |   46 ++++++++++++++++++++++++++-------------
 drivers/pci/remove.c             |    6 +++--
 include/linux/pci.h              |    2 +
 3 files changed, 37 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_pci.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_pci.c
@@ -92,26 +92,37 @@ int pciehp_unconfigure_device(struct slo
 	if (ret)
 		presence = 0;
 
+	/* check if VGA is around */
+	if (presence) {
+		list_for_each_entry(dev, &parent->devices, bus_list) {
+			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+				pci_read_config_byte(dev, PCI_BRIDGE_CONTROL,
+							&bctl);
+				if (bctl & PCI_BRIDGE_CTL_VGA) {
+					ctrl_err(ctrl,
+						 "Cannot remove display device %s\n",
+						 pci_name(dev));
+					return -EINVAL;
+				}
+			}
+		}
+	}
+
 	/*
-	 * Need to iterate device reversely, as during
+	 * Now VF need to be removed via virtfn_remove to make
+	 * sure ref to PF is put back. Some driver (mlx4_core) need
+	 * VF's driver get stopped before PF.
+	 * So we need to stop VF driver at first, that means
+	 * loop reversely, and later during stop PF driver,
+	 * disable_sriov will use virtfn_remove to remove VFs.
+	 * Also we can not loop without reverse, as during
 	 * stop PF driver, VF will be removed, the list_for_each
 	 * could point to removed VF with temp.
 	 */
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
-					 bus_list) {
-		pci_dev_get(dev);
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE && presence) {
-			pci_read_config_byte(dev, PCI_BRIDGE_CONTROL, &bctl);
-			if (bctl & PCI_BRIDGE_CTL_VGA) {
-				ctrl_err(ctrl,
-					 "Cannot remove display device %s\n",
-					 pci_name(dev));
-				pci_dev_put(dev);
-				rc = -EINVAL;
-				break;
-			}
-		}
-		pci_stop_and_remove_bus_device(dev);
+						 bus_list) {
+		pci_stop_bus_device(dev);
+
 		/*
 		 * Ensure that no new Requests will be generated from
 		 * the device.
@@ -122,6 +133,11 @@ int pciehp_unconfigure_device(struct slo
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
@@ -75,8 +75,9 @@ static void pci_stop_bus_device(struct p
 
 	pci_stop_dev(dev);
 }
+EXPORT_SYMBOL(pci_stop_bus_device);
 
-static void pci_remove_bus_device(struct pci_dev *dev)
+void pci_remove_bus_device(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->subordinate;
 	struct pci_dev *child, *tmp;
@@ -92,6 +93,7 @@ static void pci_remove_bus_device(struct
 
 	pci_destroy_dev(dev);
 }
+EXPORT_SYMBOL(pci_remove_bus_device);
 
 /**
  * pci_stop_and_remove_bus_device - remove a PCI device and any children
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -754,6 +754,8 @@ u8 pci_common_swizzle(struct pci_dev *de
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
 void pci_remove_bus(struct pci_bus *b);
+void pci_stop_bus_device(struct pci_dev *dev);
+void pci_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
