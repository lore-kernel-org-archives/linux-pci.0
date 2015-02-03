Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbbBCXGz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 Feb 2015 18:06:55 -0500
Subject: [PATCH] PCI: Expand quirk's handling of CS553x devices
From: Myron Stowe <myron.stowe@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org
Date: Tue, 03 Feb 2015 16:01:24 -0700
Message-ID: <20150203230124.1578.94572.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There seem to be a number of issues with CS553x devices and due to a
recent patch series that detects PCI read-only BARs [1], we've encountered
more.

It appears that not only are the BAR values associated with this device
often greater than the largest range that an IO decoder can request, they
can also be non-conformant with respect to PCI's BAR sizing aspects,
behaving instead, in a read-only manner [2].

This patch addresses read-only BAR values corresponding to CS553x devices
by expanding the existing quirk, manually inserting regions based on the
device's BIOS settings (as opposed to basing such on normal BAR sizing
actions) when necessary.

[1] https://lkml.org/lkml/2014/10/30/637
    [PATCH 0/3] PCI: Fix detection of read-only BARs
      36e8164882ca  PCI: Restore detection of read-only BARs
      f795d86aaa57  PCI: Shrink decoding-disabled window while sizing BARs
      7e79c5f8cad2  PCI: Add informational printk for invalid BARs
[2] https://bugzilla.kernel.org/show_bug.cgi?id=85991 (Comment #4 forward)
Reference: support.amd.com/TechDocs/31506_cs5535_databook.pdf

Reported-by: Nix <nix@esperi.org.uk>
Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
Fixes: 36e8164882ca ("PCI: Restore detection of read-only BARs")
CC: stable@vger.kernel.org  # v.2.6.27+
---
 drivers/pci/quirks.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ed6f89b..aac98c5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -324,18 +324,52 @@ static void quirk_s3_64M(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
 
+static void quirk_io(struct pci_dev *dev, int pos, unsigned size,
+		     const char *name)
+{
+	u32 region;
+	struct pci_bus_region bus_region;
+	struct resource *res = dev->resource + pos;
+
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (pos << 2), &region);
+
+	if (!region)
+		return;
+
+	res->name = pci_name(dev);
+	res->flags = region & ~PCI_BASE_ADDRESS_IO_MASK;
+	res->flags |=
+		(IORESOURCE_IO | IORESOURCE_PCI_FIXED | IORESOURCE_SIZEALIGN);
+	region &= ~(size - 1);
+
+	/* Convert from PCI bus to resource space */
+	bus_region.start = region;
+	bus_region.end = region + size - 1;
+	pcibios_bus_to_resource(dev->bus, res, &bus_region);
+
+	dev_info(&dev->dev, FW_BUG "%s quirk: reg 0x%x: %pR\n",
+		 name, PCI_BASE_ADDRESS_0 + (pos << 2), res);
+}
+
 /*
  * Some CS5536 BIOSes (for example, the Soekris NET5501 board w/ comBIOS
  * ver. 1.33  20070103) don't set the correct ISA PCI region header info.
  * BAR0 should be 8 bytes; instead, it may be set to something like 8k
  * (which conflicts w/ BAR1's memory range).
+ *
+ * CS553x's ISA PCI BARs may also be read-only (ref:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=85991 - Comment #4 forward).
  */
 static void quirk_cs5536_vsa(struct pci_dev *dev)
 {
+	static char *name = "CS5536 ISA bridge";
+
 	if (pci_resource_len(dev, 0) != 8) {
-		struct resource *res = &dev->resource[0];
-		res->end = res->start + 8 - 1;
-		dev_info(&dev->dev, "CS5536 ISA bridge bug detected (incorrect header); workaround applied\n");
+		quirk_io(dev, 0,   8, name);
+		quirk_io(dev, 1, 256, name);
+		quirk_io(dev, 2, 512, name);
+		dev_info(&dev->dev, "%s bug detected (incorrect header); workaround applied\n",
+			 name);
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);

