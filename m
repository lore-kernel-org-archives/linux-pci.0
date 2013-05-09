Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH] PCI/ACPI: Check acpi_resource_to_address64() return value
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Date: Thu, 09 May 2013 13:29:13 -0600
Message-ID: <20130509192913.17473.94947.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should check the acpi_resource_to_address64() return value, which
also removes the need to validate the resource type beforehand.
No functional change.

Found by Coverity (CID 113815).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index ac8688b..c956434 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -100,13 +100,12 @@ get_root_bridge_busnr_callback(struct acpi_resource *resource, void *data)
 {
 	struct resource *res = data;
 	struct acpi_resource_address64 address;
+	acpi_status status;
 
-	if (resource->type != ACPI_RESOURCE_TYPE_ADDRESS16 &&
-	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS32 &&
-	    resource->type != ACPI_RESOURCE_TYPE_ADDRESS64)
+	status = acpi_resource_to_address64(resource, &address);
+	if (ACPI_FAILURE(status))
 		return AE_OK;
 
-	acpi_resource_to_address64(resource, &address);
 	if ((address.address_length > 0) &&
 	    (address.resource_type == ACPI_BUS_NUMBER_RANGE)) {
 		res->start = address.minimum;

