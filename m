Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54906 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbBMQob (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Feb 2015 11:44:31 -0500
Date: Fri, 13 Feb 2015 11:44:24 -0500
From: Simon Horman <horms@verge.net.au>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: bhelgaas@google.com, valentine.barshak@cogentembedded.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Add address check of mem_res
Message-ID: <20150213164424.GA22407@verge.net.au>
References: <1423814138-18748-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423814138-18748-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Iwamatsu-san,

On Fri, Feb 13, 2015 at 04:55:38PM +0900, Nobuhiro Iwamatsu wrote:
> lower 16 bits of the address, which is managed by mem_res need to be 0.
> This adds address check of lower 16 bits.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  drivers/pci/host/pci-rcar-gen2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index d9c042f..13b2793 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -351,6 +351,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	if (mem_res->start & 0xFFFF)
> +		return -EINVAL;
> +

This check seems correct to me. But would it make sense to place it before
the call to devm_kzalloc() rather than after it? I think that should group
it would an existing checking of mem_res.

>  	priv->mem_res = *mem_res;
>  	/*
>  	 * The controller does not support/use port I/O,
> -- 
> 2.1.3
> 
