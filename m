Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Insu Yun <wuninsu@gmail.com>
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu,
	changwoo@gatech.edu, Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] hotplug: unlock in error path in acpiphp_enable_slot
Date: Sat, 23 Jan 2016 15:44:19 -0500
Message-Id: <1453581859-19565-1-git-send-email-wuninsu@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In acpiphp_enable_slot, there is a missing unlock path
when error occurred. It needs to be unlocked before returning an error.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index ff53856..0b3e0bf 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -953,8 +953,10 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
 {
 	pci_lock_rescan_remove();
 
-	if (slot->flags & SLOT_IS_GOING_AWAY)
+	if (slot->flags & SLOT_IS_GOING_AWAY) {
+		pci_unlock_rescan_remove();
 		return -ENODEV;
+	}
 
 	/* configure all functions */
 	if (!(slot->flags & SLOT_ENABLED))
-- 
1.9.1

