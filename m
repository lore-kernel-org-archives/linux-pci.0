Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
From: Peter Wu <peter@lekensteyn.nl>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Date: Wed, 25 May 2016 00:53:01 +0200
Message-Id: <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
In-Reply-To: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
List-ID: <linux-pci.vger.kernel.org>

Since "PCI: Add runtime PM support for PCIe ports", the parent PCIe port
can be runtime-suspended which disables power resources via ACPI. This
is incompatible with DSM, resulting in a GPU device which is still in D3
and locks up the kernel on resume.

Mirror the behavior of Windows 8 and newer[1] (as observed via an AMLi
debugger trace) and stop using the DSM functions for D3cold when power
resources are available on the parent PCIe port.

 [1]: https://msdn.microsoft.com/windows/hardware/drivers/bringup/firmware-requirements-for-d3cold

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index df9f73e..e469df7 100644
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
@@ -212,8 +213,26 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
 	.get_client_id = nouveau_dsm_get_client_id,
 };
 
+/* Firmware supporting Windows 8 or later do not use _DSM to put the device into
+ * D3cold, they instead rely on disabling power resources on the parent. */
+static bool nouveau_pr3_present(struct pci_dev *pdev)
+{
+	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
+	struct acpi_device *ad;
+
+	if (!parent_pdev)
+		return false;
+
+	ad = ACPI_COMPANION(&parent_pdev->dev);
+	if (!ad)
+		return false;
+
+	return ad->power.flags.power_resources;
+}
+
 static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
-				  bool *has_opt, bool *has_opt_flags)
+				  bool *has_opt, bool *has_opt_flags,
+				  bool *has_power_resources)
 {
 	acpi_handle dhandle;
 	bool supports_mux;
@@ -238,6 +257,7 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
 	*has_mux = supports_mux;
 	*has_opt = !!optimus_funcs;
 	*has_opt_flags = optimus_funcs & (1 << NOUVEAU_DSM_OPTIMUS_FLAGS);
+	*has_power_resources = false;
 
 	if (optimus_funcs) {
 		uint32_t result;
@@ -247,6 +267,8 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
 			 (result & OPTIMUS_ENABLED) ? "enabled" : "disabled",
 			 (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
 			 (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
+
+		*has_power_resources = nouveau_pr3_present(pdev);
 	}
 }
 
@@ -258,6 +280,7 @@ static bool nouveau_dsm_detect(void)
 	bool has_mux = false;
 	bool has_optimus = false;
 	bool has_optimus_flags = false;
+	bool has_power_resources = false;
 	int vga_count = 0;
 	bool guid_valid;
 	bool ret = false;
@@ -273,14 +296,14 @@ static bool nouveau_dsm_detect(void)
 		vga_count++;
 
 		nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
-				      &has_optimus_flags);
+				      &has_optimus_flags, &has_power_resources);
 	}
 
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
 		vga_count++;
 
 		nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
-				      &has_optimus_flags);
+				      &has_optimus_flags, &has_power_resources);
 	}
 
 	/* find the optimus DSM or the old v1 DSM */
@@ -289,8 +312,11 @@ static bool nouveau_dsm_detect(void)
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
 		acpi_get_name(nouveau_dsm_priv.dhandle, ACPI_FULL_PATHNAME,
@@ -320,7 +346,7 @@ void nouveau_register_dsm_handler(void)
 void nouveau_switcheroo_optimus_dsm(void)
 {
 	u32 result = 0;
-	if (!nouveau_dsm_priv.optimus_detected)
+	if (!nouveau_dsm_priv.optimus_detected || nouveau_dsm_priv.optimus_skip_dsm)
 		return;
 
 	if (nouveau_dsm_priv.optimus_flags_detected)
-- 
2.8.2
