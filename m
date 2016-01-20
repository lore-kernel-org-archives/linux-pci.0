Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 19 Jan 2016 18:24:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lenb@kernel.org, izumi.taku@jp.fujitsu.com, wency@cn.fujitsu.com,
	caoj.fnst@cn.fujitsu.com, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] pci: fix unavailable irq number 255 reported by BIOS
Message-ID: <20160120002431.GA7973@localhost>
References: <1453167913-16248-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
 <6239489.QX2A2kAHWp@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6239489.QX2A2kAHWp@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jiang]

Hi Chen,

On Tue, Jan 19, 2016 at 02:43:30PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, January 19, 2016 09:45:13 AM Chen Fan wrote:
> > In our environment, when enable Secure boot, we found an abnormal

This has more information than necessary.  I don't think Secure Boot is
really relevant, and nor are the timestamps and stack addresses below.

> > phenomenon as following call trace shows. after investigation, we
> > found the firmware assigned an irq number 255 which means unknown
> > or no connection in PCI local spec for i801_smbus, meanwhile the
> > ACPI didn't configure the pci irq routing. and the 255 irq number
> > was assigned for megasa msix without IRQF_SHARED. then in this case
> > during i801_smbus probe, the i801_smbus driver would request irq with
> > bad irq number 255. but the 255 irq number was assigned for memgasa
> > with MSIX enable. which will cause request_irq fails, and call trace
> > shows, actually, we should expose the error early, rather than in request
> > irq, here we simply fix the problem by return err when find the irq is
> > 255.

