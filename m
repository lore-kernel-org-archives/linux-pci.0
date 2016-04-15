Return-Path: <linux-acpi-owner@vger.kernel.org>
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
Subject: [PATCH V6 13/13] pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.
Date: Fri, 15 Apr 2016 19:06:48 +0200
Message-Id: <1460740008-19489-14-git-send-email-tn@semihalf.com>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch uses DECLARE_ACPI_MCFG_FIXUP to overwrite PCI config accessors.
Also, it provides alternative way to find additional configuration region:
thunder_pem_get_acpi_res is looking for host bridge's child (_HID "THRX0001")
which contains mentioned configuration region description.
See example below:

Device (PEM0) {
    Name (_HID, EISAID ("PNP0A08"))
    Name (_CID, EISAID ("PNP0A03"))

    [...]

    Device (CFG0)
    {
      Name (_HID, "THRX0001") // PEM configuration space resources
      Name (_CRS, ResourceTemplate () {
        QWordMemory(ResourceConsumer, PosDecode, MinFixed, MaxFixed,
          NonCacheable, ReadWrite, 0, 0x87e0c5000000, 0x87E0C5FFFFFF,
          0, 0x01000000)
      })
    }
}

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/host/pci-thunder-pem.c | 137 ++++++++++++++++++++++++++++++++++---
 1 file changed, 128 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 91cfeb9..685cd79 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/platform_device.h>
 
 #include "../ecam.h"
@@ -259,6 +260,83 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
+#ifdef CONFIG_ACPI
+
+struct pem_acpi_res {
+	struct resource	resource;
+	int found;
+};
+
+static acpi_status
+thunder_pem_cfg(struct acpi_resource *resource, void *ctx)
+{
+	struct pem_acpi_res *pem_ctx = ctx;
+	struct resource *res = &pem_ctx->resource;
+
+	if ((resource->type != ACPI_RESOURCE_TYPE_ADDRESS64) ||
+	    (resource->data.address32.resource_type != ACPI_MEMORY_RANGE))
+		return AE_OK;
+
+	res->start = resource->data.address64.address.minimum;
+	res->end = resource->data.address64.address.maximum;
+	res->flags = IORESOURCE_MEM;
+
+	pem_ctx->found++;
+	return AE_OK;
+}
+
+static acpi_status
+thunder_pem_find_dev(acpi_handle handle, u32 level, void *ctx, void **ret)
+{
+	struct pem_acpi_res *pem_ctx = ctx;
+	struct acpi_device_info *info;
+	acpi_status status = AE_OK;
+
+	status = acpi_get_object_info(handle, &info);
+	if (ACPI_FAILURE(status))
+		return AE_OK;
+
+	if (strncmp(info->hardware_id.string, "THRX0001", 8) != 0)
+		goto out;
+
+	pem_ctx->found = 0;
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS, thunder_pem_cfg,
+				     pem_ctx);
+	if (ACPI_FAILURE(status))
+		goto out;
+
+	if (pem_ctx->found)
+		status = AE_CTRL_TERMINATE;
+out:
+	kfree(info);
+	return status;
+}
+
+static struct resource *thunder_pem_get_acpi_res(struct device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_handle handle = acpi_device_handle(adev);
+	struct pem_acpi_res *pem_ctx;
+	acpi_status status;
+
+	pem_ctx = devm_kzalloc(dev, sizeof(*pem_ctx), GFP_KERNEL);
+	if (!pem_ctx)
+		return NULL;
+
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+				     thunder_pem_find_dev, NULL, pem_ctx, NULL);
+	if (ACPI_FAILURE(status) || !pem_ctx->found)
+		return NULL;
+
+	return &pem_ctx->resource;
+}
+#else
+static struct resource *thunder_pem_get_acpi_res(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg)
 {
 	resource_size_t bar4_start;
@@ -270,16 +348,20 @@ static int thunder_pem_init(struct device *dev, struct pci_config_window *cfg)
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
+		res_pem = thunder_pem_get_acpi_res(dev);
+	}
 	if (!res_pem) {
-		dev_err(dev, "missing \"reg[1]\"property\n");
+		dev_err(dev, "missing configuration region\n");
 		return -EINVAL;
 	}
 
@@ -332,5 +414,42 @@ static struct platform_driver thunder_pem_driver = {
 };
 module_platform_driver(thunder_pem_driver);
 
+#ifdef CONFIG_ACPI
+
+static bool thunder_pem_acpi_init(struct pci_cfg_fixup *fixup,
+				 struct acpi_pci_root *root)
+{
+	u32 midr = read_cpuid_id();
+
+	return (MIDR_IMPLEMENTOR(midr) == ARM_CPU_IMP_CAVIUM) &&
+	    (MIDR_PARTNUM(midr) == CAVIUM_CPU_PART_THUNDERX);
+}
+
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			4, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			5, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			6, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			7, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			8, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			9, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			14, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			15, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			16, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			17, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			18, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(NULL, thunder_pem_acpi_init, &pci_thunder_pem_ops,
+			19, PCI_MCFG_BUS_ANY);
+#endif
+
 MODULE_DESCRIPTION("Thunder PEM PCIe host driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1

