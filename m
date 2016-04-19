Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 Apr 2016 16:19:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	john.ronciak@intel.com, linux-kernel@vger.kernel.org,
	jesse.brandeburg@intel.com
Subject: Re: [PATCH] PCI: Quirk broken INTx masking on Intel i40e NICs
Message-ID: <20160419211927.GC17863@localhost>
References: <20160324190328.3880.44785.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160324190328.3880.44785.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 24, 2016 at 01:03:49PM -0600, Alex Williamson wrote:
> All of the i40e (XL710/X710) 10/20/40GbE NICs lack support for
> indicating INTx is asserted via the interrupt bit in the PCI status
> register.  The DisINTx bit in the command register is functional,
> causing these devices to be incorrectly detected as supporting INTx
> masking.  Quirk them to properly indicate no INTx masking support.
> 
> Device IDs copied from i40e_devids.h.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: John Ronciak <john.ronciak@intel.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>

Applied to pci/virtualization for v4.7, thanks, Alex.

> ---
>  drivers/pci/quirks.c |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0575a1e..583f040 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3121,6 +3121,39 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>  			 quirk_broken_intx_masking);
>  
> +/*
> + * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
> + * DisINTx can be set but the interrupt status bit is non-functional.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1572,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1574,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1580,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1581,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1583,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1584,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1585,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1586,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1587,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1588,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1589,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d0,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d1,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x37d2,
> +			 quirk_broken_intx_masking);
> +
>  static void quirk_no_bus_reset(struct pci_dev *dev)
>  {
>  	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
