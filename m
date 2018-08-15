Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeHODBE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Aug 2018 23:01:04 -0400
Date: Tue, 14 Aug 2018 19:11:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH] PCI: limit config space size for Netronome NFP5000
Message-ID: <20180815001124.GC28888@bhelgaas-glaptop.roam.corp.google.com>
References: <20180814234850.27447-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180814234850.27447-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 14, 2018 at 04:48:50PM -0700, Jakub Kicinski wrote:
> Like the NFP4000 and NFP6000, the NFP5000 as an erratum where reading/
> writing to PCI config space addresses above 0x600 can cause the NFP
> to generate PCIe completion timeouts.
> 
> Limit the NFP5000's PF's config space size to 0x600 bytes as is already
> done for the NFP4000 and NFP6000.
> 
> The NFP5000's VF is 0x6003 (PCI_DEVICE_ID_NETRONOME_NFP6000_VF), the same
> device ID as the NFP6000's VF.  Thus, its config space is already limited
> by the existing use of quirk_nfp6000().
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: Tony Egan <tony.egan@netronome.com>

Applied to pci/misc for v4.19, thanks!

> ---
>  drivers/pci/quirks.c    | 1 +
>  include/linux/pci_ids.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f439de848658..bf899184d07c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -460,6 +460,7 @@ static void quirk_nfp6000(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP4000,	quirk_nfp6000);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000,	quirk_nfp6000);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP5000,	quirk_nfp6000);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETRONOME,	PCI_DEVICE_ID_NETRONOME_NFP6000_VF,	quirk_nfp6000);
>  
>  /*  On IBM Crocodile ipr SAS adapters, expand BAR to system page size */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 29502238e510..381fc009551d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2541,6 +2541,7 @@
>  #define PCI_DEVICE_ID_NETRONOME_NFP3200	0x3200
>  #define PCI_DEVICE_ID_NETRONOME_NFP3240	0x3240
>  #define PCI_DEVICE_ID_NETRONOME_NFP4000	0x4000
> +#define PCI_DEVICE_ID_NETRONOME_NFP5000	0x5000
>  #define PCI_DEVICE_ID_NETRONOME_NFP6000	0x6000
>  #define PCI_DEVICE_ID_NETRONOME_NFP6000_VF	0x6003
>  
> -- 
> 2.17.1
> 
