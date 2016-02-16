Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V5 03/15] arm64, acpi: Use MCFG library and empty PCI config space accessors from pci_mcfg.c file.
Date: Tue, 16 Feb 2016 14:53:33 +0100
Message-Id: <1455630825-27253-4-git-send-email-tn@semihalf.com>
In-Reply-To: <1455630825-27253-1-git-send-email-tn@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can now enable MCFG library. Currently, there is no ARM64 use case for
RAW pci config accessors, so lets use empty ones for now.
At the same time, we can cleanup the old implementation of RAW accessors
from arch/arm64/kernel/pci.c

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/arm64/Kconfig      |  4 ++++
 arch/arm64/kernel/pci.c | 15 ---------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc6228..552e996 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -238,6 +238,10 @@ source "drivers/pci/Kconfig"
 source "drivers/pci/pcie/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
+config PCI_MMCONFIG
+	def_bool y
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
