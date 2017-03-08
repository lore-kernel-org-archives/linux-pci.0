Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mason' <slash.tmp@free.fr>, linux-pci <linux-pci@vger.kernel.org>, Linux
 ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: Neophyte questions about PCIe
Date: Wed, 8 Mar 2017 13:54:47 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE7A70A@AcuExch.aculab.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
In-Reply-To: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Mason
> Sent: 07 March 2017 22:45
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

There isn't much difference between a memory BAR and an IO BAR.
Both are used for accesses to device registers.
There are subtle differences in the PCIe TLPs (I think io writes
get a completion TLP).
Memory space (maybe only 64bit address??) can be 'pre-fetchable'
but generally the driver maps everything uncachable.


> 2) On my platform, there are two revisions of the PCIe controller.
> Rev1 muxes config and mem inside a 256 MB window, and doesn't support
> I/O space.
> Rev2 muxes all 3 spaces inside a 256 MB window.

Don't think config space fits.
With the 'obvious' mapping the 'bus number' is in the top
8 bits of the address.
IIRC x86 uses two 32bit addresses for config space.
One is used to hold the 'address' for the cycle, the other
to perform the cycle.

> Ard has stated that this model is not supported by Linux.
> AFAIU, the reason is that accesses may occur concurrently
> (especially on SMP systems). Thus tweaking a bit before
> the actual access necessarily creates a race condition.
> 
> I wondered if there might be (reasonable) software
> work-arounds, in your experience?

Remember some drivers let applications mmap PCIe addresses
directly into the user page tables.
So you have to stop absolutely everything if you change
your mux.

> 3) What happens if a device requires more than 256 MB of
> mem space? (Is that common? What kind of device? GPUs?)
> Our controller supports a remapping "facility" to add an
> offset to the bus address. Is such a feature supported
> by Linux at all?  The problem is that this creates
> another race condition, as setting the offset register
> before an access may occur concurrently on two cores.
> Perhaps 256 MB is plenty on a 32-bit embedded device?

GPUs tend to have their own paging scheme.
So don't need humongous windows.
I'm not sure how much space is really needed.
32bit x86 reserve the top 1GB of physical address for PCI(e).

> 4) The HW dev is considering the following fix.
> Instead of muxing the address spaces, provide smaller
> exclusive spaces. For example
> [0x5000_0000, 0x5400_0000] for config (64MB)
> [0x5400_0000, 0x5800_0000] for I/O (64MB)
> [0x5800_0000, 0x6000_0000] for mem (128MB)

You almost certainly don't need more than 64k of IO.

> That way, bits 26:27 implicitly select the address space
> 	00 = config
> 	01 = I/O
> 	1x = mem
> 
> This would be more in line with what Linux expects, right?
> Are these sizes acceptable? 64 MB config is probably overkill
> (we'll never have 64 devices on this board). 64 MB for I/O
> is probably plenty. The issue might be mem space?

Config space isn't dense, you (probably) need 25 bits to get a 2nd bus number.
Even 256MB constrains you to 16 bus numbers.

Is this an ARM cpu inside an altera (now intel) fpga??
There is a nasty bug in their PCIe to avalon bridge logic (fixed in quartus 16.1).

	David


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
