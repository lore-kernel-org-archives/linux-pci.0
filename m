Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938315AbdDSQtR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Apr 2017 12:49:17 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v4 04/21] ARM: implement pci_remap_cfgspace() interface
Date: Wed, 19 Apr 2017 17:48:53 +0100
Message-Id: <20170419164913.19674-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI bus specifications (rev 3.0, 3.2.5 "Transaction Ordering
and Posting") define rules for PCI configuration space transactions
ordering and posting, that state that configuration writes have to
be non-posted transactions.

Current ioremap interface on ARM provides mapping functions that
provide "bufferable" writes transactions (ie ioremap uses MT_DEVICE
memory type) aka posted writes, so PCI host controller drivers have
no arch interface to remap PCI configuration space with memory
attributes that comply with the PCI specifications for configuration
space.

Implement an ARM specific pci_remap_cfgspace() interface that allows to
map PCI config memory regions with MT_UNCACHED memory type (ie strongly
ordered - non-posted writes), providing a remap function that complies
with PCI specifications for config space transactions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/io.h | 10 ++++++++++
 arch/arm/mm/ioremap.c     |  7 +++++++
 arch/arm/mm/nommu.c       | 12 ++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 42871fb..74d1b09 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -187,6 +187,16 @@ static inline void pci_ioremap_set_mem_type(int mem_type) {}
 extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
 
 /*
+ * PCI configuration space mapping function.
+ *
+ * PCI specifications does not allow configuration write
+ * transactions to be posted. Add an arch specific
+ * pci_remap_cfgspace definition that is implemented
+ * through strongly ordered memory mappings.
+ */
+#define pci_remap_cfgspace pci_remap_cfgspace
+void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size);
+/*
  * Now, pick up the machine-defined IO definitions
  */
 #ifdef CONFIG_NEED_MACH_IO_H
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ff0eed2..fc91205 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -481,6 +481,13 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 				  __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_io);
+
+void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
+{
+	return arch_ioremap_caller(res_cookie, size, MT_UNCACHED,
+				   __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(pci_remap_cfgspace);
 #endif
 
 /*
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 33a45bd..3b8e728 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -436,6 +436,18 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size)
 }
 EXPORT_SYMBOL(ioremap_wc);
 
+#ifdef CONFIG_PCI
+
+#include <asm/mach/map.h>
+
+void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size)
+{
+	return arch_ioremap_caller(res_cookie, size, MT_UNCACHED,
+				   __builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(pci_remap_cfgspace);
+#endif
+
 void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
 {
 	return (void *)phys_addr;
-- 
2.10.0
