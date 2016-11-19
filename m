Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:20360 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752695AbcKSIcx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Nov 2016 03:32:53 -0500
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3/3] pciehp: Fix race condition handling surprise link-down
Date: Sat, 19 Nov 2016 00:32:47 -0800
Message-Id: <1479544367-7195-4-git-send-email-ashok.raj@intel.com>
In-Reply-To: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A surprise link down may retrain very quickly, causing the same slot to
generate a link up event before handling the link down completes.

Since the link is active, the power off work queued from the first link
down will cause a second down event when the power is disabled. The second
down event should be ignored because the slot is already powering off;
however, the "link up" event sets the slot state to POWERON before the
event to handle this is enqueued, making the second down event believe
it needs to do something. This creates a constant link up and down
event cycle.

This patch fixes that by setting the slot state only when the work to
handle the power event is executing, protected by the hot plug mutex.

Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index ec0b4c1..7ae068c 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -182,6 +182,7 @@ static void pciehp_power_thread(struct work_struct *work)
 	switch (info->req) {
 	case DISABLE_REQ:
 		mutex_lock(&p_slot->hotplug_lock);
+		p_slot->state = POWEROFF_STATE;
 		pciehp_disable_slot(p_slot);
 		mutex_unlock(&p_slot->hotplug_lock);
 		mutex_lock(&p_slot->lock);
@@ -190,6 +191,7 @@ static void pciehp_power_thread(struct work_struct *work)
 		break;
 	case ENABLE_REQ:
 		mutex_lock(&p_slot->hotplug_lock);
+		p_slot->state = POWERON_STATE;
 		ret = pciehp_enable_slot(p_slot);
 		mutex_unlock(&p_slot->hotplug_lock);
 		if (ret)
@@ -209,8 +211,6 @@ static void pciehp_queue_power_work(struct slot *p_slot, int req)
 {
 	struct power_work_info *info;
 
-	p_slot->state = (req == ENABLE_REQ) ? POWERON_STATE : POWEROFF_STATE;
-
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		ctrl_err(p_slot->ctrl, "no memory to queue %s request\n",
-- 
2.7.4

