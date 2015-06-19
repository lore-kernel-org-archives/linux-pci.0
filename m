Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33848 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbbFSWmx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 18:42:53 -0400
Received: by igboe5 with SMTP id oe5so26599804igb.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2015 15:42:53 -0700 (PDT)
Subject: [PATCH 5/6] PCI: Simplify reset_intel_generic_dev()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dexuan Cui <dexuan.cui@intel.com>, Matthew Wilcox <matthew@wil.cx>,
	x86@kernel.org, Felipe Balbi <balbi@ti.com>,
	Yu Zhao <yu.zhao@intel.com>, Huang Rui <ray.huang@amd.com>,
	Krzysztof =?utf-8?q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Jason Chang <jason.chang@amd.com>
Date: Fri, 19 Jun 2015 17:42:51 -0500
Message-ID: <20150619224251.14626.51652.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150619223325.14626.66402.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Restructure reset_intel_generic_dev() slightly to return early for non-USB
devices.  That makes the body of the function non-indented.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Dexuan Cui <dexuan.cui@intel.com>
CC: Yu Zhao <yu.zhao@intel.com>
---
 drivers/pci/quirks.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 356a401..ed2763b2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3358,21 +3358,20 @@ static int reset_intel_generic_dev(struct pci_dev *dev, int probe)
 	int pos;
 
 	/* only implement PCI_CLASS_SERIAL_USB at present */
-	if ((dev->class >> 8) == PCI_CLASS_SERIAL_USB) {
-		pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
-		if (!pos)
-			return -ENOTTY;
-
-		if (probe)
-			return 0;
+	if ((dev->class >> 8) != PCI_CLASS_SERIAL_USB)
+		return -ENOTTY;
 
-		pci_write_config_byte(dev, pos + 0x4, 1);
-		msleep(100);
+	pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+	if (!pos)
+		return -ENOTTY;
 
+	if (probe)
 		return 0;
-	} else {
-		return -ENOTTY;
-	}
+
+	pci_write_config_byte(dev, pos + 0x4, 1);
+	msleep(100);
+
+	return 0;
 }
 
 static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
