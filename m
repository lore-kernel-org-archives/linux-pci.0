Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:24921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752342AbcKSIcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Nov 2016 03:32:53 -0500
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/3] pciehp: Fix led status when enabling already enabled slot.
Date: Sat, 19 Nov 2016 00:32:46 -0800
Message-Id: <1479544367-7195-3-git-send-email-ashok.raj@intel.com>
In-Reply-To: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If an error occurs enabling a slot on a hot plug event, the presence LED 
is disabled.

It is not an error, though, when the slot was already enabled. This
patch returns success if called to enable an already enabled slot. This
is in the same spirit of the special handling for EEXISTS when
pciehp_configure_device determines the slot devices already exist.

Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index efe69e8..ec0b4c1 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -410,7 +410,7 @@ int pciehp_enable_slot(struct slot *p_slot)
 		if (getstatus) {
 			ctrl_info(ctrl, "Slot(%s): Already enabled\n",
 				  slot_name(p_slot));
-			return -EINVAL;
+			return 0;
 		}
 	}
 
-- 
2.7.4

