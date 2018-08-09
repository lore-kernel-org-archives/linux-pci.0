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
 <CAK8P3a1CdL5ZVvWPMriOknTCgkfbR4F-a6dRZ7ap9+NiD8H5cg@mail.gmail.com>
In-Reply-To: <CAK8P3a1CdL5ZVvWPMriOknTCgkfbR4F-a6dRZ7ap9+NiD8H5cg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 9 Aug 2018 17:29:01 +0200
Message-ID: <CAK8P3a1xxYTpHkiFRbdyKYLR-t_cbxfk+yB7tmn7U4H3ETWDYw@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 11:51 PM Arnd Bergmann <arnd@arndb.de> wrote:

> I already found a couple of things:
>
> - Failure to copy always happens at the *end* of a 16 byte aligned
>   physical address, it misses between 1 and 6 bytes, never 7 or more,
>   and it's more likely to be fewer bytes that are affected.
>
> - The first byte that fails to get copied is always 16 bytes after the
>   memcpy target. Since we only observe it at the end of the 16 byte
>   range, it means this happens specifically for addresses ending in
>   0x9 (7 bytes missed) to 0xf (1 byte missed).
>
> - Out of 7445 corruptions, 4358 were of the kind that misses a copy at the
>   end of a 16-byte area, they were for copies between 41 and 64 bytes,
>   more to the larger end of the scale  (note that with your test program,
>   smaller memcpys happen more frequenly than larger ones).

Thinking about it some more, this scenario can be explained by a
read-modify-write logic gone wrong somewhere in the hardware,
leading to the original bytes being written back after we write the
correct data.

The code path we hit most commonly in glibc is like this one:

// offset = 0xd, could be 0x9..0xf + n*0x10
// length = 0x3f, could be 0x29..0x3f
memcpy(map + 0xd, data + 0xd, 0x3f);

       stp     B_l, B_h, [dstin, 16]           # offset 0x1d
       stp     C_l, C_h, [dstend, -32]      # offset 0x2c
       stp     A_l, A_h, [dstin]                 # offset 0x0d
       stp     D_l, D_h, [dstend, -16]      # offset 0x3c

The corruption here always appears in bytes 0x1d..0x1f. A theory
that matches this  corruption is that the stores for B, C and D get
combined into write transaction of length 0x2f, spanning bytes
0x1d..0x4b in the map. This may prefetch either 8 bytes at 0x18 or
16 bytes at 0x10 into a temporary HW buffer, which gets modified
with the correct data for 0x1d..0x1f before writing back that
prefetched data.

The key here is the write of A to offset 0x0d..0x1c. This also
prefetches the data at 0x18..0x1f, and modifies the bytes ..1c
in it. When this is prefetched before the first write, but written
back after it, offsets 0x1d..0x1f have the original data again!

Variations that trigger the same thing include the modified
sequence:

       stp     C_l, C_h, [dstend, -32]      # offset 0x2c
       stp     B_l, B_h, [dstin, 16]           # offset 0x1d
       stp     D_l, D_h, [dstend, -16]      # offset 0x3c
       stp     A_l, A_h, [dstin]                 # offset 0x0d

and the special case for 64 byte memcpy that uses a completely
different sequence, either (original, corruption is common for 64 byte)

        stp     A_l, A_h, [dstin]                # offset 0x0d
        stp     B_l, B_h, [dstin, 16]          # offset 0x1d
        stp     C_l, C_h, [dstin, 32]          # offset 0x2d
        stp     D_l, D_h, [dstin, 48]          # offset 0x3d
        stp     E_l, E_h, [dstend, -32]      # offset 0x2d again
        stp     F_l, F_h, [dstend, -16]      # offset 0x3d again

or (patched libc, corruption happens very rarely for 64 byte
compared to other sizes)

        stp     E_l, E_h, [dstend, -32]      # offset 0x2d
        stp     F_l, F_h, [dstend, -16]      # offset 0x3d
        stp     A_l, A_h, [dstin]                # offset 0x0d
        stp     B_l, B_h, [dstin, 16]          # offset 0x1d
        stp     C_l, C_h, [dstin, 32]          # offset 0x2d again
        stp     D_l, D_h, [dstin, 48]          # offset 0x3d again

The corruption for both also happens at 0x1d..0x1f, which unfortunately
is not easily explained by the theory above, but maybe my glibc sources
are slightly different from the ones that were used on the system.

> - All corruption with data copied to the wrong place happened for copies
>   between 33 and 47 bytes, mostly to the smaller end of the scale:
>     391 0x21
>     360 0x22
...
>      33 0x2e
>       1 0x2f
>
> - One common (but not the only, still investigating) case for data getting
>   written to the wrong place is:
>    * corruption starts 16 bytes after the memcpy start
>    * corrupt bytes are the same as the bytes written to the start
>    * start address ends in 0x1 through 0x7
>    * length of corruption is at most memcpy length- 32, always
>      between 1 and 7.

This is only observed with the original sequence (B, C, A, D) in
glibc, and only when C overlaps with both A and B. A typical
example would be

// offset = 0x02, can be [0x01..0x07,0x09..0x0f] + n*0x10
// length = 0x23, could be 0x21..0x2f
memcpy(map + 0x2, data + 0x2, 0x23);

       stp     B_l, B_h, [dstin, 16]           # offset 0x22
       stp     C_l, C_h, [dstend, -32]      # offset 0x15
       stp     A_l, A_h, [dstin]                 # offset 0x12
       stp     D_l, D_h, [dstend, -16]      # offset 0x25

In this example, bytes 0x22..0x24 incorrectly contain the data that
was written to bytes 0x12..0x14. I would guess that only the stores
to C and D get combined here, so we actually have three separate
store transactions rather than the two in the first example. Each of
the three stores touches data in the 0x20..0x2f range, and these
are the transactions that might happen on them, assuming there
is a read-modify-write logic somewhere:

B1:     prefetch 0x20..0x21, modify 0x22..0x2f, store 0x20
CD1:                      modify 0x20..0x24
A1:    prefetch 0x10.0x11,  modify 0x12..0x1f, store 0x10
A2:    prefetch 0x22..0x2f, modify 0x20..0x21, store 0x20
CD2:                      modify 0x25..0x2f, store

The observation is that data from the A1 stage at offset 0x12..0x14
ends up in the CD buffer, which I can't yet explain simply by
doing steps in the wrong order, it still requires something to
also confuse two buffers.

I've also shown that the length of the corruption strictly depends
on the start and end pointer values, and put it up in a spreadsheet
at [1]. The case of writing the data to the wrong place happens
exactly when A and C are within the same 16-byte aligned range,
while writing back the old data (or not writing at all) happens
exactly when C writes to the same 16-byte range as the end of
B, but doesn't overlap with A. Also, if either pointer is 8-byte
aligned, everything is fine.

       Arnd

[1] https://docs.google.com/spreadsheets/d/1zlDMNAgF--5n0zQmfV3JBzkhdSrUNtwSXIHZH-fqRio/edit#gid=0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
