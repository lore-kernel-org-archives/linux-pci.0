Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE007C04EBF
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD1B2087F
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD1B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLCKQC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:16:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbeLCKQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 05:16:01 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EF1ECD17C1ED;
        Mon,  3 Dec 2018 18:15:33 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 18:15:27 +0800
Date:   Mon, 3 Dec 2018 10:15:15 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] x86: Fix an issue with invalid ACPI numa config
Message-ID: <20181203101515.00006cb8@huawei.com>
In-Reply-To: <20181120131935.00001f3a@huawei.com>
References: <20181115110617.13280-1-Jonathan.Cameron@huawei.com>
        <20181120120105.GI2131@hirez.programming.kicks-ass.net>
        <20181120131935.00001f3a@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Nov 2018 13:19:35 +0000
Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

> On Tue, 20 Nov 2018 13:01:05 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Nov 15, 2018 at 11:06:17AM +0000, Jonathan Cameron wrote:  
> > > The addition of support to read the numa node for a PCI
> > > card specified by _PXM resulted in Martin's system not
> > > booting.   Looking at the ACPI tables it seems that there
> > > are PXM entries for the root ports, but no SRAT table.
> > > 
> > > The absence of SRAT table results in dummy_numa_init being
> > > called.  However, unlike on arm64, this doesn't then result
> > > in numa_off being set.  When the PCI code later comes along
> > > and calls acpi_get_node for any PCI card below the root port,
> > > it navigates up the ACPI tree until it finds the PXM value in
> > > the root port. This value is then passed to
> > > acpi_map_pxm_to_node.  If numa_off is set this returns,
> > > NUMA_NO_NODE (as it does on arm64), on x86 it instead tries
> > > to allocate a numa node from the unused set without setting
> > > up all the infrastructure that would normally accompany such
> > > a call.  We have not identified exactly which driver is
> > > causing the subsequent hang for Martin.
> > > 
> > > It is invalid under the ACPI spec to specify new
> > > numa nodes using PXM if they have no presence in SRAT.
> > > Thus the simplest fix is to set numa_off when it is off due
> > > to an invalid SRAT (here not present at all).
> > > 
> > > I do not have easy access to appropriate x86 numa systems so
> > > would appreciate some testing of this one!
> > > 
> > > Known problem boards setups:
> > > 
> > > AMD Ryzen Threadripper 2950X on ASROCK X399 TAICHI
> > > MSI X399 SLI PLUS (probably - not confirmed yet)
> > > 
> > > The PCI patch has been reverted, so this fix is not critical.
> > > 
> > > Reported-by: Martin Hundeb?ll <martin@geanix.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Fixes: bad7dcd94f39 ("ACPI/PCI: Pay attention to device-specific _PXM node values")
> > > 
> > > ---
> > >  arch/x86/mm/numa.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 1308f5408bf7..ce1182f953ff 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -695,6 +695,8 @@ static int __init dummy_numa_init(void)
> > >  	node_set(0, numa_nodes_parsed);
> > >  	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
> > >  
> > > +	numa_off = true;    
> > 
> > Should we not:
> > 
> > 	pr_err(FW_BUG "Invalid SRAT table.\n");
> > 
> > or something along those lines?
> > 
> > We should take every possibility to call out broken and non-compliant
> > firmware.  
> 
> While I agree we should definitely be calling this out nice and loud,
> not having an SRAT isn't indicating a broken firmware as SRAT is optional
> in ACPI.  The breakage only occurs much later when the DSDT contains a
> PXM entry that doesn't correspond to any entries in SRAT.
> 
> To report at that point, we would need some background info stashed
> on why numa_off was set.  It could be off because we set it so via
> the kernel command line.
> 
> If people are happy with this general direction I'm happy to spin a
> patch to do that state tracking and pr_err as a follow up.
> 

Just a quick *bump* on this one as I'd really like to get the PCIe patch
that caused the issue back in for the next merge window if possible.
There is some related new ACPI spec stuff coming shortly that will be
making more use of this.

Martin tested the basic principle (if not necessarily exactly this patch)
with success.

Ingo, did you have a chance to take a look at this for your test system?

To my mind it seems like a very straight forward fix, with a small potential
that someone is dong something 'interesting' that would stop working due to
us blocking the domain lookup when SRAT isn't present.

Thanks,

Jonathan

