Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57821 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbcCLM03 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 12 Mar 2016 07:26:29 -0500
Date: Sat, 12 Mar 2016 06:26:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Tony Luck <tony.luck@intel.com>,
	DRI <dri-devel@lists.freedesktop.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Daniel Stone <daniel@fooishbar.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?=
	<ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v1 00/12] PCI: Rework shadow ROM handling
Message-ID: <20160312122622.GC27552@localhost>
References: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160303164533.3025.82439.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 03, 2016 at 10:53:50AM -0600, Bjorn Helgaas wrote:
> The purpose of this series is to:
> ...

>   - Move arch-specific shadow ROM location knowledge, e.g.,
>     0xC0000-0xDFFFF, from PCI core to arch code.
> ...

> Bjorn Helgaas (12):
>       PCI: Mark shadow copy of VGA ROM as IORESOURCE_PCI_FIXED
>       PCI: Don't assign or reassign immutable resources
>       PCI: Don't enable/disable ROM BAR if we're using a RAM shadow copy
>       PCI: Set ROM shadow location in arch code, not in PCI core

I propose to add the patch below at this point in the series.

>       PCI: Clean up pci_map_rom() whitespace
>       ia64/PCI: Use temporary struct resource * to avoid repetition
>       ia64/PCI: Use ioremap() instead of open-coded equivalent
>       ia64/PCI: Keep CPU physical (not virtual) addresses in shadow ROM resource
>       MIPS: Loongson 3: Use temporary struct resource * to avoid repetition
>       MIPS: Loongson 3: Keep CPU physical (not virtual) addresses in shadow ROM resource
>       PCI: Remove unused IORESOURCE_ROM_COPY and IORESOURCE_ROM_BIOS_COPY
>       PCI: Simplify sysfs ROM cleanup

commit ac0c302a919ba7b68dbf274babdc08c83df6f532
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat Mar 12 05:48:08 2016 -0600

    PCI: Remove arch-specific IORESOURCE_ROM_SHADOW size from sysfs
    
    When pci_create_sysfs_dev_files() created the "rom" sysfs file, it set the
    sysfs file size to the actual size of a ROM BAR, or if there was no ROM BAR
    but the platform provided a shadow copy in RAM, to 0x20000.  0x20000 is an
    arch-specific length that should not be baked into the PCI core.
    
    Every place that sets IORESOURCE_ROM_SHADOW also sets the size of the
    PCI_ROM_RESOURCE, so use the resource length always.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 95d9e7b..51d4dad 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1356,7 +1356,7 @@ error:
 int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	int retval;
-	int rom_size = 0;
+	int rom_size;
 	struct bin_attribute *attr;
 
 	if (!sysfs_initialized)
@@ -1373,12 +1373,8 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (retval)
 		goto err_config_file;
 
-	if (pci_resource_len(pdev, PCI_ROM_RESOURCE))
-		rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
-	else if (pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW)
-		rom_size = 0x20000;
-
 	/* If the device has a ROM, try to expose it in sysfs. */
+	rom_size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
 	if (rom_size) {
 		attr = kzalloc(sizeof(*attr), GFP_ATOMIC);
 		if (!attr) {
