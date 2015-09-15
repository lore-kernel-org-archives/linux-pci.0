Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34802 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbIOEKh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 00:10:37 -0400
Received: by padhy16 with SMTP id hy16so163415886pad.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 21:10:37 -0700 (PDT)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH/RFC 2/3] PCI: Add Netronome vendor and device IDs
Date: Tue, 15 Sep 2015 13:10:23 +0900
Message-Id: <1442290224-21729-3-git-send-email-simon.horman@netronome.com>
In-Reply-To: <1442290224-21729-1-git-send-email-simon.horman@netronome.com>
References: <1442290224-21729-1-git-send-email-simon.horman@netronome.com>
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
index fcff8f865341..085abd9681af 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2486,6 +2486,12 @@
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

