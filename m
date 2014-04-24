Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35233 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbaDXVfk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 17:35:40 -0400
Received: by mail-pa0-f43.google.com with SMTP id rd3so522767pab.30
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 14:35:39 -0700 (PDT)
Date: Thu, 24 Apr 2014 15:35:37 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Richard Zhu' <Hong-Xing.Zhu@freescale.com>,
	'Marek Vasut' <marex@denx.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	linux-pci@vger.kernel.org, 'Pratyush ANAND' <pratyush.anand@st.com>
Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
Message-ID: <20140424213537.GJ29593@google.com>
References: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FEC4809B@EAPEX1MAIL1.st.com>
 <533BA157.6030004@ti.com>
 <201404021234.48134.marex@denx.de>
 <65debfc7f79a4a27a58bd7c64382881f@BLUPR03MB136.namprd03.prod.outlook.com>
 <000001cf4fad$ff227ae0$fd6770a0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001cf4fad$ff227ae0$fd6770a0$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 04, 2014 at 11:31:34AM +0900, Jingoo Han wrote:
> On Wednesday, April 02, 2014 8:59 PM, Richard Zhu wrote:
> > Wednesday, April 02, 2014 6:35 PM, Marek Vasut wrote:
> > > On Wednesday, April 02, 2014 at 07:34:15 AM, Kishon Vijay Abraham I wrote:
> > > > On Wednesday 02 April 2014 11:03 AM, Mohit KUMAR DCG wrote:
> > > > > Wednesday, April 02, 2014 10:53 AM, Jingoo Han wrote:
> > > > >> On Wednesday, April 02, 2014 1:57 PM, Mohit KUMAR DCG wrote:
> > > > >>> On Tuesday, April 01, 2014 4:00 PM, Jingoo Han wrote:
> > > > >>>> According to the spec, the synopsys core does not implement the
> > > > >>>> optional BARs such as BAR0/1. This is based on the assumption
> > > > >>>> that the RC host probably has registers on some other internal
> > > > >>>> bus and has knowledge and setup access to these registers already.
> > > > >>>> So, remove unnecessary RC BAR setting.
> > > > >>>
> > > > >>> - Normally BARs in RC are not used but somehow available in the
> > > > >>> design. One possible BAR use can be if RC has some memory
> > > > >>> connected to
> > > > >>
> > > > >> the BAR that needs to be accessed through link.
> > > > >>
> > > > >>> Otherwise we can ignore BARs setup here.
> > > > >>
> > > > >> Hi Mohit KUMAR DCG,
> > > > >>
> > > > >> Thank you for your feedback.
> > > > >>
> > > > >> I want to know whether or not other SoCs such as ST, Freescale, TI
> > > > >> support BAR0/BAR1. If no SoC supports BAR0/BAR1, the unnecessary RC
> > > > >> BAR setting code should  be removed.
> > > > >
> > > > > - We are not currently using RC's BAR0/1 in any application but no
> > > > > such restriction from HW as ST SoCs support BARs in HW design.
> > > >
> > > > Neither do we in DRA7xx.
> > >
> > > I suspect that means we should keep the code to make sure the registers are
> > > configured correctly, no?
> > >
> > > Richard, can you comment on MX6 please ?
> > 
> >  [Richard] Sorry to reply late. I'm engaged in another stuff in the past days.
> > i.MX6 pcie doesn't use RC's BAR0/1 in applications either.
> > >
> 
> Thank you all for your comments!
> 
> I noticed that Synopsys PCIe "Dual mode" can support BAR0/BAR1.
> The bits[3:0] of BAR0 is RO(CS), which means Read-Only, but writable
> from the local application through the DBI.
> 
> So, the BAR0/1 setting might be necessary, in order to ensure the
> BAR0/1 setting is written properly.
> 
> But, when BAR0/1 are implemented, the bits[3:0] of BAR0 is decided
> by hardware configuration parameters. So, this BAR0/1 setting looks
> unnecessary.
> 
> How about others' opinions?
> 
> 1. Necessary: in order to ensure the BAR0/BAR1 setting, even though
>                    BAR0/BAR1 were already set as hardware default values
> 
> 2. Unnecessary: the BAR0/BAR1 setting code is dummy, because BAR0/BAR1
>                       were already set as hardware default values
> 
> For example, in the case of Exynos5440, BAR0/BAR1 are not implemented;
> thus, even though BAR0 is written as 0x4, BAR0 can be always read as 0.
> So, there is not side effect, but just unnecessary code is executed
> during boot time.

I don't sense a clear consensus that we should apply this, so I'll drop
it for now.  Please repost with appropriate acks if we do need it.

Bjorn
