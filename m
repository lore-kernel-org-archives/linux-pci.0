Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38195 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbdHCRKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 13:10:08 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: bhelgaas@google.com, scott@spiteful.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/5] PCI: hotplug: bmphp_ebda: constify pci_device_id.
Date: Thu,  3 Aug 2017 22:39:14 +0530
Message-Id: <1501780156-24708-4-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501780156-24708-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/hotplug/ibmphp_ebda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 43e345a..a6a4dac 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -1153,7 +1153,7 @@ void ibmphp_free_ebda_pci_rsrc_queue(void)
 	}
 }
 
-static struct pci_device_id id_table[] = {
+static const struct pci_device_id id_table[] = {
 	{
 		.vendor		= PCI_VENDOR_ID_IBM,
 		.device		= HPC_DEVICE_ID,
-- 
2.7.4
