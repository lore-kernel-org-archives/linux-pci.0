Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38689 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2JFHZn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 6 Oct 2012 03:25:43 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1278534bkc.19
        for <linux-pci@vger.kernel.org>; Sat, 06 Oct 2012 00:25:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <506F9E0F.9010705@gmail.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
	<506F9E0F.9010705@gmail.com>
Date: Sat, 6 Oct 2012 00:25:41 -0700
Message-ID: <CAE9FiQWj655cwN_e0ZmzCVYmJEnM2O_V453g4QTQqaApOPo2Fw@mail.gmail.com>
Subject: Re: [PATCH 00/10] PCI, ACPI: Use bus type notifier for root bus hotplug
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 5, 2012 at 7:57 PM, Jiang Liu <liuj97@gmail.com> wrote:
> Hi Yinghai,
>         I like your idea to get rid of acpi_device_ops->start() method, actually
> that's on my TODO list too.
>         I think the ACPI based system device hotplug framework we are working on
> may help to solve this issue. We define CPU, memory, PCI host bridge, IOAPIC,
> and CONTAINER as system devices. We have added some callbacks into acpi_device_ops
> to support system device hotplug. With the new ACPI system device hotplug framework,
> the sequence is:
> 1) Walk hot-added ACPI subtree, creates acpi devices and binds acpi drivers. Now
> acpi_device_ops->add() method only setup basic data structure to manage the ACPI
> device but without actually starting the system device.
> 2) Classify hot-added ACPI devices into classes, such CPU, MEM, PCI HOST BRIGE, IOAPIC,
> CONTAINER.
> 3) Add all hot-added system device into running system in following order:
> CONTAINER -> MEM -> CPU -> IOAPIC -> PCI_HOST_BRIDGE.
>
> With above sequence, we could scan and start PCI devices in step 3 above.

ioapic may need to be after pci device scan and pci assign-unassigned resource.

the same as iommu/dmar... need to after pci device scanning...

I have all pci root bus hot plug related patch in my tree

 for-pci-x86-pcibios-alloc-res
 for-pci-host-bridge-bus-type
 for-pci-kill-pci-root-buses

 for-pci-root-bus-hotplug

 for-pci-misc

 for-pci-jiang-hotplug

 for-pci-root-bus-hotadd-survey-pcibios-res
 for-pci-split-pci-root-hp
 for-pci-notifier


 for-acpi-next-pci
 for-pci-next

after those patches (about 61) go through pci/next

will need to push for-x86-irq for ioapic through tip
and for-iommu for iommu support through iommu : david.W

Thanks

Yinghai
