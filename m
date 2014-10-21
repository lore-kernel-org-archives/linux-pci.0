Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaJUK1L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Oct 2014 06:27:11 -0400
Message-ID: <1413887229.2751.4.camel@pengutronix.de>
Subject: Re: [PATCH v8 2/9] PCI: designware: Fix one potential assignment
 error of cfg start
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com, m-karicheri2@ti.com,
	Richard Zhu <r65037@freescale.com>
Date: Tue, 21 Oct 2014 12:27:09 +0200
In-Reply-To: <1413782724-30795-3-git-send-email-richard.zhu@freescale.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
	 <1413782724-30795-3-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 20.10.2014, 13:25 +0800 schrieb Richard Zhu:
> From: Richard Zhu <r65037@freescale.com>
> 
> if va_cfg0_base/va_cfg1_base are initialized by
> designware core, the pp->cfg.start is not initialized
> properly, when IORESOURCE_MEM "config" is represented
> as cfg space resource.
> solution: assign cfg_res->start to pp->cfg.start.
> 
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
> ---
>  drivers/pci/host/pcie-designware.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 8d1c809..e3cd54a 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -472,6 +472,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  	if (cfg_res) {
>  		pp->config.cfg0_size = resource_size(cfg_res)/2;
>  		pp->config.cfg1_size = resource_size(cfg_res)/2;
> +		pp->cfg.start = cfg_res->start;
>  		pp->cfg0_base = cfg_res->start;
>  		pp->cfg1_base = cfg_res->start + pp->config.cfg0_size;
>  

I think this patch should not be needed anymore. Please look at commit
ec98e9ab6f24 (PCI: designware: Fix configuration base address when using
'reg') in 3.18-rc1. I think it fixes the same bug, but in a different
way. Can you confirm that this works for you?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

