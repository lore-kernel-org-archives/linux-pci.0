Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755100AbcKJLXE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 06:23:04 -0500
Date: Thu, 10 Nov 2016 11:22:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        bhelgaas@google.com, olof@lixom.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com, marc.zyngier@arm.com
Subject: Re: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
Message-ID: <20161110112224.GB4418@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej>
 <1478647002.7430.69.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478647002.7430.69.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 09, 2016 at 10:16:42AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2016-11-08 at 12:03 +0000, Mark Rutland wrote:
> > On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
> > > 
> > > For arm64, there is no I/O space as other architectural platforms, such as
> > > X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
> > > such as Hip06, when accessing some legacy ISA devices connected to LPC, those
> > > known port addresses are used to control the corresponding target devices, for
> > > example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
> > > normal MMIO mode in using.
> > 
> > This has nothing to do with arm64. Hardware with this kind of indirect
> > bus access could be integrated with a variety of CPU architectures. It
> > simply hasn't been, yet.
> 
> On some ppc's we also use similar indirect access methods for IOs. We
> have a generic infrastructure for re-routing some memory or IO regions
> to hooks.
> 
> On POWER8, our PCIe doesn't do IO at all, but we have an LPC bus behind
> firmware calls ;-) We use that infrastructure to plumb in the LPC bus.

Just to check, do you hook that in your inb/outb/etc?

Generally, it would seem nicer if we could have higher-level
isa_{inb,outb,whatever} accessors that we could hook separately from
other IO.

We don't necessarily have to move all ISA drivers over to that if we had
a separate symbol for that interface.

Thanks,
Mark.
