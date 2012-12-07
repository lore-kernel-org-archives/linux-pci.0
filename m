Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH 12/15] PCI/ACPI: Move where dmi_check_system() is called from
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, yinghai@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Dec 2012 23:26:05 -0700
Message-ID: <20121207062605.11051.84910.stgit@amt.stowe>
In-Reply-To: <20121207062454.11051.12739.stgit@amt.stowe>
References: <20121207062454.11051.12739.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch moves the call of dmi_check_system() from acpi_pci_slot_init()
to acpi_pci_slot_add().  This is in preparation for converting the
"pci_slot" sub-driver to being statically built into the kernel.

No functional change.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 drivers/acpi/pci_slot.c |   57 ++++++++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/pci_slot.c b/drivers/acpi/pci_slot.c
index d22585f..efa58af 100644
--- a/drivers/acpi/pci_slot.c
+++ b/drivers/acpi/pci_slot.c
@@ -265,6 +265,31 @@ walk_root_bridge(struct acpi_pci_root *root, acpi_walk_callback user_function)
 	return status;
 }
 
+static int do_sta_before_sun(const struct dmi_system_id *d)
+{
+	info("%s detected: will evaluate _STA before calling _SUN\n", d->ident);
+	check_sta_before_sun = 1;
+	return 0;
+}
+
+static struct dmi_system_id acpi_pci_slot_dmi_table[] = {
+	/*
+	 * Fujitsu Primequest machines will return 1023 to indicate an
+	 * error if the _SUN method is evaluated on SxFy objects that
+	 * are not present (as indicated by _STA), so for those machines,
+	 * we want to check _STA before evaluating _SUN.
+	 */
+	{
+	 .callback = do_sta_before_sun,
+	 .ident = "Fujitsu PRIMEQUEST",
+	 .matches = {
+		DMI_MATCH(DMI_BIOS_VENDOR, "FUJITSU LIMITED"),
+		DMI_MATCH(DMI_BIOS_VERSION, "PRIMEQUEST"),
+		},
+	},
+	{}
+};
+
 /*
  * acpi_pci_slot_add
  * @handle: points to an acpi_pci_root
@@ -272,8 +297,14 @@ walk_root_bridge(struct acpi_pci_root *root, acpi_walk_callback user_function)
 static int
 acpi_pci_slot_add(struct acpi_pci_root *root)
 {
+	static bool inited = false;
 	acpi_status status;
 
+	if (!inited) {
+		dmi_check_system(acpi_pci_slot_dmi_table);
+		inited = true;
+	}
+
 	status = walk_root_bridge(root, register_slot);
 	if (ACPI_FAILURE(status))
 		err("%s: register_slot failure - %d\n", __func__, status);
@@ -305,35 +336,9 @@ acpi_pci_slot_remove(struct acpi_pci_root *root)
 	mutex_unlock(&slot_list_lock);
 }
 
-static int do_sta_before_sun(const struct dmi_system_id *d)
-{
-	info("%s detected: will evaluate _STA before calling _SUN\n", d->ident);
-	check_sta_before_sun = 1;
-	return 0;
-}
-
-static struct dmi_system_id acpi_pci_slot_dmi_table[] __initdata = {
-	/*
-	 * Fujitsu Primequest machines will return 1023 to indicate an
-	 * error if the _SUN method is evaluated on SxFy objects that
-	 * are not present (as indicated by _STA), so for those machines,
-	 * we want to check _STA before evaluating _SUN.
-	 */
-	{
-	 .callback = do_sta_before_sun,
-	 .ident = "Fujitsu PRIMEQUEST",
-	 .matches = {
-		DMI_MATCH(DMI_BIOS_VENDOR, "FUJITSU LIMITED"),
-		DMI_MATCH(DMI_BIOS_VERSION, "PRIMEQUEST"),
-		},
-	},
-	{}
-};
-
 static int __init
 acpi_pci_slot_init(void)
 {
-	dmi_check_system(acpi_pci_slot_dmi_table);
 	acpi_pci_register_driver(&acpi_pci_slot_driver);
 	return 0;
 }

