Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64832 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2HBPz7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2012 11:55:59 -0400
Received: by yenl2 with SMTP id l2so8872440yen.19
        for <linux-pci@vger.kernel.org>; Thu, 02 Aug 2012 08:55:58 -0700 (PDT)
Message-ID: <501AA305.1080707@gmail.com>
Date: Thu, 02 Aug 2012 23:55:49 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=
	<caronteycerbero@gmail.com>
CC: linux-pci@vger.kernel.org
Subject: Re: PCIe interrupts assignment
References: <CAOp+P+ria2vEsRj8rKsaMp0f5eRZrBVttite9Y3bknjW0ebx3A@mail.gmail.com>
In-Reply-To: <CAOp+P+ria2vEsRj8rKsaMp0f5eRZrBVttite9Y3bknjW0ebx3A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Miguel,
	Could you please help to check whether all serial ports work as expected with
the "irqpoll" kernel boot option? Seems something is wrong with the interrupt routine.

On 08/02/2012 06:28 PM, Miguel Ángel Álvarez wrote:
> Dear all,
> 
> I have a 1 to 4 PCIe switch connected to a root port of a P2020.
> 
> I am attaching a PCIe board to each one of the download ports of the
> switch (same kind of card with four serial ports in each one of them).
> 
> When booting Linux, all cards are detected, so I can see them in
> /sys/bus/pci/devices. All 16 ttyS* are created. However, when trying
> to use them, I have no problems when using the serial ports of the
> card in the last downstream port of the switch, but if I try to use
> any of the others I obtain the following error:
> 
> irq 16: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [df83fca0] [c0007540] show_stack+0x84/0x1b0 (unreliable)
> [df83fcd8] [c0077324] __report_bad_irq+0x5c/0xe0
> [df83fcf0] [c0077534] note_interrupt+0x18c/0x238
> [df83fd10] [c0078520] handle_fasteoi_irq+0xe4/0x134
> [df83fd28] [c0004ea0] handle_one_irq+0x30/0x44
> [df83fd38] [c000c078] __ipipe_do_IRQ+0x84/0xc0
> [df83fd58] [c007bdc8] __ipipe_sync_stage+0x210/0x3b8
> [df83fdb0] [c007cf40] __ipipe_unstall_root+0x60/0x74
> [df83fdb8] [c0047798] __do_softirq+0xd8/0x200
> [df83fe08] [c0004d50] do_softirq+0x60/0x80
> [df83fe18] [c004751c] irq_exit+0x54/0xac
> [df83fe20] [c000c07c] __ipipe_do_IRQ+0x88/0xc0
> [df83fe40] [c007bdc8] __ipipe_sync_stage+0x210/0x3b8
> [df83fe98] [c000ba7c] __ipipe_handle_irq+0x1c4/0x1f8
> [df83fec8] [c000bd80] __ipipe_grab_irq+0x15c/0x1f0
> [df83fee8] [c001323c] __ipipe_ret_from_except+0x0/0xc
> [df83ffa8] [c0008684] cpu_idle+0x68/0xe0
> [df83ffc0] [c0544c2c] start_secondary+0x314/0x350
> [df83fff0] [c0001c9c] __secondary_start+0x30/0x84
> handlers:
> [<c0336e80>] (serial8250_interrupt+0x0/0x148)
> Disabling IRQ #16
> 
> What I can see from /sys/bus/pci/devices/*/irq is that one irq is
> assigned to each card; 16 for the first, 17 for the second, 18 for the
> third and 19 for the last (and successfull) one.
> 
> My question is... where are irqs mapped for the pci express cards? I
> have backtrace the code to pci_device_probe in pci-driver.c, but there
> it seems that the irqs are already assigned.
> 
> I have searched the web, but have not found the clue that makes me
> understand the process.
> 
> Any ideas?
> 
> Thanks
> 
> Miguel Ángel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

