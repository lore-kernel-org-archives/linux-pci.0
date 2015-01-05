Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:38257 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbbAECXO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jan 2015 21:23:14 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 5 Jan 2015 12:23:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 74D6D2BB0078
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2015 13:17:57 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t052Hv1g50921486
	for <linux-pci@vger.kernel.org>; Mon, 5 Jan 2015 13:17:57 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t052HuF6008164
	for <linux-pci@vger.kernel.org>; Mon, 5 Jan 2015 13:17:57 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: ajit.khaparde@emulex.com, bhelgaas@google.com,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] PCI: Mark broken INTx masking for BENET devices
Date: Mon,  5 Jan 2015 13:17:54 +1100
Message-Id: <1420424274-3194-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Similar to commit 11e4253 ("PCI: Assume all Mellanox devices have
broken INTx masking"), when passing through following PCI device
using VFIO infrastructure, interrupt storm are reported. After
marking its INTx masking is broken, the interrupt storm isn't
raised again:

 # lspci -s 0000::.
 0000:01:00.0 Ethernet controller: Emulex Corporation \
              OneConnect 10Gb NIC (be3) (rev 02)
 0000:01:00.1 Ethernet controller: Emulex Corporation \
              OneConnect 10Gb NIC (be3) (rev 02)
 # lspci -n -s 0000::.
 0000:01:00.0 0200: 19a2:0710 (rev 02)
 0000:01:00.1 0200: 19a2:0710 (rev 02)

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/quirks.c    | 2 ++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ed6f89b..e823ac0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3027,6 +3027,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
 			 quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
 			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_BE, PCI_ANY_ID,
+			 quirk_broken_intx_masking);
 
 #ifdef CONFIG_ACPI
 /*
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e63c02a..df70b76 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2481,6 +2481,8 @@
 #define PCI_DEVICE_ID_KORENIX_JETCARDF2	0x1700
 #define PCI_DEVICE_ID_KORENIX_JETCARDF3	0x17ff
 
+#define PCI_VENDOR_ID_BE		0x19a2
+
 #define PCI_VENDOR_ID_QMI		0x1a32
 
 #define PCI_VENDOR_ID_AZWAVE		0x1a3b
-- 
1.8.3.2

