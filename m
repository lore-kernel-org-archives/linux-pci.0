Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58328 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400AbbGTOPF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 10:15:05 -0400
Date: Mon, 20 Jul 2015 16:15:01 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 4/8] PCI: Rationalize pci_ats_queue_depth() error checking
Message-ID: <20150720141501.GD13082@suse.de>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213215.18379.59848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213215.18379.59848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:32:16PM -0500, Bjorn Helgaas wrote:
> We previously returned -ENODEV for devices that don't support ATS (except
> that we always returned 0 for VFs, whether or not they support ATS).
> 
> For consistency, always return -EINVAL (not -ENODEV) if the device doesn't
> support ATS.  Return zero for VFs that support ATS.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 2f1fb9c..ea459b3 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -121,13 +121,13 @@ EXPORT_SYMBOL_GPL(pci_restore_ats_state);
>   */
>  int pci_ats_queue_depth(struct pci_dev *dev)
>  {
> +	if (!dev->ats_cap)
> +		return -EINVAL;
> +
>  	if (dev->is_virtfn)
>  		return 0;
>  
> -	if (dev->ats_cap)
> -		return dev->ats_qdep;
> -
> -	return -ENODEV;
> +	return dev->ats_qdep;
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_queue_depth);

Reviewed-by: Joerg Roedel <jroedel@suse.de>

