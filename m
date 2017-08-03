Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36502 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdHCRKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 13:10:07 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, scott@spiteful.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/5] PCI: hotplug: ibmphp: constify pci_device_id.
Date: Thu,  3 Aug 2017 22:39:13 +0530
Message-Id: <1501780156-24708-3-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/hotplug/ibmphp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 5efd01d..73cf846 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -852,7 +852,7 @@ static int set_bus(struct slot *slot_cur)
 	u8 speed;
 	u8 cmd = 0x0;
 	int retval;
-	static struct pci_device_id ciobx[] = {
+	static const struct pci_device_id ciobx[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, 0x0101) },
 		{ },
 	};
-- 
2.7.4
