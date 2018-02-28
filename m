Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49584 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbeB1Nd1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Feb 2018 08:33:27 -0500
Date: Wed, 28 Feb 2018 13:33:23 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: kishon@ti.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH v4 3/3] PCI: endpoint: pci_epf_create: remove goto labels
Message-ID: <20180228133323.GB21854@e107981-ln.cambridge.arm.com>
References: <20180228130719.31218-1-embedded24@evers-fischer.de>
 <20180228130719.31218-4-embedded24@evers-fischer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180228130719.31218-4-embedded24@evers-fischer.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 02:07:19PM +0100, Rolf Evers-Fischer wrote:
> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> 
> Removes the goto labels completely, handles the errors at the
> respective call site and just returns instead of jumping around.
> 
> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 1878a6776519..cf2c4f6590a0 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -203,16 +203,14 @@ struct pci_epf *pci_epf_create(const char *name)
>  	int len;
>  
>  	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
> -	if (!epf) {
> -		ret = -ENOMEM;
> -		goto err_ret;
> -	}
> +	if (!epf)
> +		return ERR_PTR(-ENOMEM);
>  
>  	len = strchrnul(name, '.') - name;
>  	epf->name = kstrndup(name, len, GFP_KERNEL);
>  	if (!epf->name) {
> -		ret = -ENOMEM;
> -		goto free_epf;
> +		kfree(epf);
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	dev = &epf->dev;
> @@ -221,24 +219,14 @@ struct pci_epf *pci_epf_create(const char *name)
>  	dev->type = &pci_epf_type;
>  
>  	ret = dev_set_name(dev, "%s", name);
> -	if (ret)
> -		goto put_dev;
> -
> -	ret = device_add(dev);
> -	if (ret)
> -		goto put_dev;
> -
> -	return epf;
> +	if (!ret) {
> +		ret = device_add(dev);
> +		if (!ret)
> +			return epf;
> +	}

This is ugly, sorry. I should have been more explicit, I prefer
this construct:

ret = dev_set_name(dev, "%s", name);
if (ret) {
	kfree(epf->name);
	kfree(epf);
	return ERR_PTR(ret);
}

ret = device_add(dev);
if (ret) {
	put_device(dev);
	return ERR_PTR(ret);
}

return epf;

Please send a v5 and let's be done with it.

Thanks,
Lorenzo

> -put_dev:
>  	put_device(dev);
>  	return ERR_PTR(ret);
> -
> -free_epf:
> -	kfree(epf);
> -
> -err_ret:
> -	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_create);
>  
> -- 
> 2.16.2
> 
