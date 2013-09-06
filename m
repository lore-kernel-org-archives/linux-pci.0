Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:34178 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab3IFRNn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:13:43 -0400
Received: by mail-yh0-f48.google.com with SMTP id f10so1312056yha.21
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:13:42 -0700 (PDT)
Subject: [PATCH 02/14] ACPI: Rename OSC_QUERY_TYPE to OSC_QUERY_DWORD
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:13:40 -0600
Message-ID: <20130906171340.11482.95044.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

OSC_QUERY_TYPE isn't a "type"; it's an index into the _OSC Capabilities
Buffer of DWORDs.  Rename OSC_QUERY_TYPE, OSC_SUPPORT_TYPE, and
OSC_CONTROL_TYPE to OSC_QUERY_DWORD, etc., to make this clear.
No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/apei/apei-base.c |    6 +++---
 drivers/acpi/bus.c            |   18 +++++++++---------
 drivers/acpi/pci_root.c       |   14 +++++++-------
 include/linux/acpi.h          |    7 ++++---
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 46f80e2..6d2c49b 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -758,9 +758,9 @@ int apei_osc_setup(void)
 		.cap.pointer	= capbuf,
 	};
 
-	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	capbuf[OSC_SUPPORT_TYPE] = 1;
-	capbuf[OSC_CONTROL_TYPE] = 0;
+	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
+	capbuf[OSC_SUPPORT_DWORD] = 1;
+	capbuf[OSC_CONTROL_DWORD] = 0;
 
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle))
 	    || ACPI_FAILURE(acpi_run_osc(handle, &context)))
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index b587ec8..fbcfaa6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -255,7 +255,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context)
 			acpi_print_osc_error(handle, context,
 				"_OSC invalid revision");
 		if (errors & OSC_CAPABILITIES_MASK_ERROR) {
-			if (((u32 *)context->cap.pointer)[OSC_QUERY_TYPE]
+			if (((u32 *)context->cap.pointer)[OSC_QUERY_DWORD]
 			    & OSC_QUERY_ENABLE)
 				goto out_success;
 			status = AE_SUPPORT;
@@ -295,30 +295,30 @@ static void acpi_bus_osc_support(void)
 	};
 	acpi_handle handle;
 
-	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	capbuf[OSC_SUPPORT_TYPE] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
+	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
+	capbuf[OSC_SUPPORT_DWORD] = OSC_SB_PR3_SUPPORT; /* _PR3 is in use */
 #if defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR) ||\
 			defined(CONFIG_ACPI_PROCESSOR_AGGREGATOR_MODULE)
-	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PAD_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PAD_SUPPORT;
 #endif
 
 #if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
-	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PPC_OST_SUPPORT;
 #endif
 
 #ifdef ACPI_HOTPLUG_OST
-	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_HOTPLUG_OST_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 #endif
 
 	if (!ghes_disable)
-		capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_APEI_SUPPORT;
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
 	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
 		u32 *capbuf_ret = context.ret.pointer;
-		if (context.ret.length > OSC_SUPPORT_TYPE)
+		if (context.ret.length > OSC_SUPPORT_DWORD)
 			osc_sb_apei_support_acked =
-				capbuf_ret[OSC_SUPPORT_TYPE] & OSC_SB_APEI_SUPPORT;
+				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
 		kfree(context.ret.pointer);
 	}
 	/* do we need to check other returned cap? Sounds no */
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d3874f4..323afd7 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -158,14 +158,14 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 	support &= OSC_PCI_SUPPORT_MASKS;
 	support |= root->osc_support_set;
 
-	capbuf[OSC_QUERY_TYPE] = OSC_QUERY_ENABLE;
-	capbuf[OSC_SUPPORT_TYPE] = support;
+	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
+	capbuf[OSC_SUPPORT_DWORD] = support;
 	if (control) {
 		*control &= OSC_PCI_CONTROL_MASKS;
-		capbuf[OSC_CONTROL_TYPE] = *control | root->osc_control_set;
+		capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
 	} else {
 		/* Run _OSC query only with existing controls. */
-		capbuf[OSC_CONTROL_TYPE] = root->osc_control_set;
+		capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
 	}
 
 	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
@@ -357,9 +357,9 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 		goto out;
 	}
 
-	capbuf[OSC_QUERY_TYPE] = 0;
-	capbuf[OSC_SUPPORT_TYPE] = root->osc_support_set;
-	capbuf[OSC_CONTROL_TYPE] = ctrl;
+	capbuf[OSC_QUERY_DWORD] = 0;
+	capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
+	capbuf[OSC_CONTROL_DWORD] = ctrl;
 	status = acpi_pci_run_osc(handle, capbuf, mask);
 	if (ACPI_SUCCESS(status))
 		root->osc_control_set = *mask;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 285de6f..3ba9fe3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -300,9 +300,10 @@ struct acpi_osc_context {
 	struct acpi_buffer ret; /* free by caller if success */
 };
 
-#define OSC_QUERY_TYPE			0
-#define OSC_SUPPORT_TYPE 		1
-#define OSC_CONTROL_TYPE		2
+/* Indexes into _OSC Capabilities Buffer (DWORDs 2 & 3 are device-specific) */
+#define OSC_QUERY_DWORD				0	/* DWORD 1 */
+#define OSC_SUPPORT_DWORD 			1	/* DWORD 2 */
+#define OSC_CONTROL_DWORD			2	/* DWORD 3 */
 
 /* _OSC Capabilities DWORD 1: Query/Control and Error Returns (generic) */
 #define OSC_QUERY_ENABLE			0x00000001  /* input */

