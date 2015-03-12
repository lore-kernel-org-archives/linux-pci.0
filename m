Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32832 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbbCLFVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Mar 2015 01:21:31 -0400
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	famz@redhat.com
Subject: [RFC PATCH] PCI: Disable MSI/MSI-X only if device is shutdown
Date: Thu, 12 Mar 2015 13:21:22 +0800
Message-Id: <1426137682-12287-1-git-send-email-famz@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the device doesn't support shutdown, disabling interrupts may cause
trouble. For example, virtio-scsi-pci doesn't implement shutdown, and
after we disable MSI-X, futher notifications from device will be
delivered to IRQ, which is unexpected. This IRQ will not be cleared, and
may prevent us from making progress, by keep triggering interrupts.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/pci/pci-driver.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 3cb2210..fb29c96 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -448,10 +448,11 @@ static void pci_device_shutdown(struct device *dev)
 
 	pm_runtime_resume(dev);
 
-	if (drv && drv->shutdown)
+	if (drv && drv->shutdown) {
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
+		pci_msi_shutdown(pci_dev);
+		pci_msix_shutdown(pci_dev);
+	}
 
 #ifdef CONFIG_KEXEC
 	/*
-- 
1.9.3

