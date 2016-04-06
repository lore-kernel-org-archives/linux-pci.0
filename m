Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jake Oshins <jakeo@microsoft.com>
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com,
	helgaas@kernel.org
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v5 2/6] drivers:hv: Call vmbus_mmio_free() to reverse vmbus_mmio_allocate()
Date: Tue,  5 Apr 2016 18:18:18 -0700
Message-Id: <1459905502-20798-3-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1459905502-20798-1-git-send-email-jakeo@microsoft.com>
References: <1459905502-20798-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Existing code just called release_mem_region().  Adding a
wrapper around it allows the more complex range tracking
that is introduced later in this patch series.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c          | 15 +++++++++++++++
 drivers/pci/host/pci-hyperv.c   | 14 +++++++-------
 drivers/video/fbdev/hyperv_fb.c |  4 ++--
 include/linux/hyperv.h          |  2 +-
 4 files changed, 25 insertions(+), 10 deletions(-)

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
diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index ed651ba..f2559b6 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1795,14 +1795,14 @@ static void hv_pci_free_bridge_windows(struct hv_pcibus_device *hbus)
 
 	if (hbus->low_mmio_space && hbus->low_mmio_res) {
 		hbus->low_mmio_res->flags |= IORESOURCE_BUSY;
-		release_mem_region(hbus->low_mmio_res->start,
-				   resource_size(hbus->low_mmio_res));
+		vmbus_free_mmio(hbus->low_mmio_res->start,
+				resource_size(hbus->low_mmio_res));
 	}
 
 	if (hbus->high_mmio_space && hbus->high_mmio_res) {
 		hbus->high_mmio_res->flags |= IORESOURCE_BUSY;
-		release_mem_region(hbus->high_mmio_res->start,
-				   resource_size(hbus->high_mmio_res));
+		vmbus_free_mmio(hbus->high_mmio_res->start,
+				resource_size(hbus->high_mmio_res));
 	}
 }
 
@@ -1880,8 +1880,8 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 
 release_low_mmio:
 	if (hbus->low_mmio_res) {
-		release_mem_region(hbus->low_mmio_res->start,
-				   resource_size(hbus->low_mmio_res));
+		vmbus_free_mmio(hbus->low_mmio_res->start,
+				resource_size(hbus->low_mmio_res));
 	}
 
 	return ret;
@@ -1924,7 +1924,7 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
 
 static void hv_free_config_window(struct hv_pcibus_device *hbus)
 {
-	release_mem_region(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
+	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
 }
 
 /**
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index e2451bd..2fd49b2 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -743,7 +743,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 err3:
 	iounmap(fb_virt);
 err2:
-	release_mem_region(par->mem->start, screen_fb_size);
+	vmbus_free_mmio(par->mem->start, screen_fb_size);
 	par->mem = NULL;
 err1:
 	if (!gen2vm)
@@ -758,7 +758,7 @@ static void hvfb_putmem(struct fb_info *info)
 	struct hvfb_par *par = info->par;
 
 	iounmap(info->screen_base);
-	release_mem_region(par->mem->start, screen_fb_size);
+	vmbus_free_mmio(par->mem->start, screen_fb_size);
 	par->mem = NULL;
 }
 
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
