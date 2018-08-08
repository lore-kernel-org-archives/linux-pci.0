Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Aug 2018 13:16:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Matt Sealey <neko@bakuhatsu.net>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <20180808121641.GB24736@iMac.local>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Matt,

On Fri, Aug 03, 2018 at 03:44:44PM -0500, Matt Sealey wrote:
> On 3 August 2018 at 13:25, Mikulas Patocka <mpatocka@redhat.com> wrote:
> > On Fri, 3 Aug 2018, Ard Biesheuvel wrote:
> >> Are we still talking about overlapping unaligned accesses here? Or do
> >> you see other failures as well?
> >
> > Yes - it is caused by overlapping unaligned accesses inside memcpy.
> > When I put "dmb sy" between the overlapping accesses in
> > glibc/sysdeps/aarch64/memcpy.S, this program doesn't detect any
> > memory corruption.
> 
> It is a symptom of generating reorderable accesses inside memcpy. It's nothing
> to do with alignment, per se (see below). A dmb sy just hides the symptoms.
> 
> What we're talking about here - yes, Ard, within certain amounts of
> reason - is that you cannot use PCI BAR memory as 'Normal' - certainly
> never cacheable memory, but Normal NC isn't good either. That is that
> your CPU cannot post writes or reads towards PCI memory spaces unless
> it is dealing with it as Device memory or very strictly controlled use
> of Normal Non-Cacheable.

I disagree that it's not possible to use Normal NC on prefetchable BARs.
This particular case looks more like a hardware issue to me as other
platforms don't exhibit the same behaviour.

Note that allowing Normal NC mapping of prefetchable BARs together with
unaliagned accesses is also a requirement for SBSA-compliant platforms
([1]; though I don't find the text in D.2 very clear).

> >> > I tried to run it on system RAM mapped with the NC attribute and I didn't
> >> > get any corruption - that suggests the the bug may be in the PCIE
> >> > subsystem.
> 
> Pure fluke.

Do you mean you don't expect Mikulas' test to run fine on system RAM
with Normal NC mapping? We would have bigger issues if this was the
case.

> I'll give a simple explanation. The Arm Architecture defines
> single-copy and multi-copy atomic transactions. You can treat
> 'single-copy' to mean that that transaction cannot be made partial, or
> reordered within itself, i.e. it must modify memory (if it is a store)
> in a single swift effort and any future reads from that memory must
> return the FULL result of that write.
> 
> Multi-copy means it can be resized and reordered a bit. Will Deacon is
> going to crucify me for simplifying it, but.. let's proceed with a
> poor example:

Not sure about Will but I think you got them wrong ;). The single/multi
copy atomicity is considered in respect to (multiple) observers, a.k.a.
masters, and nothing to do with reordering a bit (see B2.2 in the ARMv8
ARM).

> STR X0,[X1] on a 32-bit bus cannot ever be single-copy atomic, because
> you cannot write 64-bits of data on a 32-bit bus in a single,
> unbreakable transaction. This is because from one bus cycle to the
> next, one half of the transaction will be in a different place. Your
> interconnect will have latched and buffered 32-bits and the CPU is
> holding the other.

It depends on the implementation, interconnect, buses. Since single-copy
atomicity refers to master accesses, the above transaction could be a
burst of two 32-bit writes and treated atomically by the interconnect
(i.e. not interruptible).

> STP X0, X1, [X2] on a 64-bit bus can be single-copy atomic with
> respect to the element size. But it is on the whole multi-copy atomic
> - that is to say that it can provide a single transaction with
> multiple elements which are transmitted, and those elements could be
> messed with on the way down the pipe.

This has nothing to do with multi-copy atomicity which actually refers
to multiple observers seeing the same write. The ARM architecture is not
exactly multi-copy atomic anyway (rather "other-multi-copy atomic").

Architecturally, STP is treated as two single-copy accesses (as you
mentioned already).

Anyway, the single/multiple copy atomicity is irrelevant for the C test
from Mikulas where you have the same observer (the CPU) writing and
reading the memory. I wonder whether writing a byte and reading a long
back would show similar corruption.

> And the granularity of the hazarding in your system, from the CPU
> store buffer to the bus interface to the interconnect buffering to the
> PCIe bridge to the PCIe EP is.. what? Not the same all the way down,
> I'll bet you.

I think hazarding is what goes wrong here, especially since with
overlapping unaligned addresses. However, I disagree that it is
impossible to implement this properly on a platform with PCIe so that
Normal NC mappings can be used.

Thanks.

[1] https://developer.arm.com/docs/den0029/latest/server-base-system-architecture

-- 
Catalin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
