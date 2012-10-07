Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52168 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab2JGWde (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 7 Oct 2012 18:33:34 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1740913bkc.19
        for <linux-pci@vger.kernel.org>; Sun, 07 Oct 2012 15:33:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50719D20.8020009@gmail.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
	<506F9E0F.9010705@gmail.com>
	<CAE9FiQWj655cwN_e0ZmzCVYmJEnM2O_V453g4QTQqaApOPo2Fw@mail.gmail.com>
	<50719D20.8020009@gmail.com>
Date: Sun, 7 Oct 2012 15:33:33 -0700
Message-ID: <CAE9FiQXU3gwqkrmUPg-JzgRLXRzfZ2jd94q0eC4q1bpuo8_fvQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] PCI, ACPI: Use bus type notifier for root bus hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Oct 7, 2012 at 8:17 AM, Jiang Liu <liuj97@gmail.com> wrote:
> On 10/06/2012 03:25 PM, Yinghai Lu wrote:
>>> With above sequence, we could scan and start PCI devices in step 3 above.
>>
>> ioapic may need to be after pci device scan and pci assign-unassigned resource.
>>
>> the same as iommu/dmar... need to after pci device scanning...
> Hi Yinghai,
>         I have no experience with AMD IOAPIC yet, seems IOAPIC on AMD platforms
> may have the special requirement above. So your solution is better and no need
> for the ACPI system device hotplug framework to handle IOAPIC device any more.
>
>>
>> I have all pci root bus hot plug related patch in my tree
>>
...
>>
>> after those patches (about 61) go through pci/next
>>
>> will need to push for-x86-irq for ioapic through tip
>> and for-iommu for iommu support through iommu : david.W
> I have reviewed these branches, all seems great to me. It includes some nice clean
> up other than the "PCI host bridge hotplug".
> for-pci-split-pci-root-hp
> for-pci-root-bus-hotplug
> for-pci-misc
> for-pci-host-bridge-bus-type
> for-pci-jiang-hotplug
> for-pci-notifier
> for-pci-x86-pcibios-alloc-res
> for-pci-root-bus-hotadd-survey-pcibios-res
>
> And we I have several plan based on your work as below, what's your thoughts?
> 1) replace pci_root_hp.c with our new hotplug framework
> 2) enhance pci_root.c to support new hotplug framework
> 3) enable PCI host bridge hotplug for IA64 platforms.
> 4) try to make PCI host bridge hotplug work without "drivers_autoprobe".

I think my pci-root-bus hotplug should be all done.

need to flush all patches except last 7 patches about drivers_autoprobe.

my concern about your new acpihp framework:
please make sure you change will still make user have the chance not
to use acpiphp
for normal pci slot hotplug support instead of pciehp.

Also I would suggest you to start the new framework stuff after cpu,
memory, pci-root-bus work are all done separately.

Thanks

Yinghai
