Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Aug 2018 14:25:48 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAK8P3a2=rVvvW8bBcrPm3nXNNP56Ygxchu4ThD2ZgZ_cVcd8wQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808081347180.18198@file01.intranet.prod.int.rdu2.redhat.com>
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
MIME-Version: 1.0
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



On Wed, 8 Aug 2018, Arnd Bergmann wrote:

> On Wed, Aug 8, 2018 at 5:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Wed, Aug 08, 2018 at 04:01:12PM +0100, Richard Earnshaw wrote:
> > > On 08/08/18 15:12, Mikulas Patocka wrote:
> > > > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > > >> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> > - failing to write a few bytes
> > - writing a few bytes that were written 16 bytes before
> > - writing a few bytes that were written 16 bytes after
> >
> > > The overlapping writes in memcpy never write different values to the
> > > same location, so I still feel this must be some sort of HW issue, not a
> > > SW one.
> >
> > So do I (my interpretation is that it combines or rather skips some of
> > the writes to the same 16-byte address as it ignores the data strobes).
> 
> Maybe it just always writes to the wrong location, 16 bytes apart for one of
> the stp instructions. Since we are usually dealing with a pair of overlapping
> 'stp', both unaligned, that could explain both the missing bytes (we write
> data to the wrong place, but overwrite it with the correct data right away)
> and the extra copy (we write it to the wrong place, but then write the correct
> data to the correct place as well).
> 
> This sounds a bit like what the original ARM CPUs did on unaligned
> memory access, where a single aligned 4-byte location was accessed,
> but the bytes swapped around.
> 
> There may be a few more things worth trying out or analysing from
> the recorded past failures to understand more about how it goes
> wrong:
> 
> - For which data lengths does it fail? Having two overlapping
>   unaligned stp is something that only happens for 16..96 byte
>   memcpy.

If you want to research the corruptions in detail, I uploaded a file 
containing 7k corruptions here: 
http://people.redhat.com/~mpatocka/testcases/arm-pcie-corruption/

> - What if we use a pair of str instructions instead of an stp in
>   a modified memcpy? Does it now write to still write to the
>   wrong place 16 bytes away, just 8 bytes away, or correctly?

I replaced all stp instructions with str and it didn't have effect on 
corruptions. Either a few bytes is omitted, or a value that belongs 16 
bytes before or after is written.

> - Does it change in any way if we do the overlapping writes
>   in the reverse order? E.g. for the 16..64 byte case:
> 
> diff --git a/sysdeps/aarch64/memcpy.S b/sysdeps/aarch64/memcpy.S
> index 7e1163e6a0..09d0160bdf 100644
> --- a/sysdeps/aarch64/memcpy.S
> +++ b/sysdeps/aarch64/memcpy.S
> @@ -102,11 +102,11 @@ ENTRY (MEMCPY)
>         tbz     tmp1, 5, 1f
>         ldp     B_l, B_h, [src, 16]
>         ldp     C_l, C_h, [srcend, -32]
> -       stp     B_l, B_h, [dstin, 16]
>         stp     C_l, C_h, [dstend, -32]
> +       stp     B_l, B_h, [dstin, 16]
>  1:
> -       stp     A_l, A_h, [dstin]
>         stp     D_l, D_h, [dstend, -16]
> +       stp     A_l, A_h, [dstin]
>         ret
> 
>         .p2align 4
> 
>         Arnd

After reordering them, I observe only omitted writes, there are no longer 
misdirected writes:

http://people.redhat.com/~mpatocka/testcases/arm-pcie-corruption/reorder-test/

Mikulas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
