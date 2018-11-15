Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F132C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 11:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8482086C
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 11:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8482086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKOVRZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:17:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbeKOVRZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 16:17:25 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD2BECAF9E702;
        Thu, 15 Nov 2018 19:09:52 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 15 Nov 2018
 19:09:42 +0800
Date:   Thu, 15 Nov 2018 11:09:32 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH] x86: Fix an issue with invalid ACPI numa config
Message-ID: <20181115110932.00006fea@huawei.com>
In-Reply-To: <20181115110617.13280-1-Jonathan.Cameron@huawei.com>
References: <20181115110617.13280-1-Jonathan.Cameron@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Nov 2018 11:06:17 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

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
> Reported-by: Martin Hundeb�ll <martin@geanix.com>
Sorry, seems I had a wrong encoding somewhere down the line and it messed
up Martin's name.  Could we fix that if applying!

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


