Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933532AbcK2Snf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Nov 2016 13:43:35 -0500
Subject: [PATCH 1/2] ACPI: Combine acpi_dev_resource_address_space() and
 acpi_dev_resource_ext_address_space()
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org
Date: Tue, 29 Nov 2016 12:43:26 -0600
Message-ID: <20161129184326.7618.60729.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Previously acpi_dev_resource_address_space() and
acpi_dev_resource_ext_address_space() were wrappers that called
acpi_decode_space().  We need to distinguish between Word/DWord/QWord
address descriptors and Extended address descriptors, which was impossible
in acpi_decode_space().

Fold the acpi_dev_resource_address_space() and
acpi_dev_resource_ext_address_space() functionality into
acpi_decode_space() and call the result acpi_dev_resource_address_space().

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/ioapic.c          |    3 -
 drivers/acpi/resource.c        |  114 ++++++++++++++++------------------------
 drivers/pnp/pnpacpi/rsparser.c |    3 -
 include/linux/acpi.h           |    2 -
 4 files changed, 48 insertions(+), 74 deletions(-)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 6d7ce6e..6d91417 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -50,8 +50,7 @@ static acpi_status setup_res(struct acpi_resource *acpi_res, void *data)
 		return AE_OK;
 
 	if (!acpi_dev_resource_memory(acpi_res, res)) {
-		if (acpi_dev_resource_address_space(acpi_res, &win) ||
-		    acpi_dev_resource_ext_address_space(acpi_res, &win))
+		if (acpi_dev_resource_address_space(acpi_res, &win))
 			*res = win.res;
 	}
 	if ((res->flags & IORESOURCE_PREFETCH) ||
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 56241eb..2732d39e 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -197,16 +197,54 @@ bool acpi_dev_resource_io(struct acpi_resource *ares, struct resource *res)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_resource_io);
 
