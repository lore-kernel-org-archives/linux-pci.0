Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34182 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbbGNTfM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 15:35:12 -0400
Received: by obre1 with SMTP id e1so12683079obr.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 12:35:12 -0700 (PDT)
Subject: [PATCH v2 5/5] PCI: Shift PCI_CLASS_NOT_DEFINED consistently with
 other classes
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, x86@kernel.org,
	Felipe Balbi <balbi@ti.com>, Yu Zhao <yu.zhao@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Matthew Wilcox <willy@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>
Date: Tue, 14 Jul 2015 14:35:09 -0500
Message-ID: <20150714193509.13224.80127.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714193153.13224.40528.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714193153.13224.40528.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI class in dev->class is a three-byte value comprising a base class,
sub-class, and interface type.  PCI_CLASS_NOT_DEFINED includes the base
class and sub-class, but not the interface type, so it should be shifted to
make space for the interface.  It happens that PCI_CLASS_NOT_DEFINED is
zero, so it doesn't matter in the end, but we should still use it
consistently with other class definitions.

Treat PCI_CLASS_NOT_DEFINED as a base class/sub-class value that should
appear in bits 8-23 of dev->class.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c  |    2 +-
 drivers/pci/quirks.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636..71bd520 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1268,7 +1268,7 @@ int pci_setup_device(struct pci_dev *dev)
 	bad:
 		dev_err(&dev->dev, "ignoring class %#08x (doesn't match header type %02x)\n",
 			dev->class, dev->hdr_type);
-		dev->class = PCI_CLASS_NOT_DEFINED;
+		dev->class = PCI_CLASS_NOT_DEFINED << 8;
 	}
 
 	/* We found a fine healthy device, go go go... */
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 35f8d40..32cc9c8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2843,7 +2843,7 @@ static void fixup_ti816x_class(struct pci_dev *dev)
 		 class, dev->class);
 }
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_TI, 0xb800,
-			      PCI_CLASS_NOT_DEFINED, 0, fixup_ti816x_class);
+			      PCI_CLASS_NOT_DEFINED, 8, fixup_ti816x_class);
 
 /* Some PCIe devices do not work reliably with the claimed maximum
  * payload size supported.
@@ -3661,13 +3661,13 @@ static void quirk_tw686x_class(struct pci_dev *pdev)
 	dev_info(&pdev->dev, "TW686x PCI class overridden (%#08x -> %#08x)\n",
 		 class, pdev->class);
 }
-DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6864, PCI_CLASS_NOT_DEFINED, 0,
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6864, PCI_CLASS_NOT_DEFINED, 8,
 			      quirk_tw686x_class);
-DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6865, PCI_CLASS_NOT_DEFINED, 0,
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6865, PCI_CLASS_NOT_DEFINED, 8,
 			      quirk_tw686x_class);
-DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6868, PCI_CLASS_NOT_DEFINED, 0,
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6868, PCI_CLASS_NOT_DEFINED, 8,
 			      quirk_tw686x_class);
-DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 0,
+DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 8,
 			      quirk_tw686x_class);
 
 /*

