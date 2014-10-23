Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:52027 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbaJWPk6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Oct 2014 11:40:58 -0400
Received: by mail-yh0-f44.google.com with SMTP id i57so1424587yha.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2014 08:40:58 -0700 (PDT)
Date: Thu, 23 Oct 2014 09:40:54 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] pci: Limit VPD length of Emulex adapters to the
 actual length supported.
Message-ID: <20141023154054.GA7137@google.com>
References: <1f6d7b6c-7189-4fe3-926b-42609724cab9@CMEXHTCAS2.ad.emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1f6d7b6c-7189-4fe3-926b-42609724cab9@CMEXHTCAS2.ad.emulex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 16, 2014 at 02:16:42PM +0530, Venkat Duvvuru wrote:
> By default pci utilities/subsystem tries to read 32k bytes of vpd data no matter
> what the device supports. This can lead to unexpected behavior depending
> on how each of the devices handle this condition. This patch fixes the
> problem for Emulex adapter family.
> 
> v1:
> Addressed Bjorn's comments
> 1. Removed Vendor id and Device id macros from pci_ids.h and
>    using the Vendor and Device id values directly in DECLARE_PCI_FIXUP_FINAL() lines.
> 
> Signed-off-by: Venkat Duvvuru <VenkatKumar.Duvvuru@Emulex.com>

Hi Venkat,

I'll merge this (in some form), but I'd like the changelog to include more
details about what unexpected behavior occurs when reading too much data.
This is to help people who trip over this problem find this patch as the
solution.

In my opinion, this is a hardware defect, and I'd like to know what your
hardware folks think, because I don't want to have to merge similar quirks
for future devices.  Here's my reasoning:

If a device doesn't implement the entire 32K of possible VPD space, I would
expect the device to just return zeros or 0xff, or maybe alias the space by
dropping the high-order unused address bits.

The only thing I see in the spec related to this is (PCI r3.0, Appendix I,
"VPD Data" description): "Reading or writing data outside of the VPD space
in the storage component is not allowed."  The only way I see for software
to determine the size of the storage is to parse the data looking for an
End Tag.

I don't think it's reasonable to make correct hardware operation depend on
the contents of the storage, so if something bad happens when software
reads past the end, that looks like a hardware defect to me.

Bjorn

> ---
>  drivers/pci/quirks.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 80c2d01..95d88f3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3832,3 +3832,36 @@ void pci_dev_specific_enable_acs(struct pci_dev *dev)
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
> +DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x211, quirk_elx_limit_vpd);
> +DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x221, quirk_elx_limit_vpd);
> +/* BE2 */
> +DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x700, quirk_elx_limit_vpd);
> +/* BE3 */
> +DECLARE_PCI_FIXUP_FINAL(0x19a2, 0x710, quirk_elx_limit_vpd);
> +/* LANCER */
> +DECLARE_PCI_FIXUP_FINAL(0x10df, 0xe220, quirk_elx_limit_vpd);
> +/* LANCER VF */
> +DECLARE_PCI_FIXUP_FINAL(0x10df, 0xe228, quirk_elx_limit_vpd);
> +/* SKYHAWK */
> +DECLARE_PCI_FIXUP_FINAL(0x10df, 0x720, quirk_elx_limit_vpd);
> +/* SKYHAWK VF */
> +DECLARE_PCI_FIXUP_FINAL(0x10df, 0x728, quirk_elx_limit_vpd);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
