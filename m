Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 1/5] hv: Make a function to free mmio regions through vmbus
Date: Wed, 24 Feb 2016 21:23:58 +0000
Message-Id: <1456349042-16275-2-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
References: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch introduces a function that reverses everything
done by vmbus_allocate_mmio().  Existing code just called
release_mem_region().  Future patches in this series
require a more complex sequence of actions, so this function
is introduced to wrap those actions.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 15 +++++++++++++++
 include/linux/hyperv.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 063e5f5..69393ff 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1221,6 +1221,21 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
 
 /**
+ * vmbus_free_mmio() - Free a memory-mapped I/O range.
+ * @start:		Base address of region to release.
+ * @size:		Size of the range to be allocated
+ *
+ * This function releases anything requested by
+ * vmbus_mmio_allocate().
+ */
+void vmbus_free_mmio(resource_size_t start, resource_size_t size)
+{
+	release_mem_region(start, size);
+
+}
+EXPORT_SYMBOL_GPL(vmbus_free_mmio);
+
+/**
  * vmbus_cpu_number_to_vp_number() - Map CPU to VP.
  * @cpu_number: CPU number in Linux terms
  *
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a32704d..f3e0c71 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1091,7 +1091,7 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
 			resource_size_t min, resource_size_t max,
 			resource_size_t size, resource_size_t align,
 			bool fb_overlap_ok);
-
+void vmbus_free_mmio(resource_size_t start, resource_size_t size);
 int vmbus_cpu_number_to_vp_number(int cpu_number);
 u64 hv_do_hypercall(u64 control, void *input, void *output);
 
-- 
1.9.1
