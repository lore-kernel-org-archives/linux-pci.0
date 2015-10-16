Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
Date: Fri, 16 Oct 2015 10:45:30 +0200
Message-ID: <4196649.VJFYrvEAp6@wuerfel>
In-Reply-To: <5620AF42.4070204@arm.com>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <5879538.pKBkpUOxls@wuerfel> <5620AF42.4070204@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 16 October 2015 09:03:14 Marc Zyngier wrote:
> On 15/10/15 20:16, Arnd Bergmann wrote:
> > On Thursday 15 October 2015 17:01:02 Marc Zyngier wrote:
> >>
> >> "Preconfigured" is the key word. While you can do something like that if
> >> your hardware treats MSIs just as if they were wired interrupts
> >> (something like GICv2m), it becomes far more hairy if the target of MSIs
> >> is something like a GICv3 ITS (which is the case for HiSilicon mbigen).
> >>
> >> The main reason is that the ITS relies on "translation tables" kept in
> >> memory, which the OS has to configure, and handing over pre-configured
> >> tables is not something I'm looking forward to doing. From a CPU point
> >> of view, this is akin entering the kernel with the MMU already on and no
> >> idmap...
> >>
> >> The approach taken here is to make the MSI-ness explicit at the irqchip
> >> level, and keep the interrupting device oblivious of that feature. Also,
> >> this relies on the fact that we can have one MSI per wire, meaning that
> >> we don't have to multiplex anything (no nested irqchip), and that we can
> >> rely on hierarchical domains, which simplifies the code (at least for
> >> the irqchip).
> >>
> > 
> > Thanks, that already makes things much clearer. Just one more question:
> > why can't those translation tables be configured statically by the
> > irqchip driver? Is this all about being able to cut a few cycles
> > in case of virtualization? 
> 
> Having a static configuration, while doable, complicates things for
> everybody else. The LPI number used by the irqchip would need to be put
> an some "exclusion list" to make sure it is not reallocated for other
> subsystems (e.g PCI). The translation tables also define the target CPU,
> which could cause interesting problems once combined with CPU hotplug if
> the ITS is not completely in control of it.
> 
> I'm not really getting your point about virtualization though.

I think I'm mainly still confused by how MSI is implemented on
the CPU side. Your explanation makes sense though.

> > I would assume that once you have gone through the overhead of having
> > both an MSI and a normal interrupt line (with the need for
> > serialization vs DMA), you can just as well trap to user space to
> > deliver an IRQ to a guest.
> 
> The whole idea behind this bridge is to move wired interrupts to the
> periphery of a SoC. I don't think virtualization was part of the
> equation, but of course I can't speak for the "geniuses" behind the idea.
> 
> Or maybe I'm reading your question the wrong way, which is entirely
> possible given the lack of caffeine.

No, I think I get it now.

	Arnd
