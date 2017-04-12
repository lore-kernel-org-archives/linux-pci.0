Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:33178 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752608AbdDLQrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 12:47:31 -0400
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20170412083525.GF3250@mwanda>
Cc: Stephen Bates <stephen.bates@microsemi.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3de7a06b-d27c-9775-8eb9-1b02bf8e2fec@deltatee.com>
Date: Wed, 12 Apr 2017 10:47:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170412083525.GF3250@mwanda>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH] switchtec: checking for NULL instead of IS_ERR()
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dan,

Thanks for the fix. This is the exact same patch Christophe Jaillet sent
a couple of days ago so only one needs to be merged.

Logan

On 12/04/17 02:35 AM, Dan Carpenter wrote:
> stuser_create() uses error pointers, it never returns NULL.
> 
> Fixes: 74004262f329 ("MicroSemi Switchtec management interface driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
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
