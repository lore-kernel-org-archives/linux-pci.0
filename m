Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 3/4] PCI: pciehp: Rename queue_interrupt_event() to
 pciehp_queue_interrupt_event()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jun 2015 11:12:51 -0500
Message-ID: <20150618161251.32739.37707.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150618161207.32739.62577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename queue_interrupt_event() to pciehp_queue_interrupt_event() so we can
make it extern and call it from pcie_isr().

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 1086041..7ed37dc 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -37,7 +37,7 @@
 
 static void interrupt_event_handler(struct work_struct *work);
 
-static void queue_interrupt_event(struct slot *p_slot, u32 event_type)
+static void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
 {
 	struct event_info *info;
 
@@ -64,7 +64,7 @@ u8 pciehp_handle_attention_button(struct slot *p_slot)
 	ctrl_info(ctrl, "Button pressed on Slot(%s)\n", slot_name(p_slot));
 	event_type = INT_BUTTON_PRESS;
 
-	queue_interrupt_event(p_slot, event_type);
+	pciehp_queue_interrupt_event(p_slot, event_type);
 
 	return 0;
 }
@@ -90,7 +90,7 @@ u8 pciehp_handle_switch_change(struct slot *p_slot)
 		event_type = INT_SWITCH_CLOSE;
 	}
 
-	queue_interrupt_event(p_slot, event_type);
+	pciehp_queue_interrupt_event(p_slot, event_type);
 
 	return 1;
 }
@@ -120,7 +120,7 @@ u8 pciehp_handle_presence_change(struct slot *p_slot)
 		event_type = INT_PRESENCE_OFF;
 	}
 
-	queue_interrupt_event(p_slot, event_type);
+	pciehp_queue_interrupt_event(p_slot, event_type);
 
 	return 1;
 }
@@ -133,7 +133,7 @@ u8 pciehp_handle_power_fault(struct slot *p_slot)
 	ctrl_err(ctrl, "Power fault on slot %s\n", slot_name(p_slot));
 	event_type = INT_POWER_FAULT;
 	ctrl_info(ctrl, "Power fault bit %x set\n", 0);
-	queue_interrupt_event(p_slot, event_type);
+	pciehp_queue_interrupt_event(p_slot, event_type);
 
 	return 1;
 }
@@ -153,7 +153,7 @@ void pciehp_handle_linkstate_change(struct slot *p_slot)
 		event_type = INT_LINK_DOWN;
 	}
 
-	queue_interrupt_event(p_slot, event_type);
+	pciehp_queue_interrupt_event(p_slot, event_type);
 }
 
 /* The following routines constitute the bulk of the

