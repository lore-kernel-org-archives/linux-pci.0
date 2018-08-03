Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 3 Aug 2018 14:25:38 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, linux-pci <linux-pci@vger.kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matt Sealey <neko@bakuhatsu.net>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Fri, 3 Aug 2018, Ard Biesheuvel wrote:

> (- libc-alpha)
> 
> On 3 August 2018 at 19:09, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Fri, 3 Aug 2018, Will Deacon wrote:
> >
> >> On Fri, Aug 03, 2018 at 09:16:39AM +0200, Ard Biesheuvel wrote:
> >> > On 3 August 2018 at 08:35, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >> > >
> >> > >
> >> > > On Thu, 2 Aug 2018, Matt Sealey wrote:
> >> > >
> >> > >> The easiest explanation for this would be that the memory isn?t mapped
> >> > >> correctly. You can?t use PCIe memory spaces with anything other than
> >> > >> Device-nGnRE or stricter mappings. That?s just differences between the
> >> > >> AMBA and PCIe (posted/unposted) memory models.
> >> >
> >> > Whoa hold on there.
> >> >
> >> > Are you saying we cannot have PCIe BAR windows with memory semantics on ARM?
> >> >
> >> > Most accelerated graphics drivers rely heavily on the ability to map
> >> > the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
> >> > ordinary memory.
> >>
> >> Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
> >> fine for prefetchable BARs, no?
> >>
> >> Will
> >
> > So - why does it corrupt data then? I've created this program that
> > reproduces the data corruption quicky. If I run it on /dev/fb0, I get an
> > instant failure. Sometimes a few bytes are not written, sometimes a few
> > bytes are written with a value that should be 16 bytes apart.
> >
> 
> Are we still talking about overlapping unaligned accesses here? Or do
> you see other failures as well?

Yes - it is caused by overlapping unaligned accesses inside memcpy. When I 
put "dmb sy" between the overlapping accesses in 
glibc/sysdeps/aarch64/memcpy.S, this program doesn't detect any memory 
corruption.

> > I tried to run it on system RAM mapped with the NC attribute and I didn't
> > get any corruption - that suggests the the bug may be in the PCIE
> > subsystem.
> >
> > Jingoo Han and Joao Pinto are maintainers for the designware PCIE
> > controllers. Could you suggest why does the controller corrupt data when
> > writing to videoram? Are there any tricks that could be tried to work
> > around the corruption?
> >
> > Mikulas
> >
> >
> >
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <sys/mman.h>
> >
> > #define LEN             256
> > #define PRINT_STRIDE    0x20
> >
> > static unsigned char data[LEN];
> > static unsigned char val = 0;
> >
> > static unsigned char prev_data[LEN];
> >
> > static unsigned char map_copy[LEN];
> >
> > int main(int argc, char *argv[])
> > {
> >         unsigned long n = 0;
> >         int h;
> >         unsigned char *map;
> >         unsigned start, end, i;
> >
> >         if (argc < 2) fprintf(stderr, "argc\n"), exit(1);
> >         if (argc >= 4) srandom(atoll(argv[3]));
> >         h = open(argv[1], O_RDWR | O_DSYNC);
> >         if (h == -1) perror("open"), exit(1);
> >         map = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_SHARED, h, argc >= 3 ? strtoull(argv[2], NULL, 16) : 0);
> >         if (map == MAP_FAILED) perror("mmap"), exit(1);
> >
> >         memset(data, 0, LEN);
> >         memset(prev_data, 0, LEN);
> >         memset(map, 0, LEN);
> >
> >         sleep(1);
> >
> >         while (1) {
> >                 start = (unsigned)random() % (LEN + 1);
> >                 end = (unsigned)random() % (LEN + 1);
> >                 if (start > end)
> >                         continue;
> >                 for (i = start; i < end; i++)
> >                         data[i] = val++;
> >                 memcpy(map + start, data + start, end - start);
> >                 if (memcmp(map, data, LEN)) {
> >                         unsigned j;
> >                         memcpy(map_copy, map, LEN);
> >                         fprintf(stderr, "mismatch after %lu loops!\n", n);
> >                         fprintf(stderr, "last copied range: 0x%x - 0x%x (0x%x)\n", start, end, (unsigned)(end - start));
> >                         for (j = 0; j < LEN; j += PRINT_STRIDE) {
> >                                 fprintf(stderr, "p[%03x]", j);
> >                                 for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
> >                                         fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", prev_data[i]);
> >                                 fprintf(stderr, "\n");
> >                                 fprintf(stderr, "d[%03x]", j);
> >                                 for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
> >                                         fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", data[i]);
> >                                 fprintf(stderr, "\n");
> >                                 fprintf(stderr, "m[%03x]", j);
> >                                 for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
> >                                         fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", map_copy[i]);
> >                                 fprintf(stderr, "\n\n");
> >                         }
> >                         exit(1);
> >                 }
> >                 memcpy(prev_data, data, LEN);
> >                 n++;
> >         }
> > }
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
