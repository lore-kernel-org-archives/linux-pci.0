Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbcKSRpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Nov 2016 12:45:11 -0500
From: Quentin Lambert <lambert.quentin@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Quentin Lambert <lambert.quentin@gmail.com>
Subject: [PATCH] PCI Hotplug: cpqphp: Add missing call to pci_disable_device
Date: Sat, 19 Nov 2016 18:41:48 +0100
Message-Id: <20161119174148.20187-1-lambert.quentin@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Most error branches following the call to pci_enable_device contain
a call to pci_disable_device. This patch add these calls where they are
missing.

This issue was found with Hector.

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>

---
 drivers/pci/hotplug/cpqphp_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -867,7 +867,8 @@ static int cpqhpc_probe(struct pci_dev *
 	 */
 	if ((pdev->revision <= 2) && (vendor_id != PCI_VENDOR_ID_INTEL)) {
 		err(msg_HPC_not_supported);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto err_disable_device;
 	}
 
 	/* TODO: This code can be made to support non-Compaq or Intel
