Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46522 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaGXIwN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 04:52:13 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9700EEVKMUEO10@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 24 Jul 2014 17:52:06 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Shawn Guo' <shawn.guo@freescale.com>,
	'Lucas Stach' <l.stach@pengutronix.de>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Richard Zhu' <r65037@freescale.com>, kernel@pengutronix.de,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1406137217-11294-1-git-send-email-l.stach@pengutronix.de>
 <1406137217-11294-2-git-send-email-l.stach@pengutronix.de>
 <20140724084030.GA8821@dragon>
In-reply-to: <20140724084030.GA8821@dragon>
Subject: Re: [PATCH 1/3] MAINTAINERS: add myself as co-maintainer for i.MX6 PCI
 driver
Date: Thu, 24 Jul 2014 17:52:06 +0900
Message-id: <002c01cfa71c$8bd24590$a376d0b0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 24, 2014 5:41 PM, Shawn Guo wrote:
> On Wed, Jul 23, 2014 at 07:40:15PM +0200, Lucas Stach wrote:
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > I've talked privately to Richard about this and he's
> > in favor, but still should give an public ACK.
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 134483f206e4..54c23c4fcbb0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6775,6 +6775,7 @@ F:	arch/x86/kernel/quirks.c
> >  PCI DRIVER FOR IMX6
> >  M:	Richard Zhu <r65037@freescale.com>
> >  M:	Shawn Guo <shawn.guo@linaro.org>
> > +M:	Lucas Stach <l.stach@pengutronix.de>
> 
> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> 
> I would step down from the position, so I prefer you replace myself.

Hi Shawn,

OK, I also agree with your suggestion.
Then, do you mean the following? It looks good.

 PCI DRIVER FOR IMX6
 M:	Richard Zhu <r65037@freescale.com>
+M:	Lucas Stach <l.stach@pengutronix.de>
 M:	Shawn Guo <shawn.guo@linaro.org>

Thanks.

Best regards,
Jingoo Han

> 
> Shawn
> 
> >  L:	linux-pci@vger.kernel.org
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> > --
> > 2.0.1
> >

