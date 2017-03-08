Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Mar 2017 09:17:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mason <slash.tmp@free.fr>
Subject: Re: Neophyte questions about PCIe
Message-ID: <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
MIME-Version: 1.0
In-Reply-To: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 07, 2017 at 11:45:27PM +0100, Mason wrote:
> Hello,
> 
> I've been working with the Linux PCIe framework for a few weeks,
> and there are still a few things that remain unclear to me.
> I thought I'd group them in a single message.
> 
> 1) If I understand correctly, PCI defines 3 types of (address?) "spaces"
> 	- configuration
> 	- memory
> 	- I/O
> 
> I think PCI has its roots in x86, where there are separate
> instructions for I/O accesses and memory accesses (with MMIO
> sitting somewhere in the middle). I'm on ARMv7 which doesn't
> have I/O instructions AFAIK. I'm not sure what the I/O address
> space is used for in PCIe, especially since I was told that
> one may map I/O-type registers (in my understanding, registers
> for which accesses cause side effects) within mem space.

You're right about the three PCI address spaces.  Obviously, these
only apply to the *PCI* hierarchy.  The PCI host bridge, which is the
interface between the PCI hierarchy and the rest of the system (CPUs,
system RAM, etc.), generates these PCI config, memory, or I/O
transactions.

The host bridge may use a variety of mechanisms to translate a CPU
access into the appropriate PCI transaction.

  - PCI memory transactions: Generally the host bridge translates CPU
    memory accesses directly into PCI memory accesses, although it may
    translate the physical address from the CPU to a different PCI bus
    address, e.g., by truncating high-order address bits or adding a
    constant offset.

    As you mentioned, drivers use some flavor of ioremap() to set up
    mappings for PCI memory space, then they perform simple memory
    accesses to it.  There's no required PCI core wrapper and no
    locking in this path.

  - PCI I/O transactions: On x86, where the ISA supports "I/O"
    instructions, a host bridge generally forwards I/O accesses from
    the CPU directly to PCI.  Bridges for use on other arches may
    provide a bridge-specific way to convert a CPU memory access into
    a PCI I/O transaction, e.g., a CPU memory store inside a bridge
    window may be translated to a PCI I/O write transaction, with the
    PCI I/O address determined by the offset into the bridge window.

    Drivers use inb()/outb() to access PCI I/O space.  These are
    arch-specific wrappers that can use the appropriate mechanism for
    the arch and bridge.

    PCIe deprecates I/O space, and many bridges don't support it at
    all, so it's relatively unimportant.  Many PCI devices do make
    registers available in both I/O and memory space, but there's no
    spec requirement to do so.  Drivers for such devices would have to
    know about this as a device-specific detail.

  - PCI config transactions: The simplest mechanism is called ECAM
    ("Enhanced Configuration Access Method") and is required by the
    PCIe spec and also supported by some conventional PCI bridges.  A
    CPU memory access inside a bridge window is converted into a PCI
    configuration transaction.  The PCI bus/device/function
    information is encoded into the CPU physical memory address.

    Another common mechanism is for the host bridge to have an
    "address" register, where the CPU writes the PCI bus/device/
    function information, and a "data" register where the CPU reads or
    writes the configuration data.  This obviously requires locking
    around the address/data accesses.

    The PCI core and drivers use pci_read_config_*() wrappers to
    access config space.  These use the appropriate bridge-specific
    mechanism and do any required locking.

> 2) On my platform, there are two revisions of the PCIe controller.
> Rev1 muxes config and mem inside a 256 MB window, and doesn't support
> I/O space.
> Rev2 muxes all 3 spaces inside a 256 MB window.
> 
> Ard has stated that this model is not supported by Linux.
> AFAIU, the reason is that accesses may occur concurrently
> (especially on SMP systems). Thus tweaking a bit before
> the actual access necessarily creates a race condition.

Yes.

> I wondered if there might be (reasonable) software
> work-arounds, in your experience?

Muxing config and I/O space isn't a huge issue because they both use
wrappers that could do locking.  Muxing config and memory space is a
pretty big problem because memory accesses do not use a wrapper.

There's no pretty way of making sure no driver is doing memory
accesses during a config access.  Somebody already pointed out that
you'd have to make sure no other CPU could be executing a driver while
you're doing a config access.  I can't think of any better solution.

> 3) What happens if a device requires more than 256 MB of
> mem space? (Is that common? What kind of device? GPUs?)

It is fairly common to have PCI BARs larger than 256MB.

> Our controller supports a remapping "facility" to add an
> offset to the bus address. Is such a feature supported
> by Linux at all?  The problem is that this creates
> another race condition, as setting the offset register
> before an access may occur concurrently on two cores.
> Perhaps 256 MB is plenty on a 32-bit embedded device?

Linux certainly supports a constant offset between the CPU physical
address and the PCI bus address -- this is the offset described by
pci_add_resource_offset().

But it sounds like you're envisioning some sort of dynamic remapping,
and I don't see how that could work.  The PCI core needs to know the
entire host bridge window size up front, because that's how it assigns
BARs.  Since there's no wrapper for memory accesses, there's no
opportunity to change the remapping at the time of access.

> 4) The HW dev is considering the following fix.
> Instead of muxing the address spaces, provide smaller
> exclusive spaces. For example
> [0x5000_0000, 0x5400_0000] for config (64MB)
> [0x5400_0000, 0x5800_0000] for I/O (64MB)
> [0x5800_0000, 0x6000_0000] for mem (128MB)
> 
> That way, bits 26:27 implicitly select the address space
> 	00 = config
> 	01 = I/O
> 	1x = mem
> 
> This would be more in line with what Linux expects, right?
> Are these sizes acceptable? 64 MB config is probably overkill
> (we'll never have 64 devices on this board). 64 MB for I/O
> is probably plenty. The issue might be mem space?

Having exclusive spaces like that would be a typical approach.  The
I/O space seems like way more than you probably need, if you need it
at all.  There might be a few ancient devices that require I/O space,
but only you can tell whether you need to support those.

Same with memory space: if you restrict the set of devices you want to
support, you can restrict the amount of address space you need.  The
Sky Lake GPU on my laptop has a 256MB BAR, so even a single device
like that can require more than the 128MB you'd have with this map.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
