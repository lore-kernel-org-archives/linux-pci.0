Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44992 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeAYXgP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jan 2018 18:36:15 -0500
Received: by mail-pg0-f66.google.com with SMTP id m20so6079150pgc.11
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2018 15:36:15 -0800 (PST)
From: Feng Kan <fkan@apm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        alex.williamson@redhat.com, bhelgaas@google.com
Cc: Feng Kan <fkan@apm.com>
Subject: [PATCH] pci: quirk: adding Ampere vendor id to ACS quirk list
Date: Thu, 25 Jan 2018 15:36:07 -0800
Message-Id: <1516923367-28197-1-git-send-email-fkan@apm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adding Ampere Computing vendor id to the ACS quirk list.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 Tanmay is no longer with us. After the email system is rebranded
 to the new company. We will clean up the remaining legacy items.

 drivers/pci/quirks.c    | 9 +++++++++
 include/linux/pci_ids.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 10684b1..45d9187 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4512,6 +4512,15 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_CAVIUM, PCI_ANY_ID, pci_quirk_cavium_acs },
 	/* APM X-Gene */
 	{ PCI_VENDOR_ID_AMCC, 0xE004, pci_quirk_xgene_acs },
+	/* Ampere Computing */
+	{ PCI_VENDOR_ID_AMPERE, 0xE005, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_AMPERE, 0xE006, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_AMPERE, 0xE007, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_AMPERE, 0xE008, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_AMPERE, 0xE009, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
+	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
 	{ 0 }
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab20dc5..c21d1f8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1331,6 +1331,7 @@
 #define PCI_DEVICE_ID_IMS_TT3D		0x9135
 
 #define PCI_VENDOR_ID_AMCC		0x10e8
+#define PCI_VENDOR_ID_AMPERE		0x1def
 
 #define PCI_VENDOR_ID_INTERG		0x10ea
 #define PCI_DEVICE_ID_INTERG_1682	0x1682
-- 
2.7.4
