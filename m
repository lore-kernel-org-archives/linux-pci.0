Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:8508 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdAaJi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2017 04:38:26 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Keith Busch <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        zhangjukuo <zhangjukuo@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: Question: PCIe DPC not allowing for link retraining and bus
 re-scan
Date: Tue, 31 Jan 2017 09:35:58 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F9345@lhreml507-mbx>
References: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
 <20170130161453.GC11699@localhost.localdomain>
In-Reply-To: <20170130161453.GC11699@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith many thanks for coming back on this

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Keith Busch
> Sent: 30 January 2017 16:15
> To: Gabriele Paoloni
> Cc: linux-pci@vger.kernel.org; Linuxarm; liudongdong (C); zhangjukuo;
> Wangzhou (B)
> Subject: Re: Question: PCIe DPC not allowing for link retraining and
> bus re-scan
> 
> On Mon, Jan 30, 2017 at 11:56:23AM +0000, Gabriele Paoloni wrote:
> > Hi Keith
> >
> > I am looking at the current DPC implementation in:
> > http://lxr.free-electrons.com/source/drivers/pci/pcie/pcie-dpc.c
> >
> >
> > If my understanding is correct upon an incoming DPC event
> > the DPC IRQ handler will:
> > 1) stop and remove all the devices in the hierarchy under the
> > downstream port that raised the event
> > 2) wait for the data link to be inactive
> > 3) keep the downstream port status in DPC (in fact we set the DPC
> >    trigger status again here:
> >    http://lxr.free-electrons.com/source/drivers/pci/pcie/pcie-
> dpc.c#L55)
> >
> > Now looking at the specs we have (section 6.2.10):
> > "After software releases the Downstream Port from DPC, the associated
> Link
> > will normally attempt to retrain. Software can use Data Link Layer
> State
> > Changed interrupts, DL_Active ERR_COR signaling, or both, to signal
> when
> > the Link reaches the DL_Active state again"
> >
> > So if my understanding is correct in the current Linux implementation
> > It is not possible to recover a PCIe hierarchy from a DPC event, is
> it correct?
> > If this is correct, shouldn't we change the current implementation to
> release
> > the port from DPC and re-scan the secondary bus after the conditions
> described
> > in "PCIe 3.1 section 6.2.10" are met (I.e. <<Data Link Layer Link
> Active bit in
> > the 15 Link Status register reads 0b>> and if it is a root port also
> <<until
> > the DPC RP Busy bit reads 0b>>) ?
> 
> That sounds reasonable. In all testing I've done, DPC events were
> triggered as part of a hot-plug event, so the secondary bus rescan
> would
> automatically happen when a device is hot inserted. The DPC driver
> didn't
> need to initiate the rescan in that case.
> 
> But surprise removal is certainly not the only condition DPC can
> contain a
> port, so I agree with you that we may require pcie-dpc initiate a
> rescan
> after releasing the port from containment. I also agree on needing to
> poll RP busy for root ports.
> 
> Do you want to send patches for these? I could also write them up,
> but I don't have a DPC capable root port to test that part.

I don't mind writing the patches but currently I also do not have a
platform to test on.

Do you know if there is any Intel Server/Desktop with full support of
DPC on the RP including "Software Triggering of DPC" (maybe some
machines that are out on the market but you do not have there with you)?

As an alternative I am thinking that maybe I can find a switch with
full DPC support including "Software Triggering of DPC". In this case
we test anything except the RP Busy bit...

The idea is to have a sort of DPC SW Injection module to test DPC.

Cheers
Gab

> 
> Thanks,
> Keith
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
