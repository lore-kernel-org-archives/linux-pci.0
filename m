Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p3plsmtps2ded01.prod.phx3.secureserver.net ([208.109.80.58]:41514
        "EHLO p3plsmtps2ded01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbcJDEvj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Oct 2016 00:51:39 -0400
From: Long Li <longli@exchange.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: [PATCH 1/2 v3] pci-hyperv: properly handle pci bus remove
Date: Mon,  3 Oct 2016 23:42:47 -0700
Message-Id: <1475563367-16511-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Long Li <longli@microsoft.com>

hv_pci_devices_present is called in hv_pci_remove when we remove a PCI device from host (e.g. by disabling SRIOV on a device). In hv_pci_remove, the bus is already removed before the call, so we don't need to rescan the bus in the workqueue scheduled from hv_pci_devices_present. By introducing status hv_pcibus_removed, we can avoid this situation.

Signed-off-by: Long Li <longli@microsoft.com>
Tested-by: Cathy Avery <cavery@redhat.com>
Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
---
 drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index a8deeca..4a37598 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -348,6 +348,7 @@ enum hv_pcibus_state {
 	hv_pcibus_init = 0,
 	hv_pcibus_probed,
 	hv_pcibus_installed,
+	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
 
@@ -1481,13 +1482,24 @@ static void pci_devices_present_work(struct work_struct *work)
 		put_pcichild(hpdev, hv_pcidev_ref_initial);
 	}
 
-	/* Tell the core to rescan bus because there may have been changes. */
-	if (hbus->state == hv_pcibus_installed) {
+	switch (hbus->state) {
+	case hv_pcibus_installed:
+		/*
+		 * Tell the core to rescan bus
+		 * because there may have been changes.
+		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
-	} else {
+		break;
+
+	case hv_pcibus_init:
+	case hv_pcibus_probed:
 		survey_child_resources(hbus);
+		break;
+
+	default:
+		break;
 	}
 
 	up(&hbus->enum_sem);
@@ -2163,6 +2175,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+	hbus->state = hv_pcibus_init;
 
 	/*
 	 * The PCI bus "domain" is what is called "segment" in ACPI and
@@ -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 		pci_stop_root_bus(hbus->pci_bus);
 		pci_remove_root_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
+		hbus->state = hv_pcibus_removed;
 	}
 
 	ret = hv_send_resources_released(hdev);
-- 
1.8.5.6

