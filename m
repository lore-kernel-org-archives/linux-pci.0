Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33789 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023AbaE3PxR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 May 2014 11:53:17 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so987323igd.14
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2014 08:53:17 -0700 (PDT)
Date: Fri, 30 May 2014 09:53:14 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pci@vger.kernel.org, r65037@freescale.com,
	shawn.guo@linaro.org, Sean Cross <xobs@kosagi.com>
Subject: Re: [PATCH 1/1] PCI: imx6: Annotate imx6_add_pcie_port with __init
Message-ID: <20140530155314.GD4607@google.com>
References: <1401431928-15096-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401431928-15096-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 30, 2014 at 12:08:48PM +0530, Sachin Kamat wrote:
> imx6_add_pcie_port is called from probe which is annotated with __init.
> imx6_add_pcie_port calls dw_pcie_host_init which is also annotated with
> __init. Thus it makes sense to annotate imx6_add_pcie_port with __init.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Sean Cross <xobs@kosagi.com>

This looks correct to me, so I put it on a pci/host-imx6 branch to squeeze
it in for v3.16.  Richard, Shawn, let me know (soonish, since the merge
window may open next week) if you object.

> ---
>  drivers/pci/host/pci-imx6.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index ee082509b0ba..facbf8faa353 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -487,7 +487,7 @@ static struct pcie_host_ops imx6_pcie_host_ops = {
>  	.host_init = imx6_pcie_host_init,
>  };
>  
> -static int imx6_add_pcie_port(struct pcie_port *pp,
> +static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  			struct platform_device *pdev)
>  {
>  	int ret;
> -- 
> 1.7.9.5
> 
