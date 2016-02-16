Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Subject: [PATCH V5 08/15] x86, ia64: Include acpi_pci_{add|remove}_bus to the default pcibios_{add|remove}_bus implementation.
Date: Tue, 16 Feb 2016 14:53:38 +0100
Message-Id: <1455630825-27253-9-git-send-email-tn@semihalf.com>
In-Reply-To: <1455630825-27253-1-git-send-email-tn@semihalf.com>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

x86 and ia64 are the only arches that implement pcibios_{add|remove}_bus hooks
and implement them in the same way. Moreover ARM64 is going to do the same.
So it seems that acpi_pci_{add|remove}_bus is generic enough to be default
option for pcibios_{add|remove}_bus hooks. Also, it is always safe to run
acpi_pci_{add|remove}_bus as they have empty stubs for !ACPI case and
return if ACPI has been switched off in run time.

After all we can remove x86 and ia64 pcibios_{add|remove}_bus
implementation.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/ia64/pci/pci.c   | 10 ----------
 arch/x86/pci/common.c | 10 ----------
 drivers/pci/probe.c   |  3 +++
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 978d6af..be4c9ef 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -358,16 +358,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
 	platform_pci_fixup_bus(b);
 }
 
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
 void pcibios_set_master (struct pci_dev *dev)
 {
 	/* No special bus mastering setup handling */
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 2879efc..5aa25f1 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -171,16 +171,6 @@ void pcibios_fixup_bus(struct pci_bus *b)
 		pcibios_fixup_device_resources(dev);
 }
 
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
 /*
  * Only use DMI information to set this if nothing was passed
  * on the kernel command line (which was parsed earlier).
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 88a4734..9859b12 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
@@ -2060,10 +2061,12 @@ int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 
 void __weak pcibios_add_bus(struct pci_bus *bus)
 {
+	acpi_pci_add_bus(bus);
 }
 
 void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
+	acpi_pci_remove_bus(bus);
 }
 
 struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-- 
1.9.1

