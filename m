Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:58736 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbaHLLsZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Aug 2014 07:48:25 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 12 Aug 2014 17:18:20 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id B7AB8E0018
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 17:20:16 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s7CBmddr59506918
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 17:18:39 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s7CBmGR6014436
	for <linux-pci@vger.kernel.org>; Tue, 12 Aug 2014 17:18:16 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: amirv@mellanox.com, alex.williamson@redhat.com, eli@mellanox.com,
	weiyang@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3] PCI: Mark broken INTx masking for Mellanox devices
Date: Tue, 12 Aug 2014 21:48:11 +1000
Message-Id: <1407844091-20815-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The VFIO driver is routing LSI interrupts by capturing, masking,
and then delivering. When passing though Mellanox adapters from
host to guest, interrupt storm was reported from host and guest.
That's because we can't mask the LSI interrupt with help of PCI
command register.

 # lspci | grep Mellanox
 0001:05:00.0 Ethernet controller: Mellanox Technologies MT27500 \
              Family [ConnectX-3]
 0005:01:00.0 Ethernet controller: Mellanox Technologies MT26448 \
              [ConnectX EN 10GigE, PCIe 2.0 5GT/s] (rev b0)

It's confirmed by Amir Vadai that all Mellanox devices have same
problem. The patch marks broken INTx masking for all Mellanox
adapters.

Cc: Amir Vadai <amirv@mellanox.com>
Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v3: Mark broken INTx masking for all Mellanox adapters
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 80c2d01..da062d8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2985,6 +2985,8 @@ DECLARE_PCI_FIXUP_HEADER(0x1814, 0x0601, /* Ralink RT2800 802.11n PCI */
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
 			 quirk_broken_intx_masking);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
+			 quirk_broken_intx_masking);
 
 #ifdef CONFIG_ACPI
 /*
-- 
1.8.3.2

