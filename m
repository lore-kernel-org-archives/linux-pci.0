Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56088 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab2DCHQL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2012 03:16:11 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A08B83EE081
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:16:09 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8808245DE50
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:16:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 73C9545DE4D
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:16:09 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6866A1DB803B
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:16:09 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 0E8901DB8043
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:16:09 +0900 (JST)
Message-ID: <4F7AA3A2.1080900@jp.fujitsu.com>
Date: Tue, 03 Apr 2012 16:15:46 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?B?5p2+5pys5Y2a6YOO?= <matsumoto.hiroo@jp.fujitsu.com>
CC: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Subject: Re: [RFC] pciehp: Add archdata setting
References: <4F79584B.2010301@jp.fujitsu.com> <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com>
In-Reply-To: <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2012/04/02 23:13), Bjorn Helgaas wrote:
> On Mon, Apr 2, 2012 at 1:42 AM, 松本博郎<matsumoto.hiroo@jp.fujitsu.com>  wrote:
>> I'm trying to use pciehp on powerpc platform.
>> I set e1000e card to PCI Express bridge that has PCI Express HotPlug
>> Capability.
>>
>> There is problem when poweron PCI Express HotPlug slot with pciehp.
>> e1000e driver needs dma_ops in struct dev_archdata, but archdata isn't
>> set (dma_ops is NULL) when probe from pciehp.
>> Then e1000e driver returns error as below.
>>
>> -sh-3.2# echo 1>  /sys/bus/pci/slots/1/power
>> <snip>
>> [   65.493662] pci 0000:03:00.0: BAR 2: set to [io
>> 0xff7ee000-0xff7ee01f] (PCI address [0x1000-0x101f])
>> [   65.502890] pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
>> [   65.508555] pcieport 0000:02:01.0:   bridge window [io
>> 0xff7ee000-0xff7eefff]
>> [   65.515785] pcieport 0000:02:01.0:   bridge window [mem
>> 0xa0100000-0xa01fffff]
>> [   65.523015] pcieport 0000:02:01.0:   bridge window [mem
>> 0xa0200000-0xa02fffff 64bit pref]
>> [   65.531238] pci 0000:03:00.0: no hotplug settings from platform
>> [   65.538361] e1000e 0000:03:00.0: Disabling ASPM  L1
>> [   65.543616] e1000e 0000:03:00.0: enabling device (0000 ->  0002)
>> [   65.549876] e1000e 0000:03:00.0: No usable DMA configuration, aborting
>> [   65.557194] e1000e: probe of 0000:03:00.0 failed with error -5
>> -sh-3.2# lspci
>> <snip>
>> 0000:03:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit
>> Ethernet Controller (Copper) (rev 06)
>> <snip>
>> -sh-3.2# ifconfig -a
>> <snip>    // There is no network interface for 82572EI
>>
>> If archdata.dma_ops is NULL on x86 platform, e1000e will get dma_ops
>> without archdata.
>> So e1000e driver doesn't return error.
>>
>> I think that archdata should be set before driver probe (e.g pciehp).
>> I tried to fix it (pciehp-add-archdata.patch), but I'm not good at PCI
>> driver..., so please give better way.
>
> Interesting.  It would be nice if we could set archdata the same way
> for both devices present at boot and those hot-added later.

Yes. But it might be not so easy...

>                                                              Can you
> figure out where archdata is set for devices present at boot?

I read some x86 and powerpc code to setup archdata. x86 and powerpc
have different way to setup archdata. And it seems archdata is not
set in one location, each member in the archdata is setup in the
different locations.

On x86, archdata.dma_ops is set in the pci_iommu_init() code path, which
is called through rootfs_initcall(). On powerpc, archdata.dma_ops is set
in pcibios_fixup_bus() code path.

Here are my notes.

x86 (calgary iommu)
===================
rootfs_initcall()
  => pci_iommu_init()
      => x86_init.iommu.iommu_init() (== calgary_iommu_init())
          => calgary_init()

calgary_init()
{
         for_each_pci_dev() {
                         dev->dev.archdata.dma_ops = &calgary_dma_ops;
         }
}

x86 (amd iommu)
===============
rootfs_initcall()
  => pci_iommu_init()
      => x86_init.iommu.iommu_init() (== amd_iommu_init())
          => amd_iommu_init_dma_ops()
              => device_dma_ops_init()

device_dma_ops_init()
{
	for_each_pci_dev() {
		pdev->dev.archdata.dma_ops = &amd_iommu_dma_ops;
}

PowerPC
=======
pci_scan_child_bus()
  => pcibios_fixup_bus()
      => pcibios_setup_bus_devices()
          => set_dma_ops()              # for each device on the bus (default)
          => ppc_md.pci_dma_dev_setup() # for each device on the bus (machine depend)

static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
{
         dev->archdata.dma_ops = ops;
}


One possible idea is that to setup archdata in the pcibios_xxx() hook.
(for example, use existing pcibios_enable_device(), or provide new
hook like pcibios_setup_device() which is called by pci_setup_device).

Another idea is that to add support for hot-plug to each iommu (dma)
code. Maybe it can be implemented by using bus notifier.

Regards,
Kenji Kaneshige
