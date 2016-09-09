Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
From: Tomasz Nowicki <tn@semihalf.com>
To: helgaas@kernel.org,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	Lorenzo.Pieralisi@arm.com
Cc: arnd@arndb.de,
	hanjun.guo@linaro.org,
	okaya@codeaurora.org,
	jchandra@broadcom.com,
	cov@codeaurora.org,
	dhdang@apm.com,
	ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com,
	mw@semihalf.com,
	Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com,
	wangyijing@huawei.com,
	msalter@redhat.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org,
	jcm@redhat.com,
	andrea.gallo@linaro.org,
	jeremy.linton@arm.com,
	liudongdong3@huawei.com,
	gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific register range for ACPI case
Date: Fri,  9 Sep 2016 21:24:05 +0200
Message-Id: <1473449047-10499-4-git-send-email-tn@semihalf.com>
In-Reply-To: <1473449047-10499-1-git-send-email-tn@semihalf.com>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
List-ID: <linux-pci.vger.kernel.org>

thunder-pem driver stands for being ACPI based PCI host controller.
However, there is no standard way to describe its PEM-specific register
ranges in ACPI tables. Thus we add thunder_pem_init() ACPI extension
to obtain hardcoded addresses from static resource array.
Although it is not pretty, it prevents from creating standard mechanism to
handle similar cases in future.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/host/pci-thunder-pem.c | 61 ++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 6abaf80..b048761 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
@@ -284,6 +285,40 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
+#ifdef CONFIG_ACPI
+static struct resource thunder_pem_reg_res[] = {
+	[4] = DEFINE_RES_MEM(0x87e0c0000000UL, SZ_16M),
+	[5] = DEFINE_RES_MEM(0x87e0c1000000UL, SZ_16M),
+	[6] = DEFINE_RES_MEM(0x87e0c2000000UL, SZ_16M),
+	[7] = DEFINE_RES_MEM(0x87e0c3000000UL, SZ_16M),
+	[8] = DEFINE_RES_MEM(0x87e0c4000000UL, SZ_16M),
+	[9] = DEFINE_RES_MEM(0x87e0c5000000UL, SZ_16M),
+	[14] = DEFINE_RES_MEM(0x97e0c0000000UL, SZ_16M),
+	[15] = DEFINE_RES_MEM(0x97e0c1000000UL, SZ_16M),
+	[16] = DEFINE_RES_MEM(0x97e0c2000000UL, SZ_16M),
+	[17] = DEFINE_RES_MEM(0x97e0c3000000UL, SZ_16M),
+	[18] = DEFINE_RES_MEM(0x97e0c4000000UL, SZ_16M),
+	[19] = DEFINE_RES_MEM(0x97e0c5000000UL, SZ_16M),
+};
+
+static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
+{
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	if ((root->segment >= 4 && root->segment <= 9) ||
+	    (root->segment >= 14 && root->segment <= 19))
+		return &thunder_pem_reg_res[root->segment];
+
+	return NULL;
+}
+#else
+static struct resource *thunder_pem_acpi_res(struct pci_config_window *cfg)
+{
+	return NULL;
+}
+#endif
+
 static int thunder_pem_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -292,24 +327,24 @@ static int thunder_pem_init(struct pci_config_window *cfg)
 	struct thunder_pem_pci *pem_pci;
 	struct platform_device *pdev;
 
-	/* Only OF support for now */
-	if (!dev->of_node)
-		return -EINVAL;
-
 	pem_pci = devm_kzalloc(dev, sizeof(*pem_pci), GFP_KERNEL);
 	if (!pem_pci)
 		return -ENOMEM;
 
-	pdev = to_platform_device(dev);
-
-	/*
-	 * The second register range is the PEM bridge to the PCIe
-	 * bus.  It has a different config access method than those
-	 * devices behind the bridge.
-	 */
-	res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (acpi_disabled) {
+		pdev = to_platform_device(dev);
+
+		/*
+		 * The second register range is the PEM bridge to the PCIe
+		 * bus.  It has a different config access method than those
+		 * devices behind the bridge.
+		 */
+		res_pem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	} else {
+		res_pem = thunder_pem_acpi_res(cfg);
+	}
 	if (!res_pem) {
-		dev_err(dev, "missing \"reg[1]\"property\n");
+		dev_err(dev, "missing configuration region\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
