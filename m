Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750Ab3GYJ51 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Jul 2013 05:57:27 -0400
Message-ID: <51F0F67F.8070200@redhat.com>
Date: Thu, 25 Jul 2013 05:57:19 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <mstowe@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] acpi, acpi_pci_irq_enable must return an error if ACPI
 cannot map an IRQ.
References: <1373900260-1599-1-git-send-email-prarit@redhat.com> <4699269.a9aFxdNOHD@vostro.rjw.lan> <51F06AE4.9010606@redhat.com>
In-Reply-To: <51F06AE4.9010606@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/24/2013 08:01 PM, Prarit Bhargava wrote:
> 
> 
> On 07/24/2013 07:35 PM, Rafael J. Wysocki wrote:
>> On Monday, July 15, 2013 10:57:40 AM Prarit Bhargava wrote:
>>> Driver probe's currently do the following
>>>
>>> 	pci_enable_device();
>>> 	/* ... do some other init stuff, and eventually call ... */
>>> 	request_irq();
>>>
>>> After pci_enable_device() is called it is assumed that the device's irq
>>> value (pci_dev->irq) has been appropriately set on success.  This value
>>> is passed into the request_irq() call.
>>>
>>> In the case that ACPI is used to determine the irq value, it is possible
>>> that the ACPI IRQ look up for a specific device fails and success is
>>> returned by pci_enable_device().
>>>
>>> The call sequence is:
>>>
>>> pci_enable_device();
>>> 	-> pci_enable_device_flags();
>>> 		->do_pci_enable_device();
>>> 			-> pcibios_enable_device() which, if the device
>>> 			   does not use MSI calls
>>> 			   -> pcibios_enable_irq() which maps to
>>> 			      acpi_pci_irq_enable()
>>> 				-> acpi_pci_irq_lookup()
>>>
>>> If acpi_pci_irq_lookup() cannot map the device's IRQ value it returns NULL
>>> as an error.  The error is returned to acpi_pci_irq_enable(), but is not
>>> propagated further.  This can result in the driver returning success for
>>> pci_enable_device() and the driver probe attempting to call request_irq()
>>> with dev->irq = 0.
>>>
>>> This patch modifies acpi_pci_irq_enable() to return an error in the case
>>> that an entry is not found in the ACPI tables.
>>
>> Is there any known system on which this leads to observable misbehavior?
>>
>> If so, what's that system?
>>
> 
> Dell PowerEdge 840.  The end result is an genirq warning about the irq flags of
> irq 0:
> 
> [   14.126845] i801_smbus 0000:00:1f.3: can't derive routing for PCI INT B
> [   14.133473] i801_smbus 0000:00:1f.3: PCI INT B: no GSI
> [   14.795122] genirq: Flags mismatch irq 0. 00000080 (i801_smbus) vs. 00015a20
> (timer)
> [   14.796037] CPU: 0 PID: 427 Comm: systemd-udevd Tainted: G        W
> --------------   3.10.0-0.rc4.60.el7.x86_64.debug #1
> [   14.796037] Hardware name: Dell Computer Corporation PowerEdge 840/0RH822,
> BIOS A05 10/04/2007
> [   14.796037]  ffff880075643b80 ffff88007a743aa8 ffffffff816b8bbd ffff88007a743af8
> [   14.796037]  ffffffff8111ed8d ffffffff811bf5d1 0000000000000296 ffff880075b93800
> [   14.796037]  ffffffffa03d2240 0000000000000080 0000000000000000 ffff88007ad7e000
> [   14.796037] Call Trace:
> [   14.796037]  [<ffffffff816b8bbd>] dump_stack+0x19/0x1b
> [   14.796037]  [<ffffffff8111ed8d>] __setup_irq+0x51d/0x550
> [   14.796037]  [<ffffffff811bf5d1>] ? kmem_cache_alloc_trace+0x111/0x340
> [   14.796037]  [<ffffffffa03d2240>] ? i801_check_pre.isra.6+0xe0/0xe0 [i2c_i801]
> [   14.796037]  [<ffffffff8111ef1c>] request_threaded_irq+0xcc/0x170
> [   14.796037]  [<ffffffffa03d388d>] i801_probe+0x34d/0x52c [i2c_i801]
> [   14.796037]  [<ffffffff810ddecd>] ? trace_hardirqs_on+0xd/0x10
> [   14.796037]  [<ffffffff813876be>] local_pci_probe+0x3e/0x70
> [   14.796037]  [<ffffffff813889a1>] pci_device_probe+0x111/0x120
> [   14.796037]  [<ffffffff8144ff77>] driver_probe_device+0x87/0x390
> [   14.796037]  [<ffffffff81450353>] __driver_attach+0x93/0xa0
> [   14.796037]  [<ffffffff814502c0>] ? __device_attach+0x40/0x40
> [   14.796037]  [<ffffffff8144de93>] bus_for_each_dev+0x63/0xa0
> [   14.796037]  [<ffffffff8144f9ae>] driver_attach+0x1e/0x20
> [   14.796037]  [<ffffffff8144f540>] bus_add_driver+0x1f0/0x2a0
> [   14.796037]  [<ffffffffa03d8000>] ? 0xffffffffa03d7fff
> [   14.796037]  [<ffffffff814509d1>] driver_register+0x71/0x150
> [   14.796037]  [<ffffffffa03d8000>] ? 0xffffffffa03d7fff
> [   14.796037]  [<ffffffff81387540>] __pci_register_driver+0x60/0x70
> [   14.796037]  [<ffffffffa03d80af>] i2c_i801_init+0xaf/0x1000 [i2c_i801]
> [   14.796037]  [<ffffffffa03d8000>] ? 0xffffffffa03d7fff
> [   14.796037]  [<ffffffff810020e2>] do_one_initcall+0xe2/0x1a0
> [   14.796037]  [<ffffffff810ee09f>] load_module+0xf4f/0x14d0
> [   14.796037]  [<ffffffff81375d20>] ? ddebug_proc_write+0xf0/0xf0
> [   14.796037]  [<ffffffff8136088d>] ? trace_hardirqs_off_thunk+0x3a/0x3c
> [   14.796037]  [<ffffffff810ee6e1>] SyS_init_module+0xc1/0x110
> [   14.796037]  [<ffffffff816ca299>] system_call_fastpath+0x16/0x1b
> 

Rafael,

One other thing -- the core issue here is that the BIOS is broken and does not
supply an ACPI entry for the IRQ.  I think the kernel should do a better job of
reacting to that instead of just continuing down a broken path.

In either case, the end result is the same -- the i801 driver does not load, but
with my patch the warning is not displayed, which IMO is the correct way to fail.

P.

> P.
