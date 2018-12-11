Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC9AC07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12522084A
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 09:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12522084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLKJsJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:48:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbeLKJsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 04:48:09 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB1068EEFB936;
        Tue, 11 Dec 2018 17:48:05 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 11 Dec 2018 17:47:59 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>, <x86@kernel.org>, <helgaas@kernel.org>
CC:     <linuxarm@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <martin@geanix.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V2] x86: Fix an issue with invalid ACPI NUMA config
Date:   Tue, 11 Dec 2018 17:47:37 +0800
Message-ID: <20181211094737.71554-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The addition of support to read the NUMA node for a PCI card specified by
_PXM resulted in Martin's system not booting.   Looking at the ACPI tables
it seems that there are _PXM entries for the root ports, but no SRAT table.

The absence of the SRAT table results in dummy_numa_init() being called.
However, unlike on arm64, this doesn't result in numa_off being set.

When the PCI code later comes along and calls acpi_get_node() for any PCI
card below the root port, it navigates up the ACPI tree until it finds the
_PXM value in the root port. This value is then passed to
acpi_map_pxm_to_node().

As numa_off has not been set on x86 it tries to allocate a NUMA node, from
the unused set, without setting up all the infrastructure that would
normally accompany such a call.  We have not identified exactly which driver
is causing the subsequent hang for Martin.

If numa_off had been set, as it is in the equivalent flow on arm64, then
acpi_map_pxm_to_node() would return NUMA_NO_NODE, which is what we want to
happen.

It is invalid under the ACPI spec to specify new NUMA nodes using _PXM if
they have no presence in SRAT. Thus the simplest fix is to set numa_off when
NUMA support is disabled due to an invalid SRAT (here not present at all).

I do not have easy access to appropriate x86 NUMA systems so would
appreciate some testing of this one!

Known problem boards setups:

AMD Ryzen Threadripper 2950X on ASROCK X399 TAICHI
MSI X399 SLI PLUS (probably - not confirmed yet)

The PCI patch has been reverted, so this fix is not critical.

Reported-by: Martin Hundebøll <martin@geanix.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: bad7dcd94f39 ("ACPI/PCI: Pay attention to device-specific _PXM node values")
---
Changes since V1:
* Update commit message as suggested by Bjorn Helgaas.
* No functional changes.

 arch/x86/mm/numa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f5408bf7..ce1182f953ff 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -695,6 +695,8 @@ static int __init dummy_numa_init(void)
 	node_set(0, numa_nodes_parsed);
 	numa_add_memblk(0, 0, PFN_PHYS(max_pfn));
 
+	numa_off = true;
+
 	return 0;
 }
 
-- 
2.19.1

