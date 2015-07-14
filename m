Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35877 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbGNTfF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 15:35:05 -0400
Received: by obnw1 with SMTP id w1so12617626obn.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 12:35:04 -0700 (PDT)
Subject: [PATCH v2 4/5] PCI: Revert aeb30016fec3 ("PCI: add Intel USB
 specific reset method")
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, x86@kernel.org,
	Felipe Balbi <balbi@ti.com>, Yu Zhao <yu.zhao@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Matthew Wilcox <willy@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>
Date: Tue, 14 Jul 2015 14:35:01 -0500
Message-ID: <20150714193501.13224.74481.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714193153.13224.40528.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714193153.13224.40528.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Revert aeb30016fec3 ("PCI: add Intel USB specific reset method").

We checked for "dev->class == PCI_CLASS_SERIAL_USB", but dev->class
contains the entire three-byte base class/sub-class/interface, while
PCI_CLASS_SERIAL_USB is only the two-byte base class/sub-class.

This error meant that we used the Intel device-specific reset on devices
with class code 0x000c03 instead of those with class code 0x0c03xx.
0x000c03 is a reserved value in the 0x00 backwards compatibility base
class and shouldn't match any devices, so I think reset_intel_generic_dev()
always failed.

I considered adding a shift, but I can't test it, so it's as likely to
break something as to fix something.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Yu Zhao <yu.zhao@intel.com>
CC: Mathias Nyman <mathias.nyman@intel.com>
---
 drivers/pci/quirks.c |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9734b42..35f8d40 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3344,28 +3344,6 @@ fs_initcall_sync(pci_apply_final_quirks);
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
  * not available.
  */
-static int reset_intel_generic_dev(struct pci_dev *dev, int probe)
-{
-	int pos;
-
-	/* only implement PCI_CLASS_SERIAL_USB at present */
-	if (dev->class == PCI_CLASS_SERIAL_USB) {
-		pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
-		if (!pos)
-			return -ENOTTY;
-
-		if (probe)
-			return 0;
-
-		pci_write_config_byte(dev, pos + 0x4, 1);
-		msleep(100);
-
-		return 0;
-	} else {
-		return -ENOTTY;
-	}
-}
-
 static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 {
 	/*
@@ -3524,8 +3502,6 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
 		reset_ivb_igd },
-	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
-		reset_intel_generic_dev },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
 	{ 0 }

