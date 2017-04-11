Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:55955 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752719AbdDKEhI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Apr 2017 00:37:08 -0400
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kurt.schwemmer@microsemi.com, stephen.bates@microsemi.com,
        bhelgaas@google.com
References: <20170411043204.19343-1-christophe.jaillet@wanadoo.fr>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ddf51036-d86b-8ef7-37ad-1420397eb172@deltatee.com>
Date: Mon, 10 Apr 2017 22:36:59 -0600
MIME-Version: 1.0
In-Reply-To: <20170411043204.19343-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH] switchtec: Fix an error handling
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Nice catch. Thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

On 10/04/17 10:32 PM, Christophe JAILLET wrote:
> 'stuser_create' returns an error pointer in case of error, not NULL.
> So test its return value with IS_ERR.
> 
> Fixes: 74004262f329 ("MicroSemi Switchtec management interface driver")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/pci/switch/switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index fcde98161d9a..cc6e085008fb 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -608,7 +608,7 @@ static int switchtec_dev_open(struct inode *inode, struct file *filp)
>  	stdev = container_of(inode->i_cdev, struct switchtec_dev, cdev);
>  
>  	stuser = stuser_create(stdev);
> -	if (!stuser)
> +	if (IS_ERR(stuser))
>  		return PTR_ERR(stuser);
>  
>  	filp->private_data = stuser;
> 
