Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40143 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbaKMQsk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 11:48:40 -0500
Received: by mail-pd0-f169.google.com with SMTP id y10so14767074pdj.14
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 08:48:40 -0800 (PST)
Date: Thu, 13 Nov 2014 09:48:33 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Pratyush Anand' <pratyush.anand@st.com>
Subject: Re: [PATCH] PCI: spear: Add __init annotation to
 spear13xx_add_pcie_port()
Message-ID: <20141113164833.GD5064@google.com>
References: <001f01cff983$deb4da20$9c1e8e60$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001f01cff983$deb4da20$9c1e8e60$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 06, 2014 at 02:38:18PM +0900, Jingoo Han wrote:
> Add __init annotation to spear13xx_add_pcie_port(), because
> the spear13xx_add_pcie_port() is called only by spear13xx_pcie_probe()
> that was already marked as __init. Also, this patch fixes
> section mismatch warning.
> 
> WARNING: drivers/pci/host/built-in.o(.text.unlikely+0x94): Section mismatch in reference from the function spear13xx_add_pcie_port()
> to the function .init.text:dw_pcie_host_init()
> The function spear13xx_add_pcie_port() references
> the function __init dw_pcie_host_init().
> This is often because spear13xx_add_pcie_port lacks a __init
> annotation or the annotation of dw_pcie_host_init is wrong.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied with Viresh's ack to pci/host-spear for v3.19, thanks!

> ---
> This patch is based on the submitted patch "[PATCH V2] PCI:
> spear: Add spear13xx before add_pcie_port/pcie_initt".
> 
>  drivers/pci/host/pcie-spear13xx.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 63f869f..60f43cd 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -269,8 +269,8 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
>  	.host_init = spear13xx_pcie_host_init,
>  };
>  
> -static int spear13xx_add_pcie_port(struct pcie_port *pp,
> -				   struct platform_device *pdev)
> +static int __init spear13xx_add_pcie_port(struct pcie_port *pp,
> +					 struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	int ret;
> -- 
> 1.7.9.5
> 
> 
