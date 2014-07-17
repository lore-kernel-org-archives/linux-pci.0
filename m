Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46099 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077AbaGQDOb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Jul 2014 23:14:31 -0400
Message-ID: <53C73F94.7060500@linux.intel.com>
Date: Thu, 17 Jul 2014 11:14:28 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Need advices about PCI IRQ reference count tracking
References: <53C5F2C2.20707@linux.intel.com>	<CAErSpo6D3q0NoJhjF2kTZBVaQBb5Gz-bY-P_eR2EYzFvQ6yhPw@mail.gmail.com>	<CAE9FiQWsjXU0YBsgnSvNXzkPKDPph4RgYQcvmGGoL27TE7YrhA@mail.gmail.com>	<53C73CC6.20803@linux.intel.com> <CAE9FiQX3nTCXvwfUwz9vx4HmO_mdUaFg57qN_YR-cYN0qWpQpg@mail.gmail.com>
In-Reply-To: <CAE9FiQX3nTCXvwfUwz9vx4HmO_mdUaFg57qN_YR-cYN0qWpQpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/7/17 11:06, Yinghai Lu wrote:
> On Wed, Jul 16, 2014 at 8:02 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>>
>>
>> On 2014/7/17 2:37, Yinghai Lu wrote:
>>> On Wed, Jul 16, 2014 at 11:04 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> [+cc Yinghai]
>>>>
>>>> On Tue, Jul 15, 2014 at 9:34 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>>>>> Hi Bjorn,
>>>>>         When enabling ACPI based IOAPIC hotplug, we encountered an
>>>>> issue with PCI IRQ reference count tracking and need your advices.
>>>>>         In order to hot-remove an IOAPIC, we need to track and keep
>>>>> balance of IOAPIC pin usage count. But acpi_pci_irq_enable() may
>>>>> be called twice for a PCI device,
>>>>> 1) pci_acpi_init() if pci_routeirq is true
>>>>> 2) pci_enable_device()
>>>>>
>>>>> So in function acpi_pci_irq_enable(), we need a way to track whether
>>>>> an IOAPIC IRQ has been assigned to the PCI device. Previously we check
>>>>> "if (dev->irq > 0)" for that, but that's wrong because dev->irq may
>>>>> be set to non-zero in pci_read_irq() if BIOS has already assigned
>>>>> a legacy IRQ for the device. So is it OK to add a flag into pci_dev
>>>>> to track this information?
>>>
>>> Why do you need to track it?
>>>
>>> When do you hot-remove ioapic with pci root bus, all the drivers for
>>> devices on that pci root bus should be stopped at first, so no one
>>> will use the ioapic before ioapic is being removed.
>> Hi Yinghai,
>>         By tracking IOAPIC pin usage count, we could release the
>> assigned IRQ number when there are no device uses an IOAPIC pin anymore.
> 
> Delay releasing IRQ number later when destroying irq domain?
Hi Yinghai,
	We could release IRQ number at runtime not only for IOAPIC
hotplug, but also for PCI device hotplug. For example, release IRQ
number if an IOAPIC pin is not used anymore after hot-removal of
a PCI device.

Regards!
Gerry

> 
> Yinghai
> 
