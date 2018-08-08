Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Aug 2018 14:56:02 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <a804913d98ae4598a725cb40a6d19b4e@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808081453540.18198@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <20180808121641.GB24736@iMac.local>
 <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
 <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
 <20180808145017.GE24736@iMac.local>
 <alpine.LRH.2.02.1808081215120.31259@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3iURkU8LThO3xLtaNjkYArdpw+6_WqJQog4EgrcQy23g@mail.gmail.com>
 <a804913d98ae4598a725cb40a6d19b4e@AcuMS.aculab.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, 'Arnd Bergmann' <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "neko@bakuhatsu.net" <neko@bakuhatsu.net>,
 linux-pci <linux-pci@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Wed, 8 Aug 2018, David Laight wrote:

> From: Arnd Bergmann
> > Sent: 08 August 2018 17:31
> ..
> > > They do modify the same byte, but with the same value. Suppose that you
> > > want to copy a piece of data that is between 8 and 16 bytes long. You can
> > > do this:
> > >
> > > add src_end, src, len
> > > add dst_end, dst, len
> > > ldr x0, [src]
> > > ldr x1, [src_end - 8]
> > > str x0, [dst]
> > > str x1, [dst_end - 8]
> 
> I've done that myself (on x86) copied the last 'word' first then
> everything else in increasing address order.
> 
> > > The ARM64 memcpy uses this trick heavily in order to reduce branching, and
> > > this is what makes the PCIe controller choke.
> 
> More likely the write combining buffer?

When I write to memory (using the NC mapping - that is also used in the 
PCI BAR), I get no corruption. So the corruption must be in the PCIe 
controller, not the core or memory subsystem.

I also tried to disable write streaming on NC mapping with a chicken bit, 
but it didn't help.

> > So when a single unaligned 'stp' gets translated into a PCIe with TLP
> > with length=5 (20 bytes) and LastBE = ~1stBE, write combining the
> > overlapping stores gives us a TLP with a longer length (5..8 for two
> > stores), and byte-enable bits that are not exactly a complement.
> 
> Write combining should generate a much longer TLP.
> Depending on the size of the write combining buffer.
> 
> But in the above case I'd have thought that the second write
> would fail to 'combine' - because it isn't contiguous with the
> stored data.
> 
> So something more complex will be going on.
> 
> 	David

Mikulas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
