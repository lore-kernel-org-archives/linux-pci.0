Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757535AbcILVJ4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 17:09:56 -0400
Subject: [PATCH v2 8/8] PCI: pciehp: Remove useless
 pciehp_get_latch_status() calls
To: Mayurkumar Patel <mayurkumar.patel@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, MikaWesterberg@linux.intel.com,
        linux-pci@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Luis Antonio Tarazona-Duarte
        <luis.antonio.tarazona-duarte@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mika.westerberg@linux.intel.com
Date: Mon, 12 Sep 2016 16:09:52 -0500
Message-ID: <20160912210952.22258.67691.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160912210507.22258.63097.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Long ago, we updated a "switch_save" field based on the latch status.  But
switch_save was unused, and ed6cbcf2ac70 ("[PATCH] pciehp: miscellaneous
cleanups") removed it.

We no longer use the latch status, so remove calls to
pciehp_get_latch_status().  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bf50f26..efe69e8 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -389,7 +389,6 @@ static void interrupt_event_handler(struct work_struct *work)
 int pciehp_enable_slot(struct slot *p_slot)
 {
 	u8 getstatus = 0;
-	int rc;
 	struct controller *ctrl = p_slot->ctrl;
 
 	pciehp_get_adapter_status(p_slot, &getstatus);
@@ -415,13 +414,7 @@ int pciehp_enable_slot(struct slot *p_slot)
 		}
 	}
 
-	pciehp_get_latch_status(p_slot, &getstatus);
-
-	rc = board_added(p_slot);
-	if (rc)
-		pciehp_get_latch_status(p_slot, &getstatus);
-
-	return rc;
+	return board_added(p_slot);
 }
 
 /*

