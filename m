Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35569 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbLKCaZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2015 21:30:25 -0500
Received: by pfv76 with SMTP id 76so5148877pfv.2
        for <linux-pci@vger.kernel.org>; Thu, 10 Dec 2015 18:30:24 -0800 (PST)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH 1/2] PCI: Add Netronome NFP4000 device ID
Date: Fri, 11 Dec 2015 11:30:11 +0900
Message-Id: <1449801012-10432-2-git-send-email-simon.horman@netronome.com>
In-Reply-To: <1449801012-10432-1-git-send-email-simon.horman@netronome.com>
References: <1449801012-10432-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the device ID for the PF of the NFP4000.
The device ID for the VF, 0x6003, is already present
as PCI_DEVICE_ID_NETRONOME_NFP6000_VF.

Signed-off-by: Simon Horman <simon.horman@netronome.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 526e2c12ae59..37f05cb1dfd6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2498,6 +2498,7 @@
 #define PCI_VENDOR_ID_NETRONOME		0x19ee
 #define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
 #define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240
+#define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
 #define PCI_DEVICE_ID_NETRONOME_NFP6000	0x6000
 #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
 
-- 
2.1.4

