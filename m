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
Subject: [PATCH V7 10/11] arm64, pci, acpi: Provide ACPI-specific prerequisites for PCI bus enumeration.
Date: Tue, 10 May 2016 17:20:00 +0200
Message-Id: <1462893601-8937-11-git-send-email-tn@semihalf.com>
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

ACPI requires to run acpi_pci_{add|remove}_bus while new PCI bus is created.
This allows to do some ACPI-specific additional configuration, like
PCI hotplug slot enumeration. In order to fulfill these requirements,
we implement arch-specific pcibios_{add|remove}_bus calls
and call acpi_pci_{add|remove}_bus from there.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
To: Will Deacon <will.deacon@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 15109c11..eeec5f6 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/pci-acpi.h>
 #include <linux/slab.h>
 
 /*
@@ -64,6 +65,16 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 	return 0;
 }
 
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
  */
-- 
1.9.1
