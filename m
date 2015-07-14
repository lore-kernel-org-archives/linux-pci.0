Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36649 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbbGNTej (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 15:34:39 -0400
Received: by obnw1 with SMTP id w1so12610590obn.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 12:34:39 -0700 (PDT)
Subject: [PATCH v2 1/5] PCI: Use PCI_CLASS_SERIAL_USB instead of bare number
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, x86@kernel.org,
	Felipe Balbi <balbi@ti.com>, Yu Zhao <yu.zhao@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Matthew Wilcox <willy@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>
Date: Tue, 14 Jul 2015 14:34:36 -0500
Message-ID: <20150714193436.13224.8558.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714193153.13224.40528.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714193153.13224.40528.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

be6646bfbaec ("PCI: Prevent xHCI driver from claiming AMD Nolan USB3 DRD
device") added a quirk to override the PCI class code of the AMD Nolan
device.

Use PCI_CLASS_SERIAL_USB instead of a bare number to improve greppability.
Also add a log message about what we're doing.

No functional change except the new message.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Huang Rui <ray.huang@amd.com>
CC: Jason Chang <jason.chang@amd.com>
CC: Felipe Balbi <balbi@ti.com>
---
 drivers/pci/quirks.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1b9fc4e..ecaad8f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -424,10 +424,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_
  */
 static void quirk_amd_nl_class(struct pci_dev *pdev)
 {
-	/*
-	 * Use 'USB Device' (0x0c03fe) instead of PCI header provided
-	 */
-	pdev->class = 0x0c03fe;
+	u32 class = pdev->class;
+
+	/* Use "USB Device (not host controller)" class */
+	pdev->class = (PCI_CLASS_SERIAL_USB << 8) | 0xfe;
+	dev_info(&pdev->dev, "PCI class overridden (%#08x -> %#08x) so dwc3 driver can claim this instead of xhci\n",
+		 class, pdev->class);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_NL_USB,
 		quirk_amd_nl_class);

