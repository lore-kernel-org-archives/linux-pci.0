Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbdDLR1k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 13:27:40 -0400
Date: Wed, 12 Apr 2017 12:27:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kurt.schwemmer@microsemi.com, stephen.bates@microsemi.com,
        logang@deltatee.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] switchtec: Fix an error handling
Message-ID: <20170412172736.GF25197@bhelgaas-glaptop.roam.corp.google.com>
References: <20170411043204.19343-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170411043204.19343-1-christophe.jaillet@wanadoo.fr>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 06:32:04AM +0200, Christophe JAILLET wrote:
> 'stuser_create' returns an error pointer in case of error, not NULL.
> So test its return value with IS_ERR.
> 
> Fixes: 74004262f329 ("MicroSemi Switchtec management interface driver")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Since this hasn't been merged to Linus' tree yet, I folded the fix
into the original commit on pci/switchtec and added attribution to
Christophe.

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
> -- 
> 2.11.0
> 
