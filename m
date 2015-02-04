Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:64537 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbbBDEEw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 23:04:52 -0500
Received: by mail-ob0-f181.google.com with SMTP id vb8so22647498obc.12
        for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2015 20:04:52 -0800 (PST)
Date: Tue, 3 Feb 2015 22:04:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Myron Stowe <myron.stowe@redhat.com>
Cc: linux-pci@vger.kernel.org, nix@esperi.org.uk,
	linux-kernel@vger.kernel.org, Andres Salomon <dilinger@queued.net>,
	Leigh Porter <leigh@leighporter.org>,
	Jens Rottmann <JRottmann@LiPPERTEmbedded.de>,
	Bill Unruh <unruh@physics.ubc.ca>,
	Martin Lucina <martin@lucina.net>,
	Matthew Wilcox <willy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PCI: Expand quirk's handling of CS553x devices
Message-ID: <20150204040448.GB19540@google.com>
References: <20150203230124.1578.94572.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150203230124.1578.94572.stgit@amt.stowe>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Andres, Leigh, Jens because they were involved in 73d2eaac8a3f
("CS5536: apply pci quirk for BIOS SMBUS bug")]

[+cc Bill, Martin, Matthew, Greg, Linus because they saw the original
report and might be interested in the resolution]

On Tue, Feb 03, 2015 at 04:01:24PM -0700, Myron Stowe wrote:
> There seem to be a number of issues with CS553x devices and due to a
> recent patch series that detects PCI read-only BARs [1], we've encountered
> more.
> 
> It appears that not only are the BAR values associated with this device
> often greater than the largest range that an IO decoder can request, they
> can also be non-conformant with respect to PCI's BAR sizing aspects,
> behaving instead, in a read-only manner [2].
> 
> This patch addresses read-only BAR values corresponding to CS553x devices
> by expanding the existing quirk, manually inserting regions based on the
> device's BIOS settings (as opposed to basing such on normal BAR sizing
> actions) when necessary.
> 
> [1] https://lkml.org/lkml/2014/10/30/637
>     [PATCH 0/3] PCI: Fix detection of read-only BARs
>       36e8164882ca  PCI: Restore detection of read-only BARs
>       f795d86aaa57  PCI: Shrink decoding-disabled window while sizing BARs
>       7e79c5f8cad2  PCI: Add informational printk for invalid BARs
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=85991 (Comment #4 forward)
> Reference: support.amd.com/TechDocs/31506_cs5535_databook.pdf
> 
> Reported-by: Nix <nix@esperi.org.uk>
> Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
> Fixes: 36e8164882ca ("PCI: Restore detection of read-only BARs")
> CC: stable@vger.kernel.org  # v.2.6.27+
> ---
>  drivers/pci/quirks.c |   40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ed6f89b..aac98c5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -324,18 +324,52 @@ static void quirk_s3_64M(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
>  
> +static void quirk_io(struct pci_dev *dev, int pos, unsigned size,
> +		     const char *name)
> +{
> +	u32 region;
> +	struct pci_bus_region bus_region;
> +	struct resource *res = dev->resource + pos;
> +
> +	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0 + (pos << 2), &region);
> +
> +	if (!region)
> +		return;
> +
> +	res->name = pci_name(dev);
> +	res->flags = region & ~PCI_BASE_ADDRESS_IO_MASK;
> +	res->flags |=
> +		(IORESOURCE_IO | IORESOURCE_PCI_FIXED | IORESOURCE_SIZEALIGN);
> +	region &= ~(size - 1);
> +
> +	/* Convert from PCI bus to resource space */
> +	bus_region.start = region;
> +	bus_region.end = region + size - 1;
> +	pcibios_bus_to_resource(dev->bus, res, &bus_region);
> +
> +	dev_info(&dev->dev, FW_BUG "%s quirk: reg 0x%x: %pR\n",
> +		 name, PCI_BASE_ADDRESS_0 + (pos << 2), res);
> +}
> +
>  /*
>   * Some CS5536 BIOSes (for example, the Soekris NET5501 board w/ comBIOS
>   * ver. 1.33  20070103) don't set the correct ISA PCI region header info.
>   * BAR0 should be 8 bytes; instead, it may be set to something like 8k
>   * (which conflicts w/ BAR1's memory range).
> + *
> + * CS553x's ISA PCI BARs may also be read-only (ref:
> + * https://bugzilla.kernel.org/show_bug.cgi?id=85991 - Comment #4 forward).
>   */
>  static void quirk_cs5536_vsa(struct pci_dev *dev)
>  {
> +	static char *name = "CS5536 ISA bridge";
> +
>  	if (pci_resource_len(dev, 0) != 8) {
> -		struct resource *res = &dev->resource[0];
> -		res->end = res->start + 8 - 1;
> -		dev_info(&dev->dev, "CS5536 ISA bridge bug detected (incorrect header); workaround applied\n");
> +		quirk_io(dev, 0,   8, name);
> +		quirk_io(dev, 1, 256, name);
> +		quirk_io(dev, 2, 512, name);

Per sec 5.6.1 of the datasheets, I think BAR 2 (MFGPT) is only 64 bytes.

On Nix's system, we detected it as 512 bytes prior to 36e8164882ca.  That
was because the BAR contained 0x6200, and the lowest-order set bit
determines the BAR size, so it was 512 in that case.  So forcing it to be
512 certainly works on Nix's system (though it may consume unnecessary
space after the BAR).

But this quirk ONLY works if the system makes that BAR 512-byte aligned.
If the BAR is at an address that is only aligned to 64 bytes, not 512, this
quirk will forcibly align the start to 512.  For example, if we had:

  pci 0000:00:14.0: reg 0x18: [io  0x6240-0x627f]  (a read-only BAR)

this quirk would read 0x6240 from the BAR and align it to 0x6200 (the
"region &= ~(size - 1)" part) so we end up with [io 0x6200-0x63ff].  I
don't think that will work.

I tweaked the patch (as below) and applied to my for-linus branch for
v3.19.  I haven't asked Linus to pull it yet, so let me know if we still
need to tweak it some more.

Bjorn

> +		dev_info(&dev->dev, "%s bug detected (incorrect header); workaround applied\n",
> +			 name);
>  	}
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
> 


commit f13ad4b2718e5900c1b8a8eeb500860145a5991f
Author: Myron Stowe <myron.stowe@redhat.com>
Date:   Tue Feb 3 16:01:24 2015 -0700

    PCI: Handle read-only BARs on AMD CS553x devices
    
    Some AMD CS553x devices have read-only BARs because of a firmware or
    hardware defect.  There's a workaround in quirk_cs5536_vsa(), but it no
    longer works after 36e8164882ca ("PCI: Restore detection of read-only
    BARs").  Prior to 36e8164882ca, we filled in res->start; afterwards we
    leave it zeroed out.  The quirk only updated the size, so the driver tried
    to use a region starting at zero, which didn't work.
    
    Expand quirk_cs5536_vsa() to read the base addresses from the BARs and
    hard-code the sizes.
    
    Prior to 36e8164882ca, BAR 2 was detected as 512 bytes based on a read-only
    BAR value of 0x6200.  The lowest-order set bit determines the largest
    possible BAR size: 512 in this case.  Per sec 5.6.1 of the datasheets, I
    think BAR 2 (MFGPT) requires only 64 bytes, so set the resource to that.
    If a platform puts this BAR at only 64-byte alignment, we don't want to
    align the address to 512 bytes by throwing away those low-order bits.
    
    [bhelgaas: changelog, reduce BAR 2 size to 64]
    Fixes: 36e8164882ca ("PCI: Restore detection of read-only BARs")
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=85991#c4
    Link: http://support.amd.com/TechDocs/31506_cs5535_databook.pdf
    Link: http://support.amd.com/TechDocs/33238G_cs5536_db.pdf
    Reported-and-tested-by: Nix <nix@esperi.org.uk>
    Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org	# v.2.6.27+

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e52356aa09b8..903d5078b5ed 100644
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
+		quirk_io(dev, 0,   8, name);	/* SMB */
+		quirk_io(dev, 1, 256, name);	/* GPIO */
+		quirk_io(dev, 2,  64, name);	/* MFGPT */
+		dev_info(&dev->dev, "%s bug detected (incorrect header); workaround applied\n",
+			 name);
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, quirk_cs5536_vsa);
