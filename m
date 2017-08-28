Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdH1RJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Aug 2017 13:09:48 -0400
From: Tyler Baicar <tbaicar@codeaurora.org>
To: bhelgaas@google.com, jonathan.derrick@intel.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH] PCI/AER: don't call recovery process for correctable errors
Date: Mon, 28 Aug 2017 11:09:44 -0600
Message-Id: <1503940184-29423-1-git-send-email-tbaicar@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Correctable errors do not need any software intervention, so
avoid calling into the software recovery process for correctable
errors.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/pci/pcie/aer/aerdrv_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index b1303b3..4765c11 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -626,7 +626,8 @@ static void aer_recover_work_func(struct work_struct *work)
 			continue;
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
-		do_recovery(pdev, entry.severity);
+		if (entry.severity != AER_CORRECTABLE)
+			do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
