Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50845 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG0M4f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 08:56:35 -0400
Date: Mon, 27 Jul 2015 14:56:32 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 08/11] PCI: Clean up ATS error handling
Message-ID: <20150727125632.GD27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001454.28145.35617.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001454.28145.35617.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:14:54PM -0500, Bjorn Helgaas wrote:
> There's no need to BUG() if we enable ATS when it's already enabled.  We
> don't need to BUG() when disabling ATS on a device that doesn't support ATS
> or if it's already disabled.  If ATS is enabled, certainly we found an ATS
> capability in the past, so it should still be there now.
> 
> Clean up these error paths.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 0b5b0ed..67524a7 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -44,11 +44,12 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  	u16 ctrl;
>  	struct pci_dev *pdev;
>  
> -	BUG_ON(dev->ats_cap && dev->ats_enabled);
> -
>  	if (!dev->ats_cap)
>  		return -EINVAL;
>  
> +	if (pci_ats_enabled(dev))
> +		return -EINVAL;
> +

Better return -EBUSY here? It would be good to find out if we are trying
to enable ATS while it is already enabled. A WARN_ON around this would
also be good, so that we spot bugs in the iommu drivers early when they
use this interface.



	Joerg

