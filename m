Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49667 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbaGQIcE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jul 2014 04:32:04 -0400
From: Marek Vasut <marex@denx.de>
To: "Uwe =?iso-8859-1?q?Kleine-K=F6nig?="
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Date: Thu, 17 Jul 2014 10:23:10 +0200
Cc: Fabio Estevam <festevam@gmail.com>, bhelgaas@google.com,
	r65037@freescale.com, shawn.guo@freescale.com, d.mueller@elsoft.ch,
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, tharvey@gateworks.com,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com> <20140717065148.GT11056@pengutronix.de>
In-Reply-To: <20140717065148.GT11056@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201407171023.10908.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 17, 2014 at 08:51:48 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > When the mx6 PCI conctroller is initialized in the bootloader we see a
> > kernel hang inside imx6_add_pcie_port().
> > 
> > Adding a 30ms delay allows the kernel to boot.
> 
> Just my thought on how to debug that: I'd try to bisect the pci init
> routine in the boot loader. I.e. first only do the first half of the
> initialisation in U-Boot. Depending on Linux being able to boot or not
> initialize more or less on the next run.
> 
> Maybe there is a single register write that makes Linux fail?!

I am still hell-bent on thinking that the missing PCIe block reset is what makes 
the Linux fail. Missing block reset is always a problem. Or do we now have a 
mean to reset the PCIe block and it's PHY from software?

Best regards,
Marek Vasut
