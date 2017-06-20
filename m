Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdFTBtG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Jun 2017 21:49:06 -0400
Date: Mon, 19 Jun 2017 20:49:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Paul Burton <paul.burton@imgtec.com>, linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Ley Foon Tan <lftan@altera.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v5 1/4] PCI: xilinx: Create legacy IRQ domain with size 5
Message-ID: <20170620014903.GI554@bhelgaas-glaptop.roam.corp.google.com>
References: <20170617195741.12757-1-paul.burton@imgtec.com>
 <20170617195741.12757-2-paul.burton@imgtec.com>
 <20170619234708.GG554@bhelgaas-glaptop.roam.corp.google.com>
 <1497919094.42572.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1497919094.42572.3.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Marc]

On Tue, Jun 20, 2017 at 08:38:14AM +0800, Ley Foon Tan wrote:
> On Mon, 2017-06-19 at 18:47 -0500, Bjorn Helgaas wrote:
> > [+cc Thomas, Ley Foon]
> > 
> > On Sat, Jun 17, 2017 at 12:57:38PM -0700, Paul Burton wrote:
> > > 
> > > The driver expects to use hardware IRQ numbers 1 through 4 for INTX
> > > interrupts, but only creates an IRQ domain of size 4 (ie. IRQ
> > > numbers 0
> > > through 3). This results in a warning from irq_domain_associate
> > > when it
> > > is called with hwirq=4:
> > > 
> > >      WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:365
> > >          irq_domain_associate+0x170/0x220
> > >      error: hwirq 0x4 is too large for dummy
> > >      Modules linked in:
> > >      CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> > >          4.12.0-rc5-00126-g19e1b3a10aad-dirty #427
> > >      Stack : 0000000000000000 0000000000000004 0000000000000006
> > > ffffffff8092c78a
> > >              0000000000000061 ffffffff8018bf60 0000000000000000
> > > 0000000000000000
> > >              ffffffff8088c287 ffffffff80811d18 a8000000ffc60000
> > > ffffffff80926678
> > >              0000000000000001 0000000000000000 ffffffff80887880
> > > ffffffff80960000
> > >              ffffffff80920000 ffffffff801e6744 ffffffff80887880
> > > a8000000ffc4f8f8
> > >              000000000000089c ffffffff8018d260 0000000000010000
> > > ffffffff80811d18
> > >              0000000000000000 0000000000000001 0000000000000000
> > > 0000000000000000
> > >              0000000000000000 a8000000ffc4f840 0000000000000000
> > > ffffffff8042cf34
> > >              0000000000000000 0000000000000000 0000000000000000
> > > 0000000000040c00
> > >              0000000000000000 ffffffff8010d1c8 0000000000000000
> > > ffffffff8042cf34
> > >              ...
> > >      Call Trace:
> > >      [<ffffffff8010d1c8>] show_stack+0x80/0xa0
> > >      [<ffffffff8042cf34>] dump_stack+0xd4/0x110
> > >      [<ffffffff8013ea98>] __warn+0xf0/0x108
> > >      [<ffffffff8013eb14>] warn_slowpath_fmt+0x3c/0x48
> > >      [<ffffffff80196528>] irq_domain_associate+0x170/0x220
> > >      [<ffffffff80196bf0>] irq_create_mapping+0x88/0x118
> > >      [<ffffffff801976a8>] irq_create_fwspec_mapping+0xb8/0x320
> > >      [<ffffffff80197970>] irq_create_of_mapping+0x60/0x70
> > >      [<ffffffff805d1318>] of_irq_parse_and_map_pci+0x20/0x38
> > >      [<ffffffff8049c210>] pci_fixup_irqs+0x60/0xe0
> > >      [<ffffffff8049cd64>] xilinx_pcie_probe+0x28c/0x478
> > >      [<ffffffff804e8ca8>] platform_drv_probe+0x50/0xd0
> > >      [<ffffffff804e73a4>] driver_probe_device+0x2c4/0x3a0
> > >      [<ffffffff804e7544>] __driver_attach+0xc4/0xd0
> > >      [<ffffffff804e5254>] bus_for_each_dev+0x64/0xa8
> > >      [<ffffffff804e5e40>] bus_add_driver+0x1f0/0x268
> > >      [<ffffffff804e8000>] driver_register+0x68/0x118
> > >      [<ffffffff801001a4>] do_one_initcall+0x4c/0x178
> > >      [<ffffffff808d3ca8>] kernel_init_freeable+0x204/0x2b0
> > >      [<ffffffff80730b68>] kernel_init+0x10/0xf8
> > >      [<ffffffff80106218>] ret_from_kernel_thread+0x14/0x1c
> > > 
> > > This patch avoids that warning by creating the legacy IRQ domain
> > > with
> > > size 5 rather than 4, allowing it to cover the hwirq=4/INTD case.
> > > 
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > Cc: Ravikiran Gummaluri <rgummal@xilinx.com>
> > > Cc: linux-pci@vger.kernel.org
> > > 
> > > ---
> > > 
> > > Changes in v5:
> > > - New patch; replacing "PCI: xilinx: Fix INTX irq dispatch".
> > > 
> > > Changes in v4: None
> > > Changes in v3: None
> > > Changes in v2: None
> > > 
> > >  drivers/pci/host/pcie-xilinx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/host/pcie-xilinx.c
> > > b/drivers/pci/host/pcie-xilinx.c
> > > index 2fe2df51f9f8..94c71fb91648 100644
> > > --- a/drivers/pci/host/pcie-xilinx.c
> > > +++ b/drivers/pci/host/pcie-xilinx.c
> > > @@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct
> > > xilinx_pcie_port *port)
> > >               return -ENODEV;
> > >       }
> > > 
> > > -     port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
> > > +     port->leg_domain = irq_domain_add_linear(pcie_intc_node, 1 +
> > > 4,
> > I don't understand this.  Several drivers call
> > irq_domain_add_linear() with
> > a size of 4:
> > 
> >   dra7xx_pcie_init_irq_domain
> >   ks_dw_pcie_host_init
> >   advk_pcie_init_irq_domain
> >   faraday_pci_setup_cascaded_irq
> >   rockchip_pcie_init_irq_domain
> >   nwl_pcie_init_irq_domain
> > 
> > Only one other in drivers/pci uses a size of 5:
> > 
> >   altera_pcie_init_irq_domain
> > 
> > Why can't we use a size of 4 for all of them?  We only have INTA-
> > INTD.  Are
> > altera and xilinx missing something to apply an offset from the 0-3
> > space
> > to the 1-4 space?
> We have the same discussion before in 2016: https://lkml.org/lkml/2016/
> 8/30/198

Thanks for digging that out.  I knew we'd discussed this before, but I
couldn't find it in the archives.  I don't think anybody was really
satisfied with the outcome, but we accepted it to make forward
progress.

> This is because legacy interrupt is start with index 1 instead of 0.

I'm not buying this.  Your argument was that "the hwirq for legacy
interrupts will start at 0x1 to 0x4 (INTA to INTD) and these values
are as per PCIe specification for legacy interrupts.  So these cannot
be numbered from 0."

But all the other drivers I mentioned get along with the 0-3 range
somehow.  If there's something different about altera and xilinx that
means they can't use the same solution the others do, I'd like to know
what it is.

> > >                                                &intx_domain_ops,
> > >                                                port);
> > >       if (!port->leg_domain) {
> > > --
> > > 2.13.1
> > > 
> > ________________________________
> > 
> > Confidentiality Notice.
> > This message may contain information that is confidential or
> > otherwise protected from disclosure. If you are not the intended
> > recipient, you are hereby notified that any use, disclosure,
> > dissemination, distribution, or copying of this message, or any
> > attachments, is strictly prohibited. If you have received this
> > message in error, please advise the sender by reply e-mail, and
> > delete the message and any attachments. Thank you.
