Return-Path: <SRS0=QzVP=KM=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=QzVP=KM=wunner.de=lukas@kernel.org>
Message-Id: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 28 Jul 2018 07:22:00 +0200
Subject: [PATCH 1/2] PCI: pciehp: Avoid implicit fallthroughs in switch
 statements
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Per Mika's request, add an explicit break to the last case of switch
statements everywhere in pciehp to be more defensive towards future
amendments.

Per Gustavo's request, mark all non-empty implicit fallthroughs with a
comment to silence warnings triggered by -Wimplicit-fallthrough=2.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 6855933ab372..da7c72372ffc 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -211,6 +211,7 @@ void pciehp_handle_disable_request(struct slot *slot)
 	case BLINKINGON_STATE:
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&slot->work);
+		break;
 	}
 	slot->state = POWEROFF_STATE;
 	mutex_unlock(&slot->lock);
@@ -232,6 +233,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 	switch (slot->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&slot->work);
+		/* fall through */
 	case ON_STATE:
 		slot->state = POWEROFF_STATE;
 		mutex_unlock(&slot->lock);
@@ -245,6 +247,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 		break;
 	default:
 		mutex_unlock(&slot->lock);
+		break;
 	}
 
 	/* Turn the slot on if it's occupied or link is up */
@@ -259,6 +262,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 	switch (slot->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&slot->work);
+		/* fall through */
 	case OFF_STATE:
 		slot->state = POWERON_STATE;
 		mutex_unlock(&slot->lock);
@@ -272,6 +276,7 @@ void pciehp_handle_presence_or_link_change(struct slot *slot, u32 events)
 		break;
 	default:
 		mutex_unlock(&slot->lock);
+		break;
 	}
 }
 
-- 
2.18.0
