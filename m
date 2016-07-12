Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42888 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083AbcGLPb0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jul 2016 11:31:26 -0400
From: Cathy Avery <cavery@redhat.com>
To: kys@microsoft.com, haiyangz@microsoft.com, jakeo@microsoft.com,
	bhelgaas@google.com
Cc: vkuznets@redhat.com, devel@linuxdriverproject.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hv: Fix interrupt cleanup path
Date: Tue, 12 Jul 2016 11:31:24 -0400
Message-Id: <1468337484-16074-1-git-send-email-cavery@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

SR-IOV disabled from the host causes a memory leak.
pci-hyperv usually first receives a PCI_EJECT notification
and then proceeds to delete the hpdev list entry in
hv_eject_device_work(). Later in hv_msi_free() since the
device is no longer on the device list hpdev is NULL
and hv_msi_free returns without freeing int_desc as part of
hv_int_desc_free().

Signed-off-by: Cathy Avery <cavery@redhat.com>
---
 drivers/pci/host/pci-hyperv.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 7e9b2de..449d053 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -732,16 +732,18 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
 
 	pdev = msi_desc_to_pci_dev(msi);
 	hbus = info->data;
-	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
-	if (!hpdev)
+	int_desc = irq_data_get_irq_chip_data(irq_data);
+	if (!int_desc)
 		return;
 
-	int_desc = irq_data_get_irq_chip_data(irq_data);
-	if (int_desc) {
-		irq_data->chip_data = NULL;
-		hv_int_desc_free(hpdev, int_desc);
+	irq_data->chip_data = NULL;
+	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
+	if (!hpdev) {
+		kfree(int_desc);
+		return;
 	}
 
+	hv_int_desc_free(hpdev, int_desc);
 	put_pcichild(hpdev, hv_pcidev_ref_by_slot);
 }
 
-- 
2.5.0

