Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:38480 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbbFORIS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2015 13:08:18 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org, pebolle@tiscali.nl,
	haiyangz@microsoft.com, mebersol@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 1/6] drivers:hv: Modify vmbus to search for all MMIO ranges available
Date: Mon, 15 Jun 2015 17:06:34 +0000
Message-Id: <1434387999-1885-2-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
References: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

Before this patch, hv_vmbus would search the ACPI namespace above its
device looking for a _CRS (current resources) object, and hunt through
the list of resources in there looking for one that described memory-
mapped I/O space above the 4GB line.  It then exported the result for
use in the hyperv_fb (frame buffer) driver.

With this patch, hv_vmbus looks for all usable MMIO ranges above 1GB
and makes a list of them, with the highest range first in the list,
as drivers which can allocate from that range should allocate from it.

Hyperv_fb is slightly modified to use this change.

This change is necessary for supporting other Hyper-V related drivers,
which might need MMIO space below 4GB.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c          | 105 ++++++++++++++++++++++++++++++++++------
 drivers/video/fbdev/hyperv_fb.c |   2 +-
 include/linux/hyperv.h          |   2 +-
 3 files changed, 92 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c85235e..d0e8832 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -72,10 +72,7 @@ static struct notifier_block hyperv_panic_block = {
 	.notifier_call = hyperv_panic_event,
 };
 
-struct resource hyperv_mmio = {
-	.name  = "hyperv mmio",
-	.flags = IORESOURCE_MEM,
-};
+struct resource *hyperv_mmio;
 EXPORT_SYMBOL_GPL(hyperv_mmio);
 
 static int vmbus_exists(void)
@@ -982,30 +979,105 @@ void vmbus_device_unregister(struct hv_device *device_obj)
 
 
 /*
- * VMBUS is an acpi enumerated device. Get the the information we
+ * VMBUS is an acpi enumerated device. Get the information we
  * need from DSDT.
  */
-
+#define VTPM_BASE_ADDRESS 0xfed40000
 static acpi_status vmbus_walk_resources(struct acpi_resource *res, void *ctx)
 {
+	resource_size_t start = 0;
+	resource_size_t end = 0;
+	struct resource *new_res;
+	struct resource **old_res = &hyperv_mmio;
+	struct resource **prev_res = NULL;
+
 	switch (res->type) {
 	case ACPI_RESOURCE_TYPE_IRQ:
 		irq = res->data.irq.interrupts[0];
+		return AE_OK;
+
+	/*
+	 * "Address" descriptors are for bus windows. Ignore
+	 * "memory" descriptors, which are for registers on
+	 * devices.
+	 */
+	case ACPI_RESOURCE_TYPE_ADDRESS32:
+		start = res->data.address32.address.minimum;
+		end = res->data.address32.address.maximum;
 		break;
 
 	case ACPI_RESOURCE_TYPE_ADDRESS64:
-		hyperv_mmio.start = res->data.address64.address.minimum;
-		hyperv_mmio.end = res->data.address64.address.maximum;
+		start = res->data.address64.address.minimum;
+		end = res->data.address64.address.maximum;
 		break;
+
+	default:
+		/* Unused resource type */
+		return AE_OK;
+
 	}
+	/*
+	 * Ignore ranges that are below 1MB, as they're not
+	 * necessary or useful here.
+	 */
+	if (end < 0x100000)
+		return AE_OK;
+
+	new_res = kzalloc(sizeof(*new_res), GFP_ATOMIC);
+	if (!new_res)
+		return AE_NO_MEMORY;
+
+	/* If this range overlaps the virtual TPM, truncate it. */
+	if (end > VTPM_BASE_ADDRESS && start < VTPM_BASE_ADDRESS)
+		end = VTPM_BASE_ADDRESS;
+
+	new_res->name = "hyperv mmio";
+	new_res->flags = IORESOURCE_MEM;
+	new_res->start = start;
+	new_res->end = end;
+
+	do {
+		if (!*old_res) {
+			*old_res = new_res;
+			break;
+		}
+
+		if ((*old_res)->end < new_res->start) {
+			new_res->sibling = *old_res;
+			if (prev_res)
+				(*prev_res)->sibling = new_res;
+			*old_res = new_res;
+			break;
+		}
+
+		prev_res = old_res;
+		old_res = &(*old_res)->sibling;
+
+	} while (1);
 
 	return AE_OK;
 }
 
+static int vmbus_acpi_remove(struct acpi_device *device)
+{
+	struct resource *cur_res;
+	struct resource *next_res;
+
+	if (hyperv_mmio) {
+		for (cur_res = hyperv_mmio; cur_res; cur_res = next_res) {
+			next_res = cur_res->sibling;
+			kfree(cur_res);
+		}
+	}
+
+	return 0;
+}
+
 static int vmbus_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
 	int ret_val = -ENODEV;
+	struct acpi_device *ancestor;
 
 	hv_acpi_dev = device;
 
@@ -1015,23 +1087,25 @@ static int vmbus_acpi_add(struct acpi_device *device)
 	if (ACPI_FAILURE(result))
 		goto acpi_walk_err;
 	/*
-	 * The parent of the vmbus acpi device (Gen2 firmware) is the VMOD that
-	 * has the mmio ranges. Get that.
+	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
+	 * firmware) is the VMOD that has the mmio ranges. Get that.
 	 */
-	if (device->parent) {
-		result = acpi_walk_resources(device->parent->handle,
+	for (ancestor = device->parent; ancestor; ancestor = ancestor->parent) {
+		result = acpi_walk_resources(ancestor->handle,
 					METHOD_NAME__CRS,
 					vmbus_walk_resources, NULL);
 
 		if (ACPI_FAILURE(result))
-			goto acpi_walk_err;
-		if (hyperv_mmio.start && hyperv_mmio.end)
-			request_resource(&iomem_resource, &hyperv_mmio);
+			continue;
+		if (hyperv_mmio)
+			break;
 	}
 	ret_val = 0;
 
 acpi_walk_err:
 	complete(&probe_event);
+	if (ret_val)
+		vmbus_acpi_remove(device);
 	return ret_val;
 }
 
@@ -1047,6 +1121,7 @@ static struct acpi_driver vmbus_acpi_driver = {
 	.ids = vmbus_acpi_device_ids,
 	.ops = {
 		.add = vmbus_acpi_add,
+		.remove = vmbus_acpi_remove,
 	},
 };
 
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 807ee22..b54ee1c 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -688,7 +688,7 @@ static int hvfb_getmem(struct fb_info *info)
 	par->mem.name = KBUILD_MODNAME;
 	par->mem.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	if (gen2vm) {
-		ret = allocate_resource(&hyperv_mmio, &par->mem,
+		ret = allocate_resource(hyperv_mmio, &par->mem,
 					screen_fb_size,
 					0, -1,
 					screen_fb_size,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 902c37a..21fa867 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1245,7 +1245,7 @@ void hv_vss_deinit(void);
 void hv_vss_onchannelcallback(void *);
 void hv_process_channel_removal(struct vmbus_channel *channel, u32 relid);
 
-extern struct resource hyperv_mmio;
+extern struct resource *hyperv_mmio;
 
 /*
  * Negotiated version with the Host.
-- 
1.9.1

