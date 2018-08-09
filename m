Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] PCI/ACPI: allow _OSC presence to be optional for PCI
Date: Thu,  9 Aug 2018 18:46:23 +0000
Message-Id: <1533840383-7841-2-git-send-email-okaya@kernel.org>
In-Reply-To: <1533840383-7841-1-git-send-email-okaya@kernel.org>
References: <1533840383-7841-1-git-send-email-okaya@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ACPI Spec 6.0 Section 6.2.11.3 OSC Implementation Example for PCI
Host Bridge Devices:

For a host bridge device that originates a PCI Express hierarchy,
the _OSC interface defined in this section is required.

For a host bridge device that originates a PCI/PCI-X bus hierarchy,
inclusion of an _OSC object is optional.

Allow PCI host bridges to bail out silently if _OSC is not found.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reported-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/acpi/pci_root.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9d738e2..c94ed01 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -421,7 +421,8 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
-static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
+static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
+				 bool is_pcie)
 {
 	u32 support, control, requested;
 	acpi_status status;
@@ -460,9 +461,14 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 		if (pcie_aspm_support_enabled())
 			aspm_msg = "; disabling ASPM";
 
-		dev_info(&device->dev, "_OSC failed (%s) %s\n",
-				 acpi_format_exception(status), aspm_msg);
 		*no_aspm = 1;
+
+		/* _OSC is optional for PCI host bridges */
+		if ((status == AE_NOT_FOUND) && !is_pcie)
+			return;
+
+		dev_info(&device->dev, "_OSC failed (%s) %s\n",
+			 acpi_format_exception(status), aspm_msg);
 		return;
 	}
 
@@ -538,6 +544,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
 	bool hotadd = system_state == SYSTEM_RUNNING;
+	bool is_pcie;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -595,7 +602,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
 
-	negotiate_os_control(root, &no_aspm);
+	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
+	negotiate_os_control(root, &no_aspm, is_pcie);
 
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
-- 
2.7.4

