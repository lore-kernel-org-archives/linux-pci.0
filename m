Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 27/27] PCI: Use addon_fixed_resource with ati fixed resource
Date: Wed, 13 Mar 2013 16:28:22 -0700
Message-Id: <1363217302-14383-28-git-send-email-yinghai@kernel.org>
In-Reply-To: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
References: <1363217302-14383-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

After they are put in addon_res list, they will be safely claimed later.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/quirks.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6d379d6..2b4fbad 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -386,10 +386,12 @@ static void quirk_io_region(struct pci_dev *dev, int port,
  */
 static void quirk_ati_exploding_mce(struct pci_dev *dev)
 {
-	dev_info(&dev->dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
+	dev_info(&dev->dev, "ATI Northbridge, will reserve I/O ports 0x3b0 to 0x3bb\n");
 	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
-	request_region(0x3b0, 0x0C, "RadeonIGP");
-	request_region(0x3d3, 0x01, "RadeonIGP");
+	pci_add_dev_addon_fixed_resource(dev, 0x3B0, 0x0C, IORESOURCE_IO, 0,
+					 "RadeonIGP");
+	pci_add_dev_addon_fixed_resource(dev, 0x3d3, 0x01, IORESOURCE_IO, 0,
+					 "RadeonIGP");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
 
-- 
1.7.10.4

