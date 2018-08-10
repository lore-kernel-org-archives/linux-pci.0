Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeHJHAY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Aug 2018 03:00:24 -0400
From: Sinan Kaya <okaya@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] PCI/ACPI: correct error message for ASPM disabling
Date: Fri, 10 Aug 2018 04:32:11 +0000
Message-Id: <1533875532-24954-1-git-send-email-okaya@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If _OSC execution fails today for platforms without an _OSC
entry, code is printing a misleading message saying disabling
ASPM as follows:

acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

We need to ensure that platform supports ASPM to begin with.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Reported-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/acpi/pci_root.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035..e465e72 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -455,8 +455,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			 acpi_format_exception(status));
+		dev_info(&device->dev, "_OSC failed (%s)%s\n",
+			 acpi_format_exception(status),
+			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
 		*no_aspm = 1;
 		return;
 	}
-- 
2.7.4
