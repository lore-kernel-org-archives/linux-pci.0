Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 7 Aug 2018 14:17:34 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu_HasYTYLy3d_1vhBHA=M5i40DmU3EuVHhzT4pRiahcmA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808071414340.25017@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com>
 <alpine.LRH.2.02.1808061306490.12989@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_8Rq6X24ZOYvG7+kQQGSGYAZuu_co4k1nJS8K7rkrWMA@mail.gmail.com>
 <alpine.LRH.2.02.1808061552090.11930@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_iCgAeGmrajZ_euMcFLntWG1a51HF_HQ1TO=fV_v__AQ@mail.gmail.com>
 <CAPv3WKdCMpy6KarducQEtSYP35zdELhparkmPPMKGMUhsdk1Qw@mail.gmail.com>
 <alpine.LRH.2.02.1808071331260.16565@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_HasYTYLy3d_1vhBHA=M5i40DmU3EuVHhzT4pRiahcmA@mail.gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matt Sealey <neko@bakuhatsu.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Marcin Wojtas <mw@semihalf.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On Tue, 7 Aug 2018, Ard Biesheuvel wrote:

> On 7 August 2018 at 19:39, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Tue, 7 Aug 2018, Marcin Wojtas wrote:
> >
> >> Ard, Mikulas,
> >>
> >> After some self-caused setup issues I was able to run the test on my
> >> MacchiatoBin with the kernel v4.18-rc8. It's been running for 1h+ now,
> >> loading the CPU to 100% and no single error event...
> >>
> >> I built the binary file with:
> >> gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc -O2
> >>
> >> Maybe it's the older firmware issue?
> >
> > I have downloaded and built the firmware recently (it has timestamp Jul 30
> > 2018).
> >
> > Do you still have your firmware file "flash-image.bin" that you used, so
> > that I could try it?
> >
> >> Please send the full bootlog with
> >> the very first line after reset. My board rev is v1.3 and I use
> >> mainline UEFI (newest edk2 + edk2-platforms) + newest publicly
> >> available ARM-TF and earliest firmware for this board.
> >>
> >> Best regards,
> >> Marcin
> >
> 
> Mikulas,
> 
> Is the issue reproducible with an nvidia card + nouveau driver as well ?
> 
> Given the screen corruption i see with radeon even on other arm
> systems, i'd like to ensure that this is a platform bug not a driver
> bug.

I see the same memcpy-to-framebuffer corruption on Radeon HD 6450 and 
nVidia Quadro NVS 285.

3D acceleration on nVidia is slow, but it doesn't have visible glitches.

Mikulas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
