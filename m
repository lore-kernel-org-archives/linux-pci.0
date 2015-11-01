Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58904 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbbKAV6n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 1 Nov 2015 16:58:43 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Rajat Jain <rajatxjain@gmail.com>
Subject: [PATCH] PCI: pciehp: Always protect pciehp_disable_slot() with hotplug mutex
Date: Sun,  1 Nov 2015 13:58:40 -0800
Message-Id: <1446415120-14867-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When called from pciehp_sysfs_disable_slot(), the call to
pciehp_disable_slot() was not protected by the hotplug mutex.

Cc: Rajat Jain <rajatxjain@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 4c8f4cde6854..880978b6d534 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -511,7 +511,9 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
+		mutex_lock(&p_slot->hotplug_lock);
 		retval = pciehp_disable_slot(p_slot);
+		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
 		p_slot->state = STATIC_STATE;
 		break;
-- 
2.1.4

