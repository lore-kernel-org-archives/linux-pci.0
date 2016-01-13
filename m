Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V3 08/21] arm64, acpi: Use empty PCI config space accessors from mcfg.c file.
Date: Wed, 13 Jan 2016 14:20:54 +0100
Message-Id: <1452691267-32240-9-git-send-email-tn@semihalf.com>
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can now use previously prepared empty ACPI RAW accessors
and cleanup a bit before adding full support for PCI host bridge driver.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig      |  6 ++++++
 arch/arm64/kernel/pci.c | 15 ---------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 871f217..d65d315 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -92,6 +92,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_PCI_ECAM
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
@@ -207,6 +208,11 @@ source "drivers/pci/Kconfig"
 source "drivers/pci/pcie/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
+config PCI_MMCONFIG
+	def_bool y
+	select PCI_ECAM
+	depends on ACPI
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index b3d098b..023b983 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -61,21 +61,6 @@ int pcibios_add_device(struct pci_dev *dev)
 	return 0;
 }
 
-/*
- * raw_pci_read/write - Platform-specific PCI config space access.
- */
-int raw_pci_read(unsigned int domain, unsigned int bus,
-		  unsigned int devfn, int reg, int len, u32 *val)
-{
-	return -ENXIO;
-}
-
-int raw_pci_write(unsigned int domain, unsigned int bus,
-		unsigned int devfn, int reg, int len, u32 val)
-{
-	return -ENXIO;
-}
-
 #ifdef CONFIG_ACPI
 /* Root bridge scanning */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-- 
1.9.1

