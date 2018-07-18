Return-Path: <SRS0=7ilN=KC=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=7ilN=KC=linutronix.de=tglx@kernel.org>
Date: Wed, 18 Jul 2018 17:39:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
    Marc Zyngier <marc.zyngier@arm.com>,
    Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
    Zou Cao <cao.zou@windriver.com>,
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
In-Reply-To: <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1807181722020.1568@nanos.tec.linutronix.de>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de> <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com> <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de> <6339fdef-a335-b833-4022-23725fd86d9e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Paul,

On Wed, 18 Jul 2018, Paul Menzel wrote:
> On 07/18/18 17:02, Thomas Gleixner wrote:
> >>> 93.885: [   23.020572] BUG: unable to handle kernel NULL pointer dereference at 000000000000003c
> >>> 93.885: [   23.029011] PGD 0 P4D 0 
> >>> 93.885: [   23.031670] Oops: 0000 [#1] SMP NOPTI
> >>> 93.885: [   23.035455] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc5+ #1
> >>> 93.885: [   23.042079] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018
> >>> 93.886: [   23.049868] RIP: 0010:msi_set_mask_bit+0xe/0x70
> > 
> >>> 93.913: [   23.049868] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38 48
> > 
> >   f6 43 3c 01          	testb  $0x1,0x3c(%rbx)
> > 
> > That's:
> > 
> > 	if (desc->msi_attrib.is_msix)
> 
> Is there a tool to translate that?

That tool is called brain :)

Seriously, what you can do is run the 'Code: ...' line through
scripts/decodecode and that will show you the disassembly. Now staring at
msi_set_mask_bit() makes it pretty obvious which part it is and the offset of
msi_attrib in msi_desc is 0x3c, which matches the BUG: line above. You can
figure that out by counting or by using pahole.

Of course if you have the vmlinux around then scripts/faddr2line is what
you want to use.

> >>> 93.957: [   23.049880] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
> >>> 93.957: [   23.049881] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0000000000000000
> >>> 93.958: [   23.049882] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: ffff9e8e45919098
> >>> 93.958: [   23.049882] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0000000000000000
> >>> 93.958: [   23.049882] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e8e45919000
> >>> 93.958: [   23.049883] R13: 0000000000000027 R14: 0000000000000000 R15: 0000000000000000
> >>> 93.959: [   23.049884] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(0000) knlGS:0000000000000000
> >>> 93.959: [   23.049884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> 93.959: [   23.049885] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 00000000003406f0
> >>> 93.959: [   23.049885] Call Trace:
> >>> 93.959: [   23.049887]  <IRQ>
> >>> 93.960: [   23.049889]  __irq_move_irq+0x3c/0x70
> >>> 93.960: [   23.049892]  apic_ack_irq+0x2b/0x30
> >>> 93.960: [   23.049893]  handle_edge_irq+0x7d/0x1d0
> >>> 93.960: [   23.049895]  handle_irq+0x1f/0x30
> >>> 93.960: [   23.049898]  do_IRQ+0x41/0xc0
> >>> 93.960: [   23.049899]  common_interrupt+0xf/0xf
> >>> 93.961: [   23.049900]  </IRQ>
> > 
> > and desc comes from irq_data->common->msi_desc
> > 
> > I have no idea how that can happen for an MSI interrupt.
> > 
> > Paul, is this reproducible?
> 
> No, unfortunately not. I only hit this once, since I attached the serial
> console.

Bah. Could you please enable GENERIC_IRQ_DEBUGFS and after a successful
boot up provide me the content of all files in /sys/kernel/debug/irq/ and
its subfolders?

I assume you have irqbalanced running, right?

> But I found others having the same(?) problem [1][2].
> 
> [1]: https://lkml.org/lkml/2018/1/16/122
>      "[PATCH 0/1] PCI/MSI: add NULL check before use of msi_desc"

> [2]: https://marc.info/?l=linux-kernel&m=151321815226439&w=2
>      "[PATCH] PCI: designware: add a check of msi_desc in irqchip"

That's a different story as they allocate 32 interrupt descriptors in their
host driver for whatever reason. That 'fix' papers over a design issue...

Thanks,

	tglx
