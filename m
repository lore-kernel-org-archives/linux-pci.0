Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:57658 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab3IFROr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:14:47 -0400
Received: by mail-yh0-f52.google.com with SMTP id v1so1294455yhn.39
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:14:46 -0700 (PDT)
Subject: [PATCH 10/14] PCI/ACPI: Run _OSC only once for OSPM feature support
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:14:44 -0600
Message-ID: <20130906171444.11482.59374.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously, we ran _OSC once to tell the platform that we support
PCI Segment Groups, then we ran it again if we supported any additional
features (ASPM, MSI, or extended config space).  I don't think it's
necessary to run it twice, since we can easily build the complete
mask of features we support before running _OSC the first time.

We run _OSC again later when requesting control of PCIe features;
that's unaffected by this change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 3e06d4e..0e20041 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -373,23 +373,18 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
 	support = base_support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
-	acpi_pci_osc_support(root, support);
-
 	if (pci_ext_cfg_avail())
 		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
-	if (pcie_aspm_support_enabled()) {
+	if (pcie_aspm_support_enabled())
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
-	}
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
-	if (support != base_support) {
-		status = acpi_pci_osc_support(root, support);
-		if (ACPI_FAILURE(status)) {
-			dev_info(&device->dev, "ACPI _OSC support "
-				"notification failed, disabling PCIe ASPM\n");
-			*no_aspm = 1;
-			support = base_support;
-		}
+	status = acpi_pci_osc_support(root, support);
+	if (ACPI_FAILURE(status)) {
+		dev_info(&device->dev, "ACPI _OSC support "
+			"notification failed, disabling PCIe ASPM\n");
+		*no_aspm = 1;
+		support = base_support;
 	}
 
 	if (!pcie_ports_disabled

