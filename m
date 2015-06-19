Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36518 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbFSWmZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:42:25 -0400
Received: by igbiq7 with SMTP id iq7so23932480igb.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 15:42:25 -0700 (PDT)
Subject: [PATCH 1/6] PCI: Use PCI_CLASS_SERIAL_USB instead of bare number
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dexuan Cui <dexuan.cui@intel.com>, Matthew Wilcox <matthew@wil.cx>,
	x86@kernel.org, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>, Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Jason Chang <jason.chang@amd.com>
Date: Fri, 19 Jun 2015 17:42:23 -0500
Message-ID: <20150619224223.14626.20847.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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
CC: Huang Rui <ray.huang@amd.com>
CC: Jason Chang <jason.chang@amd.com>
CC: Felipe Balbi <balbi@ti.com>
---
 drivers/pci/quirks.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index cbe0351..2dab425 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
