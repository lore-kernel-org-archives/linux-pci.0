Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: [PATCH v3 26/32] unicore32: include default ioremap_nopost() implementation
Date: Tue, 11 Apr 2017 13:29:06 +0100
Message-Id: <20170411122923.6285-27-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 arch/unicore32/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/unicore32/include/asm/io.h b/arch/unicore32/include/asm/io.h
index cb1d8fd..71fdfa2 100644
--- a/arch/unicore32/include/asm/io.h
+++ b/arch/unicore32/include/asm/io.h
@@ -38,6 +38,7 @@ extern void __uc32_iounmap(volatile void __iomem *addr);
 #define ioremap_cached(cookie, size)	__uc32_ioremap_cached(cookie, size)
 #define ioremap_nocache(cookie, size)	__uc32_ioremap(cookie, size)
 #define iounmap(cookie)			__uc32_iounmap(cookie)
+#include <asm-generic/ioremap-nopost.h>
 
 #define readb_relaxed readb
 #define readw_relaxed readw
-- 
2.10.0
