Return-Path: <linux-arch-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Zankel <chris@zankel.net>
Subject: [PATCH v3 28/32] xtensa: include default ioremap_nopost() implementation
Date: Tue, 11 Apr 2017 13:29:08 +0100
Message-Id: <20170411122923.6285-29-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Zankel <chris@zankel.net>
---
 arch/xtensa/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
index c38e5a7..a469bef 100644
--- a/arch/xtensa/include/asm/io.h
+++ b/arch/xtensa/include/asm/io.h
@@ -55,6 +55,7 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
 
 #define ioremap_wc ioremap_nocache
 #define ioremap_wt ioremap_nocache
+#include <asm-generic/ioremap-nopost.h>
 
 static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 {
-- 
2.10.0
