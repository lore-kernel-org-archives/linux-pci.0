Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60927 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbaGQGwE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jul 2014 02:52:04 -0400
Date: Thu, 17 Jul 2014 08:51:48 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: bhelgaas@google.com, r65037@freescale.com, shawn.guo@freescale.com,
	marex@denx.de, d.mueller@elsoft.ch, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	tharvey@gateworks.com, Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Message-ID: <20140717065148.GT11056@pengutronix.de>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, Jun 24, 2014 at 04:18:27PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a kernel 
> hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.
Just my thought on how to debug that: I'd try to bisect the pci init
routine in the boot loader. I.e. first only do the first half of the
initialisation in U-Boot. Depending on Linux being able to boot or not
initialize more or less on the next run.

Maybe there is a single register write that makes Linux fail?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
