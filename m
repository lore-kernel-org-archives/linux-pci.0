Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHRr7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Aug 2018 13:47:59 -0400
Date: Wed, 8 Aug 2018 16:27:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180808152741.GA31808@e107981-ln.cambridge.arm.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
 <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
 <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
 <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
 <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 08, 2018 at 02:58:15PM +0000, Leonard Crestez wrote:
> On Wed, 2018-08-08 at 15:19 +0100, Lorenzo Pieralisi wrote:
> > On Wed, Aug 08, 2018 at 11:37:14AM +0000, Leonard Crestez wrote:
> > > On Wed, 2018-08-08 at 12:14 +0100, Lorenzo Pieralisi wrote:
> > > > On Wed, Aug 08, 2018 at 10:53:52AM +0000, Leonard Crestez wrote:
> > > > > On Tue, 2018-07-24 at 19:14 +0300, Leonard Crestez wrote:
> > > > > > Changes since v2:
> > > > > >  * Print with dev_info if link fails on resume (Lucas)
> > > > > >  * Add a comment on imx7d pci irq mappings (Andrey)
> > > > > >  * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)
> > > > > > 
> > > > > > The ltssm_disable does not return an error because it can't be usefully
> > > > > > handled, reversing partial suspend is a nightmare and unlikely to work.
> > > > > > 
> > > > > >  * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)
> > > > > > 
> > > > > > Series is against linux-next tag next-20180724 where the reset patch was
> > > > > > already accepted. The imx7d.dtsi patch is also useful standalone.
> > > > > 
> > > > > This is a gentle reminder that this series was reviewed by Lucas two
> > > > > weeks ago but not yet included.
> > > > 
> > > > Does this series have a functional dependency on the reset fix ? If yes
> > > > we can have a bisection proplem depending on which tree gets merged
> > > > first.
> > > 
> > > Yes, without the reset fix I expect hangs.
> > > 
> > > Maybe the reset fix should be pulled in the pci tree? I don't know how
> > > these issues are sorted out.
> > 
> > Well either I pull that fix into the PCI tree (but it is already -rc8
> > and I can't guarantee v4.19 inclusion - I shall try) or I can ack these
> > patches and Philippe will send them upstream on my behalf, atop the
> > reset fix above.
> > 
> > When will the reset fix will be sent to Linus ? Please let me know
> > how you want to proceed.
> 
> I have some other unsent changes for imx pci+dts+reset standing by.
> Since these changes qualify more as "pm features" than fixes I don't
> really mind skipping 4.19.

OK that's fine by me, resend this series and the new patches at
v4.19-rc1 and I will pull the changes into the pci tree then.

> Pulling pci features into the reset tree doesn't make much sense to me.

I was just giving you an option.

> Maybe this kind of stuff could go through Shawn's tree? There shouldn't
> be any interaction with non-imx stuff.

As I said, I can ack the changes for Shawn to pick them up but if
Shawn's tree goes to Linus via eg arm-soc we are back to square
one, it is just too late.

I have no problem taking these changes in the PCI tree for v4.20 as long
as we plan the dependencies in advance.

Lorenzo
