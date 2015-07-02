Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:33277 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbbGBJp7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jul 2015 05:45:59 -0400
Received: by laar3 with SMTP id r3so57445278laa.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2015 02:45:58 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2015 17:45:58 +0800
Message-ID: <CAFiDJ58YoXTKn2BXkUHVQeFYONQ_oG6yQKtsy=fBKbtEq9K6nQ@mail.gmail.com>
Subject: Question for irq_set_affinity in irq_chip
From: Ley Foon Tan <lftan.linux@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Ley Foon Tan <lftan.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi

I'm writing a new PCIe host controller driver for ARM32 platform and
it is with an external MSI controller. This msi driver uses the new
MSI domain framework.

But I got the error below. It is failed in
kernel/irq/msi.c:msi_domain_set_affinity(). The
"parent->chip->irq_set_affinity" is NULL.

"irq_chip" structure in my msi driver is defined as below. Do we
expect all MSI drivers need to provide .irq_set_affinity callback in
"irq_chip" structure?

Note, it is run on a SMP ARM32 processor.


My msi driver:
static struct irq_chip a msi_bottom_irq_chip = {
.name = "PCIe MSI",
.irq_compose_msi_msg = _compose_msi_msg,
};


In kernel/irq/msi.c:
int msi_domain_set_affinity(struct irq_data *irq_data,
                            const struct cpumask *mask, bool force)
{
        struct irq_data *parent = irq_data->parent_data;
        struct msi_msg msg;
        int ret;

        ret = parent->chip->irq_set_affinity(parent, mask, force);
        if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
                BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
                irq_chip_write_msi_msg(irq_data, &msg);
        }

        return ret;
}

==============================================
Error log:

[   59.581184] [<c00659c0>] (msi_domain_set_affinity) from
[<c005f3f8>] (irq_do_set_affinity+0x34/0x64)
[   59.590280] [<c005f3f8>] (irq_do_set_affinity) from [<c005f4a0>]
(setup_affinity+0x78/0xc8)
[   59.598597] [<c005f4a0>] (setup_affinity) from [<c005fc68>]
(__setup_irq+0x2c0/0x528)
[   59.606397] [<c005fc68>] (__setup_irq) from [<c0060028>]
(request_threaded_irq+0xcc/0x14c)
[   59.614636] [<c0060028>] (request_threaded_irq) from [<c0326d80>]
(e1000_request_irq+0x1b4/0x26c)
[   59.623474] [<c0326d80>] (e1000_request_irq) from [<c032a8a4>]
(e1000_open+0xcc/0x3cc)
[   59.631365] [<c032a8a4>] (e1000_open) from [<c03ca464>]
(__dev_open+0xa8/0x10c)
[   59.638647] [<c03ca464>] (__dev_open) from [<c03ca6ec>]
(__dev_change_flags+0x94/0x158)
[   59.646617] [<c03ca6ec>] (__dev_change_flags) from [<c03ca7c8>]
(dev_change_flags+0x18/0x48)
[   59.655028] [<c03ca7c8>] (dev_change_flags) from [<c0425c74>]
(devinet_ioctl+0x690/0x764)
[   59.663177] [<c0425c74>] (devinet_ioctl) from [<c03ae440>]
(sock_ioctl+0x1c0/0x28c)
[   59.670808] [<c03ae440>] (sock_ioctl) from [<c010c1a8>]
(do_vfs_ioctl+0x420/0x610)
[   59.678346] [<c010c1a8>] (do_vfs_ioctl) from [<c010c3cc>]
(SyS_ioctl+0x34/0x5c)
[   59.685632] [<c010c3cc>] (SyS_ioctl) from [<c000efc0>]
(ret_fast_syscall+0x0/0x3c)


Thanks.

Regards
