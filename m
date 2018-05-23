Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34769 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933144AbeEWRsY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2018 13:48:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id ay10-v6so13478548plb.1
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2018 10:48:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: bhelgaas@google.com, kys@microsoft.com, haiyangz@microsoft.com,
        lorenzo.pieralisi@arm.com
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH 1/3] PCI: hv: remove unused reason for refcount handler
Date: Wed, 23 May 2018 10:11:12 -0700
Message-Id: <20180523171114.5136-2-sthemmin@microsoft.com>
In-Reply-To: <20180523171114.5136-1-sthemmin@microsoft.com>
References: <20180523171114.5136-1-sthemmin@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The get/put functions were taking a reason code. This appears to be
a debug infrastructure that is no longer used.

Move the functions to start of file to eliminate need for
forward declaration. Forward declarations are discouraged on
Linux.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 70 +++++++++++++----------------------
 1 file changed, 26 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 50cdefe3f6d3..505453e23c22 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -488,17 +488,6 @@ enum hv_pcichild_state {
 	hv_pcichild_maximum
 };
 
-enum hv_pcidev_ref_reason {
-	hv_pcidev_ref_invalid = 0,
-	hv_pcidev_ref_initial,
-	hv_pcidev_ref_by_slot,
-	hv_pcidev_ref_packet,
-	hv_pcidev_ref_pnp,
-	hv_pcidev_ref_childlist,
-	hv_pcidev_irqdata,
-	hv_pcidev_ref_max
-};
-
 struct hv_pci_dev {
 	/* List protected by pci_rescan_remove_lock */
 	struct list_head list_entry;
@@ -548,10 +537,17 @@ static void hv_pci_generic_compl(void *context, struct pci_response *resp,
 
 static struct hv_pci_dev *get_pcichild_wslot(struct hv_pcibus_device *hbus,
 						u32 wslot);
-static void get_pcichild(struct hv_pci_dev *hv_pcidev,
-			 enum hv_pcidev_ref_reason reason);
-static void put_pcichild(struct hv_pci_dev *hv_pcidev,
-			 enum hv_pcidev_ref_reason reason);
+
+static void get_pcichild(struct hv_pci_dev *hpdev)
+{
+	refcount_inc(&hpdev->refs);
+}
+
+static void put_pcichild(struct hv_pci_dev *hpdev)
+{
+	if (refcount_dec_and_test(&hpdev->refs))
+		kfree(hpdev);
+}
 
 static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
 static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
@@ -762,7 +758,7 @@ static int hv_pcifront_read_config(struct pci_bus *bus, unsigned int devfn,
 
 	_hv_pcifront_read_config(hpdev, where, size, val);
 
-	put_pcichild(hpdev, hv_pcidev_ref_by_slot);
+	put_pcichild(hpdev);
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -790,7 +786,7 @@ static int hv_pcifront_write_config(struct pci_bus *bus, unsigned int devfn,
 
 	_hv_pcifront_write_config(hpdev, where, size, val);
 
-	put_pcichild(hpdev, hv_pcidev_ref_by_slot);
+	put_pcichild(hpdev);
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -856,7 +852,7 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
 	}
 
 	hv_int_desc_free(hpdev, int_desc);
-	put_pcichild(hpdev, hv_pcidev_ref_by_slot);
+	put_pcichild(hpdev);
 }
 
 static int hv_set_affinity(struct irq_data *data, const struct cpumask *dest,
@@ -1186,13 +1182,13 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	msg->address_lo = comp.int_desc.address & 0xffffffff;
 	msg->data = comp.int_desc.data;
 
-	put_pcichild(hpdev, hv_pcidev_ref_by_slot);
+	put_pcichild(hpdev);
 	return;
 
 free_int_desc:
 	kfree(int_desc);
 drop_reference:
-	put_pcichild(hpdev, hv_pcidev_ref_by_slot);
+	put_pcichild(hpdev);
 return_null_message:
 	msg->address_hi = 0;
 	msg->address_lo = 0;
@@ -1508,19 +1504,6 @@ static void q_resource_requirements(void *context, struct pci_response *resp,
 	complete(&completion->host_event);
 }
 
-static void get_pcichild(struct hv_pci_dev *hpdev,
-			    enum hv_pcidev_ref_reason reason)
-{
-	refcount_inc(&hpdev->refs);
-}
-
-static void put_pcichild(struct hv_pci_dev *hpdev,
-			    enum hv_pcidev_ref_reason reason)
-{
-	if (refcount_dec_and_test(&hpdev->refs))
-		kfree(hpdev);
-}
-
 /**
  * new_pcichild_device() - Create a new child device
  * @hbus:	The internal struct tracking this root PCI bus.
@@ -1572,7 +1555,7 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 
 	hpdev->desc = *desc;
 	refcount_set(&hpdev->refs, 1);
-	get_pcichild(hpdev, hv_pcidev_ref_childlist);
+	get_pcichild(hpdev);
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 
 	/*
@@ -1618,7 +1601,7 @@ static struct hv_pci_dev *get_pcichild_wslot(struct hv_pcibus_device *hbus,
 	list_for_each_entry(iter, &hbus->children, list_entry) {
 		if (iter->desc.win_slot.slot == wslot) {
 			hpdev = iter;
-			get_pcichild(hpdev, hv_pcidev_ref_by_slot);
+			get_pcichild(hpdev);
 			break;
 		}
 	}
@@ -1735,7 +1718,7 @@ static void pci_devices_present_work(struct work_struct *work)
 					     list_entry);
 			if (hpdev->reported_missing) {
 				found = true;
-				put_pcichild(hpdev, hv_pcidev_ref_childlist);
+				put_pcichild(hpdev);
 				list_move_tail(&hpdev->list_entry, &removed);
 				break;
 			}
@@ -1748,7 +1731,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		hpdev = list_first_entry(&removed, struct hv_pci_dev,
 					 list_entry);
 		list_del(&hpdev->list_entry);
-		put_pcichild(hpdev, hv_pcidev_ref_initial);
+		put_pcichild(hpdev);
 	}
 
 	switch (hbus->state) {
@@ -1883,8 +1866,8 @@ static void hv_eject_device_work(struct work_struct *work)
 			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
 			 VM_PKT_DATA_INBAND, 0);
 
-	put_pcichild(hpdev, hv_pcidev_ref_childlist);
-	put_pcichild(hpdev, hv_pcidev_ref_pnp);
+	put_pcichild(hpdev);
+	put_pcichild(hpdev);
 	put_hvpcibus(hpdev->hbus);
 }
 
@@ -1899,7 +1882,7 @@ static void hv_eject_device_work(struct work_struct *work)
 static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 {
 	hpdev->state = hv_pcichild_ejecting;
-	get_pcichild(hpdev, hv_pcidev_ref_pnp);
+	get_pcichild(hpdev);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	get_hvpcibus(hpdev->hbus);
 	queue_work(hpdev->hbus->wq, &hpdev->wrk);
@@ -1999,8 +1982,7 @@ static void hv_pci_onchannelcallback(void *context)
 						      dev_message->wslot.slot);
 				if (hpdev) {
 					hv_pci_eject_device(hpdev);
-					put_pcichild(hpdev,
-							hv_pcidev_ref_by_slot);
+					put_pcichild(hpdev);
 				}
 				break;
 
@@ -2398,7 +2380,7 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
 				PCI_RESOURCES_ASSIGNED2;
 			res_assigned2->wslot.slot = hpdev->desc.win_slot.slot;
 		}
-		put_pcichild(hpdev, hv_pcidev_ref_by_slot);
+		put_pcichild(hpdev);
 
 		ret = vmbus_sendpacket(hdev->channel, &pkt->message,
 				size_res, (unsigned long)pkt,
@@ -2446,7 +2428,7 @@ static int hv_send_resources_released(struct hv_device *hdev)
 		pkt.message_type.type = PCI_RESOURCES_RELEASED;
 		pkt.wslot.slot = hpdev->desc.win_slot.slot;
 
-		put_pcichild(hpdev, hv_pcidev_ref_by_slot);
+		put_pcichild(hpdev);
 
 		ret = vmbus_sendpacket(hdev->channel, &pkt, sizeof(pkt), 0,
 				       VM_PKT_DATA_INBAND, 0);
-- 
2.17.0
