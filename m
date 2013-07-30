Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34860 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab3G3Ckx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Jul 2013 22:40:53 -0400
From: tianyu.lan@intel.com
To: rjw@sisk.pl, lenb@kernel.org, bhelgaas@google.com
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, stern@rowland.harvard.edu
Subject: [PATCH] PCI/ACPI: Change dev_info() to dev_dbg() in the acpi_pci_set_power_state()
Date: Tue, 30 Jul 2013 10:32:30 +0800
Message-Id: <1375151550-28632-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Lan Tianyu <tianyu.lan@intel.com>

acpi_pci_set_power_state() produces log of device power state changing.
Now the log is produced by dev_info(). This seems make no sense when user
doesn't open debug option. So change it to dev_dbg() and prevent kernel
log from being.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60636
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/pci/pci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index c78cc43..fb3522957 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -210,7 +210,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	}
 
 	if (!error)
-		dev_info(&dev->dev, "power state changed by ACPI to %s\n",
+		dev_dbg(&dev->dev, "power state changed by ACPI to %s\n",
 			 acpi_power_state_string(state_conv[state]));
 
 	return error;
-- 
1.8.3.2

