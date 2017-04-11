Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbdDKMaP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Apr 2017 08:30:15 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH v3 22/32] s390: include default ioremap_nopost() implementation
Date: Tue, 11 Apr 2017 13:29:02 +0100
Message-Id: <20170411122923.6285-23-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Posting")
mandate non-posted configuration transactions. As further highlighted in
the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
Enhanced Configuration Access Mechanism"), through ECAM and
ECAM-derivative configuration mechanism, the memory mapped transactions
from the host CPU into Configuration Requests on the PCI express fabric
may create ordering problems for software because writes to memory
address are typically posted transactions (unless the architecture can
enforce through virtual address mapping non-posted write transactions
behaviour) but writes to Configuration Space are not posted on the PCI
express fabric.

Include the asm-generic ioremap_nopost() implementation (currently
falling back to ioremap_nocache()) to provide a non-posted writes
ioremap interface to kernel subsystems.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 437e9af..374fb43 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -39,6 +39,7 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 static inline void iounmap(volatile void __iomem *addr)
 {
 }
+#include <asm-generic/ioremap-nopost.h>
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-- 
2.10.0
