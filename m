Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:49053 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab3DXRs0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2013 13:48:26 -0400
Received: by mail-oa0-f43.google.com with SMTP id k7so1993731oag.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2013 10:48:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
References: <20130422230012.32621.15224.stgit@bhelgaas-glaptop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 24 Apr 2013 11:48:05 -0600
Message-ID: <CAErSpo7L97WSh_0QdJ6x5eR-+Z6CC=KbcL4UhE6mZD_y0ofM2g@mail.gmail.com>
Subject: Re: [PATCH v4 00/22] PCI: Cache MSI/MSI-X capability offsets, other cleanup
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	xen-devel <xen-devel@lists.xensource.com>,
	Adam Radford <aradford@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 22, 2013 at 5:10 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This supercedes Gavin's "[PATCH v3 0/5] Retrieve MSI/MSIX cap struct for
> once on setup" series from Apr 4, 2013.
>
> It includes Gavin's patches (there were actually only 4 in v3, not 5),
> together with more MSI-related cleanup that I did.
>
> There's also a possible bug-fix in xen_initdom_setup_msi_irqs(): previously
> it ignored the "Table Offset" bits in the MSI-X capability.  I don't know
> enough about Xen to know how it uses struct physdev_map_pirq, but it seems
> possible that we should pay attention to those bits.
>
> ---
>
> Bjorn Helgaas (18):
>       [SCSI] megaraid_sas: Use correct #define for MSI-X capability
>       PCI: Use u8, not int, for PM capability offset
>       PCI: Clean up MSI/MSI-X capability #defines
>       PCI: Use cached MSI/MSI-X offsets from dev, not from msi_desc
>       PCI: Drop msi_control_reg() macro and use PCI_MSI_FLAGS directly
>       PCI: Drop msi_lower_address_reg() and msi_upper_address_reg() macros
>       PCI: Drop msi_data_reg() macro
>       PCI: Drop is_64bit_address() and is_mask_bit_support() macros
>       PCI: Drop msix_table_offset_reg() and msix_pba_offset_reg() macros
>       PCI: Use msix_table_size() directly, drop multi_msix_capable()
>       PCI: Drop msi_mask_reg() and remove drivers/pci/msi.h
>       PCI: Use PCI_MSIX_TABLE_BIR, not PCI_MSIX_FLAGS_BIRMASK
>       PCI: Remove "extern" from function declarations
>       xen/pci: Pay attention to PCI_MSIX_TABLE_OFFSET
>       xen/pci: Use PCI_MSIX_TABLE_BIR, not PCI_MSIX_FLAGS_BIRMASK
>       xen/pci: Used cached MSI-X capability offset
>       vfio-pci: Use PCI_MSIX_TABLE_BIR, not PCI_MSIX_FLAGS_BIRMASK
>       vfio-pci: Use cached MSI/MSI-X capabilities
>
> Gavin Shan (4):
>       PCI: Cache MSI/MSI-X capability offsets in struct pci_dev
>       PCI: Remove MSI/MSI-X cap check in pci_msi_check_device()
>       PCI: Use cached MSI cap while enabling MSI interrupts
>       PCI: Use cached MSI-X cap while enabling MSI-X
>
>
>  arch/x86/pci/xen.c                        |    9 +
>  drivers/pci/msi.c                         |  176 +++++++++++++----------------
>  drivers/pci/msi.h                         |   24 ----
>  drivers/scsi/megaraid/megaraid_sas.h      |    3
>  drivers/scsi/megaraid/megaraid_sas_base.c |    4 -
>  drivers/vfio/pci/vfio_pci.c               |   10 +-
>  include/linux/msi.h                       |   23 ++--
>  include/linux/pci.h                       |    5 -
>  include/uapi/linux/pci_regs.h             |   30 +++--
>  9 files changed, 123 insertions(+), 161 deletions(-)
>  delete mode 100644 drivers/pci/msi.h

With the exception of the xen/pci patches, I merged these to my "next"
branch for v3.10.  Let me know if you see any issues.

I can merge the xen patches too, if somebody acks them.

Bjorn
