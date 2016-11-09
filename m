Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932212AbcKISWq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 13:22:46 -0500
Date: Wed, 9 Nov 2016 12:22:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Noa Osherovich <noaos@mellanox.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Amir Vadai <amirv@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Refine broken INTx masking for Mellanox devices
Message-ID: <20161109182232.GL14322@bhelgaas-glaptop.roam.corp.google.com>
References: <1478011644-12080-1-git-send-email-noaos@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478011644-12080-1-git-send-email-noaos@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Gavin, Amir, Majd, Alex]

Hi Noa,

On Tue, Nov 01, 2016 at 04:47:24PM +0200, Noa Osherovich wrote:
> Mellanox devices were marked as having INTx masking ability broken.

This was done by 11e42532ada3 ("PCI: Assume all Mellanox devices have
broken INTx masking"), by Gavin Shan.  Possibly that was a little too
aggressive.  I cc'd Gavin and Amir so they can comment.

This patch is really doing two separate things:

  1) Changing from a blanket "all Mellanox devices" have broken INTx to a
  specific "only these listed Mellanox devices" have broken INTx, and

  2) Checking the firmware version of PCI_DEVICE_ID_MELLANOX_CONNECTX4 and
  PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX to see if INTx masking works.

I'd like these to be split into two patches: one that sets
broken_intx_masking for the list of Mellanox devices (including CONNECTX4),
and a second that adds quirk_connectx_4_verify_fw() and calls it instead of
quirk_broken_intx_masking() for the CONNECTX4 devices.

That way, a hypothetical problem with a new Mellanox device that's not
on the list will bisect to the first patch, where the solution is
obvious, rather than to the combined patch, which would be much less
obvious.

> As a result, the VFIO driver fails to start when more than one device
> function is passed-through to a VM if both have the same INTx pin.
> 
> Prior to Connect-IB, Mellanox devices exposed to the operating system
> one PCI function per all ports.
> Starting from Connect-IB, the devices are function-per-port. When
> passing the second function to a VM, VFIO will fail to start.
> 
> Exclude ConnectX-4, ConnectX4-Lx and Connect-IB from the list of
> Mellanox devices marked as having broken INTx masking:
> 
> - ConnectX-4 and ConnectX4-LX firmware version is checked. If INTx
>   masking is supported, we unmark the broken INTx masking.
> - Connect-IB does not support INTx currently so will not cause any
>   problem.
> 
> Fixes: 11e42532ada31 ('PCI: Assume all Mellanox devices have ...')
> Signed-off-by: Noa Osherovich <noaos@mellanox.com>
> Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> --
> Previous patch version can be found here:
> https://patchwork.ozlabs.org/patch/612222/
> ---
>  drivers/pci/quirks.c    | 111 +++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pci_ids.h |  16 +++++++
>  2 files changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index c232729f5b1b..9e6d6aafc2ab 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3158,8 +3158,117 @@ static void quirk_broken_intx_masking(struct pci_dev *dev)
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x8169,
>  			 quirk_broken_intx_masking);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
> +
> +#define CONNECTX_4_CURR_MAX_MINOR 99
> +#define CONNECTX_4_INTX_SUPPORT_MINOR 14
> +
> +/*
> + * Checking ConnectX-4/LX FW version to see if it supports legacy interrupts.
> + * If so, don't mark it as broken.
> + * FW minor > 99 means older FW version format and no INTx masking support.
> + * FW minor < 14 means new FW version format and no INTx masking support.
> + */
> +static void quirk_connectx_4_verify_fw(struct pci_dev *dev)
> +{
> +	u16 pmcsr;
> +	u8 __iomem *fw_ver;
> +	u8 fw_minor;
> +
> +	dev->broken_intx_masking = 1;
> +
> +	/*
> +	 * Check that the device is in the D0 power state. If it's not,
> +	 * there is no point to look any further.
> +	 */
> +	if (dev->pm_cap) {
> +		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) != PCI_D0)
> +			return;
> +	}
> +
> +	/* Convert from PCI bus to resource space.  */
> +	fw_ver = ioremap(pci_resource_start(dev, 0), 2);

This is a little problematic.  This is run as a HEADER quirk, and the
ioremap() depends on the BAR being initialized.  On x86, the BAR
likely has been initialized by the BIOS, but that's not true on all
arches, so we can't rely on it.

I think you probably should make this a FINAL quirk and call
pci_enable_device_mem() first, then use pci_iomap().  That way all the
BARs will have been assigned, and it also means you don't need to
worry about state D0 above, because pci_enable_device_mem() will make
sure that the device is in D0.

> +	if (!fw_ver) {
> +		dev_warn(&dev->dev, "Can't map ConnectX-4 initialization segment\n");
> +		return;
> +	}
> +
> +	fw_minor = readb(fw_ver + 1);
> +	if (fw_minor > CONNECTX_4_CURR_MAX_MINOR ||
> +	    fw_minor < CONNECTX_4_INTX_SUPPORT_MINOR)
> +		dev_warn(&dev->dev, "ConnectX-4: FW doesn't support INTx masking, disabling. Please upgrade FW for INTx support\n");

Can you print the current firmware version and maybe the required one
here?  I think that might help the user figure out how to fix the
problem.

> +	else
> +		dev->broken_intx_masking = 0;
> +
> +	iounmap(fw_ver);
> +}
> +
> +/*
> + * Mellanox devices that fail under PCI device assignment using DisINTx masking
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_TAVOR,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_TAVOR_BRIDGE,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_ARBEL,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX, PCI_DEVICE_ID_MELLANOX_SINAI,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_SINAI_OLD,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_HERMON_SDR,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_HERMON_DDR,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_HERMON_QDR,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_HERMON_EN,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX2,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX3,
> +			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO,
>  			 quirk_broken_intx_masking);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX4,
> +			 quirk_connectx_4_verify_fw);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MELLANOX,
> +			 PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX,
> +			 quirk_connectx_4_verify_fw);
>  
>  /*
>   * Intel i40e (XL710/X710) 10/20/40GbE NICs all have broken INTx masking,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index c58752fe16c4..1c742842e76c 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2262,6 +2262,22 @@
>  #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
>  #define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
>  #define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
> +#define PCI_DEVICE_ID_MELLANOX_HERMON_SDR 0x6340
> +#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR 0x634a
> +#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR 0x6354
> +#define PCI_DEVICE_ID_MELLANOX_HERMON_DDR_GEN2 0x6732
> +#define PCI_DEVICE_ID_MELLANOX_HERMON_QDR_GEN2 0x673c
> +#define PCI_DEVICE_ID_MELLANOX_HERMON_EN 0x6368
> +#define PCI_DEVICE_ID_MELLANOX_HERMON_EN_GEN2 0x6750
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN 0x6372
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_T_GEN2 0x675a
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_GEN2 0x6764
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX_EN_5_GEN2 0x6746
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX2 0x676e
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX3 0x1003
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX3_PRO 0x1007
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX4 0x1013
> +#define PCI_DEVICE_ID_MELLANOX_CONNECTX4_LX 0x1015
>  
>  #define PCI_VENDOR_ID_DFI		0x15bd
>  
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
