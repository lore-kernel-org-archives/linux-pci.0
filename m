Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:NVIDIA (rivafb and nvidiafb)
        FRAMEBUFFER DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 27/30] video: fbdev: nvidia: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:31:12 -0500
Message-Id: <1511328675-21981-28-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/nvidia/nv_hw.c    | 10 +++++-----
 drivers/video/fbdev/nvidia/nv_setup.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_hw.c b/drivers/video/fbdev/nvidia/nv_hw.c
index 81c80ac..3374c5d 100644
--- a/drivers/video/fbdev/nvidia/nv_hw.c
+++ b/drivers/video/fbdev/nvidia/nv_hw.c
@@ -686,7 +686,7 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 
 	if ((par->Chipset & 0x0FF0) == 0x01A0) {
 		unsigned int uMClkPostDiv;
-		dev = pci_get_bus_and_slot(0, 3);
+		dev = pci_get_domain_bus_and_slot(0, 0, 3);
 		pci_read_config_dword(dev, 0x6C, &uMClkPostDiv);
 		uMClkPostDiv = (uMClkPostDiv >> 8) & 0xf;
 
@@ -694,7 +694,7 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 			uMClkPostDiv = 4;
 		MClk = 400000 / uMClkPostDiv;
 	} else {
-		dev = pci_get_bus_and_slot(0, 5);
+		dev = pci_get_domain_bus_and_slot(0, 0, 5);
 		pci_read_config_dword(dev, 0x4c, &MClk);
 		MClk /= 1000;
 	}
@@ -707,13 +707,13 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 	sim_data.pix_bpp = (char)pixelDepth;
 	sim_data.enable_video = 0;
 	sim_data.enable_mp = 0;
-	dev = pci_get_bus_and_slot(0, 1);
+	dev = pci_get_domain_bus_and_slot(0, 0, 1);
 	pci_read_config_dword(dev, 0x7C, &sim_data.memory_type);
 	pci_dev_put(dev);
 	sim_data.memory_type = (sim_data.memory_type >> 12) & 1;
 	sim_data.memory_width = 64;
 
-	dev = pci_get_bus_and_slot(0, 3);
+	dev = pci_get_domain_bus_and_slot(0, 0, 3);
 	pci_read_config_dword(dev, 0, &memctrl);
 	pci_dev_put(dev);
 	memctrl >>= 16;
@@ -721,7 +721,7 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 	if ((memctrl == 0x1A9) || (memctrl == 0x1AB) || (memctrl == 0x1ED)) {
 		u32 dimm[3];
 
-		dev = pci_get_bus_and_slot(0, 2);
+		dev = pci_get_domain_bus_and_slot(0, 0, 2);
 		pci_read_config_dword(dev, 0x40, &dimm[0]);
 		dimm[0] = (dimm[0] >> 8) & 0x4f;
 		pci_read_config_dword(dev, 0x44, &dimm[1]);
diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
index 2f2e162..79806ff 100644
--- a/drivers/video/fbdev/nvidia/nv_setup.c
+++ b/drivers/video/fbdev/nvidia/nv_setup.c
@@ -264,7 +264,7 @@ static void nv10GetConfig(struct nvidia_par *par)
 	}
 #endif
 
-	dev = pci_get_bus_and_slot(0, 1);
+	dev = pci_get_domain_bus_and_slot(0, 0, 1);
 	if ((par->Chipset & 0xffff) == 0x01a0) {
 		u32 amt;
 
-- 
1.9.1
