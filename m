Return-Path: <SRS0=WG/S=GL=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=WG/S=GL=arm.com=marc.zyngier@kernel.org>
Subject: Re: Why two irq chips for MSI
To: valmiki <valmikibow@gmail.com>, linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
References: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
 <adf13928-d1da-e8af-5b32-efc199ac6ba9@arm.com>
 <a0cd800b-f20f-64f3-c3b3-7f0c193c2b16@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <3c4b764a-17ae-8309-094b-cf441a132d21@arm.com>
Date: Wed, 21 Mar 2018 18:05:58 +0000
MIME-Version: 1.0
In-Reply-To: <a0cd800b-f20f-64f3-c3b3-7f0c193c2b16@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 21/03/18 17:38, valmiki wrote:
>> On 21/03/18 17:12, valmiki wrote:
>>> Hi,
>>>
>>> In most of the RP drivers, why two irq chips are being used for MSI ?
>>>
>>> One at irq_domain_set_info (which uses irq_compose_msi_msg and
>>> irq_set_affinity methods) and another being registered with struct
>>> msi_domain_info (which uses irq_mask/irq_unmask methods).
>>>
>>> When will each chip be used w.r.t to virq ?
>>
>> A simple way to think of it is that you have two pieces of HW involved:
>> an end-point that generates an interrupt, and a controller that receives it.
>>
>> Transpose this to the kernel view of things: one chip implements the PCI
>> MSI, with the PCI semantics attached to it (how to program the
>> payload/doorbell into the end-point, for example). The other implements
>> the MSI controller part of it, talking to the HW that deals with the
>> interrupt.
>>
>> Does it makes sense? Admittedly, this is not always that simple, but
>> that the general approach.
>>
> Thanks Marc. Yes got a good picture now.
> So the one which implements PCI semantics has irq_set_affinity, which is 
> being invoked at request_irq. Why most of the drivers have this as dummy 
> with return 0 ?

It depends.

In general, the irqchip implementing set_affinity is the one talking to
the MSI controller directly.

A lot of drivers don't implement it because they are multiplexing a
number of MSIs on a single interrupt. The consequence is that you cannot
change the affinity of a single MSI without affecting them all.

HW that is build this way makes it impossible to implement one of the
main feature of MSIs, which is to have per-cpu interrupts. Oh well. They
probably also miss on the "MSI as a memory barrier" semantics...

Decent HW doesn't do any multiplexing, and thus can very easily
implement set_affinity.

The other model (which x86 is using, for example), is to have one
doorbell per CPU. In this model, changing affinity is just a matter of
changing the doorbell address.

> Does setting affinity to MSI needs any support from GIC?

Absolutely. If using GICv2m, you need to change the affinity at the
distributor level. With GICv3 and the ITS, you need to emit a MOVI
command to target another redistributor.

> Setting affinity can be achieved only with hardware support ?

See above. It depends which signalling model you're using, and how well
it has been implemented.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
