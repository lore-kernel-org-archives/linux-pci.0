Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p3plsmtps2ded01.prod.phx3.secureserver.net ([208.109.80.58]:34340
        "EHLO p3plsmtps2ded01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765900AbcIOAUS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 20:20:18 -0400
From: Long Li <longli@exchange.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: [PATCH 2/2 v2] pci-hyperv: lock pci bus on device eject
Date: Wed, 14 Sep 2016 19:10:02 -0700
Message-Id: <1473905402-2375-2-git-send-email-longli@exchange.microsoft.com>
In-Reply-To: <1473905402-2375-1-git-send-email-longli@exchange.microsoft.com>
References: <1473905402-2375-1-git-send-email-longli@exchange.microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Long Li <longli@microsoft.com>

A PCI_EJECT message can arrive at the same time we are calling pci_scan_child_bus in the workqueue for the previous PCI_BUS_RELATIONS message or in create_root_hv_pci_bus(), in this case we could potentailly modify the bus from multiple places. Properly lock the bus access.

Thanks Dexuan Cui <decui@microsoft.com> for pointing out the race condition in create_root_hv_pci_bus().

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 4a37598..33c75c9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1198,9 +1198,11 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
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
@@ -1590,8 +1592,10 @@ static void hv_eject_device_work(struct work_struct *work)
 	pdev = pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
 					   wslot);
 	if (pdev) {
+		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
+		pci_unlock_rescan_remove();
 	}
 
 	memset(&ctxt, 0, sizeof(ctxt));
-- 
1.8.5.6

