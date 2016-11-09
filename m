Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36142 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754061AbcKISG0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 13:06:26 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so130652846pfz.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2016 10:06:26 -0800 (PST)
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: linux-pci@vger.kernel.org
Cc: tbroch@google.com, rajatja@google.com, gwendal@google.com,
        bhelgaas@google.com, ravisadineni@google.com,
        keith.busch@intel.com, paul.gortmaker@windriver.com,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH] pciehp_resume: don't add existing device
Date: Wed,  9 Nov 2016 10:05:35 -0800
Message-Id: <1478714735-134347-1-git-send-email-ravisadineni@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a slot was occupied before supend, and nothing has changed after
resume, we call pciehp_enable_slot() although it fails a little
later with the message:
   Device XXXX:XX:XX.X already exists at XXXX:XX:XX, cannot hot-add
   Cannot add device at XXXX:XX:XX

This was partly discussed here: https://lkml.org/lkml/2013/7/9/452
and I'm pulling only the part4 of that patch, since it does not change
anything functionally (or atleast does not seem to make it worse), but
prevents uncomfortable messages pointed above.
---
 drivers/pci/hotplug/pciehp_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 612b21a..873cff8 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -290,6 +290,7 @@ static int pciehp_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl;
 	struct slot *slot;
+	struct pci_bus *pbus = dev->port->subordinate;
 	u8 status;
 
 	ctrl = get_service_data(dev);
@@ -302,10 +303,13 @@ static int pciehp_resume(struct pcie_device *dev)
 	/* Check if slot is occupied */
 	pciehp_get_adapter_status(slot, &status);
 	mutex_lock(&slot->hotplug_lock);
-	if (status)
-		pciehp_enable_slot(slot);
-	else
+	if (status) {
+		if (list_empty(&pbus->devices))
+			pciehp_enable_slot(slot);
+	}
+	else {
 		pciehp_disable_slot(slot);
+	}
 	mutex_unlock(&slot->hotplug_lock);
 	return 0;
 }
-- 
2.6.6

