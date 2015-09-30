Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33793 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbbI3GfS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2015 02:35:18 -0400
Received: by padhy16 with SMTP id hy16so30593434pad.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 23:35:18 -0700 (PDT)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH repost 2/3] PCI: Add Netronome vendor and device IDs
Date: Wed, 30 Sep 2015 15:35:06 +0900
Message-Id: <1443594907-16196-3-git-send-email-simon.horman@netronome.com>
In-Reply-To: <1443594907-16196-1-git-send-email-simon.horman@netronome.com>
References: <1443594907-16196-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Jason S. McMullan" <jason.mcmullan@netronome.com>

Device IDs for the Netronome NFP3200, NFP3240, NFP6000, and
NFP6000 SR-IOV devices.

Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>
[simon: edited changelog]
Signed-off-by: Simon Horman <simon.horman@netronome.com>
---
 include/linux/pci_ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d9ba49cedc5d..526e2c12ae59 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2495,6 +2495,12 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
 #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
 
+#define PCI_VENDOR_ID_NETRONOME		0x19ee
+#define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
+#define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240
+#define PCI_DEVICE_ID_NETRONOME_NFP6000	0x6000
+#define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
+
 #define PCI_VENDOR_ID_QMI		0x1a32
 
 #define PCI_VENDOR_ID_AZWAVE		0x1a3b
-- 
2.1.4

