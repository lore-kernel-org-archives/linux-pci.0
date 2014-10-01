Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45879 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbaJACdv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 22:33:51 -0400
Message-ID: <1412129393.4285.195.camel@pasglop>
Subject: [PATCH 4/4] sounds/hda/radeon: Disable 64-bit DMA on radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Wed, 01 Oct 2014 12:09:53 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The chipset has a limitation in the number of address bits it
can generate. The graphics portion uses a specific mask of
40 or 48 bits depending on the generation. For audio, it's a bit
less of an issue, so just mark them as no-64bit for now.

Without this, it crashes on POWER machines which can use high bits
in the DMA address to distinguish between DMA windows. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: <stable@vger.kernel.org>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3e6d22d..2b679d5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -297,7 +297,7 @@ enum {
 /* quirks for ATI/AMD HDMI */
 #define AZX_DCAPS_PRESET_ATI_HDMI \
 	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
-	 AZX_DCAPS_NO_MSI64)
+	 AZX_DCAPS_NO_MSI64 | AZX_DCAPS_NO_64BIT)
 
 /* quirks for Nvidia */
 #define AZX_DCAPS_PRESET_NVIDIA \


