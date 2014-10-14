Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37408 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822AbaJNWNI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 18:13:08 -0400
Message-ID: <1413324779.2511.3.camel@antimon.intern.lynxeye.de>
Subject: Re: [PATCH v5 4/9] PCI: imx6: add imx6sx pcie support
From: Lucas Stach <l.stach@pengutronix.de>
To: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
Cc: Richard Zhu <richard.zhu@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shengchao Guo <Shawn.Guo@freescale.com>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>
Date: Wed, 15 Oct 2014 00:12:59 +0200
In-Reply-To: <c4b4d11b4024456cb5fdc9d36424e875@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
	 <1412919676-25344-5-git-send-email-richard.zhu@freescale.com>
	 <1413124067.2459.12.camel@antimon.intern.lynxeye.de>
	 <c4b4d11b4024456cb5fdc9d36424e875@DM2PR0301MB0862.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

Am Montag, den 13.10.2014, 02:30 +0000 schrieb
Hong-Xing.Zhu@freescale.com:
> Hi Lucas:
> 
> > -----Original Message-----
> > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> > On Behalf Of Lucas Stach
> > Sent: Sunday, October 12, 2014 10:28 PM
> > To: Richard Zhu
> > Cc: linux-pci@vger.kernel.org; Guo Shawn-R65073; festevam@gmail.com;
> > tharvey@gateworks.com; Zhu Richard-R65037
> > Subject: Re: [PATCH v5 4/9] PCI: imx6: add imx6sx pcie support
> > 
> > Am Freitag, den 10.10.2014, 13:41 +0800 schrieb Richard Zhu:
> > > From: Richard Zhu <r65037@freescale.com>
> > >
> > > - imx6sx pcie has its own standalone pcie power supply.
> > > In order to turn on the imx6sx pcie power during initialization. Add
> > > the pcie regulator and the gpc regmap into the imx6sx pcie structure.
> > > - imx6sx pcie has the new added reset mechanism, add the reset
> > > operations into the initialization.
> > > - Register one PM call-back, enter/exit L2 state of the ASPM during
> > > system suspend/resume.
> > > - disp_axi clock is required by pcie inbound axi port actually.
> > > Add one more clock named pcie_inbound_axi for imx6sx pcie.
> > 
> > > Signed-off-by: Richard Zhu <richard.zhu@freescale.com>
> > 
> > In addition to Fabios comment I have one additional nitpick below and also you
> > didn't include all the feedback from the last round.
> > 
> > > ---
> > >  drivers/pci/host/pci-imx6.c | 161
> > > +++++++++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 143 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > > index eac96fb..5ece4e1 100644
> > > --- a/drivers/pci/host/pci-imx6.c
> > > +++ b/drivers/pci/host/pci-imx6.c
> > > @@ -22,8 +22,10 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/regulator/consumer.h>
> > >  #include <linux/resource.h>
> > >  #include <linux/signal.h>
> > > +#include <linux/syscore_ops.h>
> > >  #include <linux/types.h>
> > >  #include <linux/interrupt.h>
> > >
> > > @@ -35,11 +37,15 @@ struct imx6_pcie {
> > >  	int			reset_gpio;
> > >  	struct clk		*pcie_bus;
> > >  	struct clk		*pcie_phy;
> > > +	struct clk		*pcie_inbound_axi;
> > >  	struct clk		*pcie;
> > >  	struct pcie_port	pp;
> > >  	struct regmap		*iomuxc_gpr;
> > > +	struct regmap		*gpc_ips_reg;
> > > +	struct regulator	*pcie_phy_regulator;
> > >  	void __iomem		*mem_base;
> > >  };
> > > +static struct imx6_pcie *imx6_pcie;
> > 
> > Remove this static struct. I've already said on the last version that this is
> > completely backwards.
> > 
> [Richard] I added my comments in the last round.
>  Can't use imx6_pcie struct syscore suspend/resume, if the imx6_pcie is not a static type structure.
> "
> Hi Lucas:
> Regarding to the definitions(pasted below) of the struct syscore_ops, both suspend and resume of the syscore_ops is void type functions.
> If there is no the static global struct imx6_pcie, I don't know how it can be used in suspend/resume of pci_imx_syscore_ops.
> struct syscore_ops {
>         struct list_head node;
>         int (*suspend)(void);
>         void (*resume)(void);
>         void (*shutdown)(void);
> };
> "
This only means syscore ops is not the right interface to use here.
Introducing global static vars to hold driver instance state is a
receipt to create trouble later on. Don't ever do this.

I think it should be possible to move those calls to normal dev_pm_ops,
maybe use suspend/resume_noirq or even poweroff/restore_noirq.

Regards,
Lucas

