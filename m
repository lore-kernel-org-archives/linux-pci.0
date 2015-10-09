Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19905 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497AbbJIOFJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Oct 2015 10:05:09 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-iommu@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org
Subject: [Bugfix v4 2/2] ACPI, PCI: Prevent binding other PCI drivers to IOAPIC PCI devices
Date: Fri,  9 Oct 2015 22:07:32 +0800
Message-Id: <1444399652-25920-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1444399652-25920-1-git-send-email-jiang.liu@linux.intel.com>
References: <1444386214-26319-1-git-send-email-joro@8bytes.org>
 <1444399652-25920-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The ACPI IOAPIC driver makes use of IOAPIC PCI devices, so prevent
binding other PCI drivers to IOAPIC PCI devices used by ACPI IOAPIC
driver.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/ioapic.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index ccdc8db16bb8..da71b274fc21 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -162,12 +162,14 @@ done:
 	list_add(&ioapic->list, &ioapic_list);
 	mutex_unlock(&ioapic_list_lock);
 
-	if (dev)
+	if (dev) {
+		dev->match_driver = false;
 		dev_info(&dev->dev, "%s at %pR, GSI %u\n",
 			 type, res, (u32)gsi_base);
-	else
+	} else {
 		acpi_handle_info(handle, "%s at %pR, GSI %u\n",
 				 type, res, (u32)gsi_base);
+	}
 
 	return AE_OK;
 
@@ -216,6 +218,7 @@ int acpi_ioapic_remove(struct acpi_pci_root *root)
 		if (ioapic->pdev) {
 			pci_release_region(ioapic->pdev, 0);
 			pci_disable_device(ioapic->pdev);
+			ioapic->pdev->match_driver = true;
 			pci_dev_put(ioapic->pdev);
 		} else if (ioapic->res.flags && ioapic->res.parent) {
 			release_resource(&ioapic->res);
-- 
1.7.10.4

