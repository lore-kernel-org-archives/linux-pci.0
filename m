Return-Path: <SRS0=7ilN=KC=linutronix.de=tglx@kernel.org>
Return-Path: <SRS0=7ilN=KC=linutronix.de=tglx@kernel.org>
Date: Wed, 18 Jul 2018 17:02:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: NULL pointer dereference in msi_set_mask_bit
In-Reply-To: <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807181646280.1568@nanos.tec.linutronix.de>
References: <b9bd8405-64b6-2bea-f5ce-d3ab4d82452a@molgen.mpg.de> <20180718140636.GD128988@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Wed, 18 Jul 2018, Bjorn Helgaas wrote:
> [+cc Marc, Thomas]

Uurgh. That's definitely what I need right now ... :)

> On Wed, Jul 18, 2018 at 03:28:15PM +0200, Paul Menzel wrote:
> >
> > 93.885: [   23.020572] BUG: unable to handle kernel NULL pointer dereference at 000000000000003c
> > 93.885: [   23.029011] PGD 0 P4D 0 
> > 93.885: [   23.031670] Oops: 0000 [#1] SMP NOPTI
> > 93.885: [   23.035455] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0-rc5+ #1
> > 93.885: [   23.042079] Hardware name: MSI MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.G1 05/17/2018
> > 93.886: [   23.049868] RIP: 0010:msi_set_mask_bit+0xe/0x70

> > 93.913: [   23.049868] Code: 00 53 48 89 fb e8 12 f8 ff ff 48 89 df 5b e9 c9 fe ff ff 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 8b 47 10 48 8b 58 10 <f6> 43 3c 01 74 3c 8b 15 2e 85 21 01 31 c0 85 d2 75 25 8b 43 38 48

  f6 43 3c 01          	testb  $0x1,0x3c(%rbx)

That's:

	if (desc->msi_attrib.is_msix)

> > 93.957: [   23.049880] RSP: 0018:ffff9e8e5e803f78 EFLAGS: 00010046
> > 93.957: [   23.049881] RAX: ffff9e8e45919000 RBX: 0000000000000000 RCX: 0000000000000000
> > 93.958: [   23.049882] RDX: ffff9e8e45919000 RSI: 0000000000000001 RDI: ffff9e8e45919098
> > 93.958: [   23.049882] RBP: ffff9e8e45919098 R08: 0000000000000000 R09: 0000000000000000
> > 93.958: [   23.049882] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e8e45919000
> > 93.958: [   23.049883] R13: 0000000000000027 R14: 0000000000000000 R15: 0000000000000000
> > 93.959: [   23.049884] FS:  0000000000000000(0000) GS:ffff9e8e5e800000(0000) knlGS:0000000000000000
> > 93.959: [   23.049884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 93.959: [   23.049885] CR2: 000000000000003c CR3: 00000003fc5a4000 CR4: 00000000003406f0
> > 93.959: [   23.049885] Call Trace:
> > 93.959: [   23.049887]  <IRQ>
> > 93.960: [   23.049889]  __irq_move_irq+0x3c/0x70
> > 93.960: [   23.049892]  apic_ack_irq+0x2b/0x30
> > 93.960: [   23.049893]  handle_edge_irq+0x7d/0x1d0
> > 93.960: [   23.049895]  handle_irq+0x1f/0x30
> > 93.960: [   23.049898]  do_IRQ+0x41/0xc0
> > 93.960: [   23.049899]  common_interrupt+0xf/0xf
> > 93.961: [   23.049900]  </IRQ>

and desc comes from irq_data->common->msi_desc

I have no idea how that can happen for an MSI interrupt.

Paul, is this reproducible?

Thanks,

	tglx
