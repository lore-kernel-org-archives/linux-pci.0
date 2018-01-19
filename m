Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:50638 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754771AbeASJjX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 04:39:23 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>
Cc: arnd@arndb.de, kishon@ti.com, Niklas Cassel <niklass@axis.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n build
Date: Fri, 19 Jan 2018 10:39:06 +0100
Message-Id: <20180119093906.27670-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If CONFIG_PCI=n and CONFIG_PCI_DRA7XX_EP=y, the build fails with:

  drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate'
  undeclared here (not in a function)

When building drivers/pci/dwc/pci-dra7xx.c without CONFIG_PCI,
gcc is usually smart enough to realize that RC specific code
is unreachable and can thus be eliminated.

However, gcc cannot do this if there is a function that isn't
even declared.

Hence fix the issue by introducing a dummy for pci_irqd_intx_xlate().

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 include/linux/pci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83299833a6ce..41c676a011f4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1675,6 +1675,13 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #define dev_is_pf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
+static inline int pci_irqd_intx_xlate(struct irq_domain *d,
+				      struct device_node *node,
+				      const u32 *intspec,
+				      unsigned int intsize,
+				      unsigned long *out_hwirq,
+				      unsigned int *out_type)
+{ return -EINVAL; }
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
2.14.2
