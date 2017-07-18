Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34591 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdGRONA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2017 10:13:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id p11so1952110lfd.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 07:12:59 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, marcel@redhat.com,
        Aleksandr Bezzubikov <zuban32s@gmail.com>
Subject: [PATCH] pci: shpchp: set the bridge busmaster if MSI are enabled
Date: Tue, 18 Jul 2017 17:12:25 +0300
Message-Id: <1500387145-4216-1-git-send-email-zuban32s@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An MSI-based SHPC built in PCI bridges can configure hotplugged devices
only if they notify the bridge with MSI.
But they can't trigger interrupt without the bridge being busmaster,
that's why it should be enabled.

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 drivers/pci/hotplug/shpchp_hpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index de0ea47..e5824c7 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -1062,6 +1062,8 @@ int shpc_init(struct controller *ctrl, struct pci_dev *pdev)
 		if (rc) {
 			ctrl_info(ctrl, "Can't get msi for the hotplug controller\n");
 			ctrl_info(ctrl, "Use INTx for the hotplug controller\n");
+		} else {
+			pci_set_master(pdev);
 		}
 
 		rc = request_irq(ctrl->pci_dev->irq, shpc_isr, IRQF_SHARED,
-- 
2.7.4
