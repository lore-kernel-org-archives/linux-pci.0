Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33132 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab3IJXKg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Sep 2013 19:10:36 -0400
Date: Tue, 10 Sep 2013 16:10:43 -0700
From: Todd E Brandt <todd.e.brandt@linux.intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, arjan@linux.intel.com
Subject: [PATCH] Intel pci device quirk remove D3 delay
Message-ID: <20130910231043.GA31857@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The latest Ivy Bridge Intel chipsets have a hardware optimization which
allows on-chip PCI devices to ignore the 10ms delay before entering
or exitting D3 suspend.

This patch implements the optimization as a pci quirk, since we want
tight control over which devices use it. This way we can test each device
individually to be sure there are no issues before we enable the quirk.
The first set of devices are from the Haswell platform, which includes
every PCI device that is on the northbridge and southbridge.

After testing this patch reduces the haswell suspend time from 93 ms to
47 ms and resume time from 160 ms to 64 ms. 

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>

 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e85d230..98ea960 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2955,6 +2955,29 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
 
 /*
+ * PCI devices which are on Intel chips can skip the 10ms delay
+ * before entering D3 mode.
+ */
+static void quirk_remove_d3_delay(struct pci_dev *dev)
+{
+	dev->d3_delay = 0;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0c00, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0412, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0c0c, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c31, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c3a, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c3d, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c2d, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c20, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c18, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c1c, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c26, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c4e, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c02, quirk_remove_d3_delay);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x8c22, quirk_remove_d3_delay);
+
+/*
  * Some devices may pass our check in pci_intx_mask_supported if
  * PCI_COMMAND_INTX_DISABLE works though they actually do not properly
  * support this feature.

