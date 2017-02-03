Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:8702 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752198AbdBCKgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2017 05:36:06 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        zhangjukuo <zhangjukuo@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: RE: Question: PCIe DPC not allowing for link retraining and bus
 re-scan
Date: Fri, 3 Feb 2017 10:35:47 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1FA01473@lhreml507-mbx>
References: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith

One thing that I do not understand

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Gabriele Paoloni
> Sent: 30 January 2017 11:56
> To: keith.busch@intel.com
> Cc: linux-pci@vger.kernel.org; Linuxarm; liudongdong (C); zhangjukuo;
> Wangzhou (B)
> Subject: Question: PCIe DPC not allowing for link retraining and bus
> re-scan
> 
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
>    http://lxr.free-electrons.com/source/drivers/pci/pcie/pcie-
> dpc.c#L55)

As you can see above, after waiting for the link to be inactive
we raise again a DPC event (according to PCIe3.0 6.2.10.1 we have
DPC Interrupt Enable bit set to 1b and we set DPC Interrupt Status bit
to 1b), also we keep the port in DPC status as we set also "DPC Trigger
Status" to 1b. However this seems wrong to me as I would expect SW to
clear "DPC Trigger Status" to allow the link to retrain and then to
raise the Hot-plug event...

What do you think?

Thanks
Gab

[...]
