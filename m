Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55450 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbaD1LIJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Apr 2014 07:08:09 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4Q00KTKMXKE020@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 28 Apr 2014 20:08:08 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Fabio Estevam' <festevam@gmail.com>
Cc: thomas.petazzoni@free-electrons.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	'Fabio Estevam' <fabio.estevam@freescale.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1398682281-18772-1-git-send-email-festevam@gmail.com>
In-reply-to: <1398682281-18772-1-git-send-email-festevam@gmail.com>
Subject: Re: [PATCH] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t' type
Date: Mon, 28 Apr 2014 20:08:07 +0900
Message-id: <002301cf62d2$228cf0f0$67a6d2d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, April 28, 2014 7:51 PM, Fabio Estevam wrote:
> 
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fix the following build warning that happens when building multi_v7_defconfig
> with CONFIG_ARM_LPAE=y:
> 
> drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but
> argument 3 has type 'phys_addr_t' [-Wformat=]
> 
> While at it, also use '%zx' for printing 'size_t'.
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pci-mvebu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index e384e25..572a7b5 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -330,8 +330,8 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
>  							sz, remap);
>  		if (ret) {
>  			dev_err(&port->pcie->pdev->dev,
> -				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
> -				base, sz, ret);
> +				"Could not create MBus window at %pa, size 0x%zx: %d\n",
> +				&base, sz, ret);
>  			mvebu_pcie_del_windows(port, base - size_mapped,
>  					       size_mapped);
>  			return;
> --
> 1.8.3.2

