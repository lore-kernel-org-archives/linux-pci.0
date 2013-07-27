Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24655 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3G0PL3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Jul 2013 11:11:29 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v2 1/3] PCI/pciehp: Separate VGA checking out from loop
Date: Sat, 27 Jul 2013 08:11:08 -0700
Message-Id: <1374937868-24437-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Separate VGA checking out and do that at first,
if there is VGA in the chain, do even try to stop or remove any device
under that bus.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_pci.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_pci.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_pci.c
@@ -92,6 +92,22 @@ int pciehp_unconfigure_device(struct slo
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
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
 	 * which will update the bus->devices list and confuse the
@@ -101,17 +117,6 @@ int pciehp_unconfigure_device(struct slo
 	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
 					 bus_list) {
 		pci_dev_get(dev);
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
 		pci_stop_and_remove_bus_device(dev);
 		/*
 		 * Ensure that no new Requests will be generated from
