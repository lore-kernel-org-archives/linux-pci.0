Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:39357 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795Ab3DJPLh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2013 11:11:37 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so657947ieb.37
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2013 08:11:37 -0700 (PDT)
Date: Wed, 10 Apr 2013 09:11:33 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: FAILED: Patch Upstream: Revert "PCI/ACPI: Request _OSC control
 before scanning PCI root bus"
Message-ID: <20130410151133.GA4534@google.com>
References: <20130406030022.8D4132A64@git.kroah.org>
 <20130409220525.GC6877@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130409220525.GC6877@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 09, 2013 at 03:05:25PM -0700, Greg KH wrote:
> I tried to apply the patch below to the 3.8-stable tree, but it has
> conflicts and doesn't apply.  So I tried a straight-revert of
> 8c33f51df406e1a1f7fa4e9b244845b7ebd61fa6, which did work fine, but I
> noticed that it really doesn't look anything like the patch below.
> 
> Is this patch a "logical" revert, and not a "literal" one?
> 
> Anyway, can someone send me a properly backported version so it can be
> applied to the 3.8-stable tree?

Here's a literal revert for v3.8.


commit 59bf5ae30b63368cca7f1c16d1ecfeed37fd128e
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue Apr 9 16:22:21 2013 -0600

    Revert "PCI/ACPI: Request _OSC control before scanning PCI root bus"
    
    This reverts commit 8c33f51df406e1a1f7fa4e9b244845b7ebd61fa6.
    
    This commit broke some pre-1.1 PCIe devices by leaving them with
    ASPM enabled.  Previously, we had disabled ASPM on these devices
    because many of them don't implement it correctly (per 149e1637).
    
    Requesting _OSC control early means that aspm_disabled may be set
    before we scan the PCI bus and configure link ASPM state.  But the
    ASPM configuration currently skips the check for pre-PCIe 1.1 devices
    when aspm_disabled is set, like this:
    
        acpi_pci_root_add
          acpi_pci_osc_support
            if (flags != base_flags)
              pcie_no_aspm
                aspm_disabled = 1
          pci_acpi_scan_root
            ...
              pcie_aspm_init_link_state
                pcie_aspm_sanity_check
                  if (!aspm_disabled)
                    /* check for pre-PCIe 1.1 device */
    
    Therefore, setting aspm_disabled early means that we leave ASPM enabled
    on these pre-PCIe 1.1 devices, which is a regression for some devices.
    
    The best fix would be to clean up the ASPM init so we can evaluate
    _OSC before scanning the bug (that way boot-time and hot-add discovery
    will work the same), but that requires significant rework.
    
    For now, we'll just revert the _OSC change as the lowest-risk fix.
    
    Reference: https://bugzilla.kernel.org/show_bug.cgi?id=55211
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7928d4d..eb73798 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -454,7 +454,6 @@ static int acpi_pci_root_add(struct acpi_device *device)
 	acpi_handle handle;
 	struct acpi_device *child;
 	u32 flags, base_flags;
-	bool is_osc_granted = false;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
@@ -525,60 +524,6 @@ static int acpi_pci_root_add(struct acpi_device *device)
 	flags = base_flags = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
 	acpi_pci_osc_support(root, flags);
 
