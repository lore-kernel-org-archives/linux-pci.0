Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37798 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbaFZIp1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 04:45:27 -0400
Message-ID: <1403772229.4254.4.camel@weser.hi.pengutronix.de>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
From: Lucas Stach <l.stach@pengutronix.de>
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Richard Zhu <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Thu, 26 Jun 2014 10:43:49 +0200
In-Reply-To: <20140625125306.GB6917@dragon>
References: <20140624153559.GA5741@dragon>
	 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
	 <20140625062243.GD3242@dragon>
	 <CAOMZO5BuOhWo7SCEPFmNRUQBi=5JhDrVv0yvBQM2d_jMyLkbyw@mail.gmail.com>
	 <1403693452.4249.1.camel@weser.hi.pengutronix.de>
	 <20140625125306.GB6917@dragon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 25.06.2014, 20:53 +0800 schrieb Shawn Guo:
> On Wed, Jun 25, 2014 at 12:50:52PM +0200, Lucas Stach wrote:
> > Am Mittwoch, den 25.06.2014, 07:50 -0300 schrieb Fabio Estevam:
> > > On Wed, Jun 25, 2014 at 3:22 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > 
> > > > Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> > > > should be another issue.
> > > 
> > > Yes, I see it now. Tested on -rc2 and suspend/resume works with PCI
> > > driver removed.
> > 
> > Can you please send me a dmesg from a working boot?
> 
> What do you mean by "working boot"?  Boot is always working.  What fails
> is system resuming.
> 
> Shawn
> 
Oops, what I meant is a dmesg after a working resume (from kernel 3.15).
I can see how failing to resume from L2 can cause the hang and we should
really implement the PHY PD toggling in the pcie driver, but I would
like to understand why you don't hit this on 3.15.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

