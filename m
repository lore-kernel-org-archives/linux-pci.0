Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0209.outbound.protection.outlook.com ([207.46.163.209]:35753
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750967AbaF1Ohn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 28 Jun 2014 10:37:43 -0400
Date: Sat, 28 Jun 2014 22:37:14 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Lucas Stach <l.stach@pengutronix.de>
CC: Shawn Guo <shawn.guo@freescale.com>,
	Richard Zhu <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
Message-ID: <20140628143712.GA7869@dragon>
References: <20140624153559.GA5741@dragon>
 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
 <20140625062243.GD3242@dragon>
 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
 <20140625125306.GB6917@dragon>
 <1403772229.4254.4.camel@weser.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1403772229.4254.4.camel@weser.hi.pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 26, 2014 at 10:43:49AM +0200, Lucas Stach wrote:
> Am Mittwoch, den 25.06.2014, 20:53 +0800 schrieb Shawn Guo:
> > On Wed, Jun 25, 2014 at 12:50:52PM +0200, Lucas Stach wrote:
> > > Am Mittwoch, den 25.06.2014, 07:50 -0300 schrieb Fabio Estevam:
> > > > On Wed, Jun 25, 2014 at 3:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > > 
> > > > > Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> > > > > should be another issue.
> > > > 
> > > > Yes, I see it now. Tested on -rc2 and suspend/resume works with PCI
> > > > driver removed.
> > > 
> > > Can you please send me a dmesg from a working boot?
> > 
> > What do you mean by "working boot"?  Boot is always working.  What fails
> > is system resuming.
> > 
> > Shawn
> > 
> Oops, what I meant is a dmesg after a working resume (from kernel 3.15).
> I can see how failing to resume from L2 can cause the hang and we should
> really implement the PHY PD toggling in the pcie driver, but I would
> like to understand why you don't hit this on 3.15.

Sorry, Lucas.  I just noticed that in my 3.15 testing PCIe is not
enabled in device tree at all.  So the issue should have already been
there before your changes to PCIe driver.

Shawn
