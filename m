Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausxipps301.us.dell.com ([143.166.148.223]:22183 "EHLO
	ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbbL2WVH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2015 17:21:07 -0500
From: Jordan Hargrave <Jordan_Hargrave@dell.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	helgaas@kernel.org, alexander.duyck@gmail.com,
	Jordan Hargrave <Jordan_Hargrave@dell.com>
Subject: [PATCH] Limit VPD length on Atheros wifi cards
Date: Tue, 29 Dec 2015 16:19:02 -0600
Message-Id: <1451427542-30482-1-git-send-email-Jordan_Hargrave@dell.com>
To: Jordan_Hargrave@dell.com
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Attempt to read VPD on these cards causes kernel hang or delay

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
---
 drivers/pci/quirks.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e6376f6..a72667f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2161,6 +2161,16 @@ static void quirk_brcm_570x_limit_vpd(struct pci_dev *dev)
 	}
 }
 
+static void quirk_atheros_vpd(struct pci_dev *dev)
+{
+	/* Atheros WiFi cards hang when reading VPD */
+	if (dev->vpd)
+		dev->vpd->len = 0;
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATHEROS, PCI_ANY_ID, quirk_atheros_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID, quirk_atheros_vpd);
+
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
 			PCI_DEVICE_ID_NX2_5706,
 			quirk_brcm_570x_limit_vpd);
-- 
1.7.1

