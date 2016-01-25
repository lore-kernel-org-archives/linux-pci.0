Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 25 Jan 2016 14:58:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rjw@rjwysocki.net, lenb@kernel.org, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com,
	ddaney.cavm@gmail.com, okaya@codeaurora.org, bhelgaas@google.com,
	jiang.liu@linux.intel.com, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] pci: fix unavailable irq number 255 reported by BIOS
Message-ID: <20160125205803.GA10272@localhost>
References: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453705178-27389-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Thomas]

On Mon, Jan 25, 2016 at 02:59:38PM +0800, Chen Fan wrote:
> In our environment, when enable Secure boot, we found an abnormal
> phenomenon as following call trace shows. after investigation, we
> found the firmware assigned an irq number 255 which means unknown
> or no connection in PCI local spec for i801_smbus, meanwhile the
> ACPI didn't configure the pci irq routing. and the 255 irq number
> was assigned for megasa msix without IRQF_SHARED. then in this case
> during i801_smbus probe, the i801_smbus driver would request irq with
> bad irq number 255. but the 255 irq number was assigned for memgasa
> with MSIX enable. which will cause request_irq fails as call trace
> shows, here we use ~0U as invalid IRQ to identify the 0xff IRQ specified
> by BIOS.
> 
> See the call trace:

Maybe you missed my suggestion that the timestamps aren't useful;
here's my suggestion again in more detail:

Changelogs are written once, but read dozens or hundreds of time, so
stripping out irrelevant details shows consideration for the readers.

>  [   32.459195] ipmi device interface
>  [   32.612907] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>  [   32.800459] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 4.0.1-k-rh
>  [   32.818319] ixgbe: Copyright (c) 1999-2014 Intel Corporation.
>  [   32.844009] lpc_ich 0001:80:1f.0: I/O space for ACPI uninitialized

I think the lines above are completely irrelevant.

