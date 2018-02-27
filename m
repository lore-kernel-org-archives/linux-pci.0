Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:64451 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeB0KJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 05:09:47 -0500
Subject: Re: [PATCH v3 1/2] pci: endpoint: Simplify name allocation for epf
 device
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
References: <20180227100231.22561-1-embedded24@evers-fischer.de>
 <20180227100231.22561-2-embedded24@evers-fischer.de>
CC: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andy.shevchenko@gmail.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <76904bbe-ebef-9b8f-5f30-e876f73b28fe@ti.com>
Date: Tue, 27 Feb 2018 15:39:35 +0530
MIME-Version: 1.0
In-Reply-To: <20180227100231.22561-2-embedded24@evers-fischer.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 27 February 2018 03:32 PM, Rolf Evers-Fischer wrote:
> From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> 
> This commit replaces allocating and freeing the intermediate
> 'buf'/'func_name' with a combination of 'kstrndup()' and 'len'.
> 
> 'len' is the required length of 'epf->name'.
> 'epf->name' should be either the first part of 'name' preceding the '.'
> or the complete 'name', if there is no '.' in the name.
> 
> Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 766ce1dca2ec..1f2506f32bb9 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -200,8 +200,7 @@ struct pci_epf *pci_epf_create(const char *name)
>  	int ret;
>  	struct pci_epf *epf;
>  	struct device *dev;
> -	char *func_name;
> -	char *buf;
> +	int len;
>  
>  	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
>  	if (!epf) {
> @@ -209,20 +208,11 @@ struct pci_epf *pci_epf_create(const char *name)
>  		goto err_ret;
>  	}
>  
> -	buf = kstrdup(name, GFP_KERNEL);
> -	if (!buf) {
> -		ret = -ENOMEM;
> -		goto free_epf;
> -	}
> -
> -	func_name = buf;
> -	buf = strchrnul(buf, '.');
> -	*buf = '\0';
> -
> -	epf->name = kstrdup(func_name, GFP_KERNEL);
> +	len = strchrnul(name, '.') - name;
> +	epf->name = kstrndup(name, len, GFP_KERNEL);

shouldn't the string end with '\0'?

Thanks
Kishon
