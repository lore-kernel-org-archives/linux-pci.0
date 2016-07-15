Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
From: Peter Wu <peter@lekensteyn.nl>
To: Dave Airlie <airlied@redhat.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Date: Fri, 15 Jul 2016 15:12:18 +0200
Message-Id: <20160715131218.2416-5-peter@lekensteyn.nl>
In-Reply-To: <20160715131218.2416-1-peter@lekensteyn.nl>
References: <20160715131218.2416-1-peter@lekensteyn.nl>
List-ID: <linux-pci.vger.kernel.org>

Since "PCI: Add runtime PM support for PCIe ports", the parent PCIe port
can be runtime-suspended which disables power resources via ACPI. This
is incompatible with DSM, resulting in a GPU device which is still in D3
and locks up the kernel on resume (on a Clevo P651RA, GTX965M).

Mirror the behavior of Windows 8 and newer[1] (as observed via an AMLi
debugger trace) and stop using the DSM functions for D3cold when power
resources are available on the parent PCIe port.

pci_d3cold_disable() is not used because on some machines, the old DSM
method is broken. On a Lenovo T440p (GT 730M) memory and disk corruption
would occur, but that is fixed with this patch[2].

 [1]: https://msdn.microsoft.com/windows/hardware/drivers/bringup/firmware-requirements-for-d3cold
 [2]: https://github.com/Bumblebee-Project/bbswitch/issues/78#issuecomment-223549072

 v2: simply check directly for _PR3. Added affected machines.
 v3: fixed block comment coding style.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 35 ++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index ad273ad..f2ad17a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -46,6 +46,7 @@ static struct nouveau_dsm_priv {
 	bool dsm_detected;
 	bool optimus_detected;
 	bool optimus_flags_detected;
+	bool optimus_skip_dsm;
 	acpi_handle dhandle;
 	acpi_handle rom_handle;
 } nouveau_dsm_priv;
@@ -212,9 +213,28 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
 	.get_client_id = nouveau_dsm_get_client_id,
 };
 
+/*
+ * Firmware supporting Windows 8 or later do not use _DSM to put the device into
+ * D3cold, they instead rely on disabling power resources on the parent.
+ */
+static bool nouveau_pr3_present(struct pci_dev *pdev)
+{
+	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
+	struct acpi_device *parent_adev;
+
+	if (!parent_pdev)
+		return false;
+
+	parent_adev = ACPI_COMPANION(&parent_pdev->dev);
+	if (!parent_adev)
+		return false;
+
+	return acpi_has_method(parent_adev->handle, "_PR3");
+}
+
 static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out,
 				  bool *has_mux, bool *has_opt,
-				  bool *has_opt_flags)
+				  bool *has_opt_flags, bool *has_pr3)
 {
 	acpi_handle dhandle;
 	bool supports_mux;
@@ -239,6 +259,7 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 	*has_mux = supports_mux;
 	*has_opt = !!optimus_funcs;
 	*has_opt_flags = optimus_funcs & (1 << NOUVEAU_DSM_OPTIMUS_FLAGS);
+	*has_pr3 = false;
 
 	if (optimus_funcs) {
 		uint32_t result;
@@ -248,6 +269,8 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 			 (result & OPTIMUS_ENABLED) ? "enabled" : "disabled",
 			 (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
 			 (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
+
+		*has_pr3 = nouveau_pr3_present(pdev);
 	}
 }
 
@@ -260,6 +283,7 @@ static bool nouveau_dsm_detect(void)
 	bool has_mux = false;
 	bool has_optimus = false;
 	bool has_optimus_flags = false;
+	bool has_power_resources = false;
 	int vga_count = 0;
 	bool guid_valid;
 	bool ret = false;
@@ -275,14 +299,14 @@ static bool nouveau_dsm_detect(void)
 		vga_count++;
 
 		nouveau_dsm_pci_probe(pdev, &dhandle, &has_mux, &has_optimus,
-				      &has_optimus_flags);
+				      &has_optimus_flags, &has_power_resources);
 	}
 
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
 		vga_count++;
 
 		nouveau_dsm_pci_probe(pdev, &dhandle, &has_mux, &has_optimus,
-				      &has_optimus_flags);
+				      &has_optimus_flags, &has_power_resources);
 	}
 
 	/* find the optimus DSM or the old v1 DSM */
@@ -292,8 +316,11 @@ static bool nouveau_dsm_detect(void)
 			&buffer);
 		printk(KERN_INFO "VGA switcheroo: detected Optimus DSM method %s handle\n",
 			acpi_method_name);
+		if (has_power_resources)
+			pr_info("nouveau: detected PR support, will not use DSM\n");
 		nouveau_dsm_priv.optimus_detected = true;
 		nouveau_dsm_priv.optimus_flags_detected = has_optimus_flags;
+		nouveau_dsm_priv.optimus_skip_dsm = has_power_resources;
 		ret = true;
 	} else if (vga_count == 2 && has_mux && guid_valid) {
 		nouveau_dsm_priv.dhandle = dhandle;
@@ -324,7 +351,7 @@ void nouveau_register_dsm_handler(void)
 void nouveau_switcheroo_optimus_dsm(void)
 {
 	u32 result = 0;
-	if (!nouveau_dsm_priv.optimus_detected)
+	if (!nouveau_dsm_priv.optimus_detected || nouveau_dsm_priv.optimus_skip_dsm)
 		return;
 
 	if (nouveau_dsm_priv.optimus_flags_detected)
-- 
2.9.0
