Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30143C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0132120849
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 09:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0132120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLKJrb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:47:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbeLKJrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 04:47:31 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 81F256B1E182F;
        Tue, 11 Dec 2018 17:47:27 +0800 (CST)
Received: from localhost (10.206.48.115) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 11 Dec 2018
 17:47:20 +0800
Date:   Tue, 11 Dec 2018 09:47:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, <linux-acpi@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH] x86: Fix an issue with invalid ACPI numa config
Message-ID: <20181211094711.00003f3d@huawei.com>
In-Reply-To: <20181210235637.GA99796@google.com>
References: <20181115110617.13280-1-Jonathan.Cameron@huawei.com>
        <20181210235637.GA99796@google.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.206.48.115]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 Dec 2018 17:56:37 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> I don't see this in linux-next so I assume nobody has picked it up yet?
> numa.c isn't my file, but the fix is for something that went in via
> PCI, so I can take this patch if nobody else has already.

Great. I've been assuming it is a safe change to make, but not gotten
a great deal of feedback from the x86 side.

> 
> The changelog could all be wrapped to use more of the line.  Assume 80
> char width and allow for the 4 spaces added by git log.
> 
> On Thu, Nov 15, 2018 at 11:06:17AM +0000, Jonathan Cameron wrote:
> > The addition of support to read the numa node for a PCI  
> 
> s/numa/NUMA/
> 
> > card specified by _PXM resulted in Martin's system not
> > booting.   Looking at the ACPI tables it seems that there
> > are PXM entries for the root ports, but no SRAT table.  
> 
> s/PXM/_PXM/ (and below)
> 
> > The absence of SRAT table results in dummy_numa_init being  
> 
> dummy_numa_init() and similar for other functions below.
> 
> > called.  However, unlike on arm64, this doesn't then result
> > in numa_off being set.  When the PCI code later comes along
> > and calls acpi_get_node for any PCI card below the root port,
> > it navigates up the ACPI tree until it finds the PXM value in
> > the root port. This value is then passed to
> > acpi_map_pxm_to_node.  If numa_off is set this returns,
> > NUMA_NO_NODE (as it does on arm64), on x86 it instead tries  
> 
> This doesn't parse quite right.
> 
> > to allocate a numa node from the unused set without setting
> > up all the infrastructure that would normally accompany such
> > a call.  We have not identified exactly which driver is
> > causing the subsequent hang for Martin.  
> 
> It's not clear to me why dummy_numa_init() must be different between
> arm64 and x86.  This patch makes x86 more like arm64, which is good.
> Maybe a subsequent patch could go even further?

I agree there may be potential here for a bit of unification
at a later stage. There is an awful lot of handling in this
area that is 'similar' between the architectures.

V2 will fix the other things you have commented on.

Thanks,

Jonathan

> 
> > It is invalid under the ACPI spec to specify new
> > numa nodes using PXM if they have no presence in SRAT.
> > Thus the simplest fix is to set numa_off when it is off due
> > to an invalid SRAT (here not present at all).
> > 
> > I do not have easy access to appropriate x86 numa systems so
> > would appreciate some testing of this one!
> > 
> > Known problem boards setups:
> > 
> > AMD Ryzen Threadripper 2950X on ASROCK X399 TAICHI
> > MSI X399 SLI PLUS (probably - not confirmed yet)
> > 
> > The PCI patch has been reverted, so this fix is not critical.
> > 
> > Reported-by: Martin Hundeb?ll <martin@geanix.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Fixes: bad7dcd94f39 ("ACPI/PCI: Pay attention to device-specific _PXM node values")
> > 
> > ---
> >  arch/x86/mm/numa.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 1308f5408bf7..ce1182f953ff 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -695,6 +695,8 @@ static int __init dummy_numa_init(void)
> >  	node_set(0, numa_nodes_parsed);
> >  	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
> >  
> > +	numa_off = true;
> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.18.0
> > 
> >   


