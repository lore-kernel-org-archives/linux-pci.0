Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:42030 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729801AbeGZQjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2018 12:39:10 -0400
From: Bert Kenward <bkenward@solarflare.com>
Subject: [PATCH] pci/vpd: Ensure VPD is checked before timeout
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Message-ID: <66bbf8b3-bab9-1860-12c9-1c187ddc4201@solarflare.com>
Date: Thu, 26 Jul 2018 16:21:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We check the timeout before we check the VPD access completion bit.
On a very heavily loaded system this can cause VPD access to timeout.
We should check the completion bit before checking the timeout.

Signed-off-by: Bert Kenward <bkenward@solarflare.com>
---
 drivers/pci/vpd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 8617565ba561..4963c2e2bd4c 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -146,7 +146,7 @@ static int pci_vpd_wait(struct pci_dev *dev)
 	if (!vpd->busy)
 		return 0;
 
-	while (time_before(jiffies, timeout)) {
+	do {
 		ret = pci_user_read_config_word(dev, vpd->cap + PCI_VPD_ADDR,
 						&status);
 		if (ret < 0)
@@ -160,10 +160,13 @@ static int pci_vpd_wait(struct pci_dev *dev)
 		if (fatal_signal_pending(current))
 			return -EINTR;
 
+		if (time_after(jiffies, timeout))
+			break;
+
 		usleep_range(10, max_sleep);
 		if (max_sleep < 1024)
 			max_sleep *= 2;
-	}
+	} while (true);
 
 	pci_warn(dev, "VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update\n");
 	return -ETIMEDOUT;
-- 
2.13.6
