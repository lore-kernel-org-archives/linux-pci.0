Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33578 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935366AbeF2K15 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 06:27:57 -0400
Received: by mail-qk0-f194.google.com with SMTP id c131-v6so4626877qkb.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2018 03:27:57 -0700 (PDT)
From: Hari Vyas <hari.vyas@broadcom.com>
To: bhelgaas@google.com, benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        Hari Vyas <hari.vyas@broadcom.com>
Subject: [PATCH v2 3/3] PCI: Hotplug: use new pci function to get device addition state
Date: Fri, 29 Jun 2018 15:57:41 +0530
Message-Id: <1530268061-17324-4-git-send-email-hari.vyas@broadcom.com>
In-Reply-To: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
References: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Due to one race condition happening while updating pci
device addition and master status bits in a particular
scenario, device addition state is moved to a independent
private flag variable.

This change uses newly proposed pci_dev_is_added() function
to retrieve device addition state.

Signed-off-by: Hari Vyas <hari.vyas@broadcom.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 3a17b29..ef0b1b6 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -509,7 +509,7 @@ static void enable_slot(struct acpiphp_slot *slot)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Assume that newly added devices are powered on already. */
-		if (!dev->is_added)
+		if (!pci_dev_is_added(dev))
 			dev->current_state = PCI_D0;
 	}
 
-- 
1.9.1
