Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lv Zheng <lv.zheng@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 1/3] ACPICA: Dispatch active GPEs at init time
Date: Thu, 10 Aug 2017 00:30:09 +0200
Message-ID: <46980112.WLPtxWZQ3y@aspire.rjw.lan>
In-Reply-To: <12346760.yAFCnkEgf6@aspire.rjw.lan>
References: <12346760.yAFCnkEgf6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases GPEs are already active when they are enabled by
acpi_ev_initialize_gpe_block() and whatever happens next may depend
on the result of handling the events signaled by them, so the
events should not be discarded (which is what happens currently) and
they should be handled as soon as reasonably possible.

For this reason, modify acpi_ev_initialize_gpe_block() to
dispatch GPEs with the status flag set in-band right after
enabling them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/evgpeblk.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/acpica/evgpeblk.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evgpeblk.c
+++ linux-pm/drivers/acpi/acpica/evgpeblk.c
@@ -440,9 +440,11 @@ acpi_ev_initialize_gpe_block(struct acpi
 			     void *ignored)
 {
 	acpi_status status;
+	acpi_event_status event_status;
 	struct acpi_gpe_event_info *gpe_event_info;
 	u32 gpe_enabled_count;
 	u32 gpe_index;
+	u32 gpe_number;
 	u32 i;
 	u32 j;
 
@@ -470,30 +472,38 @@ acpi_ev_initialize_gpe_block(struct acpi
 
 			gpe_index = (i * ACPI_GPE_REGISTER_WIDTH) + j;
 			gpe_event_info = &gpe_block->event_info[gpe_index];
+			gpe_number = gpe_block->block_base_number + gpe_index;
 
 			/*
 			 * Ignore GPEs that have no corresponding _Lxx/_Exx method
-			 * and GPEs that are used to wake the system
+			 * and GPEs that are used for wakeup
 			 */
-			if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
-			     ACPI_GPE_DISPATCH_NONE)
-			    || (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
-				ACPI_GPE_DISPATCH_HANDLER)
-			    || (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
-				ACPI_GPE_DISPATCH_RAW_HANDLER)
+			if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
+			     ACPI_GPE_DISPATCH_METHOD)
 			    || (gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
 				continue;
 			}
 
+			event_status = 0;
+			(void)acpi_hw_get_gpe_status(gpe_event_info,
+						     &event_status);
+
 			status = acpi_ev_add_gpe_reference(gpe_event_info);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 					"Could not enable GPE 0x%02X",
-					gpe_index +
-					gpe_block->block_base_number));
+					gpe_number));
 				continue;
 			}
 
+			if (event_status & ACPI_EVENT_FLAG_STATUS_SET) {
+				ACPI_INFO(("GPE 0x%02X active on init",
+					   gpe_number));
+				(void)acpi_ev_gpe_dispatch(gpe_block->node,
+							   gpe_event_info,
+							   gpe_number);
+			}
+
 			gpe_enabled_count++;
 		}
 	}

