Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbdC0Jul (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Mar 2017 05:50:41 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        John Garry <john.garry@huawei.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Ray Jui <rjui@broadcom.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Jon Mason <jonmason@broadcom.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 03/22] asm-generic/pgtable.h: introduce pgprot_nonposted remap attribute
Date: Mon, 27 Mar 2017 10:49:31 +0100
Message-Id: <20170327094954.7162-4-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
References: <20170327094954.7162-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

According to the PCI local bus specifications (Revision 3.0, 3.2.5),
I/O Address space transactions are non-posted. On architectures where
I/O space is implemented through a chunk of memory mapped space mapped
to PCI address space (ie IA64/ARM/ARM64) the memory mapping for the
region backing I/O Address Space transactions determines the I/O
transactions attributes (before the transactions actually reaches the
PCI bus where it is handled according to the PCI specifications).

The kernel lacks a pgprot_* attribute to map memory with type
generating non-posted writes transactions, which therefore needs to
be added.

Add a pgprot_nonposted mapping prot to create a memory mapping for
memory areas requiring non-posted write transactions; make it default to
pgprot_noncached (which should provide a sane default behaviour) but
still allowing architectures on which pgprot_noncached results in posted
write transactions to override the prot with an arch specific
implementation that guarantees non-posted writes transactions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 include/asm-generic/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 1fad160..2070172 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -399,6 +399,10 @@ static inline int pud_same(pud_t pud_a, pud_t pud_b)
 #define pgprot_device pgprot_noncached
 #endif
 
+#ifndef pgprot_nonposted
+#define pgprot_nonposted pgprot_noncached
+#endif
+
 #ifndef pgprot_modify
 #define pgprot_modify pgprot_modify
 static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
-- 
2.10.0
