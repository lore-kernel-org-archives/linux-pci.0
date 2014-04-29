Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58353 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbaD2FfT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 01:35:19 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4S00NX826T3D20@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 29 Apr 2014 14:35:17 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Fabio Estevam' <festevam@gmail.com>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	'Fabio Estevam' <fabio.estevam@freescale.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1398741896-5953-1-git-send-email-festevam@gmail.com>
In-reply-to: <1398741896-5953-1-git-send-email-festevam@gmail.com>
Subject: Re: [PATCH v2] pci: pci-mvebu: Use '%pa' for printing 'phys_addr_t'
 type
Date: Tue, 29 Apr 2014 14:35:17 +0900
Message-id: <000e01cf636c$cd9d9c70$68d8d550$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, April 29, 2014 12:25 PM, Fabio Estevam wrote:
> 
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Fix the following build warning that happens when building multi_v7_defconfig
> with CONFIG_ARM_LPAE=y:
> 
> drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but
> argument 3 has type 'phys_addr_t' [-Wformat=]
> 
> Fix the warning by using '%pa' to printing 'phys_addr_t' type. While at it,
> also use the more standard notation [mem 0x - 0x] for memory region.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> Changes since v1:
> - use the [mem 0x - 0x] notation
> 
>  drivers/pci/host/pci-mvebu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index e384e25..df57a6a 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -330,8 +330,8 @@ static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
>  							sz, remap);
>  		if (ret) {
>  			dev_err(&port->pcie->pdev->dev,
> -				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
> -				base, sz, ret);
> +				"Could not create MBus window at [mem %pa - %pa] :%d\n",
> +				&base, &base + sz, ret);
>  			mvebu_pcie_del_windows(port, base - size_mapped,
>  					       size_mapped);
>  			return;
> --
> 1.8.3.2

