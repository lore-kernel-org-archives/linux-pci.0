Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:8420 "EHLO
        lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753193AbdA3L4q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2017 06:56:46 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "keith.busch@intel.com" <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        zhangjukuo <zhangjukuo@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Question: PCIe DPC not allowing for link retraining and bus re-scan
Date: Mon, 30 Jan 2017 11:56:23 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith

I am looking at the current DPC implementation in:
http://lxr.free-electrons.com/source/drivers/pci/pcie/pcie-dpc.c


If my understanding is correct upon an incoming DPC event
the DPC IRQ handler will:
1) stop and remove all the devices in the hierarchy under the
downstream port that raised the event
2) wait for the data link to be inactive
3) keep the downstream port status in DPC (in fact we set the DPC
   trigger status again here:
   http://lxr.free-electrons.com/source/drivers/pci/pcie/pcie-dpc.c#L55)

Now looking at the specs we have (section 6.2.10):
"After software releases the Downstream Port from DPC, the associated Link
will normally attempt to retrain. Software can use Data Link Layer State
Changed interrupts, DL_Active ERR_COR signaling, or both, to signal when 
the Link reaches the DL_Active state again"

So if my understanding is correct in the current Linux implementation
It is not possible to recover a PCIe hierarchy from a DPC event, is it correct?
If this is correct, shouldn't we change the current implementation to release
the port from DPC and re-scan the secondary bus after the conditions described
in "PCIe 3.1 section 6.2.10" are met (I.e. <<Data Link Layer Link Active bit in
the 15 Link Status register reads 0b>> and if it is a root port also <<until
the DPC RP Busy bit reads 0b>>) ?  


Many Thanks

Gab

 
