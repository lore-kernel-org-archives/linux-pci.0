Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:46378 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753005AbdKWOE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Nov 2017 09:04:28 -0500
From: Oded Gabbay <oded.gabbay@gmail.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: [PATCH] pci: add class codes for processing accelerators
Date: Thu, 23 Nov 2017 16:04:22 +0200
Message-Id: <1511445862-4383-1-git-send-email-oded.gabbay@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCI codes to include/linux/pci_ids.h for Processing Accelerators. There
are new ASICs (now in development) for Deep Learning that will utilize this
base class.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 include/linux/pci_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab20dc5..4c210cd 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -139,6 +139,9 @@
 #define PCI_CLASS_SP_DPIO		0x1100
 #define PCI_CLASS_SP_OTHER		0x1180
 
+#define PCI_BASE_CLASS_PROCESSING_ACCELERATOR	0x12
+#define PCI_CLASS_PA_VENDOR_SPECIFIC		0x1200
+
 #define PCI_CLASS_OTHERS		0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
-- 
2.7.4
