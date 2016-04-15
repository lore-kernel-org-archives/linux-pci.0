Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35286 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbcDORH3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2016 13:07:29 -0400
Received: by mail-wm0-f47.google.com with SMTP id a140so40051546wma.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Apr 2016 10:07:29 -0700 (PDT)
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 06/13] arm64, pci, acpi: ACPI support for legacy IRQs parsing and consolidation with DT code.
Date: Fri, 15 Apr 2016 19:06:41 +0200
Message-Id: <1460740008-19489-7-git-send-email-tn@semihalf.com>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To enable PCI legacy IRQs on platforms booting with ACPI, arch code
should include ACPI specific callbacks that parse and set-up the
device IRQ number, equivalent to the DT boot path. Owing to the current
ACPI core scan handlers implementation, ACPI PCI legacy IRQs bindings
cannot be parsed at device add time, since that would trigger ACPI scan
handlers ordering issues depending on how the ACPI tables are defined.

To solve this problem and consolidate FW PCI legacy IRQs parsing in
one single pcibios callback (pending final removal), this patch moves
DT PCI IRQ parsing to the pcibios_alloc_irq() callback (called by
PCI core code at device probe time) and adds ACPI PCI legacy IRQs
parsing to the same callback too, so that FW PCI legacy IRQs parsing
is confined in one single arch callback that can be easily removed
when code parsing PCI legacy IRQs is consolidated and moved to core
PCI code.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index c72de66..15109c11 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -50,11 +50,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 }
 
 /*
- * Try to assign the IRQ number from DT when adding a new device
+ * Try to assign the IRQ number when probing a new device
  */
-int pcibios_add_device(struct pci_dev *dev)
+int pcibios_alloc_irq(struct pci_dev *dev)
 {
-	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+	if (acpi_disabled)
+		dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+#ifdef CONFIG_ACPI
+	else
+		return acpi_pci_irq_enable(dev);
+#endif
 
 	return 0;
 }
-- 
1.9.1

