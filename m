Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0154.outbound.protection.outlook.com ([207.46.163.154]:54126
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab3LWP1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Dec 2013 10:27:18 -0500
From: <Kashyap.Desai@lsi.com>
Message-ID: <201312231512.rBNFC6mo008974@cosmhbs0.lsi.com>
Date: Mon, 23 Dec 2013 20:43:36 +0530
To: <linux-scsi@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] megaraid_sas: Quirk mmio hook for 1078 MR controller
CC: <jbottomley@parallels.com>, <sumit.saxena@lsi.com>,
	<kashyap.desai@lsi.com>, <aradford@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch has fix for LSI Gen-1 MR controller issue which only pop-up on
few systems and it is not generic.

On few system, MR 1078 MR controller is not working if mmio decoding is off.
This patch proposed early quirck entry for Device id 0x1000/0x0411 to enable mmio.

Signed-off-by: Kashyap Desai <kashyap.desai@lsi.com>
---
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f6c31fa..a20fe41 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -43,6 +43,10 @@ static void quirk_mmio_always_on(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_ANY_ID, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_HOST, 8, quirk_mmio_always_on);
+/* LSI controller device id 0x0411 has some issues if mmio_always_on is not set. 
+ * It pop-up only on few specific system, where decoding disable is not working.
+ */
+DECLARE_PCI_FIXUP_EARLY(0x1000, 0x0411, quirk_mmio_always_on);
 
 /* The Mellanox Tavor device gives false positive parity errors
  * Mark this device with a broken_parity_status, to allow
