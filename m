Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36117 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab2AFQxI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 11:53:08 -0500
Message-ID: <4F0726EF.4060103@jp.fujitsu.com>
Date: Fri, 06 Jan 2012 11:53:03 -0500
From: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add pcie_hp=nomsi to disable MSI for pciehp driver
References: <20120106095637.16292.29895.sendpatchset@dhcp-189-101.bos.redhat.com> <20120106132408.GB8989@kroah.com>
In-Reply-To: <20120106132408.GB8989@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 6 Jan 2012 05:24:08 -0800,
Greg KH <greg@kroah.com> wrote:
> On Fri, Jan 06, 2012 at 04:56:37AM -0500, MUNEDA Takahiro wrote:
>> Not to use MSI/MSI-X for pciehp, add a kernel parameter, pcie_hp=nomsi.
>>
>> In my environment, while shutting down, following stack trace is shown
>> sometimes.
>>
>>    irq 16: nobody cared (try booting with the "irqpoll" option)
>>    Pid: 1081, comm: reboot Not tainted 3.2.0 #1
>>    Call Trace:
>>     <IRQ>   [<ffffffff810cec1d>] __report_bad_irq+0x3d/0xe0
>>     [<ffffffff810cee1c>] note_interrupt+0x15c/0x210
>>     [<ffffffff810cc485>] handle_irq_event_percpu+0xb5/0x210
>>     [<ffffffff810cc621>] handle_irq_event+0x41/0x70
>>     [<ffffffff810cf675>] handle_fasteoi_irq+0x55/0xc0
>>     [<ffffffff81015356>] handle_irq+0x46/0xb0
>>     [<ffffffff814fbe9d>] do_IRQ+0x5d/0xe0
>>     [<ffffffff814f146e>] common_interrupt+0x6e/0x6e
>>     [<ffffffff8106b040>] ? __do_softirq+0x60/0x210
>>     [<ffffffff8108aeb1>] ? hrtimer_interrupt+0x151/0x240
>>     [<ffffffff814fb5ec>] call_softirq+0x1c/0x30
>>     [<ffffffff810152d5>] do_softirq+0x65/0xa0
>>     [<ffffffff8106ae9d>] irq_exit+0xbd/0xe0
>>     [<ffffffff814fbf8e>] smp_apic_timer_interrupt+0x6e/0x99
>>     [<ffffffff814f9e5e>] apic_timer_interrupt+0x6e/0x80
>>     <EOI>   [<ffffffff814f0fb1>] ? _raw_spin_unlock_irqrestore+0x11/0x20
>>     [<ffffffff812629fc>] pci_bus_write_config_word+0x6c/0x80
>>     [<ffffffff81266fc2>] pci_intx+0x52/0xa0
>>     [<ffffffff8127de3d>] pci_intx_for_msi+0x1d/0x30
>>    [<ffffffff8127e4fb>] pci_msi_shutdown+0x7b/0x110
>>     [<ffffffff81269d34>] pci_device_shutdown+0x34/0x50
>>     [<ffffffff81326c4f>] device_shutdown+0x2f/0x140
>>     [<ffffffff8107b981>] kernel_restart_prepare+0x31/0x40
>>     [<ffffffff8107b9e6>] kernel_restart+0x16/0x60
>>     [<ffffffff8107bbfd>] sys_reboot+0x1ad/0x220
>>     [<ffffffff814f4b90>] ? do_page_fault+0x1e0/0x460
>>     [<ffffffff811942d0>] ? __sync_filesystem+0x90/0x90
>>     [<ffffffff8105c9aa>] ? __cond_resched+0x2a/0x40
>>     [<ffffffff814ef090>] ? _cond_resched+0x30/0x40
>>     [<ffffffff81169e17>] ? iterate_supers+0xb7/0xd0
>>     [<ffffffff814f9382>] system_call_fastpath+0x16/0x1b
>>    handlers:
>>    [<ffffffff8138a0f0>] usb_hcd_irq
>>    [<ffffffff8138a0f0>] usb_hcd_irq
>>    [<ffffffff8138a0f0>] usb_hcd_irq
>>    Disabling IRQ #16
>>
>> An un-wanted interrupt is generated when PCI driver switches from
>> MSI/MSI-X to INTx while shutting down the device.  The interrupt does
>> not happen if MSI/MSI-X is not used on the device.
>> I confirmed that this problem does not happen if pcie_hp=nomsi was
>> specified and hotplug operation worked fine as usual.
>>
>> Signed-off-by: MUNEDA Takahiro<muneda.takahiro@jp.fujitsu.com>
>
> There's no way to figure this out automatically?  How about just doing
> this for the PCI ids of your hardware?
>
> Adding a boot option is a pain, as users will not know they need to do
> it, and distros will not know they need to add it to their images.
> Please try to do this in an automated way if at all possible.

I can understand, but why don't we have a option to disable only for
pciehp driver?  I'm happy by adding the PCI ids of my hardware, but
this issue may happen on other devices.

Anyway, I'll send an updated patch to disable MSI/MSI-X on my devices
automatically.

Thanks,
Takahiro
