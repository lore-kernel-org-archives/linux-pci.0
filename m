Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34600 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbaBXV6q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2014 16:58:46 -0500
Received: by mail-ig0-f173.google.com with SMTP id r1so5829888igi.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2014 13:58:45 -0800 (PST)
Received: from localhost ([172.16.49.58])
        by mx.google.com with ESMTPSA id bf7sm30562258igb.9.2014.02.24.13.58.44
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Feb 2014 13:58:44 -0800 (PST)
Subject: [PATCH] PCI: pciehp: Cleanup whitespace
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 24 Feb 2014 14:58:43 -0700
Message-ID: <20140224215843.6072.69510.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Minor whitespace cleanup; no functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_acpi.c |    1 +
 drivers/pci/hotplug/pciehp_core.c |    1 +
 drivers/pci/hotplug/pciehp_ctrl.c |    9 ++++-----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_acpi.c b/drivers/pci/hotplug/pciehp_acpi.c
index eddddd447d0d..20fea57d2149 100644
--- a/drivers/pci/hotplug/pciehp_acpi.c
+++ b/drivers/pci/hotplug/pciehp_acpi.c
@@ -112,6 +112,7 @@ static struct pcie_port_service_driver __initdata dummy_driver = {
 static int __init select_detection_mode(void)
 {
 	struct dummy_slot *slot, *tmp;
+
 	if (pcie_port_service_register(&dummy_driver))
 		return PCIEHP_DETECT_ACPI;
 	pcie_port_service_unregister(&dummy_driver);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 23b4bde8aad3..0e0a2fff20a3 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -108,6 +108,7 @@ static int init_slot(struct controller *ctrl)
 	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (!ops)
 		goto out;
+
 	ops->enable_slot = enable_slot;
 	ops->disable_slot = disable_slot;
 	ops->get_power_status = get_power_status;
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 0c2e524a1cf0..c75e6a678dcc 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -399,11 +399,10 @@ static void handle_button_press_event(struct slot *p_slot)
 		 */
 		ctrl_info(ctrl, "Button cancel on Slot(%s)\n", slot_name(p_slot));
 		cancel_delayed_work(&p_slot->work);
-		if (p_slot->state == BLINKINGOFF_STATE) {
+		if (p_slot->state == BLINKINGOFF_STATE)
 			pciehp_green_led_on(p_slot);
-		} else {
+		else
 			pciehp_green_led_off(p_slot);
-		}
 		pciehp_set_attention_status(p_slot, 0);
 		ctrl_info(ctrl, "PCI slot #%s - action canceled "
 			  "due to button press\n", slot_name(p_slot));
@@ -595,9 +594,9 @@ int pciehp_enable_slot(struct slot *p_slot)
 	pciehp_get_latch_status(p_slot, &getstatus);
 
 	rc = board_added(p_slot);
-	if (rc) {
+	if (rc)
 		pciehp_get_latch_status(p_slot, &getstatus);
-	}
+
 	return rc;
 }
 

