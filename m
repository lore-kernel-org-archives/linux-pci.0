Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35437 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbbE0Q6m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 12:58:42 -0400
Received: by iesa3 with SMTP id a3so18444159ies.2
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2015 09:58:41 -0700 (PDT)
Date: Wed, 27 May 2015 11:58:38 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: break when finding the first smaller resource
Message-ID: <20150527165838.GW32152@google.com>
References: <1432016657-16816-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432016657-16816-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 02:24:17PM +0800, Wei Yang wrote:
> In commit d74b9027a4da(PCI: Consider additional PF's IOV BAR alignment in
> sizing and assigning), it stores additional alignment in realloc_head and
> take this into consideration for assignment.
> 
> After getting the additional alignment, it will re-order the head list to
> make sure resources with bigger alignment is ahead of the resources with
> smaller assignment in the head list. To make it happen, it iterate on the
> head list and find a smaller alignment resource and insert ahead of it.
> This should be done for the first occurrence, while the code now will
> iterate on the whole list.
> 
> This patch fixes this behavior by break when finding the first smaller
> resource in the head list.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Applied to for-linus for v4.1, thanks.

> ---
>  drivers/pci/setup-bus.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4fd0cac..aa281d9 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -435,9 +435,11 @@ static void __assign_resources_sorted(struct list_head *head,
>  			list_for_each_entry(dev_res2, head, list) {
>  				align = pci_resource_alignment(dev_res2->dev,
>  							       dev_res2->res);
> -				if (add_align > align)
> +				if (add_align > align) {
>  					list_move_tail(&dev_res->list,
>  						       &dev_res2->list);
> +					break;
> +				}
>  			}
>                 }
>  
> -- 
> 1.7.9.5
> 
