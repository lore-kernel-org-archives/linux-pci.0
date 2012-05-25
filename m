Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:65179 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2EYCWq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2012 22:22:46 -0400
Received: from huawei.com (szxga05-in [172.24.2.49])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4K00IO63XW96@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Fri, 25 May 2012 10:22:44 +0800 (CST)
Received: from szxrg01-dlp.huawei.com ([172.24.2.119])
 by szxga05-in.huawei.com (iPlanet Messaging Server 5.2 HotFix 2.14 (built Aug
 8 2006)) with ESMTP id <0M4K00G773XM5D@szxga05-in.huawei.com> for
 linux-pci@vger.kernel.org; Fri, 25 May 2012 10:22:44 +0800 (CST)
Date: Fri, 25 May 2012 10:21:52 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH v6 0/9] PCI,
 x86: update MMCFG information when hot-plugging PCI host bridges
In-reply-to: <20120524182601.GA7551@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>, Jiang Liu <liuj97@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org
Message-id: <4FBEECC0.5040108@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <1337745026-1180-1-git-send-email-jiang.liu@huawei.com>
 <20120524182601.GA7551@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-5-25 2:26, Bjorn Helgaas wrote:
> On Wed, May 23, 2012 at 11:50:17AM +0800, Jiang Liu wrote:
>> From: Jiang Liu<liuj97@gmail.com>
>>
>> From: Jiang Liu<jiang.liu@huawei.com>
>>
>> This patchset enhance pci_root driver to update MMCFG information when
>> hot-plugging PCI root bridges. It applies to
>> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/next-3.5
>>
>> -v2: split into smaller patches and skip updating MMCFG information when
>>       MMCFG is disabled
>> -v3: add mmconf_added to simply free path, also make pci_mmconfig_insert()
>>       to process extra exist case --- By Yinghai
>> -v4: tune arch_acpi_pci_root_add() to handle a corner case raised by Kenji
>> -v5: address review comments from Bjorn and Taku, also better handle corner
>>       cases in arch_acpi_pci_root_add()
>> -v6: get rid of arch_acpi_pci_root_xxx() by using existing hooks
>>       add MCFG information for host bridges on demand
>>       more corner cases clear up
>>       correctly handle condition compilation
>>       fix section mismatch issues
>>       fix a issue reported by Taku about a BIOS bug
>>
>> The first 4 patches in series is the same with v5.
>
> I tried this on one of my machines.  Before your patches:
>
>      ACPI: bus type pci registered
>      PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>      PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
>      ...
>      ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
>
> After:
>
>      ACPI: bus type pci registered
> 1)  PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>      PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
>      ...
>      ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
> 2)  PCI: MMCONFIG for domain 0000 [bus 00-7e] at [mem 0x80000000-0x87efffff] (base 0x80000000)
> 3)  [Firmware Bug]: PCI: MMCONFIG at [mem 0x80000000-0x87efffff] not reserved in ACPI motherboard resources
> 4)  PCI: MMCONFIG at [mem 0x80000000-0x87efffff] reserved in E820
>
> I really like the MMCONFIG info being associated with the host bridge in
> dmesg, and I really like it being split out in /proc/iomem.  That's much
> cleaner than it used to be.  MMCONFIG is defined by the PCIe spec, and
> there are non-x86 architectures that use the same mechanism, so I can
> imagine someday (not now!) making it more generic.
>
> 1): Do we really need this early MCFG scan?  Conceptually it seems like we
> don't need to look at MCFG until we add a host bridge or do a blind probe.
After digging the log messages, I found the early probing logic is
needed for two cases:
1) CONFIG_PCI_BIOS and CONFIG_PCI_DIRECT are disabled or not supported
by the platform, and MMCONF is the only method to access configuration
space. So need to support MMCONF as early as possible because ACPI
initialization may need to access PCI configuration space.

2) ACPI is disabled by "acpi=off" boot option or due to errors when 
initializing the ACPI subsystem, so pci_mmcfg_late_init() won't be called.

So it seems we do need the early probe logic.

>
> 2) and 4): These should be dev_info() with the host bridge device, e.g.,
>
>      pci_root PNP0A08:00: MMCONFIG at [mem 0x80000000-0x87efffff]
>
> Now that we can associate it with the bridge, the bus number range is
> redundant.  It might be useful to know whether the MMCONFIG range came from
> _CBA or MCFG, if that's easy to do.
>
> Here's I'm thinking: right now we have some message confusion -- the arch
> prints window info, e.g., "pci_root PNP0A08:00: host bridge window [io
> 0x0000-0x03af]", and then the PCI core prints the same thing but associated
> with the bus: "pci_bus 0000:00: root bus resource [io  0x0000-0x03af]".
> I'd like this to become more uniform, and have only the core print it, but
> using the host bridge device, not the bus.
OK, will change the log messages according to your suggestions.

>
> 3): Something seems wrong here -- this "bug" message didn't appear before,
> so I don't think it should now.  I haven't tried to chase this down.
__pci_mmcfg_init() will be called by pci_mmcfg_early_init() and
pci_mmcfg_late_init(). When it's called by pci_mmcfg_early_init(),
the ACPI subsystem hasn't been initialized yet, so
pci_mmcfg_reject_broken() doesn't check whether the resource is
reserved by ACPI motherboard devices. If we pass "pci=noearly"
option to the kernel to disable early probe, it will generate
the warning message on the same platform.

According to commit 7752d5cfe3d11ca0bb9c673ec38bd78ba6578f8e log
message, "The PCI Express firmware spec apparently tells BIOS
developers that reservation in ACPI is required and E820 reservation
is optional", it would be better for us to emit this warning message.
Any suggestions here?




