Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933845AbcKILUk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 06:20:40 -0500
Date: Wed, 9 Nov 2016 11:20:00 +0000
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
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Message-ID: <20161109111959.GB17020@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>
 <1478646779.7430.66.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478646779.7430.66.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 09, 2016 at 10:12:59AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2016-11-08 at 11:49 +0000, Mark Rutland wrote:
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
> What in that code prevents that today ?

It appears I was mistaken w.r.t. the singleton comment. We can already
translate MMIO->MMIO addresses per-instance (in the presence of a ranges
property).

The big change would be to handle !MMIO translations, for which we'd
need a runtime registry of ISA bus instance to find the relevant
accessor ops and instance-specific data.

Thanks,
Mark.
