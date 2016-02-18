Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52092 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425604AbcBRMwE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Feb 2016 07:52:04 -0500
Date: Thu, 18 Feb 2016 13:52:01 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-pci@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Borislav Petkov <bp@suse.de>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/4] PCI: aer_inject: Use dev_warn()
Message-ID: <20160218135201.1a97a532@endymion>
In-Reply-To: <20160218130928.67dbf63b@endymion>
References: <20160218130928.67dbf63b@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

dev_warn() is better than printk(LOG_WARNING...) as it records which
device the message relates to. Also add a prefix "aer_inject:" to
help differentiate real errors from injected errors.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aer_inject.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-4.5-rc4.orig/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 11:41:48.738010173 +0100
+++ linux-4.5-rc4/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 12:50:56.927581343 +0100
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/uaccess.h>
 #include <linux/stddef.h>
+#include <linux/device.h>
 #include "aerdrv.h"
 
 /* Override the existing corrected and uncorrected error masks */
@@ -397,14 +398,16 @@ static int aer_inject(struct aer_error_i
 	if (!aer_mask_override && einj->cor_status &&
 	    !(einj->cor_status & ~cor_mask)) {
 		ret = -EINVAL;
-		printk(KERN_WARNING "The correctable error(s) is masked by device\n");
+		dev_warn(&dev->dev,
+			 "aer_inject: The correctable error(s) is masked by device\n");
 		spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 	if (!aer_mask_override && einj->uncor_status &&
 	    !(einj->uncor_status & ~uncor_mask)) {
 		ret = -EINVAL;
-		printk(KERN_WARNING "The uncorrectable error(s) is masked by device\n");
+		dev_warn(&dev->dev,
+			 "aer_inject: The uncorrectable error(s) is masked by device\n");
 		spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
@@ -457,7 +460,8 @@ static int aer_inject(struct aer_error_i
 
 	if (find_aer_device(rpdev, &edev)) {
 		if (!get_service_data(edev)) {
-			printk(KERN_WARNING "AER service is not initialized\n");
+			dev_warn(&edev->device,
+				 "aer_inject: AER service is not initialized\n");
 			ret = -EPROTONOSUPPORT;
 			goto out_put;
 		}

-- 
Jean Delvare
SUSE L3 Support
