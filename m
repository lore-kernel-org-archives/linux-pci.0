Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:57961 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab2JHPZU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 11:25:20 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1612609dak.19
        for <linux-pci@vger.kernel.org>; Mon, 08 Oct 2012 08:25:19 -0700 (PDT)
Message-ID: <5072EFEF.30708@gmail.com>
Date: Mon, 08 Oct 2012 23:23:27 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/10] PCI, ACPI: Use bus type notifier for root bus hotplug
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org> <506F9E0F.9010705@gmail.com> <CAE9FiQWj655cwN_e0ZmzCVYmJEnM2O_V453g4QTQqaApOPo2Fw@mail.gmail.com> <50719D20.8020009@gmail.com> <CAE9FiQXU3gwqkrmUPg-JzgRLXRzfZ2jd94q0eC4q1bpuo8_fvQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXU3gwqkrmUPg-JzgRLXRzfZ2jd94q0eC4q1bpuo8_fvQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/08/2012 06:33 AM, Yinghai Lu wrote:
> On Sun, Oct 7, 2012 at 8:17 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> On 10/06/2012 03:25 PM, Yinghai Lu wrote:
>>>> With above sequence, we could scan and start PCI devices in step 3 above.
>>>
>>> ioapic may need to be after pci device scan and pci assign-unassigned resource.
>>>
>>> the same as iommu/dmar... need to after pci device scanning...
>> Hi Yinghai,
>>         I have no experience with AMD IOAPIC yet, seems IOAPIC on AMD platforms
>> may have the special requirement above. So your solution is better and no need
>> for the ACPI system device hotplug framework to handle IOAPIC device any more.
>>
>>>
>>> I have all pci root bus hot plug related patch in my tree
>>>
> ...
>>>
>>> after those patches (about 61) go through pci/next
>>>
>>> will need to push for-x86-irq for ioapic through tip
>>> and for-iommu for iommu support through iommu : david.W
>> I have reviewed these branches, all seems great to me. It includes some nice clean
>> up other than the "PCI host bridge hotplug".
>> for-pci-split-pci-root-hp
>> for-pci-root-bus-hotplug
>> for-pci-misc
>> for-pci-host-bridge-bus-type
>> for-pci-jiang-hotplug
>> for-pci-notifier
>> for-pci-x86-pcibios-alloc-res
>> for-pci-root-bus-hotadd-survey-pcibios-res
>>
>> And we I have several plan based on your work as below, what's your thoughts?
>> 1) replace pci_root_hp.c with our new hotplug framework
>> 2) enhance pci_root.c to support new hotplug framework
>> 3) enable PCI host bridge hotplug for IA64 platforms.
>> 4) try to make PCI host bridge hotplug work without "drivers_autoprobe".
> 
> I think my pci-root-bus hotplug should be all done.
> 
> need to flush all patches except last 7 patches about drivers_autoprobe.
> 
> my concern about your new acpihp framework:
> please make sure you change will still make user have the chance not
> to use acpiphp
> for normal pci slot hotplug support instead of pciehp.
Hi Yinghai,
	The new hotplug framework only handles CPU, memory, container and PCI host bridges,
so it shouldn't affect acpiphp or pciehp drivers.	

> 
> Also I would suggest you to start the new framework stuff after cpu,
> memory, pci-root-bus work are all done separately.
OK, hope the PCI host bridge hotplug work be merged for 3.8.

