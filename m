Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751785AbdBBXN7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Feb 2017 18:13:59 -0500
Date: Thu, 2 Feb 2017 18:22:54 -0500
From: Keith Busch <keith.busch@intel.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        zhangjukuo <zhangjukuo@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>
Subject: Re: Question: PCIe DPC not allowing for link retraining and bus
 re-scan
Message-ID: <20170202232253.GC24601@localhost.localdomain>
References: <EE11001F9E5DDD47B7634E2F8A612F2E1F9F74AA@lhreml507-mbx>
 <20170130161453.GC11699@localhost.localdomain>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F9F9345@lhreml507-mbx>
 <20170131155336.GA24601@localhost.localdomain>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F9FA346@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F9FA346@lhreml507-mbx>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 04:59:31PM +0000, Gabriele Paoloni wrote:
> Many thanks for this, I'll try to get such switch too so maybe
> I can help with development and/or validation. 
> If you know of specific switches that support for sure such SW
> trigger feature please let me know and I'll try to buy them.

I'm not trying to advertise for any particular product, but this is what
I'm currently using for testing my NVMe drives:

  http://www.serialcables.com/products.asp?cat=350&tier=264

It uses these PCIe switches:

  https://www.broadcom.com/products/pcie-switches-bridges/expressfabric/pex9781

I just use this for PCIe SSDs, but there are other vendors that have
capable switches too.

These do support DPC sofware triggering, and the method I mentioned
before is correct:

  # setpci -s <B:D.f> ECAP_DPC+6.w=40:40

On all my testing, the DPC event necesssarily triggers a PCIe HP event
that automatically does the rescan when the containment is released.
Here is a sequence from a single software trigger and nothing else,
using 4.10-rc6:

  root@localhost: ~# setpci -s 89:03.0 ECAP_DPC+6.w=40:40

  dpc 0000:89:03.0:pcie210: DPC containment event, status:0x002f source:0x0000
  dpc 0000:89:03.0:pcie210: DPC extended error triggered, remove downstream devices
  pciehp 0000:89:03.0:pcie204: Slot(3): Link Down
  dpc 0000:89:03.0:pcie210: DPC containment event, status:0x0006 source:0x0000
  pciehp 0000:89:03.0:pcie204: Slot(3): Card not present
  dpc 0000:89:03.0:pcie210: DPC containment event, status:0x0006 source:0x0000
  pciehp 0000:89:03.0:pcie204: Slot(3): Card present
  dpc 0000:89:03.0:pcie210: DPC containment event, status:0x0006 source:0x0000
  pciehp 0000:89:03.0:pcie204: Slot(3): Link Up
  pciehp 0000:89:03.0:pcie204: Slot(3): Link Up event ignored; already powering on
  pci 0000:8d:00.0: [8086:0953] type 00 class 0x010802
  pci 0000:8d:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
  pci 0000:8d:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
  pci 0000:8d:00.0: Max Payload Size set to 256 (was 128, max 256)
  pci 0000:8d:00.0: BAR 6: assigned [mem 0xec000000-0xec00ffff pref]
  pci 0000:8d:00.0: BAR 0: assigned [mem 0xec010000-0xec013fff 64bit]
  pcieport 0000:89:03.0: PCI bridge to [bus 8d]
  pcieport 0000:89:03.0:   bridge window [mem 0xec000000-0xec0fffff]
  pcieport 0000:89:03.0:   bridge window [mem 0x840c00000-0x840dfffff 64bit pre

So I think we're okay to not have DPC initiate the rescan since it would
just compete with pciehp. The only thing we need to do differently is
wait for RP busy if it implements that capability, and no such device
for general availabilty currently exists, as far as I know.
