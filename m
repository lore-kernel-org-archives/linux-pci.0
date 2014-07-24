Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0243.outbound.protection.outlook.com ([207.46.163.243]:17102
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750787AbaGXIyg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Jul 2014 04:54:36 -0400
Date: Thu, 24 Jul 2014 16:54:10 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Jingoo Han <jg1.han@samsung.com>
CC: 'Lucas Stach' <l.stach@pengutronix.de>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, 'Richard Zhu' <r65037@freescale.com>,
	<kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] MAINTAINERS: add myself as co-maintainer for i.MX6
 PCI driver
Message-ID: <20140724085410.GC8821@dragon>
References: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
 <1406137217-11294-2-git-send-email-l.stach@pengutronix.de>
 <20140724084030.GA8821@dragon>
 <002c01cfa71c$8bd24590$a376d0b0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <002c01cfa71c$8bd24590$a376d0b0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 24, 2014 at 05:52:06PM +0900, Jingoo Han wrote:
> On Thursday, July 24, 2014 5:41 PM, Shawn Guo wrote:
> > On Wed, Jul 23, 2014 at 07:40:15PM +0200, Lucas Stach wrote:
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > > I've talked privately to Richard about this and he's
> > > in favor, but still should give an public ACK.
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 134483f206e4..54c23c4fcbb0 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6775,6 +6775,7 @@ F:	arch/x86/kernel/quirks.c
> > >  PCI DRIVER FOR IMX6
> > >  M:	Richard Zhu <r65037@freescale.com>
> > >  M:	Shawn Guo <shawn.guo@linaro.org>
> > > +M:	Lucas Stach <l.stach@pengutronix.de>
> > 
> > Acked-by: Shawn Guo <shawn.guo@freescale.com>
> > 
> > I would step down from the position, so I prefer you replace myself.
> 
> Hi Shawn,
> 
> OK, I also agree with your suggestion.
> Then, do you mean the following? It looks good.
> 
>  PCI DRIVER FOR IMX6
>  M:	Richard Zhu <r65037@freescale.com>
> +M:	Lucas Stach <l.stach@pengutronix.de>
>  M:	Shawn Guo <shawn.guo@linaro.org>

Hi Jingoo,

I meant the following :)

  PCI DRIVER FOR IMX6
  M:	Richard Zhu <r65037@freescale.com>
 -M:	Shawn Guo <shawn.guo@linaro.org>
 +M:	Lucas Stach <l.stach@pengutronix.de>

Shawn