-	/* Indicate support for various _OSC capabilities. */
-	if (pci_ext_cfg_avail())
-		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
-	if (pcie_aspm_support_enabled()) {
-		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
-		OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
-	}
-	if (pci_msi_enabled())
-		flags |= OSC_MSI_SUPPORT;
-	if (flags != base_flags) {
-		status = acpi_pci_osc_support(root, flags);
-		if (ACPI_FAILURE(status)) {
-			dev_info(&device->dev, "ACPI _OSC support "
-				"notification failed, disabling PCIe ASPM\n");
-			pcie_no_aspm();
-			flags = base_flags;
-		}
-	}
-	if (!pcie_ports_disabled
-	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
-		flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
-			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
-			| OSC_PCI_EXPRESS_PME_CONTROL;
-
-		if (pci_aer_available()) {
-			if (aer_acpi_firmware_first())
-				dev_dbg(&device->dev,
-					"PCIe errors handled by BIOS.\n");
-			else
-				flags |= OSC_PCI_EXPRESS_AER_CONTROL;
-		}
-
-		dev_info(&device->dev,
-			"Requesting ACPI _OSC control (0x%02x)\n", flags);
-
-		status = acpi_pci_osc_control_set(device->handle, &flags,
-				       OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
-		if (ACPI_SUCCESS(status)) {
-			is_osc_granted = true;
-			dev_info(&device->dev,
-				"ACPI _OSC control (0x%02x) granted\n", flags);
-		} else {
-			is_osc_granted = false;
-			dev_info(&device->dev,
-				"ACPI _OSC request failed (%s), "
-				"returned control mask: 0x%02x\n",
-				acpi_format_exception(status), flags);
-		}
-	} else {
-		dev_info(&device->dev,
-			"Unable to request _OSC control "
-			"(_OSC support mask: 0x%02x)\n", flags);
-	}
-
 	/*
 	 * TBD: Need PCI interface for enumeration/configuration of roots.
 	 */
@@ -618,14 +563,66 @@ static int acpi_pci_root_add(struct acpi_device *device)
 	list_for_each_entry(child, &device->children, node)
 		acpi_pci_bridge_scan(child);
 
-	/* ASPM setting */
-	if (is_osc_granted) {
-		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM)
-			pcie_clear_aspm(root->bus);
+	/* Indicate support for various _OSC capabilities. */
+	if (pci_ext_cfg_avail())
+		flags |= OSC_EXT_PCI_CONFIG_SUPPORT;
+	if (pcie_aspm_support_enabled())
+		flags |= OSC_ACTIVE_STATE_PWR_SUPPORT |
+			OSC_CLOCK_PWR_CAPABILITY_SUPPORT;
+	if (pci_msi_enabled())
+		flags |= OSC_MSI_SUPPORT;
+	if (flags != base_flags) {
+		status = acpi_pci_osc_support(root, flags);
+		if (ACPI_FAILURE(status)) {
+			dev_info(root->bus->bridge, "ACPI _OSC support "
+				"notification failed, disabling PCIe ASPM\n");
+			pcie_no_aspm();
+			flags = base_flags;
+		}
+	}
+
+	if (!pcie_ports_disabled
+	    && (flags & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
+		flags = OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
+			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
+			| OSC_PCI_EXPRESS_PME_CONTROL;
+
+		if (pci_aer_available()) {
+			if (aer_acpi_firmware_first())
+				dev_dbg(root->bus->bridge,
+					"PCIe errors handled by BIOS.\n");
+			else
+				flags |= OSC_PCI_EXPRESS_AER_CONTROL;
+		}
+
+		dev_info(root->bus->bridge,
+			"Requesting ACPI _OSC control (0x%02x)\n", flags);
+
+		status = acpi_pci_osc_control_set(device->handle, &flags,
+					OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+		if (ACPI_SUCCESS(status)) {
+			dev_info(root->bus->bridge,
+				"ACPI _OSC control (0x%02x) granted\n", flags);
+			if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
+				/*
+				 * We have ASPM control, but the FADT indicates
+				 * that it's unsupported. Clear it.
+				 */
+				pcie_clear_aspm(root->bus);
+			}
+		} else {
+			dev_info(root->bus->bridge,
+				"ACPI _OSC request failed (%s), "
+				"returned control mask: 0x%02x\n",
+				acpi_format_exception(status), flags);
+			pr_info("ACPI _OSC control for PCIe not granted, "
+				"disabling ASPM\n");
+			pcie_no_aspm();
+		}
 	} else {
-		pr_info("ACPI _OSC control for PCIe not granted, "
-			"disabling ASPM\n");
-		pcie_no_aspm();
+		dev_info(root->bus->bridge,
+			 "Unable to request _OSC control "
+			 "(_OSC support mask: 0x%02x)\n", flags);
 	}
 
 	pci_acpi_add_bus_pm_notifier(device, root->bus);
