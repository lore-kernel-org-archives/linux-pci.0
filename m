Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:51039 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbaIVUya (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 16:54:30 -0400
Received: by mail-ig0-f171.google.com with SMTP id hn15so3492733igb.10
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 13:54:29 -0700 (PDT)
Date: Mon, 22 Sep 2014 14:54:26 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: mohit.kumar@st.com, jg1.han@samsung.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: designware: Use NULL instead of false
Message-ID: <20140922205426.GI1880@google.com>
References: <1411134450-806-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411134450-806-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 19, 2014 at 10:47:30AM -0300, Fabio Estevam wrote:
> of_get_address() expects pointers in the third and fourth parameters.
> 
> Pass NULL in order to fix the following sparse warnings:
> 
> drivers/pci/host/pcie-designware.c:433:51: warning: Using plain integer as NULL pointer
> drivers/pci/host/pcie-designware.c:433:58: warning: Using plain integer as NULL pointer 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied with acks from Lucas and Jingoo to pci/host-designware for v3.18,
thanks!

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
> 
