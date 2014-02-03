Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55256 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaBCJ2w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2014 04:28:52 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0E0015MYC2UC90@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 03 Feb 2014 18:28:50 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: =?utf-8?Q?'Bj=C3=B8rn_Erik_Nilsen'?= <ben@datarespons.no>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	linux-pci@vger.kernel.org, 'Harro Haan' <hrhaan@gmail.com>,
	'Marek Vasut' <marex@denx.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <25.15.01844.D5C20E25@epmailin6.samsung.com>
 <000201cf17ff$47025bf0$d50713d0$%han@samsung.com>
 <20140123065104.GA26318@pratyush-vbox>
 <56523137843406465091127182657491@psmtp.com>
 <20140124064822.GF2369@pratyush-vbox>
 <8E.DE.30335.83C29E25@epmailin2.samsung.com>
In-reply-to: <8E.DE.30335.83C29E25@epmailin2.samsung.com>
Subject: Re: designware/imx6: question regarding MSI
Date: Mon, 03 Feb 2014 18:28:49 +0900
Message-id: <000601cf20c2$58b25460$0a16fd20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, January 30, 2014 1:29 AM, Bjørn Erik Nilsen wrote:
> On Fri, 2014-01-24 at 07:48 +0100, Pratyush Anand wrote:
> > On Thu, Jan 23, 2014 at 11:20:55PM +0800, Bjørn Erik Nilsen wrote:
> > > On Thu, 2014-01-23 at 07:51 +0100, Pratyush Anand wrote:
> > > > On Thu, Jan 23, 2014 at 01:52:19PM +0800, Jingoo Han wrote:
> > > > > On Thursday, January 23, 2014 5:39 AM, Jingoo Han wrote:
> > > > > >
> > > > > > I’m currently playing with MSI support in pci-imx6.c using Harro Haan’s patch [*].
> > > > > >
> > > > > > Are there any technical reasons why dw_pcie_msi_init cannot be called
> > > > > > from dw_msi_setup_irq?
> Or rather,
> > > > > > why it should not?
> > > > >
> > > > > No, there is no special reason.
> > > > > The patch (call dw_pcie_msi_init from dw_msi_setup_irq) would be
> > > > > good. Thank you for your effort.
> > > > >
> > > > > Mohit, Pratyush,
> > > > > If you have different opinions, please let us know. :-)
> > > >
> > > > dw_msi_setup_irq will be called for each function which needs msi
> > > > assignment. However, dw_pcie_msi_init should be called only once. So,
> > > > in my opinion calling dw_pcie_msi_init from dw_msi_setup_irq would not
> > > > be the best option.
> > > >
> > > > @Bjørn, can you help us with tracing calling sequence of
> > > > dw_pcie_setup & dw_pcie_scan_bus. I think when you do "reset bridge",
> > > > it will call dw_pcie_setup and when you do "rescan bus", it will call
> > > > dw_pcie_scan_bus. If yes, then you can move dw_pcie_msi_init to
> > > > dw_pcie_setup.
> > >
> > >
> > > It looks like dw_pcie_setup and dw_pcie_scan_bus is only called when
> > > booting. Resetting the bridge or scanning the bus will not trigger any
> > > of these functions, unfortunately.
> >
> > Yes, I browsed pcie sysfs rescan and reset code and it does not go
> > into that path. Sorry for the wrong pointers. I should have looked
> > into code earlier :(
> >
> > Coming to the issue, I am still not convinced that msi_init part should
> > go to msi_setup_irq. May be something is missing.
> > @Mohit, Jingoo: How does remove, reset and rescan behave with your
> > platform.
> 
> Any comments?

Sorry for late response.
I tested 'remove, reset and rescan' on Exynos platform
as you did.

(remove endpoints)
# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
# echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove

(reset bridge)
# echo 1 > /sys/bus/pci/devices/0000:00:00.0/reset

(rescan bus)
# echo 1 > /sys/bus/pci/rescan

Without MSI (legacy INTx mode), it works properly. However,
with MSI, it makes the problem.

> 
> I can prepare a patch (which calls dw_pcie_msi_init from
> dw_msi_setup_irq), however if this is not the right solution then we
> need to figure out what a proper solution should look like.

If you send the patch, I will test it on Exynos platform.
Thank you for your effort. :-)

Best regards,
Jingoo Han

