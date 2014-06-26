Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0142.outbound.protection.outlook.com ([207.46.163.142]:5299
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756178AbaFZDNH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jun 2014 23:13:07 -0400
Date: Thu, 26 Jun 2014 11:12:49 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Fabio Estevam <festevam@gmail.com>
CC: <bhelgaas@google.com>, <r65037@freescale.com>, <marex@denx.de>,
	<d.mueller@elsoft.ch>, <kernel@pengutronix.de>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <tharvey@gateworks.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Message-ID: <20140626031247.GN2224@dragon>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
> hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.

We may not want to add a random delay into the driver before we
understand the root cause of the issue.

Do you see this issue with FSL kernel?

Shawn

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
> -- 
> 1.8.3.2
> 
