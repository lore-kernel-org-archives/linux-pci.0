Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
To: Mikulas Patocka <mpatocka@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <f0ab7c55-c104-241e-99d1-8247b2c567d1@kernel.org>
Date: Fri, 3 Aug 2018 13:32:10 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matt Sealey <neko@bakuhatsu.net>, linux-pci@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 8/3/2018 1:09 PM, Mikulas Patocka wrote:
>>> Most accelerated graphics drivers rely heavily on the ability to map
>>> the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
>>> ordinary memory.
>> Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
>> fine for prefetchable BARs, no?
>>
>> Will
> So - why does it corrupt data then? I've created this program that
> reproduces the data corruption quicky. If I run it on /dev/fb0, I get an
> instant failure. Sometimes a few bytes are not written, sometimes a few
> bytes are written with a value that should be 16 bytes apart.
> 
> I tried to run it on system RAM mapped with the NC attribute and I didn't
> get any corruption - that suggests the the bug may be in the PCIE
> subsystem.

Note that normal-NC gives you write combining whereas device
nGnRE doesn't have any write-combining support.
normal-NC is typically mapped to prefetchable BAR space where
write-combining is welcome.

It could be an issue on the SOC itself too. I suggest you contact your
board vendor.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
