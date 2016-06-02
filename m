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
Subject: [RFC PATCH 3/3] pci, pci-thunder-pem: Add ACPI support for ThunderX PEM.
Date: Thu,  2 Jun 2016 10:41:03 +0200
Message-Id: <1464856864-18049-4-git-send-email-tn@semihalf.com>
In-Reply-To: <1464856864-18049-1-git-send-email-tn@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com>
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
 drivers/pci/host/pci-thunder-pem.c | 132 +++++++++++++++++++++++++++++++++----
 1 file changed, 119 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index 91f6fc6..8f002ef 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
@@ -284,6 +285,83 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
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
+	struct acpi_device *adev = to_acpi_device(dev);
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
 static int thunder_pem_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
@@ -292,24 +370,24 @@ static int thunder_pem_init(struct pci_config_window *cfg)
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
+		res_pem = thunder_pem_get_acpi_res(dev);
+	}
 	if (!res_pem) {
-		dev_err(dev, "missing \"reg[1]\"property\n");
+		dev_err(dev, "missing configuration region\n");
 		return -EINVAL;
 	}
 
@@ -362,5 +440,33 @@ static struct platform_driver thunder_pem_driver = {
 };
 module_platform_driver(thunder_pem_driver);
 
+#ifdef CONFIG_ACPI
+
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			4, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			5, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			6, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			7, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			8, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			9, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			14, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			15, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			16, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			17, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			18, PCI_MCFG_BUS_ANY);
+DECLARE_ACPI_MCFG_FIXUP(&pci_thunder_pem_ops, "CAVIUM", 1,
+			19, PCI_MCFG_BUS_ANY);
+#endif
+
 MODULE_DESCRIPTION("Thunder PEM PCIe host driver");
 MODULE_LICENSE("GPL v2");
-- 
1.9.1
