Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:41135 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157AbbAPALa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jan 2015 19:11:30 -0500
Received: by mail-oi0-f42.google.com with SMTP id g201so15018456oib.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2015 16:11:30 -0800 (PST)
Date: Thu, 15 Jan 2015 18:11:25 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sathya Perla <sathya.perla@emulex.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] pci: Add ACS quirk for Emulex NICs
Message-ID: <20150116001125.GD29776@google.com>
References: <1421130143-4391-1-git-send-email-sathya.perla@emulex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421130143-4391-1-git-send-email-sathya.perla@emulex.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex]

On Tue, Jan 13, 2015 at 01:22:23AM -0500, Sathya Perla wrote:
> From: Vasundhara Volam <vasundhara.volam@emulex.com>
> 
> As Skyhawk and BE3-R (both multi-function devices) don't advertise the
> PCI-ACS capability, the vfio driver places all the functions of these
> devices in a single IOMMU group. Attaching (via PCI-passthru)two different
> Skyhawk/BE3-R partitions (nPAR, Flex etc PFs) using vfio, to different
> guests doesn't work as vfio only allows functions in *different* IOMMU
> groups to be assigned to different guests.
> 
> As peer-to-peer access between PFs in Skyhawk/BE3-R is not possible,
> we can treat them as "fully isolated" even though the device doesn't
> advertise ACS. So, this patch adds a PCI quirk for Skyhawk and BE3-R
> chips to fix this problem.
> 
> Signed-off-by: Vasundhara Volam <vasundhara.volam@emulex.com>
> Signed-off-by: Sathya Perla <sathya.perla@emulex.com>

Applied with Alex's ack to pci/virtualization for v3.20, thanks!

> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ed6f89b..3d24629 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3713,6 +3713,8 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_INTEL, 0x1551, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, 0x1558, pci_quirk_mf_endpoint_acs },
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
> +	{ 0x19a2, 0x710, pci_quirk_mf_endpoint_acs }, /* Emulex BE3-R */
> +	{ 0x10df, 0x720, pci_quirk_mf_endpoint_acs }, /* Emulex Skyhawk-R */
>  	{ 0 }
>  };
>  
> -- 
> 2.2.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
