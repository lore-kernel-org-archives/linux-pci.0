Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbdAQOWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jan 2017 09:22:03 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Duc Dang <dhdang@apm.com>
Subject: [PATCH v2] PCI/MSI: pci-xgene-msi: Fix CPU hotplug registration handling
Date: Tue, 17 Jan 2017 14:21:56 +0000
Message-Id: <1484662916-9549-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The conversion to the new hotplug state machine introduced a regression
where a successful hotplug registration would be treated as an error,
effectively disabling the MSI driver forever.

Fix it by doing the proper check on the return value.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Fixes: 9c248f8896e6 ("PCI/xgene-msi: Convert to hotplug state machine")
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Duc Dang <dhdang@apm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v1: added Sebastian's Ack and Duc's Tested-by, cc'ing linux-pci

 drivers/pci/host/pci-xgene-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
index 1f38d08..f1b633b 100644
--- a/drivers/pci/host/pci-xgene-msi.c
+++ b/drivers/pci/host/pci-xgene-msi.c
@@ -517,7 +517,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
 
 	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "pci/xgene:online",
 			       xgene_msi_hwirq_alloc, NULL);
-	if (rc)
+	if (rc < 0)
 		goto err_cpuhp;
 	pci_xgene_online = rc;
 	rc = cpuhp_setup_state(CPUHP_PCI_XGENE_DEAD, "pci/xgene:dead", NULL,
-- 
2.1.4

