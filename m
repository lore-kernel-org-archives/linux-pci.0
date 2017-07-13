Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdGMC4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jul 2017 22:56:11 -0400
Date: Wed, 12 Jul 2017 21:56:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Samuel Sieb <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170713025608.GC4486@bhelgaas-glaptop.roam.corp.google.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491575538-22694-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> ATS is broken on this hardware and causes IOMMU stalls and
> system failure. Disable ATS on these devices to make them
> usable again with IOMMU enabled.
> 
> Note that the commit in the Fixes-tag is not buggy, it
> just uncovers the problem in the hardware by increasing
> the ATS-flush rate.
> 
> Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Applied with Alex's ack to pci/virtualization for v4.14, thanks!

Alex, you seemed a little ambivalent later.  If you want to rescind
your ack, let me know and I'll remove it.

> ---
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6736836..7cbe316 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4634,3 +4634,22 @@ static void quirk_no_aersid(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
> +
> +#ifdef CONFIG_PCI_ATS
> +/*
> + * Some devices have a broken ATS implementation causing IOMMU stalls.
> + * Don't use ATS for those devices.
> + */
> +static void quirk_disable_ats(struct pci_dev *pdev)
> +{
> +	/*
> +	 * Set pdev->ats_cap = 0 to make pci_enable_ats() bail out
> +	 * early.
> +	 */
> +	dev_info(&pdev->dev, "QUIRK: Disabling ATS");
> +	pdev->ats_cap = 0;
> +}
> +
> +/* AMD Stoney platform GPU */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_disable_ats);
> +#endif /* CONFIG_PCI_ATS */
> -- 
> 1.9.1
> 
