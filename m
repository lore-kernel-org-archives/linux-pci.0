Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 6 Aug 2018 16:31:18 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu_iCgAeGmrajZ_euMcFLntWG1a51HF_HQ1TO=fV_v__AQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808061630380.18304@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
 <alpine.LRH.2.02.1808061306490.12989@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_8Rq6X24ZOYvG7+kQQGSGYAZuu_co4k1nJS8K7rkrWMA@mail.gmail.com>
 <alpine.LRH.2.02.1808061552090.11930@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_iCgAeGmrajZ_euMcFLntWG1a51HF_HQ1TO=fV_v__AQ@mail.gmail.com>
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

> > Unfortunatelly, it doesn't work. I verified that the bit is set after
> > booting Linux, but the memcpy corruption was still present.
> >
> > I also tried the other chicken bits, it slowed down the system noticeably,
> > but had no effect on the memcpy corruption.
> >
> 
> OK, it was worth a shot
> 
> Let's wait and see if Marcin has any results.

BTW. is there documentation for that DesignWare PCIe controller somewhere?

Mikulas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
