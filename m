Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 4 Aug 2018 09:29:10 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Matt Sealey <neko@bakuhatsu.net>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808040840410.16932@file01.intranet.prod.int.rdu2.redhat.com>
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
 linux-pci <linux-pci@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Fri, 3 Aug 2018, Matt Sealey wrote:

> On 3 August 2018 at 13:25, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Fri, 3 Aug 2018, Ard Biesheuvel wrote:
> >
> >> Are we still talking about overlapping unaligned accesses here? Or do
> >> you see other failures as well?
> >
> > Yes - it is caused by overlapping unaligned accesses inside memcpy. When I
> > put "dmb sy" between the overlapping accesses in
> > glibc/sysdeps/aarch64/memcpy.S, this program doesn't detect any memory
> > corruption.
> 
> It is a symptom of generating reorderable accesses inside memcpy. It's nothing
> to do with alignment, per se (see below). A dmb sy just hides the symptoms.
> 
> What we're talking about here - yes, Ard, within certain amounts of 
> reason - is that you cannot use PCI BAR memory as 'Normal' - certainly 
> never cacheable memory, but Normal NC isn't good either.

So, are you going to map the PCI BAR as Device-nGnRE and then emulate all 
the unaligned accesses in the trap handler?

Or are you going to give up on supporting PCIe graphics on ARM at all?

Videocards have linear framebuffer for 25 years. It was introduced as a 
feature that simplified graphics programming a lot - programmers can use C 
pointer arithmetics for drawing and they don't have to fiddle with 
hardware registers. If you argue that graphics programmers can't use it 
(after they have been using it for 25 years) - they will just ignore you 
and ARM.


> Links is broken.

What else should it use? Are you going to introduce new functions 
memcpy_to_framebuffer() and memset_framebuffer()?

> Even on Intel.

No, it's not. Intel will detect overlapping accesses.

You can write this - it is legal C code:

void g(void);
void overlapping(unsigned char *p)
{
        p[0] = p[1] = p[2] = p[3] = 1;
        g();
        p[3] = p[4] = p[5] = p[6] = 2;
}

and the compiler compiles it to this:

overlapping:
.LFB0:
        pushl   %ebx
        subl    $8, %esp
        movl    16(%esp), %ebx
        movl    $16843009, (%ebx)
        call    g
        movl    $33686018, 3(%ebx)
        addl    $8, %esp
        popl    %ebx
        ret

Now - if the CPU is incapable of detecing the hazaard between writes to 
(%ebx) and 3(%ebx) and reorders these writes, it is just broken because it 
violates the C standard.

If you argue that ARM is incapable of detecting this hazaard and reorders 
these two overlapping memory writes - it means that you can't use C 
pointers to access videoram on ARM - which means that you can't have PCIe 
graphics at all.

Mikulas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
