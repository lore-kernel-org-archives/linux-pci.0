Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:40545 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbaJOXIU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 19:08:20 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so2395904igc.12
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2014 16:08:20 -0700 (PDT)
Date: Wed, 15 Oct 2014 17:08:17 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: Limit VPD length of Emulex adapters to the actual
 length supported.
Message-ID: <20141015230817.GE15225@google.com>
References: <c67cd7f4-8d8f-48fc-a63c-dbdafde873a2@CMEXHTCAS1.ad.emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c67cd7f4-8d8f-48fc-a63c-dbdafde873a2@CMEXHTCAS1.ad.emulex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 07, 2014 at 12:30:06PM +0530, Venkat Duvvuru wrote:
> By default pci utilities/subsystem tries to read 32k bytes of vpd data no matter
> what the device supports. This can lead to unexpected behavior depending
> on how each of the devices handle this condition. This patch fixes the
> problem for Emulex adapter family.

Per spec (PCI r3.0, Appendix I), the VPD address is 15 bits, which limits
the addressable area to 32K.  The registers in the capability structure
(VPD Address, VPD Data) don't have any way to indicate the size of the area
supported by the device.

The spec does mandate an overall structure for data itself: it is supposed
to be a series of tagged resources, terminated by a Small Resource End Tag.
But we currently ignore that structure in the PCI core, and based on the
way I see drivers using pci_read_vpd() to read arbitrary offsets into the
VPD, I suspect many devices ignore that structure, too.

So a patch like this is probably the best we can do.

The only problem is that as mentioned at the top of
include/linux/pci_ids.h, we don't add entries there any more unless they
are required by multiple drivers.  That doesn't seem to be the case here,
so you should just put those hex vendor and device IDs directly in the
DECLARE_PCI_FIXUP_FINAL() lines.

Bjorn

> Signed-off-by: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
> ---
>  drivers/pci/quirks.c    |   35 +++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |   17 +++++++++++++++++
>  2 files changed, 52 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 80c2d01..21b439f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3832,3 +3832,38 @@ void pci_dev_specific_enable_acs(struct pci_dev *dev)
>  		}
>  	}
>  }
> +
> +#define SLI_INTF_REG_OFFSET     0x58
> +#define SLI_INTF_FT_MASK        0x00000001
> +static void quirk_elx_limit_vpd(struct pci_dev *dev)
> +{
> +	int virtfn;
> +	u32 sli_intf;
> +
> +	pci_read_config_dword(dev, SLI_INTF_REG_OFFSET, &sli_intf);
> +	virtfn = (sli_intf & SLI_INTF_FT_MASK) ? 1 : 0;
> +
> +	if (dev->vpd) {
> +		if (virtfn)
> +			dev->vpd->len = 0x200;
> +		else
> +			dev->vpd->len = 0x400;
> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_BE_ID1,
> +			quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_BE_ID2,
> +			quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_OC_BE2,
> +			quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BE, PCI_DEVICE_ID_OC_BE3,
> +			quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_LANCER,
> +			quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_VF_LANCER,
> +			quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_SKYHAWK,
> +			quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_OC_VF_SKYHAWK,
> +			quirk_elx_limit_vpd);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6ed0bb7..888041d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2971,4 +2971,21 @@
>  
>  #define PCI_VENDOR_ID_OCZ		0x1b85
>  
> +#define PCI_VENDOR_ID_BE		0x19a2
> +#define PCI_VENDOR_ID_EMULEX		0x10df
> +#define PCI_DEVICE_ID_BE_ID1		0x211
> +#define PCI_DEVICE_ID_BE_ID2		0x221
> +/* Device Id for BE2 cards */
> +#define PCI_DEVICE_ID_OC_BE2		0x700
> +/* Device Id for BE3 cards */
> +#define PCI_DEVICE_ID_OC_BE3		0x710
> +/* Device id for Lancer cards */
> +#define PCI_DEVICE_ID_OC_LANCER		0xe220
> +/* Device id for VF in Lancer */
> +#define PCI_DEVICE_ID_OC_VF_LANCER	0xe228
> +/* Device id for SkyHawk cards */
> +#define PCI_DEVICE_ID_OC_SKYHAWK	0x720
> +/* Device id for VF in SkyHawk */
> +#define PCI_DEVICE_ID_OC_VF_SKYHAWK	0x728
> +
>  #endif /* _LINUX_PCI_IDS_H */
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
