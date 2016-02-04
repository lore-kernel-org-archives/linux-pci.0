Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 23/23] arm64, pci, acpi: Start using ACPI based PCI host bridge driver for ARM64.
Date: Thu,  4 Feb 2016 18:29:01 +0100
Message-Id: <1454606941-9523-24-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lets get rid of empty PCI init stub, related ACPI header and
go with full-blown PCI host bridge driver.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/arm64/Kconfig      | 1 +
 arch/arm64/kernel/pci.c | 9 ---------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f45ea4..567523b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2,6 +2,7 @@ config ARM64
 	def_bool y
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_PCI_HOST_GENERIC if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index d1a701f..0b53262 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -70,12 +70,3 @@ int pcibios_add_device(struct pci_dev *dev)
 
 	return 0;
 }
-
-#ifdef CONFIG_ACPI
-/* Root bridge scanning */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	/* TODO: Should be revisited when implementing PCI on ACPI */
-	return NULL;
-}
-#endif
-- 
1.9.1

