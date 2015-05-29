Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38026 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbbE2VQR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2015 17:16:17 -0400
Received: by igbjd9 with SMTP id jd9so24197570igb.1
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2015 14:16:16 -0700 (PDT)
Date: Fri, 29 May 2015 16:16:13 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: keep resource size during alignment reordering
Message-ID: <20150529211613.GC12733@google.com>
References: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432878000-10921-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 10:40:00PM -0700, Yinghai Lu wrote:
> In d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing
> and assigning"), it stores additional alignment in realloc_head and takes
> this into consideration for assignment.
> During update the resource before reordering, it does not calculate
> resource end correctly.
> 
> We need to keep the original resource size before updating start.
> otherwise we will smaller size during updating end.
> 
> Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I already merged this fix for the same commit:

http://lkml.kernel.org/r/1432016657-16816-1-git-send-email-weiyang@linux.vnet.ibm.com

Is this a separate fix for a different problem?  Is it a fix for the same
problem, just implemented differently?

I'd like Wei's ack for this just to make sure we don't get things mixed up.

Wei's first fix is on my for-linus branch:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=a6b65983dabceb7ccb1801ee7f5bd421c2704d16

> ---
>  drivers/pci/setup-bus.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -428,9 +428,10 @@ static void __assign_resources_sorted(st
>  		 * consistent.
>  		 */
>  		if (add_align > dev_res->res->start) {
> +			resource_size_t r_size = resource_size(dev_res->res);
> +
>  			dev_res->res->start = add_align;
> -			dev_res->res->end = add_align +
> -				            resource_size(dev_res->res);
> +			dev_res->res->end = add_align + r_size - 1;
>  
>  			list_for_each_entry(dev_res2, head, list) {
>  				align = pci_resource_alignment(dev_res2->dev,
