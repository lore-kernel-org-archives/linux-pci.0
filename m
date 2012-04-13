Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:59841 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932287Ab2DMIWW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 04:22:22 -0400
From: "Hao, Xudong" <xudong.hao@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH v5] Quirk for IVB graphics FLR errata
Date: Fri, 13 Apr 2012 08:22:18 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FD0FF14@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For IvyBridge Mobile platform, a system hang may occur if a FLR(Function Level Reset) is asserted to internal graphics.

This quirk patch is workaround for the IVB FLR errata issue.
We are disabling the FLR reset handshake between the PCH and CPU display, then manually powering down the panel power sequencing and resetting the PCH display.

Changes from v4: (based on Matthew and Don's comments)
- using jiffies to set timeout instead of tsc.
- correct type mmio_base variable
- using readl() and writel() to access io.
- correct code style, use spaces around the multiply operator.

Signed-off-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Kay, Allen M <allen.m.kay@intel.com>
Reviewed-by: Xiantao Zhang <xiantao.zhang@intel.com>
---
 drivers/pci/quirks.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index 4bf7102..136d3c4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/ktime.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
+#include <asm/io.h>
 #include "pci.h"
 
 /*
@@ -3085,11 +3086,63 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+#include "../gpu/drm/i915/i915_reg.h"
+#define MSG_CTL	0x45010
+#define IGD_OPERATION_TIMEOUT 10000     /* set timeout 10 seconds */
+
+static int reset_ivb_igd(struct pci_dev *dev, int probe) {
+	void __iomem *mmio_base;
+	unsigned long timeout;
+	u32 val;
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
+	writel(0x00000002, mmio_base + MSG_CTL);
+	/* Clobbering SOUTH_CHICKEN2 register is fine only if the next
+	 * driver loaded sets the right bits. However, this's a reset and
+	 * the bits have been set by i915 previously, so we clobber
+	 * SOUTH_CHICKEN2 register directly here.
+	 */
+	writel(0x00000005, mmio_base + SOUTH_CHICKEN2);
+	val = readl(mmio_base + PCH_PP_CONTROL) & 0xfffffffe;
+	writel(val, mmio_base + PCH_PP_CONTROL);
+	do {
+		timeout = jiffies + msecs_to_jiffies(IGD_OPERATION_TIMEOUT);
+		while (1) {
+			val = readl(mmio_base + PCH_PP_STATUS);
+			if (((val & 0x80000000) == 0)
+				&& ((val & 0x30000000) == 0))
+				break;
+			if (time_after(jiffies, timeout))
+				break;
+			cpu_relax();
+		}
+	} while (0);
+	writel(0x00000002, mmio_base + 0xd0100);
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

