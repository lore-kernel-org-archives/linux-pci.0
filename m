Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:53306 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab3IFRPC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:15:02 -0400
Received: by mail-yh0-f50.google.com with SMTP id a41so1306917yho.23
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:15:01 -0700 (PDT)
Subject: [PATCH 12/14] PCI/ACPI: Separate out _OSC "PCIe port services
 disabled" path
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:14:59 -0600
Message-ID: <20130906171459.11482.67404.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Test "pcie_ports_disabled" separately so we can give a better message.
Previously we said "Unable to request _OSC control..."; now we'll
say "PCIe port services disabled; not requesting _OSC control".

"pcie_ports_disabled" is true when CONFIG_PCIEPORTBUS=n or we boot
with "pcie_ports=compat".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 67cc43a..68e5a18 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -387,8 +387,12 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		return;
 	}
 
-	if (!pcie_ports_disabled
-	    && (support & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
+	if (pcie_ports_disabled) {
+		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
+		return;
+	}
+
+	if ((support & ACPI_PCIE_REQ_SUPPORT) == ACPI_PCIE_REQ_SUPPORT) {
 		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
 			| OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
 			| OSC_PCI_EXPRESS_PME_CONTROL;

