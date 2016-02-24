Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:37361 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbcBXS5I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 13:57:08 -0500
From: jakeo@microsoft.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	tglx@linutronix.de, haiyangz@microsoft.com, marc.zyngier@arm.com,
	haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH] PCI: Remove usage of pci_domain_nr when the PCI bus doesn't yet exist
Date: Wed, 24 Feb 2016 18:56:36 +0000
Message-Id: <1456340196-13717-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch fixes a race condition in this driver.  Using the
function pci_domain_nr() only works if the PCI bus has already
been fully created.  This patch just deletes one call site,
as it was in debug prints which aren't strictly necessary.
Another call site is changed to look for the data in the same
structure that is passed in when creating the PCI bus in the
first place.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 9391dee..ed651ba 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1265,11 +1265,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	if (!hpdev)
 		return NULL;
 
-	dev_info(&hbus->hdev->device,
-		 "New child device (%p) [%04x:%04x] at %04x:00:00.%02x\n",
-		 hpdev, desc->v_id, desc->d_id, pci_domain_nr(hbus->pci_bus),
-		 desc->win_slot.bits.func);
-
 	hpdev->hbus = hbus;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -1558,9 +1553,15 @@ static void hv_eject_device_work(struct work_struct *work)
 		return;
 	}
 
+	/*
+	 * Ejection can come before or after the PCI bus has been set up, so
+	 * attempt to find it and tear down the bus state, if it exists.  This
+	 * must be done without constructs like pci_domain_nr(hbus->pci_bus)
+	 * because hbus->pci_bus may not exist yet.
+	 */
 	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
-	pdev = pci_get_domain_bus_and_slot(pci_domain_nr(hpdev->hbus->pci_bus),
-					   0, wslot);
+	pdev = pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
+					   wslot);
 	if (pdev) {
 		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
-- 
1.9.1

