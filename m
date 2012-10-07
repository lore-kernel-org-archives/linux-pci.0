Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57777 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab2JGPSD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Oct 2012 11:18:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3284842pbb.19
        for <linux-pci@vger.kernel.org>; Sun, 07 Oct 2012 08:18:02 -0700 (PDT)
Message-ID: <50719D20.8020009@gmail.com>
Date: Sun, 07 Oct 2012 23:17:52 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/10] PCI, ACPI: Use bus type notifier for root bus hotplug
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org> <506F9E0F.9010705@gmail.com> <CAE9FiQWj655cwN_e0ZmzCVYmJEnM2O_V453g4QTQqaApOPo2Fw@mail.gmail.com>
In-Reply-To: <CAE9FiQWj655cwN_e0ZmzCVYmJEnM2O_V453g4QTQqaApOPo2Fw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/06/2012 03:25 PM, Yinghai Lu wrote:
> On Fri, Oct 5, 2012 at 7:57 PM, Jiang Liu <liuj97@gmail.com> wrote:
>> Hi Yinghai,
>>         I like your idea to get rid of acpi_device_ops->start() method, actually
>> that's on my TODO list too.
>>         I think the ACPI based system device hotplug framework we are working on
>> may help to solve this issue. We define CPU, memory, PCI host bridge, IOAPIC,
>> and CONTAINER as system devices. We have added some callbacks into acpi_device_ops
>> to support system device hotplug. With the new ACPI system device hotplug framework,
>> the sequence is:
>> 1) Walk hot-added ACPI subtree, creates acpi devices and binds acpi drivers. Now
>> acpi_device_ops->add() method only setup basic data structure to manage the ACPI
>> device but without actually starting the system device.
>> 2) Classify hot-added ACPI devices into classes, such CPU, MEM, PCI HOST BRIGE, IOAPIC,
>> CONTAINER.
>> 3) Add all hot-added system device into running system in following order:
>> CONTAINER -> MEM -> CPU -> IOAPIC -> PCI_HOST_BRIDGE.
>>
>> With above sequence, we could scan and start PCI devices in step 3 above.
> 
> ioapic may need to be after pci device scan and pci assign-unassigned resource.
> 
> the same as iommu/dmar... need to after pci device scanning...
Hi Yinghai,
	I have no experience with AMD IOAPIC yet, seems IOAPIC on AMD platforms
may have the special requirement above. So your solution is better and no need
for the ACPI system device hotplug framework to handle IOAPIC device any more.

> 
> I have all pci root bus hot plug related patch in my tree
> 
>  for-pci-x86-pcibios-alloc-res
>  for-pci-host-bridge-bus-type
>  for-pci-kill-pci-root-buses
> 
>  for-pci-root-bus-hotplug
> 
>  for-pci-misc
> 
>  for-pci-jiang-hotplug
> 
>  for-pci-root-bus-hotadd-survey-pcibios-res
>  for-pci-split-pci-root-hp
>  for-pci-notifier
> 
> 
>  for-acpi-next-pci
>  for-pci-next
> 
> after those patches (about 61) go through pci/next
> 
> will need to push for-x86-irq for ioapic through tip
> and for-iommu for iommu support through iommu : david.W
I have reviewed these branches, all seems great to me. It includes some nice clean
up other than the "PCI host bridge hotplug".
for-pci-split-pci-root-hp
for-pci-root-bus-hotplug
for-pci-misc
for-pci-host-bridge-bus-type
for-pci-jiang-hotplug
for-pci-notifier
for-pci-x86-pcibios-alloc-res
for-pci-root-bus-hotadd-survey-pcibios-res

And we I have several plan based on your work as below, what's your thoughts?
1) replace pci_root_hp.c with our new hotplug framework
2) enhance pci_root.c to support new hotplug framework
3) enable PCI host bridge hotplug for IA64 platforms.
4) try to make PCI host bridge hotplug work without "drivers_autoprobe".

Thanks!
