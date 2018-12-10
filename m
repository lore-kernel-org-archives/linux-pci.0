Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0BEC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 23:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F14214DB
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 23:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486201;
	bh=SvtLmD/fQT4djlrP54/YcbPyBBqSjR4QQwANlhexj/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IY/5F2AtZ6VtcXJunWqcKz9rNzye8/Akj6Dut6DGyoa8XRij+tQVyXgzf2BCCENrO
	 yssKGavn+n21k8qnDc2PtUF50HDZlT5b+jb6d7/z/7NU9OC7X/TK2HWQfcCVG6Y5I1
	 vk2MCHtV1ONR70bR/23De+nrOp+sizTt0i72s38Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F14214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeLJX4k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbeLJX4k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 18:56:40 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AFA8214D9;
        Mon, 10 Dec 2018 23:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486199;
        bh=SvtLmD/fQT4djlrP54/YcbPyBBqSjR4QQwANlhexj/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAsphZK4lC2ctUp750vlr1QfS6Yur5k8obHM2qz81UbdMVsi5/qv60LVb1sXgPpuP
         2TCTJULHrlJsujakGHgBp7cKc8tMrFjnatJBriKDVTnTbwxiNtBVFZisb/oCU6RKx6
         ORMrLikejSu9MEzsKsWZqfSGUyUK7iTGzBqdpWOA=
Date:   Mon, 10 Dec 2018 17:56:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com,
        Ingo Molnar <mingo@kernel.org>, linux-acpi@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH] x86: Fix an issue with invalid ACPI numa config
Message-ID: <20181210235637.GA99796@google.com>
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

I don't see this in linux-next so I assume nobody has picked it up yet?
numa.c isn't my file, but the fix is for something that went in via
PCI, so I can take this patch if nobody else has already.

The changelog could all be wrapped to use more of the line.  Assume 80
char width and allow for the 4 spaces added by git log.

On Thu, Nov 15, 2018 at 11:06:17AM +0000, Jonathan Cameron wrote:
> The addition of support to read the numa node for a PCI

s/numa/NUMA/

> card specified by _PXM resulted in Martin's system not
> booting.   Looking at the ACPI tables it seems that there
> are PXM entries for the root ports, but no SRAT table.

s/PXM/_PXM/ (and below)

> The absence of SRAT table results in dummy_numa_init being

dummy_numa_init() and similar for other functions below.

> called.  However, unlike on arm64, this doesn't then result
> in numa_off being set.  When the PCI code later comes along
> and calls acpi_get_node for any PCI card below the root port,
> it navigates up the ACPI tree until it finds the PXM value in
> the root port. This value is then passed to
> acpi_map_pxm_to_node.  If numa_off is set this returns,
> NUMA_NO_NODE (as it does on arm64), on x86 it instead tries

This doesn't parse quite right.

> to allocate a numa node from the unused set without setting
> up all the infrastructure that would normally accompany such
> a call.  We have not identified exactly which driver is
> causing the subsequent hang for Martin.

It's not clear to me why dummy_numa_init() must be different between
arm64 and x86.  This patch makes x86 more like arm64, which is good.
Maybe a subsequent patch could go even further?

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
> +
>  	return 0;
>  }
>  
> -- 
> 2.18.0
> 
> 
