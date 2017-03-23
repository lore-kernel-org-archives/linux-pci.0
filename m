Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:52334
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751159AbdCWV7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2017 17:59:36 -0400
From: Long Li <longli@exchange.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 2/2 v5] pci-hyperv: lock pci bus on device eject
Date: Thu, 23 Mar 2017 14:58:32 -0700
Message-Id: <1490306312-6417-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Long Li <longli@microsoft.com>

A PCI_EJECT message can arrive at the same time we are calling
pci_scan_child_bus in the workqueue for the previous PCI_BUS_RELATIONS
message or in create_root_hv_pci_bus(), in this case we could potentially
modify the bus from multiple places.

Properly lock the bus access.

Thanks Dexuan Cui <decui@microsoft.com> for pointing out the race condition
in create_root_hv_pci_bus().

Signed-off-by: Long Li <longli@microsoft.com>
Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 39fafda..a1b3c19 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1209,9 +1209,11 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 	hbus->pci_bus->msi = &hbus->msi_chip;
 	hbus->pci_bus->msi->dev = &hbus->hdev->device;
 
+	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
 	pci_bus_add_devices(hbus->pci_bus);
+	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
 	return 0;
 }
@@ -1612,8 +1614,10 @@ static void hv_eject_device_work(struct work_struct *work)
 	pdev = pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
 					   wslot);
 	if (pdev) {
+		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
+		pci_unlock_rescan_remove();
 	}
 
 	spin_lock_irqsave(&hpdev->hbus->device_list_lock, flags);
-- 
2.7.4
