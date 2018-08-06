Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 6 Aug 2018 13:09:18 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808061306490.12989@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-pci <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matt Sealey <neko@bakuhatsu.net>, Jingoo Han <jingoohan1@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Mon, 6 Aug 2018, Ard Biesheuvel wrote:

> On 6 August 2018 at 14:42, Robin Murphy <robin.murphy@arm.com> wrote:
> > On 06/08/18 11:25, Mikulas Patocka wrote:
> > [...]
> >>>
> >>> None of this explains why some transactions fail to make it across
> >>> entirely. The overlapping writes in question write the same data to
> >>> the memory locations that are covered by both, and so the ordering in
> >>> which the transactions are received should not affect the outcome.
> >>
> >>
> >> You're right that the corruption couldn't be explained just by reordering
> >> writes. My hypothesis is that the PCIe controller tries to disambiguate
> >> the overlapping writes, but the disambiguation logic was not tested and it
> >> is buggy. If there's a barrier between the overlapping writes, the PCIe
> >> controller won't see any overlapping writes, so it won't trigger the
> >> faulty disambiguation logic and it works.
> >>
> >> Could the ARM engineers look if there's some chicken bit in Cortex-A72
> >> that could insert barriers between non-cached writes automatically?
> >
> >
> > I don't think there is, and even if there was I imagine it would have a
> > pretty hideous effect on non-coherent DMA buffers and the various other
> > places in which we have Normal-NC mappings of actual system RAM.
> >
> 
> Looking at the A72 manual, there is one chicken bit that looks like it
> may be related:
> 
> CPUACTLR_EL1 bit #50:
> 
> 0 Enables store streaming on NC/GRE memory type. This is the reset value.
> 1 Disables store streaming on NC/GRE memory type.
> 
> so putting something like
> 
> mrs x0, S3_1_C15_C2_0
> orr x0, x0, #(1 << 50)
> msr S3_1_C15_C2_0, x0
> 
> in __cpu_setup() would be worth a try.

It won't boot.

But if i write the same value that was read, it also won't boot.

I created a simple kernel module that reads this register and it has bit 
32 set, all other bits clear. But when I write the same value into it, the 
core that does the write is stuck in infinite loop.

So, it seems that we are writing this register from a wrong place.

Mikulas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
