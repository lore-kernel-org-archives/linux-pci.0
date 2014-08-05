Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:42173 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710AbaHEQMD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Aug 2014 12:12:03 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so1284165wes.34
        for <linux-pci@vger.kernel.org>; Tue, 05 Aug 2014 09:12:02 -0700 (PDT)
From: matthew_minter@xyratex.com
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: matthew_minter <matthew_minter@xyratex.com>
Subject: [PATCH 07/22] Fixed PCI initilisation code for arches which dont need to map irqs
Date: Tue,  5 Aug 2014 17:11:08 +0100
Message-Id: <1407255083-9356-8-git-send-email-matthew_minter@xyratex.com>
In-Reply-To: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
References: <1407255083-9356-1-git-send-email-matthew_minter@xyratex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: matthew_minter <matthew_minter@xyratex.com>

---
 drivers/pci/setup-irq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
index a994e07..7bb4356 100644
--- a/drivers/pci/setup-irq.c
+++ b/drivers/pci/setup-irq.c
@@ -30,6 +30,11 @@ void pdev_assign_irq(struct pci_dev *dev,
 	u8 slot = -1;
 	int irq = 0;
 
+	if (!map_irq) {
+		dev_dbg(&dev->dev, "map_irq not provided by arch\n", dev->irq);
+		return;
+	}
+
 	/* If this device is not on the primary bus, we need to figure out
 	   which interrupt pin it will come in on.   We know which slot it
 	   will come in on 'cos that slot is where the bridge is.   Each
-- 
2.0.4

