Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:41571
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753757AbaGGOKj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Jul 2014 10:10:39 -0400
Date: Mon, 7 Jul 2014 21:55:03 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Lucas Stach <l.stach@pengutronix.de>
CC: Richard Zhu <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"Fabio Estevam" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
Message-ID: <20140707135502.GR30239@dragon>
References: <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
 <20140625062243.GD3242@dragon>
 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
 <20140625125306.GB6917@dragon>
 <1403772229.4254.4.camel@weser.hi.pengutronix.de>
 <20140628143712.GA7869@dragon>
 <1404135864.4305.23.camel@weser.hi.pengutronix.de>
 <20140701065105.GE14471@dragon>
 <1404724251.4587.20.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1404724251.4587.20.camel@weser.hi.pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 07, 2014 at 11:10:51AM +0200, Lucas Stach wrote:
> Hi Shawn,
> 
> Over the weekend I tried to reproduce your problem on a SabreSD board,
> but wasn't able to trigger the issue. 3.16-rc3 with PCIe active works
> just fine over a suspend and resume cycle for me.

That's strange.  In my setup, PCIe support is enabled in kernel and DT,
but I do not have a PCIe device connected to the board.

> 
> One possibly relevant difference is that I've booted with NFSroot, while
> it seems you are using a SATA connected device. Is this right?

I have a SATA disk connected, but did boot with NFSroot.

> If so,
> can you test if it works if you boot from SDcard or the like? This might
> be relevant as PCIe and SATA share some clocks.

I tried to disable SATA support completely, but it doesn't help.

$ echo mem > /sys/power/state
[  410.052595] PM: Syncing filesystems ... done.
[  410.150033] PM: Preparing system for mem sleep
[  410.207963] Freezing user space processes ... (elapsed 0.004 seconds) done.
[  410.219796] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[  410.230243] PM: Entering mem sleep
[  410.316574] PM: suspend of devices complete after 79.461 msecs
[  410.322498] PM: suspend devices took 0.090 seconds
[  410.332655] PM: late suspend of devices complete after 5.338 msecs


Shawn
