Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52557 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaDDCbh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 22:31:37 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N3H00D0BJ0MW530@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 04 Apr 2014 11:31:35 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Richard Zhu' <Hong-Xing.Zhu@freescale.com>,
	'Marek Vasut' <marex@denx.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Pratyush ANAND' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FEC4809B@EAPEX1MAIL1.st.com>
 <533BA157.6030004@ti.com> <201404021234.48134.marex@denx.de>
 <65debfc7f79a4a27a58bd7c64382881f@BLUPR03MB136.namprd03.prod.outlook.com>
In-reply-to: <65debfc7f79a4a27a58bd7c64382881f@BLUPR03MB136.namprd03.prod.outlook.com>
Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
Date: Fri, 04 Apr 2014 11:31:34 +0900
Message-id: <000001cf4fad$ff227ae0$fd6770a0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 02, 2014 8:59 PM, Richard Zhu wrote:
> Wednesday, April 02, 2014 6:35 PM, Marek Vasut wrote:
> > On Wednesday, April 02, 2014 at 07:34:15 AM, Kishon Vijay Abraham I wrote:
> > > On Wednesday 02 April 2014 11:03 AM, Mohit KUMAR DCG wrote:
> > > > Wednesday, April 02, 2014 10:53 AM, Jingoo Han wrote:
> > > >> On Wednesday, April 02, 2014 1:57 PM, Mohit KUMAR DCG wrote:
> > > >>> On Tuesday, April 01, 2014 4:00 PM, Jingoo Han wrote:
> > > >>>> According to the spec, the synopsys core does not implement the
> > > >>>> optional BARs such as BAR0/1. This is based on the assumption
> > > >>>> that the RC host probably has registers on some other internal
> > > >>>> bus and has knowledge and setup access to these registers already.
> > > >>>> So, remove unnecessary RC BAR setting.
> > > >>>
> > > >>> - Normally BARs in RC are not used but somehow available in the
> > > >>> design. One possible BAR use can be if RC has some memory
> > > >>> connected to
> > > >>
> > > >> the BAR that needs to be accessed through link.
> > > >>
> > > >>> Otherwise we can ignore BARs setup here.
> > > >>
> > > >> Hi Mohit KUMAR DCG,
> > > >>
> > > >> Thank you for your feedback.
> > > >>
> > > >> I want to know whether or not other SoCs such as ST, Freescale, TI
> > > >> support BAR0/BAR1. If no SoC supports BAR0/BAR1, the unnecessary RC
> > > >> BAR setting code should  be removed.
> > > >
> > > > - We are not currently using RC's BAR0/1 in any application but no
> > > > such restriction from HW as ST SoCs support BARs in HW design.
> > >
> > > Neither do we in DRA7xx.
> >
> > I suspect that means we should keep the code to make sure the registers are
> > configured correctly, no?
> >
> > Richard, can you comment on MX6 please ?
> 
>  [Richard] Sorry to reply late. I'm engaged in another stuff in the past days.
> i.MX6 pcie doesn't use RC's BAR0/1 in applications either.
> >

Thank you all for your comments!

I noticed that Synopsys PCIe "Dual mode" can support BAR0/BAR1.
The bits[3:0] of BAR0 is RO(CS), which means Read-Only, but writable
from the local application through the DBI.

So, the BAR0/1 setting might be necessary, in order to ensure the
BAR0/1 setting is written properly.

But, when BAR0/1 are implemented, the bits[3:0] of BAR0 is decided
by hardware configuration parameters. So, this BAR0/1 setting looks
unnecessary.

How about others' opinions?

1. Necessary: in order to ensure the BAR0/BAR1 setting, even though
                   BAR0/BAR1 were already set as hardware default values

2. Unnecessary: the BAR0/BAR1 setting code is dummy, because BAR0/BAR1
                      were already set as hardware default values

For example, in the case of Exynos5440, BAR0/BAR1 are not implemented;
thus, even though BAR0 is written as 0x4, BAR0 can be always read as 0.
So, there is not side effect, but just unnecessary code is executed
during boot time.

Thank you. :-)

Best regards,
Jingoo Han

