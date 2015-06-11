Return-Path: <linux-kernel-owner@vger.kernel.org>
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	mebersol@microsoft.com, haiyangz@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 2/6] drivers:hv: Move MMIO range picking from hyper_fb.mod to hv_vmbus.mod
Date: Thu, 11 Jun 2015 16:22:23 +0000
Message-Id: <1434039747-44535-3-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
References: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c          | 87 ++++++++++++++++++++++++++++++++++++++++-
 drivers/video/fbdev/hyperv_fb.c | 46 ++++++++++------------
 include/linux/hyperv.h          |  7 +++-
 3 files changed, 112 insertions(+), 28 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d0e8832..067a469 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -39,6 +39,7 @@
 #include <asm/mshyperv.h>
 #include <linux/notifier.h>
 #include <linux/ptrace.h>
+#include <linux/screen_info.h>
 #include "hyperv_vmbus.h"
 
 static struct acpi_device  *hv_acpi_dev;
@@ -73,7 +74,6 @@ static struct notifier_block hyperv_panic_block = {
 };
 
 struct resource *hyperv_mmio;
-EXPORT_SYMBOL_GPL(hyperv_mmio);
 
 static int vmbus_exists(void)
 {
@@ -1073,6 +1073,91 @@ static int vmbus_acpi_remove(struct acpi_device *device)
 	return 0;
 }
 
