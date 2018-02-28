Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] PCI: endpoint: pci_epf_create: remove goto labels
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
References: <20180228130719.31218-1-embedded24@evers-fischer.de>
 <20180228130719.31218-4-embedded24@evers-fischer.de>
CC: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andy.shevchenko@gmail.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b442fcb1-10e0-8654-7dad-dbcc384733d1@ti.com>
Date: Wed, 28 Feb 2018 18:57:36 +0530
MIME-Version: 1.0
In-Reply-To: <20180228130719.31218-4-embedded24@evers-fischer.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wednesday 28 February 2018 06:37 PM, Rolf Evers-Fischer wrote:
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

I don't prefer the correct return value being hidden under two levels of 'if'.

Thanks
Kishon
