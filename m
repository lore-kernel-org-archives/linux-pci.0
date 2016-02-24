Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:16255 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758618AbcBXVZ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 16:25:58 -0500
From: jakeo@microsoft.com
To: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, haiyangz@microsoft.com, haddenh@microsoft.com
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 3/5] hv: Use new vmbus_mmio_free() from client drivers.
Date: Wed, 24 Feb 2016 21:24:00 +0000
Message-Id: <1456349042-16275-4-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
References: <1456349042-16275-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

This patch modifies all the callers of vmbus_mmio_allocate()
to call vmbus_mmio_free() instead of release_mem_region().

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c   | 14 +++++++-------
 drivers/video/fbdev/hyperv_fb.c |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 6f77d52..177bbec 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -2034,14 +2034,14 @@ static void hv_pci_free_bridge_windows(struct hv_pcibus_device *hbus)
 
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
 
@@ -2119,8 +2119,8 @@ static int hv_pci_allocate_bridge_windows(struct hv_pcibus_device *hbus)
 
 release_low_mmio:
 	if (hbus->low_mmio_res) {
-		release_mem_region(hbus->low_mmio_res->start,
-				   resource_size(hbus->low_mmio_res));
+		vmbus_free_mmio(hbus->low_mmio_res->start,
+				resource_size(hbus->low_mmio_res));
 	}
 
 	return ret;
@@ -2163,7 +2163,7 @@ static int hv_allocate_config_window(struct hv_pcibus_device *hbus)
 
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
 
-- 
1.9.1

