Return-Path: <SRS0=5qxz=6H=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=5qxz=6H=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <e57debab-3457-1d9c-a72e-ecdf7d4f742e@sigmadesigns.com>
 <baf9866b-04ba-698c-3012-a957ec0123d1@sigmadesigns.com>
 <20170704070958.oolhapyx7uy2fly4@hirez.programming.kicks-ass.net>
 <c80ce48f-5a7d-48d2-fd60-0d87eb0fcc0a@free.fr>
 <20170704142758.GB7287@worktop>
From: Mason <slash.tmp@free.fr>
Message-ID: <d64a48bd-c593-2f0e-e4e9-8863fba38176@free.fr>
Date: Tue, 4 Jul 2017 17:18:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170704142758.GB7287@worktop>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 04/07/2017 16:27, Peter Zijlstra wrote:

> Mason wrote:
>
>> 	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT) && in_atomic_preempt_off()) {
>> 		pr_err("Preemption disabled at:");
>> 		print_ip_sym(preempt_disable_ip);
>> 		pr_cont("\n");
>> 	}
>>
>> BTW, why didn't print_ip_sym(preempt_disable_ip); say
>> where preemption had been disabled?
> 
> It does, but it might be non-obvious. We only store the first 0->!0
> transition IP in there.

The output was:

[    1.079483] Preemption disabled at:[    1.082820] [<  (null)>]   (null)

so preempt_disable_ip was NULL, right?

Has it been already clobbered?


>> Here's the high-level view. My HW is borked and muxes
>> config space and mem space. So I need a way to freeze
>> the entire system, make the config space access, and
>> then return the system to normal. (AFAICT, config space
>> accesses are rare, so if I kill performance for these
>> accesses, the system might remain usable.)
>>
>> Is there a way to do this? Mark suggested stop_machine
>> but it seems using it in my situation is not quite
>> straight-forward.
> 
> *groan*... so yeah, broken hardware demands crazy stuff... stop machine
> is tricky here because I'm not sure we can demand all PCI accessors to
> allow sleeping.
> 
> And given that PCI lock is irqsave, we can't even assume IRQs are
> enabled.
> 
> Does your platform have NMIs? If so, you can do yuck things like the
> kgdb sync. NMI IPI all other CPUs and have them spin-wait on your state.
> 
> Then be careful not to deadlock when two CPUs do that concurrently.

My platform is arch/arm/mach-tango (Cortex A9, ARMv7-A)

This looks similar to what you described:
https://www.linaro.org/blog/core-dump/debugging-arm-kernels-using-nmifiq/
(I CCed Daniel Thompson)

Quote article:

> Note: On ARMv7-A devices that have security extensions (TrustZone)
> FIQ can only be used by the kernel if it is possible to run Linux in
> secure mode. It is therefore not possible to exploit FIQ for
> debugging and run a secure monitor simultaneously. At the end of this
> blog post we will discuss potential future work to mitigate this
> problem.

On my platform, Linux runs in non-secure mode...

Sounds like I don't have many options left for this driver :-(

Regards.
