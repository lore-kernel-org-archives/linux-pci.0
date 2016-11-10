Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51205 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbcKJHKC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 02:10:02 -0500
Message-ID: <1478761707.7430.119.camel@kernel.crashing.org>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Rutland <mark.rutland@arm.com>
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
Date: Thu, 10 Nov 2016 18:08:27 +1100
In-Reply-To: <20161109111959.GB17020@leverpostej>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
         <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
         <20161108114953.GB15297@leverpostej>
         <1478646779.7430.66.camel@kernel.crashing.org>
         <20161109111959.GB17020@leverpostej>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-11-09 at 11:20 +0000, Mark Rutland wrote:
> The big change would be to handle !MMIO translations, for which we'd
> need a runtime registry of ISA bus instance to find the relevant
> accessor ops and instance-specific data.

Yes. We do something a bit like that on ppc, we find the PCI bus
for which the IO ports match and I have a hook to register the
special indirect ISA.

It's a bit messy, we could do something nicer generically.

Cheers,
Ben.

