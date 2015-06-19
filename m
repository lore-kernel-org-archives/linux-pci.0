Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36798 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbbFSWmq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:42:46 -0400
Received: by iecrd14 with SMTP id rd14so83684058iec.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 15:42:46 -0700 (PDT)
Subject: [PATCH 4/6] PCI: Fix Intel generic reset quirk class code check
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dexuan Cui <dexuan.cui@intel.com>, Matthew Wilcox <matthew@wil.cx>,
	x86@kernel.org, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>, Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Jason Chang <jason.chang@amd.com>
Date: Fri, 19 Jun 2015 17:42:43 -0500
Message-ID: <20150619224243.14626.59367.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We checked for "dev->class == PCI_CLASS_SERIAL_USB", but dev->class
contains the entire three-byte base class/sub-class/interface, while
PCI_CLASS_SERIAL_USB is only the two-byte base class/sub-class.

This error meant that we used the Intel device-specific reset on devices
with class code 0x000c03 instead of those with class code 0x0c03xx.
0x000c03 is a reserved value in the 0x00 backwards compatibility base class
and shouldn't match any devices, so I think reset_intel_generic_dev()
always failed.

Shift dev->class to discard the interface byte before comparing with
PCI_CLASS_SERIAL_USB.

Fixes: aeb30016fec3 ("PCI: add Intel USB specific reset method")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Dexuan Cui <dexuan.cui@intel.com>
CC: Yu Zhao <yu.zhao@intel.com>
---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8bc60c2..356a401 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3358,7 +3358,7 @@ static int reset_intel_generic_dev(struct pci_dev *dev, int probe)
 	int pos;
 
 	/* only implement PCI_CLASS_SERIAL_USB at present */
-	if (dev->class == PCI_CLASS_SERIAL_USB) {
+	if ((dev->class >> 8) == PCI_CLASS_SERIAL_USB) {
 		pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
 		if (!pos)
 			return -ENOTTY;

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
