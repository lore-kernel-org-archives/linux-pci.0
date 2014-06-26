Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37763 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaFZInI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 04:43:08 -0400
Message-ID: <1403772085.4254.1.camel@weser.hi.pengutronix.de>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, r65037@freescale.com, marex@denx.de,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-pci@vger.kernel.org, tharvey@gateworks.com,
	shawn.guo@freescale.com, kernel@pengutronix.de,
	d.mueller@elsoft.ch, linux-arm-kernel@lists.infradead.org
Date: Thu, 26 Jun 2014 10:41:25 +0200
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

Am Dienstag, den 24.06.2014, 16:18 -0300 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
> hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.
> 
> Suggested-by: David Müller <d.mueller@elsoft.ch>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> I am happy to get feedback on how to properly fix this.
> 
> Thanks
> 
>  drivers/pci/host/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index a568efa..669f771 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -507,6 +507,8 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
>  	pp->root_bus_nr = -1;
>  	pp->ops = &imx6_pcie_host_ops;
>  
> +	usleep_range(25000, 30000);
> +
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to initialize host\n");

I would suspect the issue to be somewhere in imx6_pcie_host_init(). Can
you move the delay there (and to different positions in this function)
to narrow down where the hang happens?

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

