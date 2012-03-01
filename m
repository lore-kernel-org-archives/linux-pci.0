Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44047 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756596Ab2CAEcF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Feb 2012 23:32:05 -0500
From: "Hao, Xudong" <xudong.hao@intel.com>
To: "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Kay, Allen M" <allen.m.kay@intel.com>,
	"Zhang, Xiantao" <xiantao.zhang@intel.com>
Subject: [PATCH V3] Quirk for IVB graphics FLR errata
Date: Thu, 1 Mar 2012 04:30:52 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FCDB487@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For IvyBridge Mobile platform, a system hang may occur if a FLR(Function Level Reset) is asserted to internal graphics.

This quirk patch is workaround for the IVB FLR errata issue.
We are disabling the FLR reset handshake between the PCH and CPU display, then manually powering down the panel power sequencing and resetting the PCH display.

Signed-off-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Kay, Allen M <allen.m.kay@intel.com>
Reviewed-by: Xiantao Zhang <xiantao.zhang@intel.com>
---
 drivers/pci/quirks.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index 6476547..c687218 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -27,6 +27,7 @@
 #include <linux/pci-aspm.h>
 #include <linux/ioport.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
+#include <asm/tsc.h>
 #include "pci.h"
 
 /*
@@ -3069,11 +3070,63 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+#include "../gpu/drm/i915/i915_reg.h"
+#define MSG_CTL	0x45010
+static const int op_timeout = 10;	/* set timeout 10 seconds */
+
+static int reset_ivb_igd(struct pci_dev *dev, int probe) {
+	u8 *mmio_base;
+	u32 val;
+	cycles_t cyc_op_timeout = tsc_khz*op_timeout*1000;
+
+	if (probe)
+		return 0;
+
+	mmio_base = ioremap_nocache(pci_resource_start(dev, 0),
+				 pci_resource_len(dev, 0));
+	if (!mmio_base)
+		return -ENOMEM;
+
+	/* Work Around */
+	*((u32 *)(mmio_base + MSG_CTL)) = 0x00000002;
+	/* Clobbering SOUTH_CHICKEN2 register is fine only if the next
+	 * driver loaded sets the right bits. However, this's a reset and
+	 * the bits have been set by i915 previously, so we clobber
+	 * SOUTH_CHICKEN2 register directly here.
+	 */
+	*((u32 *)(mmio_base + SOUTH_CHICKEN2)) = 0x00000005;
+	val = *((u32 *)(mmio_base + PCH_PP_CONTROL)) & 0xfffffffe;
+	*((u32 *)(mmio_base + PCH_PP_CONTROL)) = val;
+	do {
+		cycles_t start_time = get_cycles();
+		while (1) {
+			val = *((u32 *)(mmio_base + PCH_PP_STATUS));
+			if (((val & 0x80000000) == 0)
+				&& ((val & 0x30000000) == 0))
+				break;
+			if (cyc_op_timeout < (get_cycles() - start_time))
+				break;
+			cpu_relax();
+		}
+	} while (0);
+	*((u32 *)(mmio_base + 0xd0100)) = 0x00000002;
+
+	iounmap(pci_resource_start(dev, 0));
+	return 0;
+}
+
 #define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
+#define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
+#define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
 
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
+		reset_ivb_igd },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
+		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 		reset_intel_generic_dev },
 	{ 0 }
--
1.6.0.rc1


