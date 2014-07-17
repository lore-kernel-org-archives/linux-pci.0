Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0208.outbound.protection.outlook.com ([207.46.163.208]:33169
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933145AbaGQPmw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Jul 2014 11:42:52 -0400
Date: Thu, 17 Jul 2014 23:27:09 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Marek Vasut <marex@denx.de>
CC: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <bhelgaas@google.com>,
	<r65037@freescale.com>, <d.mueller@elsoft.ch>,
	<kernel@pengutronix.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <tharvey@gateworks.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Message-ID: <20140717152707.GA8537@dragon>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
 <20140717065148.GT11056@pengutronix.de> <201407171023.10908.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <201407171023.10908.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 17, 2014 at 10:23:10AM +0200, Marek Vasut wrote:
> On Thursday, July 17, 2014 at 08:51:48 AM, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> > > From: Fabio Estevam <fabio.estevam@freescale.com>
> > > 
> > > When the mx6 PCI conctroller is initialized in the bootloader we see a
> > > kernel hang inside imx6_add_pcie_port().
> > > 
> > > Adding a 30ms delay allows the kernel to boot.
> > 
> > Just my thought on how to debug that: I'd try to bisect the pci init
> > routine in the boot loader. I.e. first only do the first half of the
> > initialisation in U-Boot. Depending on Linux being able to boot or not
> > initialize more or less on the next run.
> > 
> > Maybe there is a single register write that makes Linux fail?!
> 
> I am still hell-bent on thinking that the missing PCIe block reset is what makes 
> the Linux fail. Missing block reset is always a problem.

Indeed.  We're missing a hardware reset for PCIe on i.MX6Q and i.MX6DL.
Such reset is available on i.MX6SX, so there is no this problem for
i.MX6SX PCIe.

> Or do we now have a 
> mean to reset the PCIe block and it's PHY from software?

Richard is trying to find a SW workaround for it, but we're not really
sure if it's possible.

Shawn
