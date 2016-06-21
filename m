Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38450 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbcFUCAK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jun 2016 22:00:10 -0400
Date: Mon, 20 Jun 2016 20:50:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
Subject: Re: [RESEND PATCH v2 2/4] PCI: Do not Use IORESOURCE_STARTALIGN to
 identify bridge resources
Message-ID: <20160621015045.GB30307@localhost>
References: <1464846411-16895-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1464846411-16895-3-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464846411-16895-3-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 02, 2016 at 01:46:49PM +0800, Yongji Xie wrote:
> Now we use the IORESOURCE_STARTALIGN to identify bridge resources
> in __assign_resources_sorted(). That's quite fragile. We can't
> make sure that the PCI devices' resources will not use
> IORESOURCE_STARTALIGN any more.

Can you explain this a little more?  I don't quite understand the
problem.  Maybe you can give an example of the problem?

> In this patch, we try to use a more robust way to identify
> bridge resources.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-bus.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 55641a3..216ddbc 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -390,6 +390,7 @@ static void __assign_resources_sorted(struct list_head *head,
>  	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
>  	unsigned long fail_type;
>  	resource_size_t add_align, align;
> +	int index;
>  
>  	/* Check if optional add_size is there */
>  	if (!realloc_head || list_empty(realloc_head))
> @@ -410,11 +411,13 @@ static void __assign_resources_sorted(struct list_head *head,
>  
>  		/*
>  		 * There are two kinds of additional resources in the list:
> -		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
> -		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
> +		 * 1. bridge resource
> +		 * 2. SR-IOV resource
>  		 * Here just fix the additional alignment for bridge
>  		 */
> -		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
> +		index = dev_res->res - dev_res->dev->resource;
> +		if (index < PCI_BRIDGE_RESOURCES ||
> +			index > PCI_BRIDGE_RESOURCE_END)

I think the code looks OK; at least, it seems to match the comment.
I'd just like to understand the problem a little better.

>  			continue;
>  
>  		add_align = get_res_add_align(realloc_head, dev_res->res);
> -- 
> 1.7.9.5
> 
