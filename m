Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33422 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbaIVVFu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 17:05:50 -0400
Received: by mail-ie0-f178.google.com with SMTP id at20so8354218iec.9
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 14:05:50 -0700 (PDT)
Date: Mon, 22 Sep 2014 15:05:47 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robert Stonehouse <rstonehouse@solarflare.com>
Subject: Re: [PATCH] pci: quirks: Add ACS quirk for Solarflare SFC9120 &
 SFC9140
Message-ID: <20140922210547.GK1880@google.com>
References: <20140917145838.19243.14630.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140917145838.19243.14630.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 17, 2014 at 08:59:36AM -0600, Alex Williamson wrote:
> Solarflare confirms that these devices do not allow peer-to-peer
> between functions.  Quirk them to allow IOMMU grouping to expose this
> isolation.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Robert Stonehouse <rstonehouse@solarflare.com>

Applied with Robert's ack to pci/virtualization for v3.18, thanks!

> ---
> 
>  drivers/pci/quirks.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 80c2d01..78cc83f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3664,6 +3664,21 @@ static int pci_quirk_intel_pch_acs(struct pci_dev *dev, u16 acs_flags)
>  	return acs_flags & ~flags ? 0 : 1;
>  }
>  
> +static int pci_quirk_solarflare_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * SV, TB, and UF are not relevant to multifunction endpoints.
> +	 *
> +	 * Solarflare indicates that peer-to-peer between functions is not
> +	 * possible, therefore RR, CR, and DT are not implemented.  Mask
> +	 * these out as if they were clear in the ACS capabilities register.
> +	 */
> +	acs_flags &= ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR |
> +		       PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_DT);
> +
> +	return acs_flags ? 0 : 1;
> +}
> +
>  static const struct pci_dev_acs_enabled {
>  	u16 vendor;
>  	u16 device;
> @@ -3675,6 +3690,8 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_ATI, 0x439d, pci_quirk_amd_sb_acs },
>  	{ PCI_VENDOR_ID_ATI, 0x4384, pci_quirk_amd_sb_acs },
>  	{ PCI_VENDOR_ID_ATI, 0x4399, pci_quirk_amd_sb_acs },
> +	{ PCI_VENDOR_ID_SOLARFLARE, 0x0903, pci_quirk_solarflare_acs },
> +	{ PCI_VENDOR_ID_SOLARFLARE, 0x0923, pci_quirk_solarflare_acs },
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
>  	{ 0 }
>  };
> 
