Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbdKVWuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 17:50:50 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org (open list:NVIDIA (rivafb and nvidiafb)
        FRAMEBUFFER DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 26/29] video: fbdev: nvidia: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:21 -0500
Message-Id: <1511390964-9979-27-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

struct nvidia_par has a pointer to struct pci_dev. Use the pci_dev
member to extract the domain information and pass it to
pci_get_domain_bus_and_slot() function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/nvidia/nv_hw.c    | 11 ++++++-----
 drivers/video/fbdev/nvidia/nv_setup.c |  3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_hw.c b/drivers/video/fbdev/nvidia/nv_hw.c
index 81c80ac..33f3110 100644
--- a/drivers/video/fbdev/nvidia/nv_hw.c
+++ b/drivers/video/fbdev/nvidia/nv_hw.c
@@ -683,10 +683,11 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 	nv10_sim_state sim_data;
 	unsigned int M, N, P, pll, MClk, NVClk, memctrl;
 	struct pci_dev *dev;
+	u32 domain = pci_domain_nr(par->pci_dev->bus);
 
 	if ((par->Chipset & 0x0FF0) == 0x01A0) {
 		unsigned int uMClkPostDiv;
-		dev = pci_get_bus_and_slot(0, 3);
+		dev = pci_get_domain_bus_and_slot(domain, 0, 3);
 		pci_read_config_dword(dev, 0x6C, &uMClkPostDiv);
 		uMClkPostDiv = (uMClkPostDiv >> 8) & 0xf;
 
@@ -694,7 +695,7 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 			uMClkPostDiv = 4;
 		MClk = 400000 / uMClkPostDiv;
 	} else {
-		dev = pci_get_bus_and_slot(0, 5);
+		dev = pci_get_domain_bus_and_slot(domain, 0, 5);
 		pci_read_config_dword(dev, 0x4c, &MClk);
 		MClk /= 1000;
 	}
@@ -707,13 +708,13 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 	sim_data.pix_bpp = (char)pixelDepth;
 	sim_data.enable_video = 0;
 	sim_data.enable_mp = 0;
-	dev = pci_get_bus_and_slot(0, 1);
+	dev = pci_get_domain_bus_and_slot(domain, 0, 1);
 	pci_read_config_dword(dev, 0x7C, &sim_data.memory_type);
 	pci_dev_put(dev);
 	sim_data.memory_type = (sim_data.memory_type >> 12) & 1;
 	sim_data.memory_width = 64;
 
-	dev = pci_get_bus_and_slot(0, 3);
+	dev = pci_get_domain_bus_and_slot(domain, 0, 3);
 	pci_read_config_dword(dev, 0, &memctrl);
 	pci_dev_put(dev);
 	memctrl >>= 16;
@@ -721,7 +722,7 @@ static void nForceUpdateArbitrationSettings(unsigned VClk,
 	if ((memctrl == 0x1A9) || (memctrl == 0x1AB) || (memctrl == 0x1ED)) {
 		u32 dimm[3];
 
-		dev = pci_get_bus_and_slot(0, 2);
+		dev = pci_get_domain_bus_and_slot(domain, 0, 2);
 		pci_read_config_dword(dev, 0x40, &dimm[0]);
 		dimm[0] = (dimm[0] >> 8) & 0x4f;
 		pci_read_config_dword(dev, 0x44, &dimm[1]);
diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
index 2f2e162..b17acd2 100644
--- a/drivers/video/fbdev/nvidia/nv_setup.c
+++ b/drivers/video/fbdev/nvidia/nv_setup.c
@@ -264,7 +264,8 @@ static void nv10GetConfig(struct nvidia_par *par)
 	}
 #endif
 
-	dev = pci_get_bus_and_slot(0, 1);
+	dev = pci_get_domain_bus_and_slot(pci_domain_nr(par->pci_dev->bus),
+					  0, 1);
 	if ((par->Chipset & 0xffff) == 0x01a0) {
 		u32 amt;
 
-- 
1.9.1
