Return-Path: <SRS0=WG/S=GL=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=WG/S=GL=arm.com=marc.zyngier@kernel.org>
Subject: Re: Why two irq chips for MSI
To: valmiki <valmikibow@gmail.com>, linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
References: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <adf13928-d1da-e8af-5b32-efc199ac6ba9@arm.com>
Date: Wed, 21 Mar 2018 17:25:25 +0000
MIME-Version: 1.0
In-Reply-To: <81eb7191-1c5c-ad27-2714-9563e4ef7c68@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 21/03/18 17:12, valmiki wrote:
> Hi,
> 
> In most of the RP drivers, why two irq chips are being used for MSI ?
> 
> One at irq_domain_set_info (which uses irq_compose_msi_msg and 
> irq_set_affinity methods) and another being registered with struct 
> msi_domain_info (which uses irq_mask/irq_unmask methods).
> 
> When will each chip be used w.r.t to virq ?

A simple way to think of it is that you have two pieces of HW involved:
an end-point that generates an interrupt, and a controller that receives it.

Transpose this to the kernel view of things: one chip implements the PCI
MSI, with the PCI semantics attached to it (how to program the
payload/doorbell into the end-point, for example). The other implements
the MSI controller part of it, talking to the HW that deals with the
interrupt.

Does it makes sense? Admittedly, this is not always that simple, but
that the general approach.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
