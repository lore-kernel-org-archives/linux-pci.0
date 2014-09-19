Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35930 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425AbaISP1g (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Sep 2014 11:27:36 -0400
Message-ID: <1411140448.2739.1.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: designware: Use NULL instead of false
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: bhelgaas@google.com, mohit.kumar@st.com, jg1.han@samsung.com,
	linux-pci@vger.kernel.org
Date: Fri, 19 Sep 2014 17:27:28 +0200
In-Reply-To: <1411134450-806-1-git-send-email-fabio.estevam@freescale.com>
References: <1411134450-806-1-git-send-email-fabio.estevam@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 19.09.2014, 10:47 -0300 schrieb Fabio Estevam:
> of_get_address() expects pointers in the third and fourth parameters.
> 
> Pass NULL in order to fix the following sparse warnings:
> 
> drivers/pci/host/pcie-designware.c:433:51: warning: Using plain integer as NULL pointer
> drivers/pci/host/pcie-designware.c:433:58: warning: Using plain integer as NULL pointer 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>
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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

