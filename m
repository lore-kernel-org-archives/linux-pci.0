Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 5 Apr 2017 13:37:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wesley Terpstra <wesley@sifive.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org
Subject: Re: PCI enumeration without a BIOS
Message-ID: <20170405183732.GB17066@bhelgaas-glaptop.roam.corp.google.com>
References: <CAMgXwTjX1j2dhi7n+APNef0di5oo+iK57Cq0S+3NdMtQzAc=Vw@mail.gmail.com>
 <20170404205617.GG27692@bhelgaas-glaptop.roam.corp.google.com>
 <CAMgXwTgacUcfzinQKuf8htwxFDJ_GvUN-R0zj7sNbqnpJF3QBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
In-Reply-To: <CAMgXwTgacUcfzinQKuf8htwxFDJ_GvUN-R0zj7sNbqnpJF3QBA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+cc Michal, Ley Foon]

On Tue, Apr 04, 2017 at 04:00:49PM -0700, Wesley Terpstra wrote:
> Thank you very much for your detailed analysis of the log!
> 
> On Tue, Apr 4, 2017 at 1:56 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >> In particular, these are the lines that seem wrong to me:
> >> [    5.920000] pci 0000:00:00.0: bridge configuration invalid ([bus
> >> 00-00]), reconfiguring
> >> [    5.930000] pci 0000:01:00.0: bridge configuration invalid ([bus
> >> 00-00]), reconfiguring
> >
> > This is normal but possibly worded more alarmingly than necessary.
> > Bridges power up with secondary/subordinate bus numbers as zero, so
> > this just means nothing has changed their configuration from the
> > power-up default.
> 
> Right. If the firmware had enumerated the bridge already, though, you
> would not see this message because it would have been assigned a bus
> number already. Right?

Yes.

> >> [    6.000000] pci 0000:04:00.0: [Firmware Bug]: reg 0x10: invalid BAR
> >> (can't size)
> >> [    6.010000] pci 0000:06:00.0: [Firmware Bug]: reg 0x10: invalid BAR
> >> (can't size)
> >
> > These are more worrisome.  We discover the size of a BAR by writing
> > all ones to it and reading it back, which tells us how many bits of
> > the BAR are hard-wired to zero.  This behavior is prescribed by the
> > PCI specs, so it's likely a hardware defect.
> 
> So, you would say it's a hardware problem of the PCIe cards in
> question and I can safely ignore it?

Yes.

> > This is because the xilinx host bridge doesn't support I/O space
> 
> Yeah. I knew this, but thanks for confirming.
> 
> FYI, there is a bug in the pcie-xilinx bridge wrt legacy interrupts.
> I've seen several people discussing the same problem for the altera
> bridge and the "NW" xilinx bridge, but somehow this bridge still has
> the issue. I've attached a patch that solved the problem for me.

This sounds familiar to me, too.  Copying Michal & Ley Foon in case they
know something about it.

> Without it I see:
> 
> [    6.230000] ------------[ cut here ]------------
> [    6.230000] WARNING: CPU: 0 PID: 1 at
> /scratch/terpstra/freedom-u-sdk/linux/kernel/irq/irqdomain.c:365
> irq_domain_associate+0x190/0x200
> [    6.240000] error: hwirq 0x4 is too large for dummy
> [    6.250000] CPU: 0 PID: 1 Comm: swapper Not tainted
> 4.11.0-rc1-661305-g4f97179 #12
> [    6.250000] Call Trace:
> [    6.260000] [<ffffffff80288660>] walk_stackframe+0x0/0x104
> [    6.260000] [<ffffffff80288800>] show_stack+0x38/0x50
> [    6.270000] [<ffffffff803c6e30>] dump_stack+0x2c/0x40
> [    6.270000] [<ffffffff8028c600>] __warn+0x118/0x130
> [    6.280000] [<ffffffff8028c658>] warn_slowpath_fmt+0x40/0x54
> [    6.280000] [<ffffffff802c02a8>] irq_domain_associate+0x18c/0x200
> [    6.290000] [<ffffffff802c0a3c>] irq_create_mapping+0x90/0xe4
> [    6.300000] [<ffffffff802c0be4>] irq_create_fwspec_mapping+0x154/0x288
> [    6.300000] [<ffffffff802c0d7c>] irq_create_of_mapping+0x64/0x84
> [    6.310000] [<ffffffff804f9cb8>] of_irq_parse_and_map_pci+0x38/0x50
> [    6.310000] [<ffffffff80407e00>] pci_fixup_irqs+0x6c/0x114
> [    6.320000] [<ffffffff80408e64>] xilinx_pcie_probe+0x308/0x3f0
> [    6.330000] [<ffffffff8042cba4>] platform_drv_probe+0x3c/0x88
> [    6.330000] [<ffffffff8042aec0>] really_probe+0xbc/0x260
> [    6.340000] [<ffffffff8042b138>] __driver_attach+0xd4/0xdc
> [    6.340000] [<ffffffff80429200>] bus_for_each_dev+0x68/0xb8
> [    6.350000] [<ffffffff8042b640>] driver_attach+0x24/0x38
> [    6.350000] [<ffffffff80429db8>] bus_add_driver+0x1b4/0x22c
> [    6.360000] [<ffffffff8042bdc0>] driver_register+0x68/0x12c
> [    6.360000] [<ffffffff8042da78>] __platform_driver_register+0x48/0x5c
> [    6.370000] [<ffffffff8000db38>] xilinx_pcie_driver_init+0x20/0x34
> [    6.380000] [<ffffffff80000d48>] do_one_initcall+0x98/0x140
> [    6.380000] [<ffffffff80000f38>] kernel_init_freeable+0x148/0x218
> [    6.390000] [<ffffffff805ad19c>] kernel_init+0x18/0x114
> [    6.390000] [<ffffffff80286cac>] ret_from_syscall+0xc/0x10
> [    6.400000] ---[ end trace 8023adf5befc91e0 ]---
> 
> ... that said, I am not confident my patch is the right fix. So
> consider this a bug report + work-around only. :)
> 
> > Yeah, everything seems mostly working.  The "invalid BAR" things
> > *could* be an issue -- those registers are not what the PCI spec says
> > they should be.
> 
> The devices in question are:
> 04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
> 06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe
> SATA 6Gb/s Controller (rev 11)
> 
> I am going to plug them in to an Intel machine with 4.11 and see if I
> get the same warnings.



--2fHTh5uZTiUOsy+g
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="pcie-xilinx.patch"

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 7f030f5..619bc67 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -443,7 +443,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
 			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
 				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
 			generic_handle_irq(irq_find_mapping(port->leg_domain,
-							    val));
+							    val + 1));
 		}
 	}
 
@@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
+	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 5,
 						 &intx_domain_ops,
 						 port);
 	if (!port->leg_domain) {

--2fHTh5uZTiUOsy+g--
