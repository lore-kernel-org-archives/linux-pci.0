Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f74.google.com ([209.85.216.74]:43013 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760425Ab2D0Rlm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Apr 2012 13:41:42 -0400
Received: by qabg24 with SMTP id g24so83592qab.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Apr 2012 10:41:41 -0700 (PDT)
Date: Fri, 27 Apr 2012 11:41:41 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Hao, Xudong" <xudong.hao@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	"Zhang, Xiantao" <xiantao.zhang@intel.com>
Subject: Re: [PATCH v6] Quirk for IVB graphics FLR errata
Message-ID: <20120427174141.GA11634@google.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD24698@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4Dm45uRsvdzSAfrvGNPPA_7QqvC_Se-JxpJErsasoTKw@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD3ABC3@SHSMSX101.ccr.corp.intel.com>
 <CAErSpo4Qm1DP-i2YWc1ZibiUAnPC-tLG9X0xceAvGFxs8e+mPQ@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD8BEA9@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4tUnA6oFr1uXyfVPHQh7F-LMN913pu=MfaEsRi5isLLQ@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD906DD@SHSMSX102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <403610A45A2B5242BD291EDAE8B37D300FD906DD@SHSMSX102.ccr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2012 at 01:26:18AM +0000, Hao, Xudong wrote:
> Maybe something configuration wrong on my mail client, I attach the patch as an attachment, can you open it in your side?

Yes, I could open the attachment.  But it makes it easier for everybody to
read & review your patches if you can figure out how to post patches
directly in the message rather than as an attachment.

Here's an updated version of your patch.  I changed the following:

    - Wrapped changelog text so it fits nicely for "git log".
    - Added #define for 0xd0100 offset (please supply a more useful name).
    - Used pci_iomap() and ioread32()/iowrite32().
    - Used msleep() rather than spinning (Matthew suggested this earlier,
      but you apparently missed it).  Note that I went back to your
      original "do {} while ()" structure to make sure we read PCH_PP_STATUS
      at least once.
    - Added message if reset times out.

This is still x86-specific code that clutters all other architectures.  We
might fix this someday by adding a DECLARE_PCI_FIXUP_RESET(), so the IVB
code could live in arch/x86, and the linker could still collect all the
device-specific reset methods.  But I haven't done that yet.

Please test and comment on this (and supply a name for 0xd0100):

commit 8566df6d83bf89c8cad3810d5d333a31a95b133e
Author: Xudong Hao <xudong.hao@intel.com>
Date:   Fri Apr 27 09:16:46 2012 -0600

    PCI: work around IvyBridge internal graphics FLR erratum
    
    For IvyBridge Mobile platform, a system hang may occur if a FLR (Function
    Level Reset) is asserted to internal graphics.
    
    This quirk is a workaround for the IVB FLR errata issue.  We are
    disabling the FLR reset handshake between the PCH and CPU display, then
    manually powering down the panel power sequencing and resetting the PCH
    display.
    
    Signed-off-by: Xudong Hao <xudong.hao@intel.com>
    Signed-off-by: Kay, Allen M <allen.m.kay@intel.com>
    Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4bf7102..d5646de 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3085,16 +3085,74 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+#include "../gpu/drm/i915/i915_reg.h"
+#define MSG_CTL			0x45010
+#define XXXX			0xd0100
+#define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */
+
+static int reset_ivb_igd(struct pci_dev *dev, int probe)
+{
+	void __iomem *mmio_base;
+	unsigned long timeout;
+	u32 val;
+
+	if (probe)
+		return 0;
+
+	mmio_base = pci_iomap(dev, 0, 0);
+	if (!mmio_base)
+		return -ENOMEM;
+
+	iowrite32(0x00000002, mmio_base + MSG_CTL);
+
+	/*
+	 * Clobbering SOUTH_CHICKEN2 register is fine only if the next
+	 * driver loaded sets the right bits. However, this's a reset and
+	 * the bits have been set by i915 previously, so we clobber
+	 * SOUTH_CHICKEN2 register directly here.
+	 */
+	iowrite32(0x00000005, mmio_base + SOUTH_CHICKEN2);
+
+	val = ioread32(mmio_base + PCH_PP_CONTROL) & 0xfffffffe;
+	iowrite32(val, mmio_base + PCH_PP_CONTROL);
+
+	timeout = jiffies + msecs_to_jiffies(IGD_OPERATION_TIMEOUT);
+	do {
+		val = ioread32(mmio_base + PCH_PP_STATUS);
+		if ((val & 0xB0000000) == 0)
+			goto reset_complete;
+		msleep(10);
+	} while (time_before(jiffies, timeout));
+	dev_warn(&dev->dev, "timeout during reset\n");
+
+reset_complete:
+	iowrite32(0x00000002, mmio_base + XXXX);
+
+	pci_iounmap(dev, mmio_base);
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
 };
 
+/*
+ * These device-specific reset methods are here rather than in a driver
+ * because when a host assigns a device to a guest VM, the host may need
+ * to reset the device but probably doesn't have a driver for it.
+ */
 int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 {
 	const struct pci_dev_reset_methods *i;
