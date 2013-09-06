Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:54407 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab3IFROy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:14:54 -0400
Received: by mail-yh0-f41.google.com with SMTP id f73so1317900yha.14
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:14:54 -0700 (PDT)
Subject: [PATCH 11/14] PCI/ACPI: Skip _OSC control tests if _OSC support
 call failed
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:14:51 -0600
Message-ID: <20130906171451.11482.47944.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the _OSC support notification fails, we will never request control
(because "support == OSC_PCI_SEGMENT_GROUPS_SUPPORT", which doesn't include
all the features in ACPI_PCIE_REQ_SUPPORT), so we can return early to
simplify the code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 0e20041..67cc43a 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -363,7 +363,7 @@ EXPORT_SYMBOL(acpi_pci_osc_control_set);
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 int *clear_aspm)
 {
-	u32 support, base_support, control;
+	u32 support, control;
 	acpi_status status;
 	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
@@ -372,7 +372,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
-	support = base_support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+	support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
 	if (pci_ext_cfg_avail())
 		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
 	if (pcie_aspm_support_enabled())
@@ -381,10 +381,10 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		support |= OSC_PCI_MSI_SUPPORT;
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
-		dev_info(&device->dev, "ACPI _OSC support "
-			"notification failed, disabling PCIe ASPM\n");
+		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
+			 acpi_format_exception(status));
 		*no_aspm = 1;
-		support = base_support;
+		return;
 	}
 
 	if (!pcie_ports_disabled

