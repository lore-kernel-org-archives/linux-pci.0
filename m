Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:43391 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531AbaGPSKv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jul 2014 14:10:51 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so4441706igd.11
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2014 11:10:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53C5F2C2.20707@linux.intel.com>
References: <53C5F2C2.20707@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 16 Jul 2014 12:04:05 -0600
Message-ID: <CAErSpo6D3q0NoJhjF2kTZBVaQBb5Gz-bY-P_eR2EYzFvQ6yhPw@mail.gmail.com>
Subject: Re: Need advices about PCI IRQ reference count tracking
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Jul 15, 2014 at 9:34 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> Hi Bjorn,
>         When enabling ACPI based IOAPIC hotplug, we encountered an
> issue with PCI IRQ reference count tracking and need your advices.
>         In order to hot-remove an IOAPIC, we need to track and keep
> balance of IOAPIC pin usage count. But acpi_pci_irq_enable() may
> be called twice for a PCI device,
> 1) pci_acpi_init() if pci_routeirq is true
> 2) pci_enable_device()
>
> So in function acpi_pci_irq_enable(), we need a way to track whether
> an IOAPIC IRQ has been assigned to the PCI device. Previously we check
> "if (dev->irq > 0)" for that, but that's wrong because dev->irq may
> be set to non-zero in pci_read_irq() if BIOS has already assigned
> a legacy IRQ for the device. So is it OK to add a flag into pci_dev
> to track this information?
>
> Another possible workaround is to disable IOAPIC hotplug when
> pci_routeirq is set, but that sounds not the best solution.

My first choice would be to get rid of pci_routeirq.  It was added in
2004 as a workaround for broken drivers.  I don't know any reason why
we need the "pci=routeirq" option any more.

However, 629e15d245f4 ("x86, irq: update_mptable needs pci_routeirq")
added another use of pci_routeirq.  This is only used when booting
with the undocumented "update_mptable" option, and I can't tell
whether it's useful or not.

Bjorn

P.S.  I'm going on vacation for a few weeks, so I won't be able to
follow this for a while.
