Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbdA3QGZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jan 2017 11:06:25 -0500
Date: Mon, 30 Jan 2017 11:14:53 -0500
From: Keith Busch <keith.busch@intel.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        zhangjukuo <zhangjukuo@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Re: Question: PCIe DPC not allowing for link retraining and bus
 re-scan
Message-ID: <20170130161453.GC11699@localhost.localdomain>
References: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 30, 2017 at 11:56:23AM +0000, Gabriele Paoloni wrote:
> Hi Keith
> 
> I am looking at the current DPC implementation in:
> http://lxr.free-electrons.com/source/drivers/pci/pcie/pcie-dpc.c
> 
> 
> If my understanding is correct upon an incoming DPC event
> the DPC IRQ handler will:
> 1) stop and remove all the devices in the hierarchy under the
> downstream port that raised the event
> 2) wait for the data link to be inactive
> 3) keep the downstream port status in DPC (in fact we set the DPC
>    trigger status again here:
>    http://lxr.free-electrons.com/source/drivers/pci/pcie/pcie-dpc.c#L55)
> 
> Now looking at the specs we have (section 6.2.10):
> "After software releases the Downstream Port from DPC, the associated Link
> will normally attempt to retrain. Software can use Data Link Layer State
> Changed interrupts, DL_Active ERR_COR signaling, or both, to signal when 
> the Link reaches the DL_Active state again"
> 
> So if my understanding is correct in the current Linux implementation
> It is not possible to recover a PCIe hierarchy from a DPC event, is it correct?
> If this is correct, shouldn't we change the current implementation to release
> the port from DPC and re-scan the secondary bus after the conditions described
> in "PCIe 3.1 section 6.2.10" are met (I.e. <<Data Link Layer Link Active bit in
> the 15 Link Status register reads 0b>> and if it is a root port also <<until
> the DPC RP Busy bit reads 0b>>) ?

That sounds reasonable. In all testing I've done, DPC events were
triggered as part of a hot-plug event, so the secondary bus rescan would
automatically happen when a device is hot inserted. The DPC driver didn't
need to initiate the rescan in that case.

But surprise removal is certainly not the only condition DPC can contain a
port, so I agree with you that we may require pcie-dpc initiate a rescan
after releasing the port from containment. I also agree on needing to
poll RP busy for root ports.

Do you want to send patches for these? I could also write them up,
but I don't have a DPC capable root port to test that part.

Thanks,
Keith
