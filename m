Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:7697
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753335AbaFYGMs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jun 2014 02:12:48 -0400
Date: Wed, 25 Jun 2014 14:12:40 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>
CC: Richard Zhu <r65037@freescale.com>, <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
Message-ID: <20140625061238.GA3242@dragon>
References: <20140624153559.GA5741@dragon>
 <1403626435.4230.17.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1403626435.4230.17.camel@weser.hi.pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 24, 2014 at 06:13:55PM +0200, Lucas Stach wrote:
> Hi Shawn,
> 
> Am Dienstag, den 24.06.2014, 23:36 +0800 schrieb Shawn Guo:
> > Hi Lucas,
> > 
> > I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> > just fine if PCIe support is built out.  However the issue was not
> > exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> > is part of the cause.
> > 
> I don't yet see why any of the changes to the designware/imx6 host
> driver would cause such failures.
> 
> Which board are you doing your testing on? What devices are connected to
> the PCIe bus? In what way does it break system resume, complete hang?

It's on imx6q-sabresd without any PCIe device connected.  Right, it's a
complete hang after enabling non-boot CPUs.

...
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
<*** hang here ***>

Shawn
