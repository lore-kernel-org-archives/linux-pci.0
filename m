Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Alex Hung <alex.hung@canonical.com>
To: rjw@rjwysocki.net, lenb@kernel.org, alex.hung@canonical.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH][V3] ACPI/PCI: pci_link: allow the absence of _PSR and change log level
Date: Thu, 22 Feb 2018 21:43:44 -0800
Message-Id: <1519364624-4363-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In recent Intel hardware the IRQs become non-configurable after BIOS
initializes them in PEI phase and _PRS objects are no longer included in
ASL.

This is the same as "static (non-configurable) devices do not
specify a _PRS object" in ACPI spec. As a result, error messages
saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" does not need to
be in kernel messenges all the time but only when debug is enabled, and
acpi_pci_link_get_possible should not return -ENODEV when _PRS is
absent.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index bc3d914..65f1908 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -173,8 +173,8 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
 				     acpi_pci_link_check_possible, link);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
-		return -ENODEV;
+		acpi_handle_debug(link->device->handle, "_PRS not present or invalid");
+		return 0;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-- 
2.7.4

