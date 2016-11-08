Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932177AbcKHRKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 12:10:44 -0500
Date: Tue, 8 Nov 2016 17:10:04 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        bhelgaas@google.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-serial@vger.kernel.org, minyard@acm.org,
        benh@kernel.crashing.org, liviu.dudau@arm.com,
        zourongrong@gmail.com, john.garry@huawei.com,
        gabriele.paoloni@huawei.com, zhichang.yuan02@gmail.com,
        kantyzc@163.com, xuwei5@hisilicon.com, marc.zyngier@arm.com
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Message-ID: <20161108171004.GF15297@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>
 <2368890.jTbyGqYR0M@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2368890.jTbyGqYR0M@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 05:19:54PM +0100, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 11:49:53 AM CET Mark Rutland wrote:
> > My understanding of ISA (which may be flawed) is that it's not part of
> > the PCI host bridge, but rather on x86 it happens to share the IO space
> > with PCI.
> 
> On normal systems, ISA or LPC are behind a PCI bridge device, which
> passes down both low addresses of I/O space and memory space.

Ok, so the use of those address spaces is an artifact of the ISA
controller being a device under the PCI host bridge.

Given we can have multiple domains, surely that implies we can have
multiple ISA controllers in general?

> > I believe that we could theoretically have multiple independent LPC/ISA
> > busses, as is possible with PCI on !x86 systems. If the current ISA code
> > assumes a singleton bus, I think that's something that needs to be fixed
> > up more generically.
> > 
> > I don't see why we should need any architecture-specific code here. Why
> > can we not fix up the ISA bus code in drivers/of/address.c such that it
> > handles multiple ISA bus instances, and translates all sub-device
> > addresses relative to the specific bus instance?
> 
> I think it is a relatively safe assumption that there is only one
> ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> when talking to an ISA device, so having multiple instances is
> already problematic.

I'm worried that this might not be a safe assumption. Hardware these
days has a habit of pushing the boundaries of our expectations.

If we're going to assume that, I'd certainly want the kernel to verify
that it's true for all instanciated ISA/LPC devices. Otherwise, I can
imagine people relying on (or working around) that assumption in ACPI
tables and DTs, and that will be a nightmare (at best) to untangle in
future.

Thanks,
Mark.
