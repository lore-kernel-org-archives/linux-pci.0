Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:63099 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758699AbcBXV0M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 16:26:12 -0500
From: jakeo@microsoft.com
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 5/5] hv: Track allocations of children of hv_vmbus in private resource tree
Date: Wed, 24 Feb 2016 21:24:02 +0000
Message-Id: <1456349042-16275-6-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
References: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch changes vmbus_allocate_mmio() and vmbus_free_mmio() so
that when child paravirtual devices allocate memory-mapped I/O
space, they allocate it privately from a resource tree pointed
at by hyperv_mmio and also by the public resource tree
iomem_resource.  This allows the region to be marked as "busy"
in the private tree, but a "bridge window" in the public tree,
guaranteeing that no two bridge windows will overlap each other
but while also allowing the PCI device children of the bridge
windows to overlap that window.

One might conclude that this belongs in the pnp layer, rather
than in this driver.  Rafael Wysocki, the maintainter of the
pnp layer, has previously asked that we not modify the pnp layer
as it is considered deprecated.  This patch is thus essentially
a workaround.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b090548..2a7eb3f 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1169,7 +1169,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			resource_size_t size, resource_size_t align,
 			bool fb_overlap_ok)
 {
-	struct resource *iter;
+	struct resource *iter, *shadow;
 	resource_size_t range_min, range_max, start, local_min, local_max;
 	const char *dev_n = dev_name(&device_obj->device);
 	u32 fb_end = screen_info.lfb_base + (screen_info.lfb_size << 1);
@@ -1211,12 +1211,22 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 
 			start = (local_min + align - 1) & ~(align - 1);
 			for (; start + size - 1 <= local_max; start += align) {
+				shadow = __request_region(iter, start,
+							  size,
+							  NULL,
+							  IORESOURCE_BUSY);
+				if (!shadow)
+					continue;
+
 				*new = request_mem_region_exclusive(start, size,
 								    dev_n);
 				if (*new) {
+					shadow->name = (char*)*new;
 					retval = 0;
 					goto exit;
 				}
+
+				__release_region(iter, start, size);
 			}
 		}
 	}
@@ -1237,7 +1247,17 @@ EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
  */
 void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 {
+	struct resource *iter;
+
+	down(&hyperv_mmio_lock);
+	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
+		if ((iter->start >= start + size) || (iter->end <= start))
+			continue;
+
+		__release_region(iter, start, size);
+	}
 	release_mem_region(start, size);
+	up(&hyperv_mmio_lock);
 
 }
 EXPORT_SYMBOL_GPL(vmbus_free_mmio);
-- 
1.9.1