> > See the call trace:
> > 
> >  [   32.459195] ipmi device interface
> >  [   32.612907] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> >  [   32.800459] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.0.1-k-rh
> >  [   32.818319] ixgbe: Copyright (c) 1999-2014 Intel Corporation.
> >  [   32.844009] lpc_ich 0001:80:1f.0: I/O space for ACPI uninitialized
> >  [   32.850093] i801_smbus 0000:00:1f.3: enabling device (0140 -> 0143)
> >  [   32.851134] i801_smbus 0000:00:1f.3: can't derive routing for PCI INT C
> >  [   32.851136] i801_smbus 0000:00:1f.3: PCI INT C: no GSI
> >  [   32.851164] genirq: Flags mismatch irq 255. 00000080 (i801_smbus) vs. 00000000 (megasa
> >  [   32.851168] CPU: 0 PID: 2487 Comm: kworker/0:1 Not tainted 3.10.0-229.el7.x86_64 #1
> >  [   32.851170] Hardware name: FUJITSU PRIMEQUEST 2800E2/D3736, BIOS PRIMEQUEST 2000 Serie5
> >  [   32.851178] Workqueue: events work_for_cpu_fn
> >  [   32.851208]  ffff88086c330b00 00000000e233a9df ffff88086d57bca0 ffffffff81603f36
> >  [   32.851227]  ffff88086d57bcf8 ffffffff8110d23a ffff88686fe02000 0000000000000246
> >  [   32.851246]  ffff88086a9a8c00 00000000e233a9df ffffffffa00ad220 0000000000000080
> >  [   32.851247] Call Trace:
> >  [   32.851261]  [<ffffffff81603f36>] dump_stack+0x19/0x1b
> >  [   32.851271]  [<ffffffff8110d23a>] __setup_irq+0x54a/0x570
> >  [   32.851282]  [<ffffffffa00ad220>] ? i801_check_pre.isra.5+0xe0/0xe0 [i2c_i801]
> >  [   32.851289]  [<ffffffff8110d3bc>] request_threaded_irq+0xcc/0x170
> >  [   32.851298]  [<ffffffffa00ae87f>] i801_probe+0x32f/0x508 [i2c_i801]
> >  [   32.851308]  [<ffffffff81308385>] local_pci_probe+0x45/0xa0
> >  [   32.851315]  [<ffffffff8108bfd4>] work_for_cpu_fn+0x14/0x20
> >  [   32.851323]  [<ffffffff8108f0ab>] process_one_work+0x17b/0x470
> >  [   32.851330]  [<ffffffff81090003>] worker_thread+0x293/0x400
> >  [   32.851338]  [<ffffffff8108fd70>] ? rescuer_thread+0x400/0x400
> >  [   32.851346]  [<ffffffff8109726f>] kthread+0xcf/0xe0
> >  [   32.851353]  [<ffffffff810971a0>] ? kthread_create_on_node+0x140/0x140
> >  [   32.851362]  [<ffffffff81613cfc>] ret_from_fork+0x7c/0xb0
> >  [   32.851369]  [<ffffffff810971a0>] ? kthread_create_on_node+0x140/0x140
> >  [   32.851373] i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
> >  [   32.851435] i801_smbus: probe of 0000:00:1f.3 failed with error -16

Since the Interrupt Line register is writable and might contain any
value, it would be nice if Linux could at least tolerate anything
firmware might leave there without a backtrace, even if we end up not
being able to use the device.

Your patch changes the acpi_pci_irq_enable() return value from 0 to
-EINVAL for this case.  You're running v3.10, and this change probably
makes pci_enable_device() fail.  I suppose the user-visible effect is
that with your patch,

  - there's no backtrace,
  - i801_smbus fails with "Failed to enable SMBus PCI device" instead
    of with "Failed to allocate irq 255", and
  - i801_smbus fails even if no other device is using IRQ 255, instead
    of "succeeding" and using an IRQ 255 that probably doesn't work
    (this seems like maybe the most important difference)

Jiang has changed this path with 890e4847587f ("PCI: Add
pcibios_alloc_irq() and pcibios_free_irq()"), so I think on newer
kernels, we'll never even call the i801_smbus probe function.

What behavior are you looking for from i801_smbus?  Decline to claim
the device?  Try to use the device without interrupts?  Try to figure
out an interrupt in some other way?

I'm not 100% sure that 890e4847587f does the right thing by preventing
a driver from claiming a device where we can't set up an IRQ.  It's
conceivable that a driver could still operate a device even without an
IRQ.

> >  [   33.180145] ixgbe 0000:5a:00.0: Multiq[   33.240538] ixgbe 0000:5a:00.0: (PCI Express:03:e0
> >  [   33.280826] ixgbe 0000:5a:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
> > 
> > Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> > ---
> >  drivers/acpi/pci_irq.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> > index d30184c..d2f47f8 100644
> > --- a/drivers/acpi/pci_irq.c
> > +++ b/drivers/acpi/pci_irq.c
> > @@ -439,9 +439,17 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
> >  		if (acpi_isa_register_gsi(dev))
> >  			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> >  				 pin_name(pin));
> > +		rc = 0;
> > +		/*
> > +		 * Excluding the BIOS report the value 255, which meaning
> > +		 * "unknown" or "no connection" in PCI Local Bus Specification
> > +		 * Revision 3.0 February 3, 2004, P223.
> 
> You mean the footnote on page 223 talking about the Interrupt Line values, right?
> 
> > +		 */
> > +		if (dev->irq == 0xFF)
> > +			rc = -EINVAL;
> >  
> >  		kfree(entry);
> > -		return 0;
> > +		return rc;
> >  	}
> >  
> >  	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
> > 
> 
> Well, if you look at acpi_isa_register_gsi(), you'll see that it
> actually does the check you're adding, so maybe the following should
> be done instead?
> 
> ---
>  drivers/acpi/pci_irq.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/pci_irq.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/pci_irq.c
> +++ linux-pm/drivers/acpi/pci_irq.c
> @@ -436,12 +436,13 @@ int acpi_pci_irq_enable(struct pci_dev *
>  	 * driver reported one, then use it. Exit in any case.
>  	 */
>  	if (gsi < 0) {
> -		if (acpi_isa_register_gsi(dev))
> +		rc = acpi_isa_register_gsi(dev);
> +		if (rc)
>  			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
>  				 pin_name(pin));
>  
>  		kfree(entry);
> -		return 0;
> +		return rc;
>  	}
>  
>  	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
