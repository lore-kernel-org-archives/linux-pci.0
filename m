Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jake Oshins <jakeo@microsoft.com>
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 6/7] drivers:hv: Record MMIO range in use by frame buffer
Date: Wed, 30 Mar 2016 16:48:46 -0700
Message-Id: <1459381727-25039-7-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1459381727-25039-1-git-send-email-jakeo@microsoft.com>
References: <y>
 <1459381727-25039-1-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Later in the boot sequence, we need to figure out which memory
ranges can be given out to various paravirtual drivers.  The
hyperv_fb driver should, ideally, be placed right on top of
the frame buffer, without some other device getting plopped on
top of this range in the meantime.  Recording this now allows
that to be guaranteed by the code introduced in the next patch.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index dfc6149..f8fa7b8 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -41,6 +41,7 @@
 #include <linux/ptrace.h>
 #include <linux/screen_info.h>
 #include <linux/kdebug.h>
+#include <linux/efi.h>
 #include "hyperv_vmbus.h"

 static struct acpi_device  *hv_acpi_dev;
@@ -101,6 +102,8 @@ static struct notifier_block hyperv_panic_block = {
 	.notifier_call = hyperv_panic_event,
 };

+static const char *fb_mmio_name = "fb_range";
+static struct resource *fb_mmio;
 struct resource *hyperv_mmio;
 DEFINE_SEMAPHORE(hyperv_mmio_lock);

@@ -1091,6 +1094,12 @@ static int vmbus_acpi_remove(struct acpi_device *device)
 	struct resource *next_res;

 	if (hyperv_mmio) {
+		if (fb_mmio) {
+			__release_region(hyperv_mmio, fb_mmio->start,
+					 fb_mmio->end - fb_mmio->start + 1);
+			fb_mmio = NULL;
+		}
+
 		for (cur_res = hyperv_mmio; cur_res; cur_res = next_res) {
 			next_res = cur_res->sibling;
 			kfree(cur_res);
@@ -1100,6 +1109,30 @@ static int vmbus_acpi_remove(struct acpi_device *device)
 	return 0;
 }

+static void vmbus_reserve_fb(void)
+{
+	int size;
+	/*
+	 * Make a claim for the frame buffer in the resource tree under the
+	 * first node, which will be the one below 4GB.  The length seems to
+	 * be underreported, particularly in a Generation 1 VM.  So start out
+	 * reserving a larger area and make it smaller until it succeeds.
+	 */
+
+	if (screen_info.lfb_base) {
+		if (efi_enabled(EFI_BOOT))
+			size = screen_info.lfb_size;
+		else
+			size = max_t(__u32, screen_info.lfb_size, 0x4000000);
+
+		for (; !fb_mmio && (size >= 0x100000); size >>= 1) {
+			fb_mmio = __request_region(hyperv_mmio,
+						   screen_info.lfb_base, size,
+						   fb_mmio_name, 0);
+		}
+	}
+}
+
 /**
  * vmbus_allocate_mmio() - Pick a memory-mapped I/O range.
  * @new:		If successful, supplied a pointer to the
@@ -1261,8 +1294,10 @@ static int vmbus_acpi_add(struct acpi_device *device)

 		if (ACPI_FAILURE(result))
 			continue;
-		if (hyperv_mmio)
+		if (hyperv_mmio) {
+			vmbus_reserve_fb();
 			break;
+		}
 	}
 	ret_val = 0;

--
1.9.1
