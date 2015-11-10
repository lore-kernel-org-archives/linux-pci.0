Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54390 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbKJJaG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2015 04:30:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	linux-pci@vger.kernel.org, Richard.Zhu@freescale.com,
	linux-kernel@vger.kernel.org, David Mueller <dave.mueller@gmx.ch>,
	bhelgaas@google.com
Subject: Re: [PATCH] PCI: imx6:don't sleep in atomic context
Date: Tue, 10 Nov 2015 10:28:46 +0100
Message-ID: <4800389.dqcmlJY3HC@wuerfel>
In-Reply-To: <1447144878.3142.3.camel@pengutronix.de>
References: <1447066080-5859-1-git-send-email-sanjeev_sharma@mentor.com> <1447144878.3142.3.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 10 November 2015 09:41:18 Lucas Stach wrote:
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index 233a196..9769b13 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -499,7 +499,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
> >                * Wait a little bit, then re-check if the link finished
> >                * the training.
> >                */
> > -             usleep_range(1000, 2000);
> > +             mdelay(1000);
> 
> A mdelay(1000) is a whole different timescale than a usleep(1000). If
> this patch works for you with mdelay(1) or maybe mdelay(2) I would be
> fine with it.

mdelay(1) is still a really long time to block the CPU for, on potentially
every config space access.

Everybody else just returns the link status here, which seems to be
the better alternative. If you need to delay the startup, better have
a msleep(1) loop in the initial probe function where you are allowed to
sleep.

	Arnd
