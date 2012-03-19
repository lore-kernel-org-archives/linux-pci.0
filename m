Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:25634 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162101Ab2CSFuH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2012 01:50:07 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH -v2 26/26] PCI: Use addon_fixed_resource with ati fixed resource
Date: Sun, 18 Mar 2012 22:48:49 -0700
Message-Id: <1332136129-14010-27-git-send-email-yinghai@kernel.org>
In-Reply-To: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
References: <1332136129-14010-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

after they are put in add-on resources, they will be safely claimed later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/quirks.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4561610..76dd901 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -386,10 +386,12 @@ static void __devinit quirk_io_region(struct pci_dev *dev, int port,
  */
 static void __devinit quirk_ati_exploding_mce(struct pci_dev *dev)
 {
-	dev_info(&dev->dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
+	dev_info(&dev->dev, "ATI Northbridge, will reserve I/O ports 0x3b0 to 0x3bb\n");
 	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
-	request_region(0x3b0, 0x0C, "RadeonIGP");
-	request_region(0x3d3, 0x01, "RadeonIGP");
+	add_pci_dev_addon_fixed_resource(dev, 0x3B0, 0x0C, IORESOURCE_IO, 0,
+					 "RadeonIGP");
+	add_pci_dev_addon_fixed_resource(dev, 0x3d3, 0x01, IORESOURCE_IO, 0,
+					 "RadeonIGP");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
 
-- 
1.7.7

