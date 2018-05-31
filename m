Return-Path: <SRS0=cmb1=IS=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=cmb1=IS=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 31 May 2018 16:51:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 2/7] PCI: Introduce shpchp_is_native()
Message-ID: <20180531135117.GX15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180528124756.78512-3-mika.westerberg@linux.intel.com>
 <20180530202343.GO39853@bhelgaas-glaptop.roam.corp.google.com>
 <20180531065852.GV15419@lahna.fi.intel.com>
 <20180531131202.GA76395@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180531131202.GA76395@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 31, 2018 at 08:12:02AM -0500, Bjorn Helgaas wrote:
> Maybe I'm reading your patches wrong.  It looks to me like shpchp will
> claim GOLAM_7450, which means shpchp will register slots, program the
> SHPC, handle hotplug interrupts, etc.
> 
> But since shpchp_is_native() returns false, acpiphp thinks *it* should
> handle hotplug.  For example, I think that given some ACPI
> prerequisites (_EJ0/_RMV/etc), both will call pci_hp_register():
> 
>   shpc_probe
>     is_shpc_capable             # true for GOLAM_7450
>     init_slots
>       pci_hp_register
> 
>   acpi_pci_add_slots
>     acpiphp_enumerate_slots
>       acpi_walk_namespace(..., acpiphp_add_context)
>         acpiphp_add_context
>           hotplug_is_native     # false for GOLAM_7450
>           acpiphp_register_hotplug_slot
>             pci_hp_register
> 
> It is true that the same situation occurred before your patches, since
> acpiphp_add_context() only checked pciehp_is_native().  In fact, with
> the existing code, shpchp and acpiphp could both try to manage *any*
> SHPC, not just GOLAM_7450.
> 
> I think the current series fixes 99% of that problem and it seems like
> we should try to do that last 1% at the same time so the SHPC code
> makes more sense.

Would the following fix the last 1% for you? Applies on top of this
patch.

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 9675ab757323..516e4835019c 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -105,7 +105,6 @@ struct controller {
 };
 
 /* Define AMD SHPC ID  */
-#define PCI_DEVICE_ID_AMD_GOLAM_7450	0x7450
 #define PCI_DEVICE_ID_AMD_POGO_7458	0x7458
 
 /* AMD PCI-X bridge registers */
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 0f3711404c2b..e91be287f292 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -270,22 +270,12 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	return 0;
 }
 
-static int is_shpc_capable(struct pci_dev *dev)
-{
-	if (dev->vendor == PCI_VENDOR_ID_AMD &&
-	    dev->device == PCI_DEVICE_ID_AMD_GOLAM_7450)
-		return 1;
-	if (acpi_get_hp_hw_control_from_firmware(dev))
-		return 0;
-	return 1;
-}
-
 static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int rc;
 	struct controller *ctrl;
 
-	if (!is_shpc_capable(pdev))
+	if (acpi_get_hp_hw_control_from_firmware(pdev))
 		return -ENODEV;
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index bbc4ea70505a..fd1c0ee33805 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -408,6 +408,14 @@ bool shpchp_is_native(struct pci_dev *bridge)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		return false;
 
+	/*
+	 * It is assumed that AMD GOLAM chips support SHPC but they do not
+	 * have SHPC capability.
+	 */
+	if (bridge->vendor == PCI_VENDOR_ID_AMD &&
+	    bridge->device == PCI_DEVICE_ID_AMD_GOLAM_7450)
+		return true;
+
 	if (!pci_find_capability(bridge, PCI_CAP_ID_SHPC))
 		return false;
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 883cb7bf78aa..5aace6cca0d7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -561,6 +561,7 @@
 #define PCI_DEVICE_ID_AMD_OPUS_7443	0x7443
 #define PCI_DEVICE_ID_AMD_VIPER_7443	0x7443
 #define PCI_DEVICE_ID_AMD_OPUS_7445	0x7445
+#define PCI_DEVICE_ID_AMD_GOLAM_7450	0x7450
 #define PCI_DEVICE_ID_AMD_8111_PCI	0x7460
 #define PCI_DEVICE_ID_AMD_8111_LPC	0x7468
 #define PCI_DEVICE_ID_AMD_8111_IDE	0x7469
