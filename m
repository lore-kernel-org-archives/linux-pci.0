Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vga_switcheroo: add power support for windows 10 machines.
Date: Wed,  9 Mar 2016 16:14:04 +1000
Message-Id: <1457504045-12738-1-git-send-email-airlied@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Airlie <airlied@redhat.com>

Windows 10 seems to have standardised power control for the
optimus/powerxpress laptops using PR3 power resource hooks.

I'm not sure this is definitely the correct place to be
doing this, but it works for me here.

The ACPI device for the GPU I have is \_SB_.PCI0.PEG_.VID_
but the power resource hooks are on \_SB_.PCI0.PEG_, so
this patch creates a new power domain to turn the GPU
device parent off using standard ACPI calls.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/vga/vga_switcheroo.c | 54 +++++++++++++++++++++++++++++++++++++++-
 include/linux/vga_switcheroo.h   |  3 ++-
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 665ab9f..be32cb2 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -42,7 +42,7 @@
 #include <linux/uaccess.h>
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
-
+#include <linux/acpi.h>
 /**
  * DOC: Overview
  *
@@ -997,3 +997,55 @@ vga_switcheroo_init_domain_pm_optimus_hdmi_audio(struct device *dev,
 	return -EINVAL;
 }
 EXPORT_SYMBOL(vga_switcheroo_init_domain_pm_optimus_hdmi_audio);
+
+/* With Windows 10 the runtime suspend/resume can use power
+   resources on the parent device */
+static int vga_acpi_switcheroo_runtime_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+	struct acpi_device *adev;
+
+	ret = dev->bus->pm->runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev);
+	if (!ret)
+		acpi_device_set_power(adev->parent, ACPI_STATE_D3_COLD);
+	return 0;
+}
+
+static int vga_acpi_switcheroo_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct acpi_device *adev;
+	int ret;
+
+	ret = acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev);
+	if (!ret)
+		acpi_device_set_power(adev->parent, ACPI_STATE_D0);
+	ret = dev->bus->pm->runtime_resume(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int vga_switcheroo_init_parent_pr3_ops(struct device *dev,
+				       struct dev_pm_domain *domain)
+
+{
+	/* copy over all the bus versions */
+	if (dev->bus && dev->bus->pm) {
+		domain->ops = *dev->bus->pm;
+		domain->ops.runtime_suspend = vga_acpi_switcheroo_runtime_suspend;
+		domain->ops.runtime_resume = vga_acpi_switcheroo_runtime_resume;
+
+		dev_pm_domain_set(dev, domain);
+		return 0;
+	}
+	dev_pm_domain_set(dev, NULL);
+	return -EINVAL;
+}
+EXPORT_SYMBOL(vga_switcheroo_init_parent_pr3_ops);
diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switcheroo.h
index 69e1d4a1..5ce0cbe 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -144,6 +144,7 @@ void vga_switcheroo_set_dynamic_switch(struct pci_dev *pdev, enum vga_switcheroo
 int vga_switcheroo_init_domain_pm_ops(struct device *dev, struct dev_pm_domain *domain);
 void vga_switcheroo_fini_domain_pm_ops(struct device *dev);
 int vga_switcheroo_init_domain_pm_optimus_hdmi_audio(struct device *dev, struct dev_pm_domain *domain);
+int vga_switcheroo_init_parent_pr3_ops(struct device *dev, struct dev_pm_domain *domain);
 #else
 
 static inline void vga_switcheroo_unregister_client(struct pci_dev *dev) {}
@@ -163,6 +164,6 @@ static inline void vga_switcheroo_set_dynamic_switch(struct pci_dev *pdev, enum
 static inline int vga_switcheroo_init_domain_pm_ops(struct device *dev, struct dev_pm_domain *domain) { return -EINVAL; }
 static inline void vga_switcheroo_fini_domain_pm_ops(struct device *dev) {}
 static inline int vga_switcheroo_init_domain_pm_optimus_hdmi_audio(struct device *dev, struct dev_pm_domain *domain) { return -EINVAL; }
-
+static inline int vga_switcheroo_init_parent_pr3_ops(struct device *dev, struct dev_pm_domain *domain) { return -EINVAL; }
 #endif
 #endif /* _LINUX_VGA_SWITCHEROO_H_ */
-- 
2.5.0

