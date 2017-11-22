Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbdKVFcl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 00:32:41 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:NVIDIA (rivafb and nvidiafb)
        FRAMEBUFFER DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 28/30] video: fbdev: riva: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:31:13 -0500
Message-Id: <1511328675-21981-29-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/riva/nv_driver.c | 4 ++--
 drivers/video/fbdev/riva/riva_hw.c   | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/riva/nv_driver.c b/drivers/video/fbdev/riva/nv_driver.c
index f3694cf..d31f51b 100644
--- a/drivers/video/fbdev/riva/nv_driver.c
+++ b/drivers/video/fbdev/riva/nv_driver.c
@@ -226,12 +226,12 @@ unsigned long riva_get_memlen(struct riva_par *par)
 	case NV_ARCH_30:
 		if(chipset == NV_CHIP_IGEFORCE2) {
 
-			dev = pci_get_bus_and_slot(0, 1);
+			dev = pci_get_domain_bus_and_slot(0, 0, 1);
 			pci_read_config_dword(dev, 0x7C, &amt);
 			pci_dev_put(dev);
 			memlen = (((amt >> 6) & 31) + 1) * 1024;
 		} else if (chipset == NV_CHIP_0x01F0) {
-			dev = pci_get_bus_and_slot(0, 1);
+			dev = pci_get_domain_bus_and_slot(0, 0, 1);
 			pci_read_config_dword(dev, 0x84, &amt);
 			pci_dev_put(dev);
 			memlen = (((amt >> 4) & 127) + 1) * 1024;
diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 8bdf37f..29956df 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -1117,7 +1117,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     unsigned int uMClkPostDiv;
     struct pci_dev *dev;
 
-    dev = pci_get_bus_and_slot(0, 3);
+    dev = pci_get_domain_bus_and_slot(0, 0, 3);
     pci_read_config_dword(dev, 0x6C, &uMClkPostDiv);
     pci_dev_put(dev);
     uMClkPostDiv = (uMClkPostDiv >> 8) & 0xf;
@@ -1132,7 +1132,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     sim_data.enable_video   = 0;
     sim_data.enable_mp      = 0;
 
-    dev = pci_get_bus_and_slot(0, 1);
+    dev = pci_get_domain_bus_and_slot(0, 0, 1);
     pci_read_config_dword(dev, 0x7C, &sim_data.memory_type);
     pci_dev_put(dev);
     sim_data.memory_type    = (sim_data.memory_type >> 12) & 1;
@@ -2118,12 +2118,12 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
      * Fill in chip configuration.
      */
     if(chipset == NV_CHIP_IGEFORCE2) {
-        dev = pci_get_bus_and_slot(0, 1);
+        dev = pci_get_domain_bus_and_slot(0, 0, 1);
         pci_read_config_dword(dev, 0x7C, &amt);
         pci_dev_put(dev);
         chip->RamAmountKBytes = (((amt >> 6) & 31) + 1) * 1024;
     } else if(chipset == NV_CHIP_0x01F0) {
-        dev = pci_get_bus_and_slot(0, 1);
+        dev = pci_get_domain_bus_and_slot(0, 0, 1);
         pci_read_config_dword(dev, 0x84, &amt);
         pci_dev_put(dev);
         chip->RamAmountKBytes = (((amt >> 4) & 127) + 1) * 1024;
-- 
1.9.1
