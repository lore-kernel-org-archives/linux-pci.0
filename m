Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38276 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbbFRQMr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jun 2015 12:12:47 -0400
Received: by igblz2 with SMTP id lz2so63165546igb.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2015 09:12:46 -0700 (PDT)
Subject: [PATCH 2/4] PCI: pciehp: Make queue_interrupt_event() void
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2015 11:12:45 -0500
Message-ID: <20150618161245.32739.87037.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Nobody looks at the return value from queue_interrupt_event(), so errors
were silently ignored.  Convert it to a "void" function and note the error
in the dmesg log.

No functional change except the new message.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 4bdaf62..1086041 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -37,21 +37,20 @@
 
 static void interrupt_event_handler(struct work_struct *work);
 
-static int queue_interrupt_event(struct slot *p_slot, u32 event_type)
+static void queue_interrupt_event(struct slot *p_slot, u32 event_type)
 {
 	struct event_info *info;
 
 	info = kmalloc(sizeof(*info), GFP_ATOMIC);
-	if (!info)
-		return -ENOMEM;
+	if (!info) {
+		ctrl_err(p_slot->ctrl, "dropped event %d (ENOMEM)\n", event_type);
+		return;
+	}
 
+	INIT_WORK(&info->work, interrupt_event_handler);
 	info->event_type = event_type;
 	info->p_slot = p_slot;
-	INIT_WORK(&info->work, interrupt_event_handler);
-
 	queue_work(p_slot->wq, &info->work);
-
-	return 0;
 }
 
 u8 pciehp_handle_attention_button(struct slot *p_slot)

