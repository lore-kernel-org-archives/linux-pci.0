Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:48802 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbaFQObb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jun 2014 10:31:31 -0400
Message-ID: <53A0513C.2070103@oracle.com>
Date: Tue, 17 Jun 2014 22:31:24 +0800
From: Jeff Liu <jeff.liu@oracle.com>
MIME-Version: 1.0
To: bhelgaas@google.com
CC: linux-pci@vger.kernel.org
Subject: [PATCH 13/24] drivers/pci: return actual error on pci_slot_init
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jie Liu <jeff.liu@oracle.com>

Return the actual error code if call kset_create_and_add() failed
at pci_slot_init().

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jie Liu <jeff.liu@oracle.com>
---
 drivers/pci/slot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 396c200..dddb46a 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -387,9 +387,9 @@ static int pci_slot_init(void)
 	pci_bus_kset = bus_get_kset(&pci_bus_type);
 	pci_slots_kset = kset_create_and_add("slots", NULL,
 						&pci_bus_kset->kobj);
-	if (!pci_slots_kset) {
+	if (IS_ERR(pci_slots_kset)) {
 		printk(KERN_ERR "PCI: Slot initialization failure\n");
-		return -ENOMEM;
+		return PTR_ERR(pci_slots_kset);
 	}
 	return 0;
 }
-- 
1.8.3.2
