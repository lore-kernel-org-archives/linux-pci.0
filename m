Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 5/5] PCI: Remove includes of asm/pci-bridge.h
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Tue, 02 Feb 2016 13:39:02 -0600
Message-ID: <20160202193902.9258.7816.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Drivers should include asm/pci-bridge.h only when they need the arch-
specific things provided there.  Outside of the arch/ directories, the only
drivers that actually need things provided by asm/pci-bridge.h are the
powerpc RPA hotplug drivers in drivers/pci/hotplug/rpa*.

Remove the includes of asm/pci-bridge.h from the other drivers, adding an
include of linux/pci.h if necessary.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/ata/pata_macio.c                   |    2 +-
 drivers/char/agp/uninorth-agp.c            |    1 -
 drivers/gpu/drm/radeon/radeon_combios.c    |    1 -
 drivers/ide/pdc202xx_new.c                 |    1 -
 drivers/ide/pmac.c                         |    1 -
 drivers/macintosh/macio_asic.c             |    1 -
 drivers/misc/cxl/pci.c                     |    1 -
 drivers/net/ethernet/sun/sungem.c          |    1 -
 drivers/net/ethernet/toshiba/spider_net.c  |    1 -
 drivers/scsi/mac53c94.c                    |    2 +-
 drivers/scsi/mesh.c                        |    2 +-
 drivers/usb/core/hcd-pci.c                 |    1 -
 drivers/video/fbdev/aty/aty128fb.c         |    1 -
 drivers/video/fbdev/aty/radeon_base.c      |    1 -
 drivers/video/fbdev/imsttfb.c              |    1 -
 drivers/video/fbdev/matrox/matroxfb_base.h |    1 -
 drivers/video/fbdev/offb.c                 |    4 ----
 sound/ppc/pmac.c                           |    1 -
 18 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index e3d4b05..e347e7a 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -22,6 +22,7 @@
 #include <linux/scatterlist.h>
 #include <linux/of.h>
 #include <linux/gfp.h>
+#include <linux/pci.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
@@ -30,7 +31,6 @@
 #include <asm/macio.h>
 #include <asm/io.h>
 #include <asm/dbdma.h>
-#include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/mediabay.h>
diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 0575544..fdced54 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -10,7 +10,6 @@
 #include <linux/delay.h>
 #include <linux/vmalloc.h>
 #include <asm/uninorth.h>
-#include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <asm/pmac_feature.h>
 #include "agp.h"
diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index a9b01bc..432480f 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -34,7 +34,6 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #endif /* CONFIG_PPC_PMAC */
 
 /* from radeon_legacy_encoder.c */
diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 9ad014a..b33646b 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -28,7 +28,6 @@
 
 #ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #endif
 
 #define DRV_NAME "pdc202xx_new"
diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 96a3452..7f0434f 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -40,7 +40,6 @@
 #include <asm/io.h>
 #include <asm/dbdma.h>
 #include <asm/ide.h>
-#include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/sections.h>
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 4f12c6f..b6819f0 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -31,7 +31,6 @@
 #include <asm/macio.h>
 #include <asm/pmac_feature.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 
 #undef DEBUG
 
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 4c1903f..a214032 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -19,7 +19,6 @@
 #include <linux/delay.h>
 #include <asm/opal.h>
 #include <asm/msi_bitmap.h>
-#include <asm/pci-bridge.h> /* for struct pci_controller */
 #include <asm/pnv-pci.h>
 #include <asm/io.h>
 
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index e23a642..2437227 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -51,7 +51,6 @@
 #endif
 
 #ifdef CONFIG_PPC_PMAC
-#include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 3c54a2c..6761027 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -48,7 +48,6 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/bitops.h>
-#include <asm/pci-bridge.h>
 #include <net/checksum.h>
 
 #include "spider_net.h"
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 1412266..a6682c5 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -18,11 +18,11 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <asm/dbdma.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include <asm/macio.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 555367f..1753e42 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <linux/spinlock.h>
+#include <linux/pci.h>
 #include <asm/dbdma.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -38,7 +39,6 @@
 #include <asm/processor.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
-#include <asm/pci-bridge.h>
 #include <asm/macio.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index 9eb1cff..c3640f8 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -28,7 +28,6 @@
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
-#include <asm/pci-bridge.h>
 #include <asm/prom.h>
 #endif
 
diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index c42ce2f..0a46268 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -68,7 +68,6 @@
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include "../macmodes.h"
 #endif
 
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index ce0b1d0..218339a 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -76,7 +76,6 @@
 
 #ifdef CONFIG_PPC
 
-#include <asm/pci-bridge.h>
 #include "../macmodes.h"
 
 #ifdef CONFIG_BOOTX_TEXT
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 9b167f7..4363c64 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -33,7 +33,6 @@
 #if defined(CONFIG_PPC)
 #include <linux/nvram.h>
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include "macmodes.h"
 #endif
 
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h b/drivers/video/fbdev/matrox/matroxfb_base.h
index 09b02cd..7a90ea2 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.h
+++ b/drivers/video/fbdev/matrox/matroxfb_base.h
@@ -47,7 +47,6 @@
 
 #if defined(CONFIG_PPC_PMAC)
 #include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include "../macmodes.h"
 #endif
 
diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 43a0a52..fb60a8f 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -28,10 +28,6 @@
 #include <linux/pci.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_PPC64
-#include <asm/pci-bridge.h>
-#endif
-
 #ifdef CONFIG_PPC32
 #include <asm/bootx.h>
 #endif
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 0095a80..a5843fc 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -34,7 +34,6 @@
 #include "pmac.h"
 #include <sound/pcm_params.h>
 #include <asm/pmac_feature.h>
-#include <asm/pci-bridge.h>
 
 
 /* fixed frequency table for awacs, screamer, burgundy, DACA (44100 max) */
