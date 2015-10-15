Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <561FCDBE.8000407@arm.com>
Date: Thu, 15 Oct 2015 17:01:02 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
CC: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH RFC 0/7] Adding core support for wire-MSI bridges
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <5027676.zPNVVQXaP4@wuerfel>
In-Reply-To: <5027676.zPNVVQXaP4@wuerfel>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 15/10/15 16:46, Arnd Bergmann wrote:
> On Thursday 15 October 2015 16:39:21 Marc Zyngier wrote:
>> There seems to be a new class of interrupt controller out there whose
>> sole purpose (apart from making everybody's life a nightmare) is to
>> turn wired interrupts into MSIs.
>>
>> Instead of considering that the MSIs allocated to a device are for the
>> direct use of that device, we can turn this set of MSIs into a irq
>> domain, and use that domain to build a standard irqchip on top of
>> that.
>>
>> This requires some (slightly ugly) surgery in both the generic MSI and
>> platform MSI layers, but the amount of code is actually relatively
>> small (about +150 LoC so far).
>>
>> On top of that, we add a dummy driver for a such a bridge, hoping that
>> this will give enough information to driver authors so that they can
>> use this new feature. An even more stupid client driver is provided to
>> show the interrupt stack allocation:
> 
> I'm pretty sure you've thought of this before and it doesn't work, but
> can you explain why we can't just treat this as an edge-triggered
> nested irqchip? As long as the weird hardware can be preconfigured
> by the bootloader, the device that is attached to it shouldn't
> care how the interrupt ends up at the CPU.

"Preconfigured" is the key word. While you can do something like that if
your hardware treats MSIs just as if they were wired interrupts
(something like GICv2m), it becomes far more hairy if the target of MSIs
is something like a GICv3 ITS (which is the case for HiSilicon mbigen).

The main reason is that the ITS relies on "translation tables" kept in
memory, which the OS has to configure, and handing over pre-configured
tables is not something I'm looking forward to doing. From a CPU point
of view, this is akin entering the kernel with the MMU already on and no
idmap...

The approach taken here is to make the MSI-ness explicit at the irqchip
level, and keep the interrupting device oblivious of that feature. Also,
this relies on the fact that we can have one MSI per wire, meaning that
we don't have to multiplex anything (no nested irqchip), and that we can
rely on hierarchical domains, which simplifies the code (at least for
the irqchip).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
