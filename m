Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965312AbeAMAIo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jan 2018 19:08:44 -0500
Date: Fri, 12 Jan 2018 18:08:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pci/setup-bus: Delete an error message for a failed
 memory allocation in add_to_list()
Message-ID: <20180113000839.GD205469@bhelgaas-glaptop.roam.corp.google.com>
References: <fd9d212e-e8da-1aa7-be7f-7bf6d8f1e15f@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fd9d212e-e8da-1aa7-be7f-7bf6d8f1e15f@users.sourceforge.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 29, 2017 at 12:47:11PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2017 12:15:16 +0100
> 
> Omit an extra message for a memory allocation failure in this function.

If this is an "extra" message, I assume there's some other message?
Can you mention where that is in the changelog?

Also, please squash all the drivers/pci patches into one.

> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pci/setup-bus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b1ad466199ad..d131d29c4fdb 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -67,10 +67,8 @@ static int add_to_list(struct list_head *head,
>  	struct pci_dev_resource *tmp;
>  
>  	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
> -	if (!tmp) {
> -		pr_warn("add_to_list: kmalloc() failed!\n");
> +	if (!tmp)
>  		return -ENOMEM;
> -	}
>  
>  	tmp->res = res;
>  	tmp->dev = dev;
> -- 
> 2.15.1
> 
