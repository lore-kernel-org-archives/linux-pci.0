Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from p3plsmtps2ded02.prod.phx3.secureserver.net ([208.109.80.59]:43490
	"EHLO p3plsmtps2ded02.prod.phx3.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755345AbcDAXK1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Apr 2016 19:10:27 -0400
From: Jake Oshins <jakeo@microsoft.com>
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v4 2/7] drivers:hv: Make a function to free mmio regions through vmbus
Date: Fri,  1 Apr 2016 17:47:42 -0700
Message-Id: <1459558067-1725-3-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1459558067-1725-1-git-send-email-jakeo@microsoft.com>
References: <y>
 <1459558067-1725-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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
index 799518b..60553c1 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1188,6 +1188,21 @@ exit:
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
index aa0fadc..ecd81c3 100644
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

