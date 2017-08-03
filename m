Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34342 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdHCRKE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 13:10:04 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, scott@spiteful.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/5] PCI: hotplug: shpchp: constify pci_device_id.
Date: Thu,  3 Aug 2017 22:39:12 +0530
Message-Id: <1501780156-24708-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/hotplug/shpchp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 3454dc7..7bfb87b 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -351,7 +351,7 @@ static void shpc_remove(struct pci_dev *dev)
 	kfree(ctrl);
 }
 
-static struct pci_device_id shpcd_pci_tbl[] = {
+static const struct pci_device_id shpcd_pci_tbl[] = {
 	{PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0)},
 	{ /* end: all zeroes */ }
 };
-- 
2.7.4
