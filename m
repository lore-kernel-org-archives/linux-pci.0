Return-Path: <SRS0=OVob=6H=infradead.org=peterz@kernel.org>
Return-Path: <SRS0=OVob=6H=infradead.org=peterz@kernel.org>
Date: Tue, 4 Jul 2017 16:27:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mason <slash.tmp@free.fr>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
Message-ID: <20170704142758.GB7287@worktop>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <e57debab-3457-1d9c-a72e-ecdf7d4f742e@sigmadesigns.com>
 <baf9866b-04ba-698c-3012-a957ec0123d1@sigmadesigns.com>
 <20170704070958.oolhapyx7uy2fly4@hirez.programming.kicks-ass.net>
 <c80ce48f-5a7d-48d2-fd60-0d87eb0fcc0a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c80ce48f-5a7d-48d2-fd60-0d87eb0fcc0a@free.fr>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 04, 2017 at 03:08:43PM +0200, Mason wrote:
> On 04/07/2017 09:09, Peter Zijlstra wrote:
> 
> > On Mon, Jul 03, 2017 at 05:30:28PM +0200, Marc Gonzalez wrote:
> > 
> >> And at the end of smp8759_config_read:
> >>
> >> 	printk("in_atomic_preempt_off = %d\n", in_atomic_preempt_off());
> > 
> > That's confused...
> 
> That much is certain. I am indeed grasping at straws.
> 
> I grepped "scheduling while atomic", found __schedule_bug()
> in kernel/sched/core.c and saw
> 
> 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT) && in_atomic_preempt_off()) {
> 		pr_err("Preemption disabled at:");
> 		print_ip_sym(preempt_disable_ip);
> 		pr_cont("\n");
> 	}
> 
> I thought printing the value of in_atomic_preempt_off()
> in the callback would indicate whether preemption had
> already been turned off at that point.

in_atomic_preempt_off() is a 'weird' construct. It basically checks to
see if preempt_count != 1. So calling it while holding a single preempt,
will return false (like in your case).

> It doesn't work like that?

Not really, you want to just print preempt_count.

> BTW, why didn't print_ip_sym(preempt_disable_ip); say
> where preemption had been disabled?

It does, but it might be non-obvious. We only store the first 0->!0
transition IP in there.

So if you have chains like:

	preempt_disable();		// 0 -> 1
	spin_lock();			// 1 -> 2
	preempt_enable();		// 2 -> 1
	preempt_disable();		// 1 -> 2
	spin_unlock();			// 2 -> 1

	mutex_lock();
	  might_sleep();		*SPLAT* report the IP of 0 -> 1

	preempt_enable():		// 1 -> 0


That IP might not even be part of the current callchain.

> >> [    1.026568] BUG: scheduling while atomic: swapper/0/1/0x00000002
> >> [    1.032625] 5 locks held by swapper/0/1:
> >> [    1.036575]  #0:  (&dev->mutex){......}, at: [<c038c684>] __driver_attach+0x50/0xd0
> >> [    1.044319]  #1:  (&dev->mutex){......}, at: [<c038c694>] __driver_attach+0x60/0xd0
> >> [    1.052050]  #2:  (pci_lock){+.+...}, at: [<c03309d8>] pci_bus_read_config_dword+0x44/0x94
> > 
> > This is a raw_spinlock_t, that disables preemption
> 
> drivers/pci/access.c
> 
> /*
>  * This interrupt-safe spinlock protects all accesses to PCI
>  * configuration space.
>  */
> DEFINE_RAW_SPINLOCK(pci_lock);
> 
> 
> 	raw_spin_lock_irqsave(&pci_lock, flags);
> 	res = bus->ops->read(bus, devfn, pos, len, &data);
> 
> 
> IIUC, it's not possible to call stop_machine() while holding
> a raw spinlock?

Correct. You cannot call blocking primitives while holding a spinlock.

> What about regular spinlocks? IIUC, in RT,
> regular spinlocks may sleep?

Still not, your code should not depend on CONFIG_PREEMPT*.

> I didn't find "preempt" or "schedul" in the spinlock doc.
> https://www.kernel.org/doc/Documentation/locking/spinlocks.txt

Correct... as per usual the documentation is somewhat terse.

But once you think about it, its 'obvious' a spinlock needs to disable
preemption. If you don't you get into heaps of trouble (one of the
reasons userspace spinlocks are an absolute trainwreck).

> > Using stop_machine() is per definition doing it wrong ;-)
> 
> Here's the high-level view. My HW is borked and muxes
> config space and mem space. So I need a way to freeze
> the entire system, make the config space access, and
> then return the system to normal. (AFAICT, config space
> accesses are rare, so if I kill performance for these
> accesses, the system might remain usable.)
> 
> Is there a way to do this? Mark suggested stop_machine
> but it seems using it in my situation is not quite
> straight-forward.

*groan*... so yeah, broken hardware demands crazy stuff... stop machine
is tricky here because I'm not sure we can demand all PCI accessors to
allow sleeping.

And given that PCI lock is irqsave, we can't even assume IRQs are
enabled.

Does your platform have NMIs? If so, you can do yuck things like the
kgdb sync. NMI IPI all other CPUs and have them spin-wait on your state.

Then be careful not to deadlock when two CPUs do that concurrently.
