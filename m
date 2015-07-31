Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35534 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbGaIS4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2015 04:18:56 -0400
References: <1437515651-20883-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1437515651-20883-1-git-send-email-m-karicheri2@ti.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <81A7634D-6946-45CB-9DFF-4FD728632D14@gmail.com>
Cc: "<pratyush.anand@gmail.com>" <pratyush.anand@gmail.com>,
	"<bhelgaas@google.com>" <bhelgaas@google.com>,
	"<linux-pci@vger.kernel.org>" <linux-pci@vger.kernel.org>,
	"<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>,
	jingoohan1@gmail.com
From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [Resend: PATCH] PCI: designware: fix the boot noise for missing *config* reg space
Date: Fri, 31 Jul 2015 17:18:49 +0900
To: Murali Karicheri <m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015. 7. 22., at AM 6:54, Murali Karicheri <m-karicheri2@ti.com> wrote:
> 
> Currently on Keystone SoCs, boot up log shows an unnecessary boot
> noise as follows:-
> 
> [    0.365823] keystone-pcie 21021000.pcie: missing *config* reg space
> 
> Keystone uses older version of designware h/w that doesn't have ATU
> support. So va_cfg0_base and va_cfg1_base are already set up in
> ks_dw_pcie_host_init() before calling dw_pcie_host_init() and
> they point to the remote config space address va (both same for Keystone).
> So add a check to avoid this boot noise on Keystone.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> - Resend with "PCI: designware" prefix in subject
> drivers/pci/host/pcie-designware.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 69486be..b48b8a2 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -388,7 +388,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>        addrp = of_get_address(np, index, NULL, NULL);
>        pp->cfg0_mod_base = of_read_number(addrp, ns);
>        pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
> -    } else {
> +    } else if (!pp->va_cfg0_base) {
>        dev_err(pp->dev, "missing *config* reg space\n");
>    }
> 
> -- 
> 1.9.1
> 
