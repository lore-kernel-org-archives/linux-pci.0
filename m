Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [65.55.169.112] ([65.55.169.112]:2112 "EHLO
	na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933984AbaJaC7X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 22:59:23 -0400
From: "Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>
To: Murali Karicheri <m-karicheri2@ti.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: RE: [PATCH v8 5/9] PCI: imx6: Add imx6sx pcie support
Date: Fri, 31 Oct 2014 02:43:48 +0000
Message-ID: <2014dd5aeb7748ff80fdd63e17e25801@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
 <1413782724-30795-6-git-send-email-richard.zhu@freescale.com>
 <544E8DDB.9000008@ti.com>
In-Reply-To: <544E8DDB.9000008@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Murali Karicheri [mailto:m-karicheri2@ti.com]
> Sent: Tuesday, October 28, 2014 2:24 AM
> To: Zhu Richard-R65037
> Cc: linux-pci@vger.kernel.org; Guo Shawn-R65073; festevam@gmail.com;
> l.stach@pengutronix.de; tharvey@gateworks.com; Zhu Richard-R65037
> Subject: Re: [PATCH v8 5/9] PCI: imx6: Add imx6sx pcie support
> 
> 
> >   	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> >
> > diff --git a/drivers/pci/host/pcie-designware.h
> > b/drivers/pci/host/pcie-designware.h
> > index 1a59600..6061355 100644
> > --- a/drivers/pci/host/pcie-designware.h
> > +++ b/drivers/pci/host/pcie-designware.h
> > @@ -75,7 +75,7 @@ struct pcie_host_ops {
> >   	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
> >   			unsigned int devfn, int where, int size, u32 val);
> >   	int (*link_up)(struct pcie_port *pp);
> > -	void (*host_init)(struct pcie_port *pp);
> > +	int (*host_init)(struct pcie_port *pp);
> Richard,
> 
> Please update the drivers/pci/host/pci-keystine.c as well for
> host_init() as pci-keystone is already merged to v3.18rc1. Please update the
> driver if you are changing API for pcie-designware core.
> 
> Murali
Got that, thanks for your notice.

Best Regards
Richard Zhu
> >   	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> >   	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> >   	u32 (*get_msi_data)(struct pcie_port *pp); diff --git
> > a/drivers/pci/host/pcie-spear13xx.c
> > b/drivers/pci/host/pcie-spear13xx.c
> > index 6dea9e4..b8fd76b 100644
> > --- a/drivers/pci/host/pcie-spear13xx.c
> > +++ b/drivers/pci/host/pcie-spear13xx.c
> > @@ -258,10 +258,12 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
> >   	return 0;
> >   }
> >
> > -static void spear13xx_pcie_host_init(struct pcie_port *pp)
> > +static int spear13xx_pcie_host_init(struct pcie_port *pp)
> >   {
> >   	spear13xx_pcie_establish_link(pp);
> >   	spear13xx_pcie_enable_interrupts(pp);
> > +
> > +	return 0;
> >   }
> >
> >   static struct pcie_host_ops spear13xx_pcie_host_ops = {
> 
> -
> Murali Karicheri
> Linux Kernel, Texas Instruments
