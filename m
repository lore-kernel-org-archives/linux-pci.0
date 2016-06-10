Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	arnd@arndb.de,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org,
	jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	dhdang@apm.com,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	cov@codeaurora.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V9 09/11] ARM64/PCI: ACPI support for legacy IRQs parsing and consolidation with DT code
Date: Fri, 10 Jun 2016 21:55:17 +0200
Message-Id: <1465588519-11334-10-git-send-email-tn@semihalf.com>
In-Reply-To: <1465588519-11334-1-git-send-email-tn@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
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
index d5d3d26..b3b8a2c 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -51,11 +51,16 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
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
