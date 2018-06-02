Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH v1 2/2] PCI: shpchp: Fix AMD POGO identification
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Date: Sat, 02 Jun 2018 00:42:12 -0500
Message-ID: <152791813206.257724.14863139556803168986.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The fix for an AMD POGO erratum related to SHPC incorrectly identified the
device.  The workaround should be applied only for AMD POGO devices, but it
was instead applied to:

  - all AMD bridges, and
  - all devices from any vendor with device ID 0x7458

Fixes: 53044f357448 ("[PATCH] PCI Hotplug: shpchp: AMD POGO errata fix")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/shpchp_ctrl.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index bedda5bda910..1047b56e5730 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -585,13 +585,13 @@ static int shpchp_enable_slot (struct slot *p_slot)
 	ctrl_dbg(ctrl, "%s: p_slot->pwr_save %x\n", __func__, p_slot->pwr_save);
 	p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 
-	if (((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD) ||
-	    (p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458))
+	if ((p_slot->ctrl->pci_dev->vendor == PCI_VENDOR_ID_AMD &&
+	     p_slot->ctrl->pci_dev->device == PCI_DEVICE_ID_AMD_POGO_7458)
 	     && p_slot->ctrl->num_slots == 1) {
-		/* handle amd pogo errata; this must be done before enable  */
+		/* handle AMD POGO errata; this must be done before enable  */
 		amd_pogo_errata_save_misc_reg(p_slot);
 		retval = board_added(p_slot);
-		/* handle amd pogo errata; this must be done after enable  */
+		/* handle AMD POGO errata; this must be done after enable  */
 		amd_pogo_errata_restore_misc_reg(p_slot);
 	} else
 		retval = board_added(p_slot);

