Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jake Oshins <jakeo@microsoft.com>
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v3 1/7] drivers:hv: Lock access to hyperv_mmio resource tree
Date: Fri,  1 Apr 2016 16:11:26 -0700
Message-Id: <1459552292-1297-2-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1459552292-1297-1-git-send-email-jakeo@microsoft.com>
References: <y>
 <1459552292-1297-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In existing code, this tree of resources is created
in single-threaded code and never modified after it is
created, and thus needs no locking.  This patch introduces
a semaphore for tree access, as other patches in this
series introduce run-time modifications of this resource
tree which can happen on multiple threads.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 64713ff..799518b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -102,6 +102,7 @@ static struct notifier_block hyperv_panic_block = {
 };
 
 struct resource *hyperv_mmio;
+DEFINE_SEMAPHORE(hyperv_mmio_lock);
 
 static int vmbus_exists(void)
 {
@@ -1132,7 +1133,10 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 	resource_size_t range_min, range_max, start, local_min, local_max;
 	const char *dev_n = dev_name(&device_obj->device);
 	u32 fb_end = screen_info.lfb_base + (screen_info.lfb_size << 1);
-	int i;
+	int i, retval;
+
+	retval = -ENXIO;
+	down(&hyperv_mmio_lock);
 
 	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
 		if ((iter->start >= max) || (iter->end <= min))
@@ -1169,13 +1173,17 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			for (; start + size - 1 <= local_max; start += align) {
 				*new = request_mem_region_exclusive(start, size,
 								    dev_n);
-				if (*new)
-					return 0;
+				if (*new) {
+					retval = 0;
+					goto exit;
+				}
 			}
 		}
 	}
 
-	return -ENXIO;
+exit:
+	up(&hyperv_mmio_lock);
+	return retval;
 }
 EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
 
-- 
1.9.1
