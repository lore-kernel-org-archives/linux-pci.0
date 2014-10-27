Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50159 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752395AbaJ0SYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Oct 2014 14:24:40 -0400
Message-ID: <544E8DDB.9000008@ti.com>
Date: Mon, 27 Oct 2014 14:24:27 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Richard Zhu <richard.zhu@freescale.com>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: Re: [PATCH v8 5/9] PCI: imx6: Add imx6sx pcie support
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com> <1413782724-30795-6-git-send-email-richard.zhu@freescale.com>
In-Reply-To: <1413782724-30795-6-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


>   	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
>
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 1a59600..6061355 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -75,7 +75,7 @@ struct pcie_host_ops {
>   	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
>   			unsigned int devfn, int where, int size, u32 val);
>   	int (*link_up)(struct pcie_port *pp);
> -	void (*host_init)(struct pcie_port *pp);
> +	int (*host_init)(struct pcie_port *pp);
Richard,

Please update the drivers/pci/host/pci-keystine.c as well for 
host_init() as pci-keystone is already merged to v3.18rc1. Please update 
the driver if you are changing API for pcie-designware core.

Murali
>   	void (*msi_set_irq)(struct pcie_port *pp, int irq);
>   	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
>   	u32 (*get_msi_data)(struct pcie_port *pp);
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 6dea9e4..b8fd76b 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -258,10 +258,12 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
>   	return 0;
>   }
>
> -static void spear13xx_pcie_host_init(struct pcie_port *pp)
> +static int spear13xx_pcie_host_init(struct pcie_port *pp)
>   {
>   	spear13xx_pcie_establish_link(pp);
>   	spear13xx_pcie_enable_interrupts(pp);
> +
> +	return 0;
>   }
>
>   static struct pcie_host_ops spear13xx_pcie_host_ops = {

-
Murali Karicheri
Linux Kernel, Texas Instruments
