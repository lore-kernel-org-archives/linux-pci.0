Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34620 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbbFSWmj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:42:39 -0400
Received: by iebmu5 with SMTP id mu5so83620076ieb.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 15:42:38 -0700 (PDT)
Subject: [PATCH 3/6] PCI: Fix TI816X class code quirk
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dexuan Cui <dexuan.cui@intel.com>, Matthew Wilcox <matthew@wil.cx>,
	x86@kernel.org, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>, Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Jason Chang <jason.chang@amd.com>
Date: Fri, 19 Jun 2015 17:42:36 -0500
Message-ID: <20150619224236.14626.87980.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In fixup_ti816x_class(), we assigned "class = PCI_CLASS_MULTIMEDIA_VIDEO".
But PCI_CLASS_MULTIMEDIA_VIDEO is only the two-byte base class/sub-class
and needs to be shifted to make space for the low-order interface byte.

Shift PCI_CLASS_MULTIMEDIA_VIDEO to set the correct class code.

Fixes: 63c4408074cb ("PCI: Add quirk for setting valid class for TI816X Endpoint")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Hemant Pedanekar <hemantp@ti.com>
---
 drivers/pci/quirks.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 64177a6..8bc60c2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2844,12 +2844,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x3c28, vtd_mask_spec_errors);
 
 static void fixup_ti816x_class(struct pci_dev *dev)
 {
+	u32 class = dev->class;
+
 	/* TI 816x devices do not have class code set when in PCIe boot mode */
-	dev_info(&dev->dev, "Setting PCI class for 816x PCIe device\n");
-	dev->class = PCI_CLASS_MULTIMEDIA_VIDEO;
+	dev->class = PCI_CLASS_MULTIMEDIA_VIDEO << 8;
+	dev_info(&dev->dev, "PCI class overridden (%#08x -> %#08x)\n",
+		 class, dev->class);
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_TI, 0xb800,
-				 PCI_CLASS_NOT_DEFINED, 0, fixup_ti816x_class);
+			      PCI_CLASS_NOT_DEFINED, 0, fixup_ti816x_class);
 
 /* Some PCIe devices do not work reliably with the claimed maximum
  * payload size supported.

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
