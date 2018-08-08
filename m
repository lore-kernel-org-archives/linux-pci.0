Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Aug 2018 14:40:16 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180808142852.GD24736@iMac.local>
Message-ID: <alpine.LRH.2.02.1808081437260.18198@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808142852.GD24736@iMac.local>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, libc-alpha@sourceware.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matt Sealey <neko@bakuhatsu.net>, linux-pci@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Wed, 8 Aug 2018, Catalin Marinas wrote:

> On Wed, Aug 08, 2018 at 10:12:27AM -0400, Mikulas Patocka wrote:
> > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > > On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> > > > 	while (1) {
> > > > 		start = (unsigned)random() % (LEN + 1);
> > > > 		end = (unsigned)random() % (LEN + 1);
> > > > 		if (start > end)
> > > > 			continue;
> > > > 		for (i = start; i < end; i++)
> > > > 			data[i] = val++;
> > > > 		memcpy(map + start, data + start, end - start);
> > > > 		if (memcmp(map, data, LEN)) {
> > > 
> > > It may be worth trying to do a memcmp(map+start, data+start, end-start)
> > > here to see whether the hazard logic fails when the writes are unaligned
> > > but the reads are not.
> > > 
> > > This problem may as well appear if you do byte writes and read longs
> > > back (and I consider this a hardware problem on this specific board).
> > 
> > I triad to insert usleep(10000) between the memcpy and memcmp, but the 
> > same corruption occurs. So, it can't be read-after-write hazard. It is 
> > caused by the improper handling of hazard between the overlapping writes 
> > inside memcpy.
> 
> It could get it wrong between subsequent writes to the same 64-bit range
> (e.g. the address & ~63 is the same but the data strobes for which bytes
> to write are different). If it somehow thinks that it's a
> write-after-write hazard even though the strobes are different, it could
> cancel one of the writes.

I believe that the SoC has logic for write-after-write detection, but the 
logic is broken and corrupts data.

If I insert "dmb sy" between the overlapping writes, there's no corruption 
(the PCIe controller won't see any overlapping writes in that case).

> It may be worth trying with a byte-only memcpy() function while keeping
> the default memcmp().

I tried that and byte-only memcpy works without any corruption.

> -- 
> Catalin

Mikulas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
