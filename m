Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754825AbdDKMaF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Apr 2017 08:30:05 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v3 14/32] metag: include default ioremap_nopost() implementation
Date: Tue, 11 Apr 2017 13:28:54 +0100
Message-Id: <20170411122923.6285-15-lorenzo.pieralisi@arm.com>
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
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/metag/include/asm/io.h b/arch/metag/include/asm/io.h
index 9890f21..c805e0d 100644
--- a/arch/metag/include/asm/io.h
+++ b/arch/metag/include/asm/io.h
@@ -166,4 +166,6 @@ extern void __iounmap(void __iomem *addr);
 #define iounmap(addr)                           \
 	__iounmap(addr)
 
+#include <asm-generic/ioremap-nopost.h>
+
 #endif  /* _ASM_METAG_IO_H */
-- 
2.10.0