>  [   32.850093] i801_smbus 0000:00:1f.3: enabling device (0140 -> 0143)
>  [   32.851134] i801_smbus 0000:00:1f.3: can't derive routing for PCI INT C
>  [   32.851136] i801_smbus 0000:00:1f.3: PCI INT C: no GSI
>  [   32.851164] genirq: Flags mismatch irq 255. 00000080 (i801_smbus) vs. 00000000 (megasa

These are useful, but the timestamps ("[   32.850093]") are not.

>  [   32.851168] CPU: 0 PID: 2487 Comm: kworker/0:1 Not tainted 3.10.0-229.el7.x86_64 #1
>  [   32.851170] Hardware name: FUJITSU PRIMEQUEST 2800E2/D3736, BIOS PRIMEQUEST 2000 Serie5

These are probably useful; it's nice to know what kernel and hardware
is involved.

>  [   32.851178] Workqueue: events work_for_cpu_fn
>  [   32.851208]  ffff88086c330b00 00000000e233a9df ffff88086d57bca0 ffffffff81603f36
>  [   32.851227]  ffff88086d57bcf8 ffffffff8110d23a ffff88686fe02000 0000000000000246
>  [   32.851246]  ffff88086a9a8c00 00000000e233a9df ffffffffa00ad220 0000000000000080

I doubt these are useful.

>  [   32.851247] Call Trace:
>  [   32.851261]  [<ffffffff81603f36>] dump_stack+0x19/0x1b
>  [   32.851271]  [<ffffffff8110d23a>] __setup_irq+0x54a/0x570
>  [   32.851282]  [<ffffffffa00ad220>] ? i801_check_pre.isra.5+0xe0/0xe0 [i2c_i801]
>  [   32.851289]  [<ffffffff8110d3bc>] request_threaded_irq+0xcc/0x170
>  [   32.851298]  [<ffffffffa00ae87f>] i801_probe+0x32f/0x508 [i2c_i801]
>  [   32.851308]  [<ffffffff81308385>] local_pci_probe+0x45/0xa0

The above might be useful, but the addresses ("[<ffffffff81603f36>]")
are not, and you should go through them manually and strip out the
lines that are junk from the stack.  For example, I don't think
request_threaded_irq() really calls i801_check_pre().

>  [   32.851315]  [<ffffffff8108bfd4>] work_for_cpu_fn+0x14/0x20
>  [   32.851323]  [<ffffffff8108f0ab>] process_one_work+0x17b/0x470
>  [   32.851330]  [<ffffffff81090003>] worker_thread+0x293/0x400
>  [   32.851338]  [<ffffffff8108fd70>] ? rescuer_thread+0x400/0x400
>  [   32.851346]  [<ffffffff8109726f>] kthread+0xcf/0xe0
>  [   32.851353]  [<ffffffff810971a0>] ? kthread_create_on_node+0x140/0x140
>  [   32.851362]  [<ffffffff81613cfc>] ret_from_fork+0x7c/0xb0
>  [   32.851369]  [<ffffffff810971a0>] ? kthread_create_on_node+0x140/0x140

The lines above are completely useless.

>  [   32.851373] i801_smbus 0000:00:1f.3: Failed to allocate irq 255: -16
>  [   32.851435] i801_smbus: probe of 0000:00:1f.3 failed with error -16

>  [   33.180145] ixgbe 0000:5a:00.0: Multiq[   33.240538] ixgbe 0000:5a:00.0: (PCI Express:03:e0
>  [   33.280826] ixgbe 0000:5a:00.0: MAC: 3, PHY: 0, PBA No: 000000-000

These ixgbe entries are irrelevant.

> Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/irq_vectors.h |  2 ++
>  drivers/acpi/pci_irq.c             | 11 ++++++++++-
>  include/linux/interrupt.h          |  9 +++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 6ca9fd6..b616d69 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -146,4 +146,6 @@
>  #define NR_IRQS				NR_IRQS_LEGACY
>  #endif
>  
> +#define IRQ_INVALID			(~0U)

If this is a good idea (I cc'd Thomas, the IRQ maintainer, for his
thoughts), I'd like to see this in a more generic place so it isn't
x86-specific.

>  #endif /* _ASM_X86_IRQ_VECTORS_H */
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index d30184c..819eb23 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -33,6 +33,7 @@
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
> +#include <linux/interrupt.h>
>  
>  #define PREFIX "ACPI: "
>  
> @@ -436,7 +437,15 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  	 * driver reported one, then use it. Exit in any case.
>  	 */
>  	if (gsi < 0) {
> -		if (acpi_isa_register_gsi(dev))
> +#ifdef CONFIG_X86
> +		/*
> +		 * The Interrupt Line value of 0xff is defined to mean "unknown"
> +		 * or "no connection" (PCI 3.0, Section 6.2.4, footnote on page
> +		 * 223), using ~0U as invalid IRQ.
> +		 */
> +		dev->irq = (dev->irq == 0xff) ? IRQ_INVALID : dev->irq;

It's much simpler and clearer to write:

  if (dev->irq == 0xff)
    dev->irq = IRQ_INVALID;

> +#endif
> +		if (!irq_is_valid(dev->irq) || acpi_isa_register_gsi(dev))
>  			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
>  				 pin_name(pin));
>  
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index cb30edb..2f0d46b 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -198,6 +198,15 @@ extern void enable_percpu_irq(unsigned int irq, unsigned int type);
>  extern bool irq_percpu_is_enabled(unsigned int irq);
>  extern void irq_wake_thread(unsigned int irq, void *dev_id);
>  
> +static inline bool irq_is_valid(unsigned int irq)
> +{
> +#ifdef CONFIG_X86
> +	if (irq == IRQ_INVALID)
> +		return false;
> +#endif
> +	return true;
> +}

I don't like the x86 ifdef.  I'd prefer:

  static inline bool irq_valid(unsigned int irq)
  {
    if (irq < NR_IRQS)
      return true;
    return false;
  }

This could be used in many of the places that currently use NR_IRQS.

My suggestion:

  - patch 1: Add IRQ_INVALID and irq_valid() as generic things
  - patch 2: Use irq_valid() in all the places where it can obviously
    replace NR_IRQS
  - patch 3: Add the acpi_pci_irq_enable() check.  This is now a
    trivial patch, basically just this:

 +    #ifdef CONFIG_X86
 +      if (dev->irq == 0xff)
 +        dev->irq = IRQ_INVALID;
 +    #endif
 +      if (!irq_valid(dev->irq) ...

Bjorn
