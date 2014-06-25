Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1lp0145.outbound.protection.outlook.com ([207.46.163.145]:40635
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752609AbaFYNCL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Jun 2014 09:02:11 -0400
Date: Wed, 25 Jun 2014 20:46:36 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Shawn Guo <shawn.guo@linaro.org>
CC: Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: The imx6q suspend/resume is broken on 3.16-rc due to PCIe
Message-ID: <20140625124635.GA6917@dragon>
References: <20140624153559.GA5741@dragon>
 <CAOMZO5AT54hOF2bi9bQwmBcdtG0QHyofQgoRG6Mw_RpDQXzx=w@mail.gmail.com>
 <20140625062243.GD3242@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140625062243.GD3242@dragon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 25, 2014 at 02:22:44PM +0800, Shawn Guo wrote:
> On Tue, Jun 24, 2014 at 04:37:19PM -0300, Fabio Estevam wrote:
> > On Tue, Jun 24, 2014 at 12:36 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > Hi Lucas,
> > >
> > > I found that imx6q suspend/resume is broken on 3.16-rc, and it works
> > > just fine if PCIe support is built out.  However the issue was not
> > > exposed on 3.15, so I suspect the PCIe driver change merged in 3.16
> > > is part of the cause.
> > 
> > I have just tested this on linux-next and I see that suspend/resume
> > fails even if I build a kernel without PCI support.
> 
> Please test against v3.16-rc1 or -rc2.  The breakage on linux-next
> should be another issue.

Yeah, the issue on linux-next is caused by commit 478850160636 (irq_work:
Implement remote queueing).  And Stephen reported the issue as below.

https://lkml.org/lkml/2014/6/24/765

Shawn
