Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 Jul 2018 09:56:00 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PCI: Mark expected switch fall-throughs
Message-ID: <20180705145600.GA22099@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 2 was used: -Wimplicit-fallthrough=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 2 ++
 drivers/pci/hotplug/shpchp_ctrl.c | 2 ++
 drivers/pci/pci.c                 | 1 +
 drivers/pci/quirks.c              | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index c684faa..cfc46e8 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -436,6 +436,7 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -473,6 +474,7 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 1047b56..1267dcc 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -654,6 +654,7 @@ int shpchp_sysfs_enable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -689,6 +690,7 @@ int shpchp_sysfs_disable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&p_slot->work);
+		/* fall through */
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 97acba7..f5c6ab1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2045,6 +2045,7 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		case PCI_D2:
 			if (pci_no_d1d2(dev))
 				break;
+			/* else: fall through */
 		default:
 			target_state = state;
 		}
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f439de8..502275c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2105,6 +2105,7 @@ static void quirk_netmos(struct pci_dev *dev)
 		if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
 				dev->subsystem_device == 0x0299)
 			return;
+		/* else: fall through */
 	case PCI_DEVICE_ID_NETMOS_9735:
 	case PCI_DEVICE_ID_NETMOS_9745:
 	case PCI_DEVICE_ID_NETMOS_9845:
-- 
2.7.4
