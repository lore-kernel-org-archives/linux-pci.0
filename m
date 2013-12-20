Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:9536 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab3LTCmD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2013 21:42:03 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MY300BE13HW5820@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 20 Dec 2013 11:41:57 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Harro Haan' <hrhaan@gmail.com>, 'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <hong-xing.zhu@freescale.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Pratyush ANAND' <pratyush.anand@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Juergen Beisert' <jbe@pengutronix.de>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Srikanth T Shivanand' <ts.srikanth@samsung.com>,
	'Sean Cross' <xobs@kosagi.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Jingoo Han' <jg1.han@samsung.com>
References: <20131212182903.409515738@gmail.com>
 <005b01cef9f9$52022bd0$f6068370$%han@samsung.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F6A22@EAPEX1MAIL1.st.com>
In-reply-to: <2CC2A0A4A178534D93D5159BF3BCB66189F95F6A22@EAPEX1MAIL1.st.com>
Subject: Re: [PATCH] pci: designware: fix missing msi irqs
Date: Fri, 20 Dec 2013 11:41:56 +0900
Message-id: <003201cefd2d$0c7cbc60$25763520$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, December 16, 2013 3:49 PM, Mohit KUMAR DCG wrote:
> On Monday, December 16, 2013 6:24 AM, Jingoo Han wrote:
> > On Friday, December 13, 2013 3:29 AM, Harro Haan wrote:
> > >
> > > The interrupts were cleared after the irq handler was called.
> > > This means that new interrupts that occur after the handler handled
> > > the previous irq but before the interrupt is cleared will be missed.
> > >
> > > Signed-off-by: Harro Haan <hrhaan@gmail.com>
> > > Cc: Mohit Kumar <mohit.kumar@st.com>
> > > Cc: Jingoo Han <jg1.han@samsung.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Marek Vasut <marex@denx.de>
> > > Cc: Richard Zhu <hong-xing.zhu@freescale.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Pratyush Anand <pratyush.anand@st.com>
> > > Cc: Tim Harvey <tharvey@gateworks.com>
> > > Cc: Juergen Beisert <jbe@pengutronix.de>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> > > Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> > > Cc: Sean Cross <xobs@kosagi.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> >
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> >
> > I was not able to reproduce the problem, however it looks good. Also, there
> > is no side effect on Exynos platform.
> >
> > Mohit,
> > If you have some comments, please let us know.
> 
> - Quickly tested on SPEAr1310, working fine without any side effect. So is,
> Acked-by: Mohit Kumar <mohit.kumar@st.com>

Hi Bjorn Helgaas,

Would you apply this patch to your 'pci/host-designware' branch
with the following Tested-by and Acked-by?

Tested-by: Marek Vasut <marex@denx.de>
Tested-by:  Matthias Mann <m.mann@arkona-technologies.de>
Acked-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Mohit Kumar <mohit.kumar@st.com>


> ..
> >
> > > ---
> > >  drivers/pci/host/pcie-designware.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)

