Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF7EC4161B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C574920C01
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1SkhQuT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C574920C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeKTWaC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:30:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKTWaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 17:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gYrUXyxG/b1K5uz7O8N60HcRNLacYO2ChYQzU69csbE=; b=1SkhQuT+sraRr55N6OUhM1nxQ
        zdHHhcwje4YoRNzKA+qjPq8/rETRoprk1qUAjq9vYuu4ZAB0Yg0/7nJGgYK17fYH20EEaGJTBcMHK
        BxiHxu5o+9mmuGHGcOxAvw76Nu1BvKhGNeSu5tE/O2NInjzjqzMtRm+Z3JCeEBMsfrLL7OcBBy6Cn
        RA+yU9UBuzyyBV7Gk0Pe/cXQAj7ANt/GScdsrxCee4DBufDamqXjN901UJFLFo6py0zLwxGVRhZ4X
        bLLU9gIAs5X2m6cXxJePrq1ITMf/XY7UlRtH2uHe49d+45kJNjcKynvdD+6DR/smERtlE2w0SJ9jZ
        6BJvbSMaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP4iI-0007In-R2; Tue, 20 Nov 2018 12:01:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 905932029F87F; Tue, 20 Nov 2018 13:01:05 +0100 (CET)
Date:   Tue, 20 Nov 2018 13:01:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org, linuxarm@huawei.com,
        Ingo Molnar <mingo@kernel.org>, linux-acpi@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: Fix an issue with invalid ACPI numa config
Message-ID: <20181120120105.GI2131@hirez.programming.kicks-ass.net>
References: <20181115110617.13280-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115110617.13280-1-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 11:06:17AM +0000, Jonathan Cameron wrote:
> The addition of support to read the numa node for a PCI
> card specified by _PXM resulted in Martin's system not
> booting.   Looking at the ACPI tables it seems that there
> are PXM entries for the root ports, but no SRAT table.
> 
> The absence of SRAT table results in dummy_numa_init being
> called.  However, unlike on arm64, this doesn't then result
> in numa_off being set.  When the PCI code later comes along
> and calls acpi_get_node for any PCI card below the root port,
> it navigates up the ACPI tree until it finds the PXM value in
> the root port. This value is then passed to
> acpi_map_pxm_to_node.  If numa_off is set this returns,
> NUMA_NO_NODE (as it does on arm64), on x86 it instead tries
> to allocate a numa node from the unused set without setting
> up all the infrastructure that would normally accompany such
> a call.  We have not identified exactly which driver is
> causing the subsequent hang for Martin.
> 
> It is invalid under the ACPI spec to specify new
> numa nodes using PXM if they have no presence in SRAT.
> Thus the simplest fix is to set numa_off when it is off due
> to an invalid SRAT (here not present at all).
> 
> I do not have easy access to appropriate x86 numa systems so
> would appreciate some testing of this one!
> 
> Known problem boards setups:
> 
> AMD Ryzen Threadripper 2950X on ASROCK X399 TAICHI
> MSI X399 SLI PLUS (probably - not confirmed yet)
> 
> The PCI patch has been reverted, so this fix is not critical.
> 
> Reported-by: Martin Hundeb?ll <martin@geanix.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: bad7dcd94f39 ("ACPI/PCI: Pay attention to device-specific _PXM node values")
> 
> ---
>  arch/x86/mm/numa.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 1308f5408bf7..ce1182f953ff 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -695,6 +695,8 @@ static int __init dummy_numa_init(void)
>  	node_set(0, numa_nodes_parsed);
>  	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
>  
> +	numa_off = true;

Should we not:

	pr_err(FW_BUG "Invalid SRAT table.\n");

or something along those lines?

We should take every possibility to call out broken and non-compliant
firmware.
