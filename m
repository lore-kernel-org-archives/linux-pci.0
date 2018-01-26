Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 5/5] ACPICA: Remove calling of _STA from acpi_get_object_info
Date: Fri, 26 Jan 2018 16:03:00 +0100
Message-Id: <20180126150300.9691-5-hdegoede@redhat.com>
In-Reply-To: <20180126150300.9691-1-hdegoede@redhat.com>
References: <20180126150300.9691-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As the comment above it indicates, acpi_get_object_info is intended for
early probe usage and as such should not call any methods which may rely
on OpRegions, before this commit it was also calling _STA, which on some
systems does rely on OpRegions.

Calling _STA before things are ready leads to errors such as these:

[    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
               [GenericSerialBus] (20170831/evregion-166)
[    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
               (20170831/exfldio-299)
[    0.123618] ACPI Error: Method parse/execution failed
               \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)

End 2015 support for the _SUB method was removed for exactly the same
reason. Removing current_status from struct acpi_device_info only has
a limit impact. Within ACPICA it is only used by 2 debug messages, both
of which are modified to no longer print it with this commit.

Outside of ACPICA, for Linux there is only one user. For which a patch to
remove the dependency on the current_status field is available.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/dbdisply.c |  5 ++---
 drivers/acpi/acpica/nsdumpdv.c |  5 ++---
 drivers/acpi/acpica/nsxfname.c | 19 ++++---------------
 include/acpi/actypes.h         |  2 --
 4 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index 5a606eac0c22..7b5eb33fe962 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -642,9 +642,8 @@ void acpi_db_display_object_type(char *object_arg)
 		return;
 	}
 
-	acpi_os_printf("ADR: %8.8X%8.8X, STA: %8.8X, Flags: %X\n",
-		       ACPI_FORMAT_UINT64(info->address),
-		       info->current_status, info->flags);
+	acpi_os_printf("ADR: %8.8X%8.8X, Flags: %X\n",
+		       ACPI_FORMAT_UINT64(info->address), info->flags);
 
 	acpi_os_printf("S1D-%2.2X S2D-%2.2X S3D-%2.2X S4D-%2.2X\n",
 		       info->highest_dstates[0], info->highest_dstates[1],
diff --git a/drivers/acpi/acpica/nsdumpdv.c b/drivers/acpi/acpica/nsdumpdv.c
index 5026594763ea..573a5f36f01a 100644
--- a/drivers/acpi/acpica/nsdumpdv.c
+++ b/drivers/acpi/acpica/nsdumpdv.c
@@ -88,10 +88,9 @@ acpi_ns_dump_one_device(acpi_handle obj_handle,
 		}
 
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_TABLES,
-				      "    HID: %s, ADR: %8.8X%8.8X, Status: %X\n",
+				      "    HID: %s, ADR: %8.8X%8.8X\n",
 				      info->hardware_id.value,
-				      ACPI_FORMAT_UINT64(info->address),
-				      info->current_status));
+				      ACPI_FORMAT_UINT64(info->address));
 		ACPI_FREE(info);
 	}
 
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 106966235805..0a9c600c2599 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -241,7 +241,7 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
  *              namespace node and possibly by running several standard
  *              control methods (Such as in the case of a device.)
  *
- * For Device and Processor objects, run the Device _HID, _UID, _CID, _STA,
+ * For Device and Processor objects, run the Device _HID, _UID, _CID,
  * _CLS, _ADR, _sx_w, and _sx_d methods.
  *
  * Note: Allocates the return buffer, must be freed by the caller.
@@ -250,8 +250,9 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
  * discovery namespace traversal. Therefore, no complex methods can be
  * executed, especially those that access operation regions. Therefore, do
  * not add any additional methods that could cause problems in this area.
- * this was the fate of the _SUB method which was found to cause such
- * problems and was removed (11/2015).
+ * Because of this reason support for the following methods has been removed:
+ * 1) _SUB method was removed (11/2015)
+ * 2) _STA method was removed (01/2018)
  *
  ******************************************************************************/
 
@@ -374,20 +375,8 @@ acpi_get_object_info(acpi_handle handle,
 		 * Notes: none of these methods are required, so they may or may
 		 * not be present for this device. The Info->Valid bitfield is used
 		 * to indicate which methods were found and run successfully.
-		 *
-		 * For _STA, if the method does not exist, then (as per the ACPI
-		 * specification), the returned current_status flags will indicate
-		 * that the device is present/functional/enabled. Otherwise, the
-		 * current_status flags reflect the value returned from _STA.
 		 */
 
-		/* Execute the Device._STA method */
-
-		status = acpi_ut_execute_STA(node, &info->current_status);
-		if (ACPI_SUCCESS(status)) {
-			valid |= ACPI_VALID_STA;
-		}
-
 		/* Execute the Device._ADR method */
 
 		status = acpi_ut_evaluate_numeric_object(METHOD_NAME__ADR, node,
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 4f077edb9b81..220ef8674763 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1191,7 +1191,6 @@ struct acpi_device_info {
 	u8 flags;		/* Miscellaneous info */
 	u8 highest_dstates[4];	/* _sx_d values: 0xFF indicates not valid */
 	u8 lowest_dstates[5];	/* _sx_w values: 0xFF indicates not valid */
-	u32 current_status;	/* _STA value */
 	u64 address;	/* _ADR value */
 	struct acpi_pnp_device_id hardware_id;	/* _HID value */
 	struct acpi_pnp_device_id unique_id;	/* _UID value */
@@ -1205,7 +1204,6 @@ struct acpi_device_info {
 
 /* Flags for Valid field above (acpi_get_object_info) */
 
-#define ACPI_VALID_STA                  0x0001
 #define ACPI_VALID_ADR                  0x0002
 #define ACPI_VALID_HID                  0x0004
 #define ACPI_VALID_UID                  0x0008
-- 
2.14.3

