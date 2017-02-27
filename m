Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdB0PPc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Feb 2017 10:15:32 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
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
        Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 03/20] asm-generic/io.h: add PCI config space remap interface
Date: Mon, 27 Feb 2017 15:14:14 +0000
Message-Id: <20170227151436.18698-4-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
Posting") mandate non-posted configuration transactions. As further
highlighted in the PCIe specifications (4.0 - Rev0.3, "Ordering
Considerations for the Enhanced Configuration Access Mechanism"),
through ECAM and ECAM-derivative configuration mechanism, the memory
mapped transactions from the host CPU into Configuration Requests on the
PCI express fabric may create ordering problems for software because
writes to memory address are typically posted transactions (unless the
architecture can enforce through virtual address mapping non-posted
write transactions behaviour) but writes to Configuration Space are not
posted on the PCI express fabric.

Current DT and ACPI host bridge controllers map PCI configuration space
(ECAM and ECAM-derivative) into the virtual address space through
ioremap() calls, that are non-cacheable device accesses on most
architectures, but may provide "bufferable" or "posted" write semantics
in architecture like eg ARM/ARM64 that allow ioremap'ed regions writes
to be buffered in the bus connecting the host CPU to the PCI fabric;
this behaviour, as underlined in the PCIe specifications, may trigger
transactions ordering rules and must be prevented.

Introduce a new generic and explicit API to create a memory
mapping for ECAM and ECAM-derivative config space area that
defaults to ioremap_nocache() (which should provide a sane default
behaviour) but still allowing architectures on which ioremap_nocache()
results in posted write transactions to override the function
call with an arch specific implementation that complies with
the PCI specifications for configuration transactions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 include/asm-generic/io.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ef015e..52dda81 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -915,6 +915,15 @@ extern void ioport_unmap(void __iomem *p);
 #endif /* CONFIG_GENERIC_IOMAP */
 #endif /* CONFIG_HAS_IOPORT_MAP */
 
+#ifndef pci_remap_cfgspace
+#define pci_remap_cfgspace pci_remap_cfgspace
+static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
+					       size_t size)
+{
+	return ioremap_nocache(offset, size);
+}
+#endif
+
 #ifndef xlate_dev_kmem_ptr
 #define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
 static inline void *xlate_dev_kmem_ptr(void *addr)
-- 
2.10.0
