Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36061 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965275AbcDLSKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 14:10:34 -0400
Date: Tue, 12 Apr 2016 13:10:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>,
	linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 0/6] PCI: Support multiple DMA aliases
Message-ID: <20160412181031.GA13093@localhost>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160412043828.GA11361@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160412043828.GA11361@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 11, 2016 at 11:38:28PM -0500, Bjorn Helgaas wrote:
> On Wed, Feb 24, 2016 at 01:43:32PM -0600, Bjorn Helgaas wrote:
> > This is a revision of Jacek's v3 posting:
> > http://lkml.kernel.org/r/1454152012-46337-1-git-send-email-jacek.lawrynowicz@intel.com
> > 
> > The changes from v3 are:
> > 
> >   - Split into smaller patches for reviewability
> >   - Move printk when adding DMA alias
> >   - Change dma_alias_is_enabled() interface to take two pci_devs
> >   - Rename dma_alias_is_enabled() to indicate PCI context
> > 
> > The only remaining thing I want to sort out is the dma_alias_is_enabled()
> > vs pci_for_each_dma_alias() question Alex raised.  I'll respond to the
> > relevant part of the patch in this series with my specific questions.
> > 
> > ---
> > 
> > Bjorn Helgaas (1):
> >       PCI: Rename dma_alias_is_enabled() to pci_devs_are_dma_aliases()
> > 
> > Jacek Lawrynowicz (5):
> >       PCI: Add pci_add_dma_alias() to abstract implementation
> >       PCI: Move informational printk to pci_add_dma_alias()
> >       PCI: Add support for multiple DMA aliases
> >       pci: Add DMA alias quirk for mic_x200_dma
> >       PCI: Squash pci_dev_flags to remove holes
> 
> I applied this series to pci/ntb for v4.7.

Jacek sent another patch to add a second PCI ID.  I don't see it on the
list, probably because it's got too much fancy encoding.  I applied it, so
the last patch now looks like this:

commit b1a928cdb477037fb7c10fbf94c47f65f2bcce77
Author: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
Date:   Thu Mar 3 15:53:20 2016 +0100

    PCI: Add DMA alias quirk for mic_x200_dma
    
    The MIC x200 NTB forwards DMA transactions upstream using multiple alien
    RIDs.  These RIDs have to be added as aliases to the DMA device to allow
    buffer access when the IOMMU is enabled.
    
    Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
    Acked-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7559e40..8889ac4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3725,6 +3725,21 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
 
 /*
+ * MIC x200 NTB forwards PCIe traffic using multiple alien RIDs. They have to
+ * be added as aliases to the DMA device in order to allow buffer access
+ * when IOMMU is enabled. Following devfns have to match RIT-LUT table
+ * programmed in the EEPROM.
+ */
+static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
+{
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
+
+/*
  * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
  * class code.  Fix it.
  */