-static bool acpi_decode_space(struct resource_win *win,
-			      struct acpi_resource_address *addr,
-			      struct acpi_address64_attribute *attr)
+/**
+ * acpi_dev_resource_address_space - Extract ACPI address space information.
+ * @ares: Input ACPI resource object.
+ * @win: Output generic resource object.
+ *
+ * Check if the given ACPI resource object represents an address space resource
+ * and if that's the case, use the information in it to populate the generic
+ * resource object pointed to by @win.
+ *
+ * Return:
+ * 1) false with win->res.flags setting to zero: not the expected resource type
+ * 2) false with IORESOURCE_DISABLED in win->res.flags: valid unassigned
+ *    resource
+ * 3) true: valid assigned resource
+ XXX check these return values
+ */
+bool acpi_dev_resource_address_space(struct acpi_resource *ares,
+				     struct resource_win *win)
 {
-	u8 iodec = attr->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16;
-	bool wp = addr->info.mem.write_protect;
-	u64 len = attr->address_length;
-	u64 start, end, offset = 0;
+	struct acpi_resource_address *addr;
+	struct acpi_address64_attribute *attr;
+	struct acpi_resource_extended_address64 *ext_addr;
+	struct acpi_resource_address64 addr64;
+	acpi_status status;
+	u8 iodec;
+	bool wp;
+	u64 len, start, end, offset = 0;
 	struct resource *res = &win->res;
 
+	win->res.flags = 0;
+
+	if (ares->type == ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64) {
+		ext_addr = &ares->data.ext_address64;
+		addr = (struct acpi_resource_address *)ext_addr;
+		attr = &ext_addr->address;
+	} else {
+		status = acpi_resource_to_address64(ares, &addr64);
+		if (ACPI_FAILURE(status))
+			return false;
+
+		addr = (struct acpi_resource_address *)&addr64;
+		attr = &addr64.address;
+	}
+
+	iodec = attr->granularity == 0xfff ? ACPI_DECODE_10 : ACPI_DECODE_16;
+	wp = addr->info.mem.write_protect;
+	len = attr->address_length;
+
 	/*
 	 * Filter out invalid descriptor according to ACPI Spec 5.0, section
 	 * 6.4.3.5 Address Space Resource Descriptors.
@@ -264,68 +302,9 @@ static bool acpi_decode_space(struct resource_win *win,
 
 	return !(res->flags & IORESOURCE_DISABLED);
 }
-
-/**
- * acpi_dev_resource_address_space - Extract ACPI address space information.
- * @ares: Input ACPI resource object.
- * @win: Output generic resource object.
- *
- * Check if the given ACPI resource object represents an address space resource
- * and if that's the case, use the information in it to populate the generic
- * resource object pointed to by @win.
- *
- * Return:
- * 1) false with win->res.flags setting to zero: not the expected resource type
- * 2) false with IORESOURCE_DISABLED in win->res.flags: valid unassigned
- *    resource
- * 3) true: valid assigned resource
- */
-bool acpi_dev_resource_address_space(struct acpi_resource *ares,
-				     struct resource_win *win)
-{
-	struct acpi_resource_address64 addr;
-
-	win->res.flags = 0;
-	if (ACPI_FAILURE(acpi_resource_to_address64(ares, &addr)))
-		return false;
-
-	return acpi_decode_space(win, (struct acpi_resource_address *)&addr,
-				 &addr.address);
-}
 EXPORT_SYMBOL_GPL(acpi_dev_resource_address_space);
 
 /**
- * acpi_dev_resource_ext_address_space - Extract ACPI address space information.
- * @ares: Input ACPI resource object.
- * @win: Output generic resource object.
- *
- * Check if the given ACPI resource object represents an extended address space
- * resource and if that's the case, use the information in it to populate the
- * generic resource object pointed to by @win.
- *
- * Return:
- * 1) false with win->res.flags setting to zero: not the expected resource type
- * 2) false with IORESOURCE_DISABLED in win->res.flags: valid unassigned
- *    resource
- * 3) true: valid assigned resource
- */
-bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
-					 struct resource_win *win)
-{
-	struct acpi_resource_extended_address64 *ext_addr;
-
-	win->res.flags = 0;
-	if (ares->type != ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64)
-		return false;
-
-	ext_addr = &ares->data.ext_address64;
-
-	return acpi_decode_space(win, (struct acpi_resource_address *)ext_addr,
-				 &ext_addr->address);
-}
-EXPORT_SYMBOL_GPL(acpi_dev_resource_ext_address_space);
-
-/**
  * acpi_dev_irq_flags - Determine IRQ resource flags.
  * @triggering: Triggering type as provided by ACPI.
  * @polarity: Interrupt polarity as provided by ACPI.
@@ -542,8 +521,7 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
 
 	if (acpi_dev_resource_memory(ares, res)
 	    || acpi_dev_resource_io(ares, res)
-	    || acpi_dev_resource_address_space(ares, &win)
-	    || acpi_dev_resource_ext_address_space(ares, &win))
+	    || acpi_dev_resource_address_space(ares, &win))
 		return acpi_dev_new_resource_entry(&win, c);
 
 	for (i = 0; acpi_dev_resource_interrupt(ares, i, res); i++) {
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 4b717c6..bc61651 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -184,8 +184,7 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
 	struct resource *r = &win.res;
 	int i, flags;
 
-	if (acpi_dev_resource_address_space(res, &win)
-	    || acpi_dev_resource_ext_address_space(res, &win)) {
+	if (acpi_dev_resource_address_space(res, &win)) {
 		pnp_add_resource(dev, &win.res);
 		return AE_OK;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddbeda6..a06a877 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -399,8 +399,6 @@ bool acpi_dev_resource_memory(struct acpi_resource *ares, struct resource *res);
 bool acpi_dev_resource_io(struct acpi_resource *ares, struct resource *res);
 bool acpi_dev_resource_address_space(struct acpi_resource *ares,
 				     struct resource_win *win);
-bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
-					 struct resource_win *win);
 unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
 unsigned int acpi_dev_get_irq_type(int triggering, int polarity);
 bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,

