Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40508 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab2HBK2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Aug 2012 06:28:32 -0400
Received: by wgbfm10 with SMTP id fm10so5035631wgb.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Aug 2012 03:28:31 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Aug 2012 11:28:31 +0100
Message-ID: <CAOp+P+ria2vEsRj8rKsaMp0f5eRZrBVttite9Y3bknjW0ebx3A@mail.gmail.com>
Subject: PCIe interrupts assignment
From: =?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=
	<caronteycerbero@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear all,

I have a 1 to 4 PCIe switch connected to a root port of a P2020.

I am attaching a PCIe board to each one of the download ports of the
switch (same kind of card with four serial ports in each one of them).

When booting Linux, all cards are detected, so I can see them in
/sys/bus/pci/devices. All 16 ttyS* are created. However, when trying
to use them, I have no problems when using the serial ports of the
card in the last downstream port of the switch, but if I try to use
any of the others I obtain the following error:

irq 16: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[df83fca0] [c0007540] show_stack+0x84/0x1b0 (unreliable)
[df83fcd8] [c0077324] __report_bad_irq+0x5c/0xe0
[df83fcf0] [c0077534] note_interrupt+0x18c/0x238
[df83fd10] [c0078520] handle_fasteoi_irq+0xe4/0x134
[df83fd28] [c0004ea0] handle_one_irq+0x30/0x44
[df83fd38] [c000c078] __ipipe_do_IRQ+0x84/0xc0
[df83fd58] [c007bdc8] __ipipe_sync_stage+0x210/0x3b8
[df83fdb0] [c007cf40] __ipipe_unstall_root+0x60/0x74
[df83fdb8] [c0047798] __do_softirq+0xd8/0x200
[df83fe08] [c0004d50] do_softirq+0x60/0x80
[df83fe18] [c004751c] irq_exit+0x54/0xac
[df83fe20] [c000c07c] __ipipe_do_IRQ+0x88/0xc0
[df83fe40] [c007bdc8] __ipipe_sync_stage+0x210/0x3b8
[df83fe98] [c000ba7c] __ipipe_handle_irq+0x1c4/0x1f8
[df83fec8] [c000bd80] __ipipe_grab_irq+0x15c/0x1f0
[df83fee8] [c001323c] __ipipe_ret_from_except+0x0/0xc
[df83ffa8] [c0008684] cpu_idle+0x68/0xe0
[df83ffc0] [c0544c2c] start_secondary+0x314/0x350
[df83fff0] [c0001c9c] __secondary_start+0x30/0x84
handlers:
[<c0336e80>] (serial8250_interrupt+0x0/0x148)
Disabling IRQ #16

What I can see from /sys/bus/pci/devices/*/irq is that one irq is
assigned to each card; 16 for the first, 17 for the second, 18 for the
third and 19 for the last (and successfull) one.

My question is... where are irqs mapped for the pci express cards? I
have backtrace the code to pci_device_probe in pci-driver.c, but there
it seems that the irqs are already assigned.

I have searched the web, but have not found the clue that makes me
understand the process.

Any ideas?

Thanks

Miguel Ángel
