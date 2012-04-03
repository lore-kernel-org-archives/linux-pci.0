Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:60118 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2DCHxh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2012 03:53:37 -0400
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 010313EE0B5
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:53:36 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D6BB145DEB2
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:53:35 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BE4FC45DEA6
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:53:35 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B03AD1DB803B
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:53:35 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 55CDB1DB8038
	for <linux-pci@vger.kernel.org>; Tue,  3 Apr 2012 16:53:35 +0900 (JST)
Message-ID: <4F7AAC6E.5070809@jp.fujitsu.com>
Date: Tue, 03 Apr 2012 16:53:18 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: =?ISO-2022-JP?B?GyRCPj5LXEduTzobKEI=?=
	<matsumoto.hiroo@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, jbarnes@virtuousgeek.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC] pciehp: Add archdata setting
References: <4F79584B.2010301@jp.fujitsu.com> <CAErSpo4Yy9d93gNzDadFxSN+41NkEKBz4yai9KzB1aaCP3pwWw@mail.gmail.com> <4F7A9816.2080700@jp.fujitsu.com>
In-Reply-To: <4F7A9816.2080700@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

(2012/04/03 15:26), 松本博郎 wrote:
> Hi
> 
> 
> Thanks for your comment.
> 
> I have mistake.
> archdata.dma_ops is always NULL on x86 platform.
> On x86 platform, probe with pciehp is same as probe with initcall.
> I'm so sorry.
> 
> But archdata on powerpc platform is set with initcall.
> Call stack is as below.
> 1. pcibios_init
> 2. pcibios_scan_phb
> 3. pci_scan_child_bus
> 4. pci_scan_bridge
> 5. pci_scan_child_bus
> 6. pci_scan_bridge
> 7. pci_scan_child_bus
> 8. pcibios_setup_bus_devices
> 
> In pcibios_setup_bus_devices, archdata is set with set_dma_ops and set_dma_offset.
> But set_dma_ops and set_dma_offset are defined only at powerpc and microblaze (Why...).
> 
> Can architecture code, like arch/powerpc/kernel/pci.c, be called from pciehp ?

Hello Hiroo,

Pcidhp can call the arch specific code, but I don't think it's a good idea.
It's not pciehp specific problem. So it should be done in more generic way.
As Bjorn said, it would be nice if we could use the same code for both
devices present at boot and hot-added devices.

Regards,
Kenji Kaneshige


> 
> 
> Regards.
> 
> Hiroo MATSUMOTO (FUJITSU COMPUTER TECHNOLOGIES LIMITED)
> matsumoto.hiroo@jp.fujitsu.com
> 
>>> I'm trying to use pciehp on powerpc platform.
>>> I set e1000e card to PCI Express bridge that has PCI Express HotPlug
>>> Capability.
>>>
>>> There is problem when poweron PCI Express HotPlug slot with pciehp.
>>> e1000e driver needs dma_ops in struct dev_archdata, but archdata isn't
>>> set (dma_ops is NULL) when probe from pciehp.
>>> Then e1000e driver returns error as below.
>>>
>>> -sh-3.2# echo 1 > /sys/bus/pci/slots/1/power
>>> <snip>
>>> [ 65.493662] pci 0000:03:00.0: BAR 2: set to [io
>>> 0xff7ee000-0xff7ee01f] (PCI address [0x1000-0x101f])
>>> [ 65.502890] pcieport 0000:02:01.0: PCI bridge to [bus 03-03]
>>> [ 65.508555] pcieport 0000:02:01.0: bridge window [io
>>> 0xff7ee000-0xff7eefff]
>>> [ 65.515785] pcieport 0000:02:01.0: bridge window [mem
>>> 0xa0100000-0xa01fffff]
>>> [ 65.523015] pcieport 0000:02:01.0: bridge window [mem
>>> 0xa0200000-0xa02fffff 64bit pref]
>>> [ 65.531238] pci 0000:03:00.0: no hotplug settings from platform
>>> [ 65.538361] e1000e 0000:03:00.0: Disabling ASPM L1
>>> [ 65.543616] e1000e 0000:03:00.0: enabling device (0000 -> 0002)
>>> [ 65.549876] e1000e 0000:03:00.0: No usable DMA configuration, aborting
>>> [ 65.557194] e1000e: probe of 0000:03:00.0 failed with error -5
>>> -sh-3.2# lspci
>>> <snip>
>>> 0000:03:00.0 Ethernet controller: Intel Corporation 82572EI Gigabit
>>> Ethernet Controller (Copper) (rev 06)
>>> <snip>
>>> -sh-3.2# ifconfig -a
>>> <snip> // There is no network interface for 82572EI
>>>
>>> If archdata.dma_ops is NULL on x86 platform, e1000e will get dma_ops
>>> without archdata.
>>> So e1000e driver doesn't return error.
>>>
>>> I think that archdata should be set before driver probe (e.g pciehp).
>>> I tried to fix it (pciehp-add-archdata.patch), but I'm not good at PCI
>>> driver..., so please give better way.
>>
>> Interesting. It would be nice if we could set archdata the same way
>> for both devices present at boot and those hot-added later. Can you
>> figure out where archdata is set for devices present at boot?
>>
>> Bjorn
>>
>>> Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
>>> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
>>> index a4031df..a021fbc 100644
>>> --- a/drivers/pci/hotplug/pciehp_pci.c
>>> +++ b/drivers/pci/hotplug/pciehp_pci.c
>>> @@ -89,6 +89,7 @@ int pciehp_configure_device(struct slot *p_slot)
>>> pciehp_add_bridge(dev);
>>> }
>>> pci_dev_put(dev);
>>> + dev->dev.archdata = bridge->dev.archdata;
>>> }
>>>
>>> pci_assign_unassigned_bridge_resources(bridge);
>>>
>>
> 
> 

