Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42291 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbaBDEkK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2014 23:40:10 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0G00GC0FMWAUB0@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Tue, 04 Feb 2014 13:40:08 +0900 (KST)
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
 <000601cf20c2$58b25460$0a16fd20$%han@samsung.com>
 <000801cf20c6$0e34f9c0$2a9eed40$%han@samsung.com>
 <C3.BD.30335.F2DBFE25@epmailin2.samsung.com>
In-reply-to: <C3.BD.30335.F2DBFE25@epmailin2.samsung.com>
Subject: Re: designware/imx6: question regarding MSI
Date: Tue, 04 Feb 2014 13:40:07 +0900
Message-id: <000101cf2163$2e2fb0b0$8a8f1210$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, February 04, 2014 1:01 AM, Bjørn Erik Nilsen wrote:
> On Mon, 2014-02-03 at 10:55 +0100, Jingoo Han wrote:
> > On Monday, February 03, 2014 6:29 PM, Jingoo Han wrote:
> > > On Thursday, January 30, 2014 1:29 AM, Bjørn Erik Nilsen wrote:
> > > > On Fri, 2014-01-24 at 07:48 +0100, Pratyush Anand wrote:
> > > > >
> > > > > Yes, I browsed pcie sysfs rescan and reset code and it does not go
> > > > > into that path. Sorry for the wrong pointers. I should have looked
> > > > > into code earlier :(
> > > > >
> > > > > Coming to the issue, I am still not convinced that msi_init part should
> > > > > go to msi_setup_irq. May be something is missing.
> > > > > @Mohit, Jingoo: How does remove, reset and rescan behave with your
> > > > > platform.
> > > >
> > > > Any comments?
> > >
> > > Sorry for late response.
> > > I tested 'remove, reset and rescan' on Exynos platform
> > > as you did.
> > >
> > > (remove endpoints)
> > > # echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
> > > # echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove
> > >
> > > (reset bridge)
> > > # echo 1 > /sys/bus/pci/devices/0000:00:00.0/reset
> > >
> > > (rescan bus)
> > > # echo 1 > /sys/bus/pci/rescan
> > >
> > > Without MSI (legacy INTx mode), it works properly. However,
> > > with MSI, it makes the problem.
> >
> > Oh, there was my mistake. There is no problem on Exynos platform.
> > I tested two different LAN cards. With MSI, 'remove, reset and
> > rescan' works properly on Exynos platform using the current
> > pci/next tree. Sorry for the confusion.
> > Thank you.
> 
> Right.
> 
> So if I understand you correctly it works fine with pci/next, however
> you were able to reproduce with an earlier kernel version? That is
> indeed very good news. I will try to pull in the latest and greatest
> from pci/next to verify this.

Hi Bjørn Erik Nilsen,

I tested an earlier kernel v3.13. As you know, this version have
Some problems about designware PCIe MSI handling.

I tested the latest v3.14-rc1 kernel (vanilla kernel). It works
properly. Currently, v3.14-rc1 kernel was merged to the current
pci/next kernel. So, you can test 'mainline kernel v3.14-rc1' or
'the latest pci/next kernel'. (the commit 7f2d86 "Merge branch
'pci/numa-cleanup' into next")

If you have some problems, please let us know. :-)
Thank you.

Best regards,
Jingoo Han

