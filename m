Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com>
 <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com>
 <20180808151444.GF24736@iMac.local>
 <CAK8P3a2=rVvvW8bBcrPm3nXNNP56Ygxchu4ThD2ZgZ_cVcd8wQ@mail.gmail.com>
 <alpine.LRH.2.02.1808081347180.18198@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808081347180.18198@file01.intranet.prod.int.rdu2.redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 8 Aug 2018 23:51:53 +0200
Message-ID: <CAK8P3a1CdL5ZVvWPMriOknTCgkfbR4F-a6dRZ7ap9+NiD8H5cg@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To: Mikulas Patocka <mpatocka@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Richard.Earnshaw@arm.com, Joao Pinto <Joao.Pinto@synopsys.com>,
 GNU C Library <libc-alpha@sourceware.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, neko@bakuhatsu.net,
 Jingoo Han <jingoohan1@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 8, 2018 at 8:25 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Wed, 8 Aug 2018, Arnd Bergmann wrote:
>
> > On Wed, Aug 8, 2018 at 5:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Wed, Aug 08, 2018 at 04:01:12PM +0100, Richard Earnshaw wrote:
> > > > On 08/08/18 15:12, Mikulas Patocka wrote:
> > > > > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > > > >> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> > > - failing to write a few bytes
> > > - writing a few bytes that were written 16 bytes before
> > > - writing a few bytes that were written 16 bytes after
> > >
> > > > The overlapping writes in memcpy never write different values to the
> > > > same location, so I still feel this must be some sort of HW issue, not a
> > > > SW one.
> > >
> > > So do I (my interpretation is that it combines or rather skips some of
> > > the writes to the same 16-byte address as it ignores the data strobes).
> >
> > Maybe it just always writes to the wrong location, 16 bytes apart for one of
> > the stp instructions. Since we are usually dealing with a pair of overlapping
> > 'stp', both unaligned, that could explain both the missing bytes (we write
> > data to the wrong place, but overwrite it with the correct data right away)
> > and the extra copy (we write it to the wrong place, but then write the correct
> > data to the correct place as well).
> >
> > This sounds a bit like what the original ARM CPUs did on unaligned
> > memory access, where a single aligned 4-byte location was accessed,
> > but the bytes swapped around.
> >
> > There may be a few more things worth trying out or analysing from
> > the recorded past failures to understand more about how it goes
> > wrong:
> >
> > - For which data lengths does it fail? Having two overlapping
> >   unaligned stp is something that only happens for 16..96 byte
> >   memcpy.
>
> If you want to research the corruptions in detail, I uploaded a file
> containing 7k corruptions here:
> http://people.redhat.com/~mpatocka/testcases/arm-pcie-corruption/

Nice!

I already found a couple of things:

- Failure to copy always happens at the *end* of a 16 byte aligned
  physical address, it misses between 1 and 6 bytes, never 7 or more,
  and it's more likely to be fewer bytes that are affected.
   279 7
   389 6
   484 5
   683 4
   741 3
   836 2
   946 1

- The first byte that fails to get copied is always 16 bytes after the
  memcpy target. Since we only observe it at the end of the 16 byte
  range, it means this happens specifically for addresses ending in
  0x9 (7 bytes missed) to 0xf (1 byte missed).

- Out of 7445 corruptions, 4358 were of the kind that misses a copy at the
  end of a 16-byte area, they were for copies between 41 and 64 bytes,
  more to the larger end of the scale  (note that with your test program,
  smaller memcpys happen more frequenly than larger ones).
     47 0x29
     36 0x2a
     47 0x2b
     23 0x2c
     29 0x2d
     31 0x2e
     36 0x2f
     46 0x30
     45 0x31
     51 0x32
     62 0x33
     64 0x34
     77 0x35
     91 0x36
     90 0x37
    100 0x38
    100 0x39
    209 0x3a
    279 0x3b
    366 0x3c
    498 0x3d
    602 0x3e
    682 0x3f
    747 0x40

- All corruption with data copied to the wrong place happened for copies
  between 33 and 47 bytes, mostly to the smaller end of the scale:
    391 0x21
    360 0x22
    319 0x23
    273 0x24
    273 0x25
    241 0x26
    224 0x27
    221 0x28
    231 0x29
    208 0x2a
    163 0x2b
     86 0x2c
     63 0x2d
     33 0x2e
      1 0x2f

- One common (but not the only, still investigating) case for data getting
  written to the wrong place is:
   * corruption starts 16 bytes after the memcpy start
   * corrupt bytes are the same as the bytes written to the start
   * start address ends in 0x1 through 0x7
   * length of corruption is at most memcpy length- 32, always
     between 1 and 7.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
