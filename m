Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52627 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbbBPOBi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Feb 2015 09:01:38 -0500
Date: Mon, 16 Feb 2015 09:01:33 -0500
From: Simon Horman <horms@verge.net.au>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: bhelgaas@google.com, valentine.barshak@cogentembedded.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar: Add address check of mem_res
Message-ID: <20150216140133.GB5479@verge.net.au>
References: <1424051648-7430-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424051648-7430-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 16, 2015 at 10:54:08AM +0900, Nobuhiro Iwamatsu wrote:
> lower 16 bits of the address, which is managed by mem_res need to be 0.
> This adds address check of lower 16 bits.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  v2: Remove to before devm_kzalloc().
> 
>  drivers/pci/host/pci-rcar-gen2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index d9c042f..e9617d3 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -346,6 +346,9 @@ static int rcar_pci_probe(struct platform_device *pdev)
>  	if (!mem_res || !mem_res->start)
>  		return -ENODEV;
>  
> +	if (mem_res->start & 0xFFFF)
> +		return -EINVAL;
> +
>  	priv = devm_kzalloc(&pdev->dev,
>  			    sizeof(struct rcar_pci_priv), GFP_KERNEL);
>  	if (!priv)
> -- 
> 2.1.3
> 
