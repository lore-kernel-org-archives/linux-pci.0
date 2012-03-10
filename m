Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 26/37] PCI, acpiphp: Use acpi_hp_work
Date: Fri,  9 Mar 2012 23:00:26 -0800
Message-Id: <1331362837-10740-27-git-send-email-yinghai@kernel.org>
In-Reply-To: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove local defined acpiphp_hp_work.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/pci/hotplug/acpiphp_glue.c |   42 +++++------------------------------
 1 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 1ca82ae..9f1a195 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -1118,34 +1118,6 @@ check_sub_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
 	return AE_OK ;
 }
 
-struct acpiphp_hp_work {
-	struct work_struct work;
-	acpi_handle handle;
-	u32 type;
-	void *context;
-};
-
-static void alloc_acpiphp_hp_work(acpi_handle handle, u32 type,
-				  void *context,
-				  void (*func)(struct work_struct *work))
-{
-	struct acpiphp_hp_work *hp_work;
-	int ret;
-
-	hp_work = kmalloc(sizeof(*hp_work), GFP_KERNEL);
-	if (!hp_work)
-		return;
-
-	hp_work->handle = handle;
-	hp_work->type = type;
-	hp_work->context = context;
-
-	INIT_WORK(&hp_work->work, func);
-	ret = queue_work(kacpi_hotplug_wq, &hp_work->work);
-	if (!ret)
-		kfree(hp_work);
-}
-
 static void _handle_hotplug_event_bridge(struct work_struct *work)
 {
 	struct acpiphp_bridge *bridge;
@@ -1154,11 +1126,11 @@ static void _handle_hotplug_event_bridge(struct work_struct *work)
 				      .pointer = objname };
 	struct acpi_device *device;
 	int num_sub_bridges = 0;
-	struct acpiphp_hp_work *hp_work;
+	struct acpi_hp_work *hp_work;
 	acpi_handle handle;
 	u32 type;
 
-	hp_work = container_of(work, struct acpiphp_hp_work, work);
+	hp_work = container_of(work, struct acpi_hp_work, work);
 	handle = hp_work->handle;
 	type = hp_work->type;
 
@@ -1260,8 +1232,7 @@ static void handle_hotplug_event_bridge(acpi_handle handle, u32 type,
 	 * For now just re-add this work to the kacpi_hotplug_wq so we
 	 * don't deadlock on hotplug actions.
 	 */
-	alloc_acpiphp_hp_work(handle, type, context,
-			      _handle_hotplug_event_bridge);
+	alloc_acpi_hp_work(handle, type, context, _handle_hotplug_event_bridge);
 }
 
 static void _handle_hotplug_event_func(struct work_struct *work)
@@ -1270,12 +1241,12 @@ static void _handle_hotplug_event_func(struct work_struct *work)
 	char objname[64];
 	struct acpi_buffer buffer = { .length = sizeof(objname),
 				      .pointer = objname };
-	struct acpiphp_hp_work *hp_work;
+	struct acpi_hp_work *hp_work;
 	acpi_handle handle;
 	u32 type;
 	void *context;
 
-	hp_work = container_of(work, struct acpiphp_hp_work, work);
+	hp_work = container_of(work, struct acpi_hp_work, work);
 	handle = hp_work->handle;
 	type = hp_work->type;
 	context = hp_work->context;
@@ -1336,8 +1307,7 @@ static void handle_hotplug_event_func(acpi_handle handle, u32 type,
 	 * For now just re-add this work to the kacpi_hotplug_wq so we
 	 * don't deadlock on hotplug actions.
 	 */
-	alloc_acpiphp_hp_work(handle, type, context,
-			      _handle_hotplug_event_func);
+	alloc_acpi_hp_work(handle, type, context, _handle_hotplug_event_func);
 }
 
 static struct acpi_pci_driver acpi_pci_hp_driver = {
-- 
1.7.7

