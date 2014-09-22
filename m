Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59663 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbaIVJ0H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 05:26:07 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NCA00GQVQ7HJIC0@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 22 Sep 2014 18:26:05 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Fabio Estevam' <fabio.estevam@freescale.com>
Cc: bhelgaas@google.com, mohit.kumar@st.com, linux-pci@vger.kernel.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1411134450-806-1-git-send-email-fabio.estevam@freescale.com>
In-reply-to: <1411134450-806-1-git-send-email-fabio.estevam@freescale.com>
Subject: Re: [PATCH] PCI: designware: Use NULL instead of false
Date: Mon, 22 Sep 2014 18:26:05 +0900
Message-id: <00ac01cfd647$3c1ab8c0$b4502a40$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 19, 2014 10:48 PM, Fabio Estevam wrote:
> 
> of_get_address() expects pointers in the third and fourth parameters.
> 
> Pass NULL in order to fix the following sparse warnings:
> 
> drivers/pci/host/pcie-designware.c:433:51: warning: Using plain integer as NULL pointer
> drivers/pci/host/pcie-designware.c:433:58: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/pci/host/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 12c42fc..f1f0b7a 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -430,7 +430,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
> 
>  		/* Find the untranslated configuration space address */
>  		index = of_property_match_string(np, "reg-names", "config");
> -		addrp = of_get_address(np, index, false, false);
> +		addrp = of_get_address(np, index, NULL, NULL);
>  		pp->cfg0_mod_base = of_read_number(addrp, ns);
>  		pp->cfg1_mod_base = pp->cfg0_mod_base + pp->config.cfg0_size;
>  	} else {
> --
> 1.9.1

