Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S940879AbcJXNwS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Oct 2016 09:52:18 -0400
Message-ID: <580E1210.5050000@redhat.com>
Date: Mon, 24 Oct 2016 09:52:16 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Lukas Wunner <lukas@wunner.de>
CC: linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        David Arcari <darcari@redhat.com>,
        Myron Stowe <mstowe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFE PATCH] pci: Do not enable intx on MSI-capable devices on
 shutdown
References: <1477052083-13815-1-git-send-email-prarit@redhat.com> <20161024094445.GA5144@wunner.de>
In-Reply-To: <20161024094445.GA5144@wunner.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/24/2016 05:44 AM, Lukas Wunner wrote:
> On Fri, Oct 21, 2016 at 08:14:43AM -0400, Prarit Bhargava wrote:
>> The following unhandled IRQ warning is seen during shutdown:
>>
>> irq 16: nobody cared (try booting with the "irqpoll" option)
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
>> Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/01/2016
>>  0000000000000000 ffff88041f803e70 ffffffff81333bd5 ffff88041cb78200
>>  ffff88041cb7829c ffff88041f803e98 ffffffff810d9465 ffff88041cb78200
>>  0000000000000000 0000000000000028 ffff88041f803ed0 ffffffff810d97bf
>> Call Trace:
>>  <IRQ>  [<ffffffff81333bd5>] dump_stack+0x63/0x8e
>>  [<ffffffff810d9465>] __report_bad_irq+0x35/0xd0
>>  [<ffffffff810d97bf>] note_interrupt+0x20f/0x260
>>  [<ffffffff810d6b35>] handle_irq_event_percpu+0x45/0x60
>>  [<ffffffff810d6b7c>] handle_irq_event+0x2c/0x50
>>  [<ffffffff810da31a>] handle_fasteoi_irq+0x8a/0x150
>>  [<ffffffff8102edfb>] handle_irq+0xab/0x130
>>  [<ffffffff81082391>] ? _local_bh_enable+0x21/0x50
>>  [<ffffffff817064ad>] do_IRQ+0x4d/0xd0
>>  [<ffffffff81704502>] common_interrupt+0x82/0x82
>>  <EOI>  [<ffffffff815d0181>] ? cpuidle_enter_state+0xc1/0x280
>>  [<ffffffff815d0174>] ? cpuidle_enter_state+0xb4/0x280
>>  [<ffffffff815d0377>] cpuidle_enter+0x17/0x20
>>  [<ffffffff810bf660>] cpu_startup_entry+0x220/0x3a0
>>  [<ffffffff816f6da7>] rest_init+0x77/0x80
>>  [<ffffffff81d8e147>] start_kernel+0x495/0x4a2
>>  [<ffffffff81d8daa0>] ? set_init_arg+0x55/0x55
>>  [<ffffffff81d8d120>] ? early_idt_handler_array+0x120/0x120
>>  [<ffffffff81d8d5d6>] x86_64_start_reservations+0x2a/0x2c
>>  [<ffffffff81d8d715>] x86_64_start_kernel+0x13d/0x14c
>>
>> pci_device_shutdown() is called on each PCI device, and does
>>
>>         if (drv && drv->shutdown)
>>                 drv->shutdown(pci_dev);
>>         pci_msi_shutdown(pci_dev);
>>         pci_msix_shutdown(pci_dev);
>>
>> The pci_msi_shutdown() and pci_msix_shutdown() functions both call
>> pci_intx_for_msi() which enables the intx interrupt independent of the driver.
>> The driver still thinks it is using MSI/X and the result is the above stack
>> trace.
>>
>> We have seen this at Red Hat on various drivers: nouveau, ahci, and pcieport
>> (so far).  Google search for "unhandled irq 16" yields many results reporting
>> similar behavior during shutdown indicating that this problem is widespread.
> 
> I've occasionally seen this on an Ivy Bridge MacBook Pro as well,
> also on IRQ 16.  It's been a major annoyance, so thanks for looking
> into this.
>
> Why is this always occurring on IRQ 16, not on any others?  On my
> MacBook Pro IRQ 16 is used by a root port (00:1c.0, pcieport),
> an Ethernet controller below that root port (02:00.0, tg3) and
> a Thunderbolt hotplug bridge (06:03.0, pcieport).  I've never seen
> these spurious interrupts on any other IRQ.

That is exactly what I have -- the root port has IRQ 16, and it is a device
below the port that is being switched from MSI to intx that causes the problem.
 Note: darcari (cc'd) has a system on which this isn't the case.  I've spent
some time looking at IOAPIC documentation to see if there is something special
about IRQ 16 but haven't found anything.

I do think, however, in my case that IRQ 16 has something to do with the PCIE
ports.  I have another root port with IRQ 40.  If I boot with pcie_ports=native
acpi=noirq pcie_pme=nomsi I can cause the issue to happen on both root ports'
IRQs during shutdown:

[  203.068123] Disabling IRQ #40
[  204.975339] Disabling IRQ #16

I also thought this might be a unhandled AER or PME event but dumping the
registers for that functionality doesn't show that anything is wrong.

Alex suggested (during discussion) that this might be some odd issue with the
LAPIC generating a IRQ on 16.  I'll let him answer with his thoughts.

> 
> The patch looks good, I'm wondering though if it works correctly
> with PCI devices passed through to a VM:  When the VM is shut down,
> it won't enable INTx any longer.  Not sure if this can cause problems
> for the host.
> 

I'll set up a VM and see what happens.

P.
