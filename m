Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35128 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754243AbbFAXHf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2015 19:07:35 -0400
Received: by iesa3 with SMTP id a3so120834433ies.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2015 16:07:34 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:07:31 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PCI: keep resource size during alignment reordering
Message-ID: <20150601230731.GC3631@google.com>
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

Applied with Wei's ack to for-linus for v4.1, thanks!

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
