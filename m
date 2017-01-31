Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:8549 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdAaRCG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2017 12:02:06 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Keith Busch <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        zhangjukuo <zhangjukuo@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: Question: PCIe DPC not allowing for link retraining and bus
 re-scan
Date: Tue, 31 Jan 2017 16:59:31 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F9FA346@lhreml507-mbx>
References: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
 <20170130161453.GC11699@localhost.localdomain>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F9F9345@lhreml507-mbx>
 <20170131155336.GA24601@localhost.localdomain>
In-Reply-To: <20170131155336.GA24601@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith

> -----Original Message-----
> From: Keith Busch [mailto:keith.busch@intel.com]
> Sent: 31 January 2017 15:54
> To: Gabriele Paoloni
> Cc: linux-pci@vger.kernel.org; Linuxarm; liudongdong (C); zhangjukuo;
> Wangzhou (B)
> Subject: Re: Question: PCIe DPC not allowing for link retraining and
> bus re-scan
> 
> On Tue, Jan 31, 2017 at 09:35:58AM +0000, Gabriele Paoloni wrote:
> > I don't mind writing the patches but currently I also do not have a
> > platform to test on.
> >
> > Do you know if there is any Intel Server/Desktop with full support of
> > DPC on the RP including "Software Triggering of DPC" (maybe some
> > machines that are out on the market but you do not have there with
> you)?
> 
> Currently available Intel offerings do not have eDPC capable root
> ports.
> I use switches from Microsemi and PLX with these capabilities on their
> downstream ports so I'm limited to non-root port testing at the moment.
> 
> > As an alternative I am thinking that maybe I can find a switch with
> > full DPC support including "Software Triggering of DPC". In this case
> > we test anything except the RP Busy bit...
> >
> > The idea is to have a sort of DPC SW Injection module to test DPC.
> 
> I think you can s/w inject from userspace with setpci:
> 
>   # setpci -s <B:D.f> ECAP_DPC+6.w=40:40
> 
> The port has to have a software trigger capability. I can get such a
> switch, but don't have one immediately available.
> 
> Anyway, I'll write a couple patches and post them when I can get
> validation. Thank you for pointing out the current gaps.

Many thanks for this, I'll try to get such switch too so maybe
I can help with development and/or validation. 
If you know of specific switches that support for sure such SW
trigger feature please let me know and I'll try to buy them.

I'll ping you as soon as I am able to get something to test this.

Cheers
Gab
