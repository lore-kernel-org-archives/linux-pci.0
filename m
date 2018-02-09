Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45274 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbeBIW4s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Feb 2018 17:56:48 -0500
From: Alex Hung <alex.hung@canonical.com>
To: rjw@rjwysocki.net, lenb@kernel.org, alex.hung@canonical.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI/PCI: pci_link: change log level of no _PRS messages
Date: Fri,  9 Feb 2018 14:56:43 -0800
Message-Id: <1518217003-19637-1-git-send-email-alex.hung@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In recent Intel hardware the IRQs become non-configurable after BIOS
initializes them in PEI phase and _PRS objects are no longer included in
ASL.

This is the same as "static (non-configurable) devices do not
specify a _PRS object" in ACPI spec. As a result, error messages
saying "ACPI Exception: AE_NOT_FOUND, Evaluating _PRS" does not need to
be in kernel messages all the time but only when debug is enabled.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 85ad679..9d9cf24 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -173,7 +173,7 @@ static int acpi_pci_link_get_possible(struct acpi_pci_link *link)
 	status = acpi_walk_resources(link->device->handle, METHOD_NAME__PRS,
 				     acpi_pci_link_check_possible, link);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PRS"));
+		acpi_handle_debug(link->device->handle, "failed to evaluate _PRS");
 		return -ENODEV;
 	}
 
-- 
2.7.4
