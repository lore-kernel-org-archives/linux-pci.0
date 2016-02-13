Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33517 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbcBMXkN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 13 Feb 2016 18:40:13 -0500
Received: by mail-lf0-f49.google.com with SMTP id m1so71016732lfg.0
        for <linux-pci@vger.kernel.org>; Sat, 13 Feb 2016 15:40:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4beDk_ajsgqMUNJ3TGxDv=ysyPzhXHcx2AhUEUE9ROKA@mail.gmail.com>
References: <bug-112121-41252@https.bugzilla.kernel.org/> <CAErSpo4beDk_ajsgqMUNJ3TGxDv=ysyPzhXHcx2AhUEUE9ROKA@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sat, 13 Feb 2016 23:39:52 +0000
Message-ID: <CAHbf0-GBiMVr4=n3ZT1NSH8Xgdh3TcdDd=Di+pok6Ep6h42ZOQ@mail.gmail.com>
Subject: Re: [Bug 112121] New: Some PCIe options cause devices to be removed
 after syspend
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

I've just tested this again, I enabled PCI Hotplug & PCIe Hotplug and
nothing - then I noticed I hadn't enabled the ACPI Hotplug driver -
once I did the issue re-appeared

I then had to use testdisk to restore my partition table :'(

I've attached the updated dmesg & my .config

Cheers

Mike

On 8 February 2016 at 13:51, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linux-pci, NVMe folks,  power management folks]
>
> On Sun, Feb 7, 2016 at 11:04 AM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=112121
>>
>>             Bug ID: 112121
>>            Summary: Some PCIe options cause devices to be removed after
>>                     syspend
>>            Product: Drivers
>>            Version: 2.5
>>     Kernel Version: 4.5-rc2
>>           Hardware: All
>>                 OS: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: PCI
>>           Assignee: drivers_pci@kernel-bugs.osdl.org
>>           Reporter: mike@fireburn.co.uk
>>         Regression: No
>>
>> Created attachment 203091
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=203091&action=edit
>> Dmesg showing PCIe device removals
>>
>> I was having issues with suspend, when the machine was being resumed iommu
>> started removing devices - including my PCIe NVMe drive which contained my root
>> partition
>>
>> The problem showed up with:
>>
>> [*] PCI support
>> [*]   Support mmconfig PCI config space access
>> [*]   PCI Express Port Bus support
>> [*]     PCI Express Hotplug driver
>> [*]     Root Port Advanced Error Reporting support
>> [*]       PCI Express ECRC settings control
>> < >       PCIe AER error injector support
>> -*-     PCI Express ASPM control
>> [ ]       Debug PCI Express ASPM
>>           Default ASPM policy (BIOS default)  --->
>> [*]   Message Signaled Interrupts (MSI and MSI-X)
>> [ ]   PCI Debugging
>> [*]   Enable PCI resource re-allocation detection
>> < >   PCI Stub driver
>> [*]   Interrupts on hypertransport devices
>> [ ] PCI IOV support
>> [*] PCI PRI support
>> -*- PCI PASID support
>>     PCI host controller drivers  ----
>> < > PCCard (PCMCIA/CardBus) support  ----
>> [*] Support for PCI Hotplug  --->
>> < > RapidIO support
>>
>>
>> This is what I have now:
>>
>> [*] PCI support
>> [*]   Support mmconfig PCI config space access
>> [*]   PCI Express Port Bus support
>> [ ]     Root Port Advanced Error Reporting support
>> -*-     PCI Express ASPM control
>> [ ]       Debug PCI Express ASPM
>>           Default ASPM policy (BIOS default)  --->
>> [*]   Message Signaled Interrupts (MSI and MSI-X)
>> [*]   PCI Debugging
>> [ ]   Enable PCI resource re-allocation detection
>> < >   PCI Stub driver
>> [*]   Interrupts on hypertransport devices
>> [ ] PCI IOV support
>> [ ] PCI PRI support
>> [ ] PCI PASID support
>>     PCI host controller drivers  ----
>> < > PCCard (PCMCIA/CardBus) support  ----
>> [ ] Support for PCI Hotplug  ----
>> < > RapidIO support
>>
>> I tried disabling the iommu driver first but it had no effect
>>
>> If people are interested I could play with the above options to see which one
>> causes the issue
>
> My guess is that PCI hotplug is the important one.  It would be nice
> if dmesg contained enough information to connect nvme0n1 to a PCI
> device.  It'd be even nicer if the PCI core noted device removals or
> whatever happened here.
>
> You don't get any more details if you boot with "ignore_loglevel", do you?
>
> Mike, you didn't mark this as a regression, so I assume it's always
> been this way, and we just haven't noticed it because most people
> enable PCI hotplug (or whatever the relevant config option is).
>
> Bjorn
