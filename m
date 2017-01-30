Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbdA3W6C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 17:58:02 -0500
Date: Mon, 30 Jan 2017 16:57:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI: Remove res_to_dev_res() debug message
Message-ID: <20170130225758.GY20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170119145806.13731.64428.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170119145806.13731.64428.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 19, 2017 at 08:58:06AM -0600, Bjorn Helgaas wrote:
> Remove res_to_dev_res() debug message.  This is printed from a lookup
> function.  If the message is important, it should be printed from the
> caller with more context.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/resource for v4.11.

> ---
>  drivers/pci/setup-bus.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index f30ca75b5b6c..1ca8870245f4 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -106,14 +106,6 @@ static struct pci_dev_resource *res_to_dev_res(struct list_head *head,
>  
>  	list_for_each_entry(dev_res, head, list) {
>  		if (dev_res->res == res) {
> -			int idx = res - &dev_res->dev->resource[0];
> -
> -			dev_printk(KERN_DEBUG, &dev_res->dev->dev,
> -				 "res[%d]=%pR res_to_dev_res add_size %llx min_align %llx\n",
> -				 idx, dev_res->res,
> -				 (unsigned long long)dev_res->add_size,
> -				 (unsigned long long)dev_res->min_align);
> -
>  			return dev_res;
>  		}
>  	}
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
