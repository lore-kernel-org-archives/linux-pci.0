Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34831 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdHCRKM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 13:10:12 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, scott@spiteful.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 4/5] PCI: hotplug: cpcihp_zt5550: constify pci_device_id.
Date: Thu,  3 Aug 2017 22:39:15 +0530
Message-Id: <1501780156-24708-5-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/hotplug/cpcihp_zt5550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
index 5f49c3f..2f8659a 100644
--- a/drivers/pci/hotplug/cpcihp_zt5550.c
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c
@@ -280,7 +280,7 @@ static void zt5550_hc_remove_one(struct pci_dev *pdev)
 }
 
 
-static struct pci_device_id zt5550_hc_pci_tbl[] = {
+static const struct pci_device_id zt5550_hc_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ZIATECH, PCI_DEVICE_ID_ZIATECH_5550_HC, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, }
 };
-- 
2.7.4
