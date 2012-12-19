Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:51279 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755723Ab2LSRaq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2012 12:30:46 -0500
Received: by mail-vc0-f202.google.com with SMTP id m8so250790vcd.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Dec 2012 09:30:45 -0800 (PST)
Subject: [PATCH] ACPI: Remove unused struct acpi_pci_root.id member
To: "Rafael J. Wysocki" <rjw@sisk.pl>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 19 Dec 2012 10:30:44 -0700
Message-ID: <20121219173044.12424.11336.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This member is never initialized and never referenced, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/acpi/acpi_bus.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7ced5dc..4f42c0e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -397,7 +397,6 @@ int unregister_acpi_bus_type(struct acpi_bus_type *);
 struct acpi_pci_root {
 	struct list_head node;
 	struct acpi_device * device;
-	struct acpi_pci_id id;
 	struct pci_bus *bus;
 	u16 segment;
 	struct resource secondary;	/* downstream bus range */

