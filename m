Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, Sinan Kaya <okaya@codeaurora.org>,
        Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:NVIDIA (rivafb and nvidiafb)
        FRAMEBUFFER DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 27/29] video: fbdev: riva: deprecate pci_get_bus_and_slot()
Date: Mon, 27 Nov 2017 11:58:04 -0500
Message-Id: <1511801886-6753-28-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

struct riva_par has a pointer to struct pci_dev. Use the pci_dev member
to extract the domain information.

Change the function signature for CalcStateExt and RivaGetConfig to pass
in struct pci_dev in addition to RIVA_HW_INST so that code inside the
riva_hw.c can also calculate domain number and pass it to
pci_get_domain_bus_and_slot().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/riva/fbdev.c     |  2 +-
 drivers/video/fbdev/riva/nv_driver.c |  7 ++++---
 drivers/video/fbdev/riva/riva_hw.c   | 20 +++++++++++++-------
 drivers/video/fbdev/riva/riva_hw.h   |  3 ++-
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 1ea78bb..ff82823 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -780,7 +780,7 @@ static int riva_load_video_mode(struct fb_info *info)
 	else
 		newmode.misc_output |= 0x80;	
 
-	rc = CalcStateExt(&par->riva, &newmode.ext, bpp, width,
+	rc = CalcStateExt(&par->riva, &newmode.ext, par->pdev, bpp, width,
 			  hDisplaySize, height, dotClock);
 	if (rc)
 		goto out;
diff --git a/drivers/video/fbdev/riva/nv_driver.c b/drivers/video/fbdev/riva/nv_driver.c
index f3694cf..a3d9c66 100644
--- a/drivers/video/fbdev/riva/nv_driver.c
+++ b/drivers/video/fbdev/riva/nv_driver.c
@@ -159,6 +159,7 @@ unsigned long riva_get_memlen(struct riva_par *par)
 	unsigned int chipset = par->Chipset;
 	struct pci_dev* dev;
 	u32 amt;
+	int domain = pci_domain_nr(par->pdev->bus);
 
 	switch (chip->Architecture) {
 	case NV_ARCH_03:
@@ -226,12 +227,12 @@ unsigned long riva_get_memlen(struct riva_par *par)
 	case NV_ARCH_30:
 		if(chipset == NV_CHIP_IGEFORCE2) {
 
-			dev = pci_get_bus_and_slot(0, 1);
+			dev = pci_get_domain_bus_and_slot(domain, 0, 1);
 			pci_read_config_dword(dev, 0x7C, &amt);
 			pci_dev_put(dev);
 			memlen = (((amt >> 6) & 31) + 1) * 1024;
 		} else if (chipset == NV_CHIP_0x01F0) {
-			dev = pci_get_bus_and_slot(0, 1);
+			dev = pci_get_domain_bus_and_slot(domain, 0, 1);
 			pci_read_config_dword(dev, 0x84, &amt);
 			pci_dev_put(dev);
 			memlen = (((amt >> 4) & 127) + 1) * 1024;
@@ -417,6 +418,6 @@ unsigned long riva_get_maxdclk(struct riva_par *par)
 	}
 	par->riva.flatPanel = (par->FlatPanel > 0) ? TRUE : FALSE;
 
-	RivaGetConfig(&par->riva, par->Chipset);
+	RivaGetConfig(&par->riva, par->pdev, par->Chipset);
 }
 
diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 8bdf37f..0601c13 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -1108,7 +1108,8 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     unsigned      pixelDepth,
     unsigned     *burst,
     unsigned     *lwm,
-    RIVA_HW_INST *chip
+    RIVA_HW_INST *chip,
+    struct pci_dev *pdev
 )
 {
     nv10_fifo_info fifo_data;
@@ -1116,8 +1117,9 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     unsigned int M, N, P, pll, MClk, NVClk;
     unsigned int uMClkPostDiv;
     struct pci_dev *dev;
+    int domain = pci_domain_nr(pdev->bus);
 
-    dev = pci_get_bus_and_slot(0, 3);
+    dev = pci_get_domain_bus_and_slot(domain, 0, 3);
     pci_read_config_dword(dev, 0x6C, &uMClkPostDiv);
     pci_dev_put(dev);
     uMClkPostDiv = (uMClkPostDiv >> 8) & 0xf;
@@ -1132,7 +1134,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
     sim_data.enable_video   = 0;
     sim_data.enable_mp      = 0;
 
-    dev = pci_get_bus_and_slot(0, 1);
+    dev = pci_get_domain_bus_and_slot(domain, 0, 1);
     pci_read_config_dword(dev, 0x7C, &sim_data.memory_type);
     pci_dev_put(dev);
     sim_data.memory_type    = (sim_data.memory_type >> 12) & 1;
@@ -1234,6 +1236,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
 (
     RIVA_HW_INST  *chip,
     RIVA_HW_STATE *state,
+    struct pci_dev *pdev,
     int            bpp,
     int            width,
     int            hDisplaySize,
@@ -1300,7 +1303,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
                                           pixelDepth * 8,
                                          &(state->arbitration0),
                                          &(state->arbitration1),
-                                          chip);
+                                          chip, pdev);
             } else {
                 nv10UpdateArbitrationSettings(VClk, 
                                           pixelDepth * 8, 
@@ -2102,10 +2105,12 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
 static void nv10GetConfig
 (
     RIVA_HW_INST *chip,
+    struct pci_dev *pdev,
     unsigned int chipset
 )
 {
     struct pci_dev* dev;
+    int domain = pci_domain_nr(pdev->bus);
     u32 amt;
 
 #ifdef __BIG_ENDIAN
@@ -2118,12 +2123,12 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
      * Fill in chip configuration.
      */
     if(chipset == NV_CHIP_IGEFORCE2) {
-        dev = pci_get_bus_and_slot(0, 1);
+        dev = pci_get_domain_bus_and_slot(domain, 0, 1);
         pci_read_config_dword(dev, 0x7C, &amt);
         pci_dev_put(dev);
         chip->RamAmountKBytes = (((amt >> 6) & 31) + 1) * 1024;
     } else if(chipset == NV_CHIP_0x01F0) {
-        dev = pci_get_bus_and_slot(0, 1);
+        dev = pci_get_domain_bus_and_slot(domain, 0, 1);
         pci_read_config_dword(dev, 0x84, &amt);
         pci_dev_put(dev);
         chip->RamAmountKBytes = (((amt >> 4) & 127) + 1) * 1024;
@@ -2224,6 +2229,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
 int RivaGetConfig
 (
     RIVA_HW_INST *chip,
+    struct pci_dev *pdev,
     unsigned int chipset
 )
 {
@@ -2245,7 +2251,7 @@ static char nv3_get_param(nv3_fifo_info *res_info, nv3_sim_state * state, nv3_ar
         case NV_ARCH_10:
         case NV_ARCH_20:
         case NV_ARCH_30:
-            nv10GetConfig(chip, chipset);
+            nv10GetConfig(chip, pdev, chipset);
             break;
         default:
             return (-1);
diff --git a/drivers/video/fbdev/riva/riva_hw.h b/drivers/video/fbdev/riva/riva_hw.h
index c2769f7..5e7b354 100644
--- a/drivers/video/fbdev/riva/riva_hw.h
+++ b/drivers/video/fbdev/riva/riva_hw.h
@@ -536,6 +536,7 @@
 (
     RIVA_HW_INST  *chip,
     RIVA_HW_STATE *state,
+    struct pci_dev *pdev,
     int            bpp,
     int            width,
     int            hDisplaySize,
@@ -546,7 +547,7 @@
 /*
  * External routines.
  */
-int RivaGetConfig(RIVA_HW_INST *, unsigned int);
+int RivaGetConfig(RIVA_HW_INST *chip, struct pci_dev *pdev, unsigned int c);
 /*
  * FIFO Free Count. Should attempt to yield processor if RIVA is busy.
  */
-- 
1.9.1
