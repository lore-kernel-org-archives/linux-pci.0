Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:40794 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaHAEyk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Aug 2014 00:54:40 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 1 Aug 2014 10:24:38 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 66E313940018
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2014 10:24:35 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s714sd5258589184
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2014 10:24:40 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s714sXvX008338
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2014 10:24:34 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: amirv@mellanox.com, alex.williamson@redhat.com,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2] PCI: Mark broken INTx masking for Mellanox devices
Date: Fri,  1 Aug 2014 14:54:31 +1000
Message-Id: <1406868871-350-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The VFIO driver is routing LSI interrupts by capturing, masking,
and then delivering. When passing though Mallanox adapters from
host to guest, interrupt storm was reported from host and guest.
That's because we can't mask the LSI interrupt with help of PCI
command register.

[root@ncc-1701 ~]# lspci | grep Mellanox
0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
             Family [ConnectX-3]
0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
             [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)

The patch marks broken INTx masking for Mellanox devices so that
the VFIO driver will always mask the interrupt from interrupt
controller side to avoid interrupt storm.

Cc: Amir Vadai <amirv@mellanox.com>
Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d0f6926..8c2b96f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2977,6 +2977,10 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, 0x0030,
 			 quirk_broken_intx_masking);
 DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
 			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x1003,
+			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, 0x6750,
+			 quirk_broken_intx_masking);
 /*
  * Realtek RTL8169 PCI Gigabit Ethernet Controller (rev 10)
  * Subsystem: Realtek RTL8169/8110 Family PCI Gigabit Ethernet NIC
-- 
1.8.3.2

