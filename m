Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
To: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
From: Mason <slash.tmp@free.fr>
Subject: Neophyte questions about PCIe
Message-ID: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
Date: Tue, 7 Mar 2017 23:45:27 +0100
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
 David Laight <david.laight@aculab.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I've been working with the Linux PCIe framework for a few weeks,
and there are still a few things that remain unclear to me.
I thought I'd group them in a single message.

1) If I understand correctly, PCI defines 3 types of (address?) "spaces"
	- configuration
	- memory
	- I/O

I think PCI has its roots in x86, where there are separate
instructions for I/O accesses and memory accesses (with MMIO
sitting somewhere in the middle). I'm on ARMv7 which doesn't
have I/O instructions AFAIK. I'm not sure what the I/O address
space is used for in PCIe, especially since I was told that
one may map I/O-type registers (in my understanding, registers
for which accesses cause side effects) within mem space.


2) On my platform, there are two revisions of the PCIe controller.
Rev1 muxes config and mem inside a 256 MB window, and doesn't support
I/O space.
Rev2 muxes all 3 spaces inside a 256 MB window.

Ard has stated that this model is not supported by Linux.
AFAIU, the reason is that accesses may occur concurrently
(especially on SMP systems). Thus tweaking a bit before
the actual access necessarily creates a race condition.

I wondered if there might be (reasonable) software
work-arounds, in your experience?


3) What happens if a device requires more than 256 MB of
mem space? (Is that common? What kind of device? GPUs?)
Our controller supports a remapping "facility" to add an
offset to the bus address. Is such a feature supported
by Linux at all?  The problem is that this creates
another race condition, as setting the offset register
before an access may occur concurrently on two cores.
Perhaps 256 MB is plenty on a 32-bit embedded device?


4) The HW dev is considering the following fix.
Instead of muxing the address spaces, provide smaller
exclusive spaces. For example
[0x5000_0000, 0x5400_0000] for config (64MB)
[0x5400_0000, 0x5800_0000] for I/O (64MB)
[0x5800_0000, 0x6000_0000] for mem (128MB)

That way, bits 26:27 implicitly select the address space
	00 = config
	01 = I/O
	1x = mem

This would be more in line with what Linux expects, right?
Are these sizes acceptable? 64 MB config is probably overkill
(we'll never have 64 devices on this board). 64 MB for I/O
is probably plenty. The issue might be mem space?


Thanks to anyone who can shine some light on either of
these points for me :-)

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
