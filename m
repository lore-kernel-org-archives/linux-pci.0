Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933563AbeBVSTI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 13:19:08 -0500
Date: Thu, 22 Feb 2018 18:19:01 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: kishon@ti.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH 1/2] pci: endpoint: Free func_name after last usage
Message-ID: <20180222181901.GA13694@e107981-ln.cambridge.arm.com>
References: <20180221124707.26308-1-embedded24@evers-fischer.de>
 <20180221124707.26308-2-embedded24@evers-fischer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180221124707.26308-2-embedded24@evers-fischer.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:47:06PM +0100, Rolf Evers-Fischer wrote:
> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> 
> This commit decreases the number of jump labels and ensures
> that the next commit doesn't increase the number of occurrences
> of 'kfree(func_name)'.
> 
> Change-Id: I0d1b6fd652395b85f82b11c43bf9b7db512854d1
> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 766ce1dca2ec..23d0e128d1a5 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -220,9 +220,10 @@ struct pci_epf *pci_epf_create(const char *name)
>  	*buf = '\0';
>  
>  	epf->name = kstrdup(func_name, GFP_KERNEL);
> +	kfree(func_name);

I am certainly missing something but what if we reworked the code
and just:

kstrdup(name, GFP_KERNEL);

once instead of allocating another local copy (that we then have to
free) ?

Reworded: why

epf->name = func_name;

would not work ?

Thanks,
Lorenzo

>  	if (!epf->name) {
>  		ret = -ENOMEM;
> -		goto free_func_name;
> +		goto free_epf;
>  	}
>  
>  	dev = &epf->dev;
> @@ -238,16 +239,12 @@ struct pci_epf *pci_epf_create(const char *name)
>  	if (ret)
>  		goto put_dev;
>  
> -	kfree(func_name);
>  	return epf;
>  
>  put_dev:
>  	put_device(dev);
>  	kfree(epf->name);
>  
> -free_func_name:
> -	kfree(func_name);
> -
>  free_epf:
>  	kfree(epf);
>  
> -- 
> 2.16.2
> 
