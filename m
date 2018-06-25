Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933587AbeFYOB0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 10:01:26 -0400
Date: Mon, 25 Jun 2018 09:01:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: shpchp: Fix probing logic inversion
Message-ID: <20180625140122.GF108993@bhelgaas-glaptop.roam.corp.google.com>
References: <20180621164715.28160-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180621164715.28160-1-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

Sorry we broke this!

On Thu, Jun 21, 2018 at 05:47:15PM +0100, Marc Zyngier wrote:
> Until recently, shpc_probe() would bail out pretty early in the
> absence of the SHPC capability. A logic change in the way the
> driver now checks that capability makes it go and probe the
> firmware anyway, with ugly consequences if the system is not
> ACPI based (my arm64 ThunderX is DT driven, and explodes in
> a spectacular way after getting a NULL root bridge from the
> non-existent ACPI tables...).
>
> Take this opportunity to move the call to shpchp_is_native()
> back into shpc_probe(), making it clear that a non-ACPI system
> is not expected to use this driver.

But a non-ACPI system *should* be able to use SHPC.

Here's my understanding of how it should work.  On an ACPI system,

  - If firmware has _OSC, the OS calls it to request permission to
    manage the SHPC.  If _OSC grants permission, it should also
    configure the hardware (interrupts, etc) to give the OS.
    
  - If there's no _OSC, shpchp assumes it's allowed to manage the
    SHPC, and it calls OSHP to configure the hardware appropriately.

On a non-ACPI system, shpchp assumes there's no firmware involved at
all, so it can manage the SHPC without doing anything special.

I see Mika has already posted a patch similar to the first one
below; I think either of those should fix the problem you're seeing.

The second is an attempt to clean things up so they make a
little more sense.

Bjorn


commit 7780896578a93fdec2b345def554355168cceee4
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Jun 25 08:17:33 2018 -0500

    PCI: shpchp: Manage SHPC unconditionally on non-ACPI systems
    
    If CONFIG_ACPI=y but the current hardware/firmware platform doesn't support
    ACPI, acpi_get_hp_hw_control_from_firmware() is implemented and causes a
    NULL pointer dereference  because acpi_pci_find_root() returns NULL.
    
    If acpi_pci_find_root() returns NULL, it means there's no ACPI host bridge
    device (PNP0A03 or PNP0A08), and the OS is always allowed to manage the
    SHPC, so return success in that case.

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 3979f89b250a..912d0de29caa 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -87,8 +87,17 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 		return 0;
 
 	/* If _OSC exists, we should not evaluate OSHP */
+
+	/*
+	 * If there's no ACPI host bridge (i.e., ACPI support is compiled
+	 * into the kernel but the hardware platform doesn't support ACPI),
+	 * there's nothing to do here.
+	 */
 	host = pci_find_host_bridge(pdev->bus);
 	root = acpi_pci_find_root(ACPI_HANDLE(&host->dev));
+	if (!root)
+		return 0;
+
 	if (root->osc_support_set)
 		goto no_control;
 

commit 82ca61ebf1e38bc05753d38103791f48f6a09d91
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Jun 22 17:48:11 2018 -0500

    PCI: shpchp: Separate existence of SHPC and permission to use it
    
    The shpchp driver registers for all PCI bridge devices.  Its probe method
    should fail if either (1) the bridge doesn't have an SHPC or (2) the OS
    isn't allowed to use it.
    
    Separate these two tests into:
    
      - A new shpc_capable() that looks for the SHPC hardware and is applicable
        on all systems, and
    
      - A simplified acpi_get_hp_hw_control_from_firmware() that we call only
        when we already know an SHPC exists and there may be ACPI methods to
        either request permission to use it (_OSC) or transfer control to the
        OS (OSHP).

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 912d0de29caa..bd7358bcb2ea 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -74,20 +74,6 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 	acpi_handle chandle, handle;
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	/*
-	 * Per PCI firmware specification, we should run the ACPI _OSC
-	 * method to get control of hotplug hardware before using it. If
-	 * an _OSC is missing, we look for an OSHP to do the same thing.
-	 * To handle different BIOS behavior, we look for _OSC on a root
-	 * bridge preferentially (according to PCI fw spec). Later for
-	 * OSHP within the scope of the hotplug controller and its parents,
-	 * up to the host bridge under which this controller exists.
-	 */
-	if (shpchp_is_native(pdev))
-		return 0;
-
-	/* If _OSC exists, we should not evaluate OSHP */
-
 	/*
 	 * If there's no ACPI host bridge (i.e., ACPI support is compiled
 	 * into the kernel but the hardware platform doesn't support ACPI),
@@ -98,9 +84,25 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 	if (!root)
 		return 0;
 
-	if (root->osc_support_set)
-		goto no_control;
+	/*
+	 * If _OSC exists, it determines whether we're allowed to manage
+	 * the SHPC.  We executed it while enumerating the host bridge.
+	 */
+	if (root->osc_support_set) {
+		if (host->native_shpc_hotplug)
+			return 0;
+		return -ENODEV;
+	}
 
+	/*
+	 * In the absence of _OSC, we're always allowed to manage the SHPC.
+	 * However, if an OSHP method is present, we must execute it so the
+	 * firmware can transfer control to the OS, e.g., direct interrupts
+	 * to the OS instead of to the firmware.
+	 *
+	 * N.B. The PCI Firmware Spec (r3.2, sec 4.8) does not endorse
+	 * searching up the ACPI hierarchy, so the loops below are suspect.
+	 */
 	handle = ACPI_HANDLE(&pdev->dev);
 	if (!handle) {
 		/*
@@ -129,7 +131,7 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 		if (ACPI_FAILURE(status))
 			break;
 	}
-no_control:
+
 	pci_info(pdev, "Cannot get control of SHPC hotplug\n");
 	kfree(string.pointer);
 	return -ENODEV;
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index e91be287f292..7eb44fdc4445 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -270,11 +270,30 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	return 0;
 }
 
+static bool shpc_capable(struct pci_dev *bridge)
+{
+	/*
+	 * It is assumed that AMD GOLAM chips support SHPC but they do not
+	 * have SHPC capability.
+	 */
+	if (bridge->vendor == PCI_VENDOR_ID_AMD &&
+	    bridge->device == PCI_DEVICE_ID_AMD_GOLAM_7450)
+		return true;
+
+	if (pci_find_capability(bridge, PCI_CAP_ID_SHPC))
+		return true;
+
+	return false;
+}
+
 static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int rc;
 	struct controller *ctrl;
 
+	if (!shpc_capable(pdev))
+		return -ENODEV;
+
 	if (acpi_get_hp_hw_control_from_firmware(pdev))
 		return -ENODEV;
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 65113b6eed14..b10dd6caeda1 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -408,17 +408,6 @@ bool shpchp_is_native(struct pci_dev *bridge)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		return false;
 
-	/*
-	 * It is assumed that AMD GOLAM chips support SHPC but they do not
-	 * have SHPC capability.
-	 */
-	if (bridge->vendor == PCI_VENDOR_ID_AMD &&
-	    bridge->device == PCI_DEVICE_ID_AMD_GOLAM_7450)
-		return true;
-
-	if (!pci_find_capability(bridge, PCI_CAP_ID_SHPC))
-		return false;
-
 	host = pci_find_host_bridge(bridge->bus);
 	return host->native_shpc_hotplug;
 }