+/**
+ * This function walks the resources granted to VMBus by the
+ * _CRS object in the ACPI namespace underneath the parent
+ * "bridge" whether that's a root PCI bus in the Generation 1
+ * case or a Module Device in the Generation 2 case.  It then
+ * attempts to allocate from the global MMIO pool in a way that
+ * matches the constraints supplied in these parameters and by
+ * that _CRS.
+ *
+ * @param new - If successful, supplied a pointer to the
+ *            allocated MMIO space.
+ * @param device_obj - Identifies the caller
+ * @param min - Minimum guest physical address of the allocation
+ * @param max - Maximum guest physical address
+ * @param size - Size of the range to be allocated
+ * @param align - Alignment of the range to be allocated
+ * @param fb_overlap_ok - Whether this allocation can be allowed
+ *			to overlap the video frame buffer.
+ *
+ * @return int
+ */
+int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
+			resource_size_t min, resource_size_t max,
+			resource_size_t size, resource_size_t align,
+			bool fb_overlap_ok)
+{
+	struct resource *iter;
+	resource_size_t range_min, range_max, start, local_min, local_max;
+	const char *dev_n = dev_name(&device_obj->device);
+	u32 fb_end = screen_info.lfb_base + (screen_info.lfb_size << 1);
+	int i;
+
+	pr_devel("allocating %llxx bytes alignment %llx in %llx->%llx for %s\n",
+		 size, align, min, max, dev_n);
+
+	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
+
+		if ((iter->start >= max) || (iter->end <= min))
+			continue;
+
+		range_min = iter->start;
+		range_max = iter->end;
+
+		/* If this range overlaps the frame buffer, split it into
+		   two tries. */
+		for (i = 0; i < 2; i++) {
+			local_min = range_min;
+			local_max = range_max;
+			if (fb_overlap_ok || ((range_min >= fb_end) ||
+			      (range_max <= screen_info.lfb_base))) {
+				i++;
+			} else {
+				if ((range_min <= screen_info.lfb_base) &&
+				    (range_max >= screen_info.lfb_base)) {
+
+					/*
+					 * The frame buffer is in this window,
+					 * so trim this into the part that
+					 * preceeds the frame buffer.
+					 */
+					local_max = screen_info.lfb_base-1;
+					range_min = fb_end;
+				} else {
+					range_min = fb_end;
+					continue;
+				}
+			}
+
+			pr_devel("looking between %llx:%llx\n", range_min,
+				 range_max);
+			start = (local_min + align - 1) & ~(align - 1);
+			for (; start + size - 1 <= local_max; start += align) {
+				*new = request_mem_region_exclusive(start, size,
+								    dev_n);
+				if (*new)
+					return 0;
+			}
+		}
+	}
+
+	pr_warn("vmbus_allocate_mmio failed\n");
+	return -ENXIO;
+}
+EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
+
 static int vmbus_acpi_add(struct acpi_device *device)
 {
 	acpi_status result;
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index b54ee1c..e2451bd 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -213,7 +213,7 @@ struct synthvid_msg {
 
 struct hvfb_par {
 	struct fb_info *info;
-	struct resource mem;
+	struct resource *mem;
 	bool fb_ready; /* fb device is ready */
 	struct completion wait;
 	u32 synthvid_version;
@@ -677,26 +677,18 @@ static void hvfb_get_option(struct fb_info *info)
 
 
 /* Get framebuffer memory from Hyper-V video pci space */
-static int hvfb_getmem(struct fb_info *info)
+static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 {
 	struct hvfb_par *par = info->par;
 	struct pci_dev *pdev  = NULL;
 	void __iomem *fb_virt;
 	int gen2vm = efi_enabled(EFI_BOOT);
+	resource_size_t pot_start, pot_end;
 	int ret;
 
-	par->mem.name = KBUILD_MODNAME;
-	par->mem.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
 	if (gen2vm) {
-		ret = allocate_resource(hyperv_mmio, &par->mem,
-					screen_fb_size,
-					0, -1,
-					screen_fb_size,
-					NULL, NULL);
-		if (ret != 0) {
-			pr_err("Unable to allocate framebuffer memory\n");
-			return -ENODEV;
-		}
+		pot_start = 0;
+		pot_end = -1;
 	} else {
 		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
 			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
@@ -709,16 +701,18 @@ static int hvfb_getmem(struct fb_info *info)
 		    pci_resource_len(pdev, 0) < screen_fb_size)
 			goto err1;
 
-		par->mem.end = pci_resource_end(pdev, 0);
-		par->mem.start = par->mem.end - screen_fb_size + 1;
-		ret = request_resource(&pdev->resource[0], &par->mem);
-		if (ret != 0) {
-			pr_err("Unable to request framebuffer memory\n");
-			goto err1;
-		}
+		pot_end = pci_resource_end(pdev, 0);
+		pot_start = pot_end - screen_fb_size + 1;
+	}
+
+	ret = vmbus_allocate_mmio(&par->mem, hdev, pot_start, pot_end,
+				  screen_fb_size, 0x100000, true);
+	if (ret != 0) {
+		pr_err("Unable to allocate framebuffer memory\n");
+		goto err1;
 	}
 
-	fb_virt = ioremap(par->mem.start, screen_fb_size);
+	fb_virt = ioremap(par->mem->start, screen_fb_size);
 	if (!fb_virt)
 		goto err2;
 
@@ -736,7 +730,7 @@ static int hvfb_getmem(struct fb_info *info)
 		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
 	}
 
-	info->fix.smem_start = par->mem.start;
+	info->fix.smem_start = par->mem->start;
 	info->fix.smem_len = screen_fb_size;
 	info->screen_base = fb_virt;
 	info->screen_size = screen_fb_size;
@@ -749,7 +743,8 @@ static int hvfb_getmem(struct fb_info *info)
 err3:
 	iounmap(fb_virt);
 err2:
-	release_resource(&par->mem);
+	release_mem_region(par->mem->start, screen_fb_size);
+	par->mem = NULL;
 err1:
 	if (!gen2vm)
 		pci_dev_put(pdev);
@@ -763,7 +758,8 @@ static void hvfb_putmem(struct fb_info *info)
 	struct hvfb_par *par = info->par;
 
 	iounmap(info->screen_base);
-	release_resource(&par->mem);
+	release_mem_region(par->mem->start, screen_fb_size);
+	par->mem = NULL;
 }
 
 
@@ -794,7 +790,7 @@ static int hvfb_probe(struct hv_device *hdev,
 		goto error1;
 	}
 
-	ret = hvfb_getmem(info);
+	ret = hvfb_getmem(hdev, info);
 	if (ret) {
 		pr_err("No memory for framebuffer\n");
 		goto error2;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 21fa867..ffd98d7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -982,6 +982,11 @@ int __must_check __vmbus_driver_register(struct hv_driver *hv_driver,
 					 const char *mod_name);
 void vmbus_driver_unregister(struct hv_driver *hv_driver);
 
+int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
+			resource_size_t min, resource_size_t max,
+			resource_size_t size, resource_size_t align,
+			bool fb_overlap_ok);
+
 /**
  * VMBUS_DEVICE - macro used to describe a specific hyperv vmbus device
  *
@@ -1245,8 +1250,6 @@ void hv_vss_deinit(void);
 void hv_vss_onchannelcallback(void *);
 void hv_process_channel_removal(struct vmbus_channel *channel, u32 relid);
 
-extern struct resource *hyperv_mmio;
-
 /*
  * Negotiated version with the Host.
  */
-- 
1.9.1

