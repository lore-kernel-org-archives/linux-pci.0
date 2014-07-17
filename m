Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:43799 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaGQDG4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 23:06:56 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so5265746igd.17
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 20:06:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53C73CC6.20803@linux.intel.com>
References: <53C5F2C2.20707@linux.intel.com>
	<CAErSpo6D3q0NoJhjF2kTZBVaQBb5Gz-bY-P_eR2EYzFvQ6yhPw@mail.gmail.com>
	<CAE9FiQWsjXU0YBsgnSvNXzkPKDPph4RgYQcvmGGoL27TE7YrhA@mail.gmail.com>
	<53C73CC6.20803@linux.intel.com>
Date: Wed, 16 Jul 2014 20:06:55 -0700
Message-ID: <CAE9FiQX3nTCXvwfUwz9vx4HmO_mdUaFg57qN_YR-cYN0qWpQpg@mail.gmail.com>
Subject: Re: Need advices about PCI IRQ reference count tracking
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 16, 2014 at 8:02 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>
>
> On 2014/7/17 2:37, Yinghai Lu wrote:
>> On Wed, Jul 16, 2014 at 11:04 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> [+cc Yinghai]
>>>
>>> On Tue, Jul 15, 2014 at 9:34 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
>>>> Hi Bjorn,
>>>>         When enabling ACPI based IOAPIC hotplug, we encountered an
>>>> issue with PCI IRQ reference count tracking and need your advices.
>>>>         In order to hot-remove an IOAPIC, we need to track and keep
>>>> balance of IOAPIC pin usage count. But acpi_pci_irq_enable() may
>>>> be called twice for a PCI device,
>>>> 1) pci_acpi_init() if pci_routeirq is true
>>>> 2) pci_enable_device()
>>>>
>>>> So in function acpi_pci_irq_enable(), we need a way to track whether
>>>> an IOAPIC IRQ has been assigned to the PCI device. Previously we check
>>>> "if (dev->irq > 0)" for that, but that's wrong because dev->irq may
>>>> be set to non-zero in pci_read_irq() if BIOS has already assigned
>>>> a legacy IRQ for the device. So is it OK to add a flag into pci_dev
>>>> to track this information?
>>
>> Why do you need to track it?
>>
>> When do you hot-remove ioapic with pci root bus, all the drivers for
>> devices on that pci root bus should be stopped at first, so no one
>> will use the ioapic before ioapic is being removed.
> Hi Yinghai,
>         By tracking IOAPIC pin usage count, we could release the
> assigned IRQ number when there are no device uses an IOAPIC pin anymore.

Delay releasing IRQ number later when destroying irq domain?

Yinghai
