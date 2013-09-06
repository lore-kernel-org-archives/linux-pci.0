Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH 07/14] PCI/ACPI: Drop unnecessary _OSC existence tests
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:14:18 -0600
Message-ID: <20130906171418.11482.83703.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's no need to check whether _OSC exists here; we eventually
call acpi_evaluate_object(..., "_OSC", ...), and that will fail
gracefully if _OSC doesn't exist.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_root.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 28dd555..cc87cc4 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -180,11 +180,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
 static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
 {
 	acpi_status status;
-	acpi_handle tmp;
 
-	status = acpi_get_handle(root->device->handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
 	mutex_lock(&osc_lock);
 	status = acpi_pci_query_osc(root, flags, NULL);
 	mutex_unlock(&osc_lock);
@@ -316,9 +312,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
 acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 {
 	struct acpi_pci_root *root;
-	acpi_status status;
+	acpi_status status = AE_OK;
 	u32 ctrl, capbuf[3];
-	acpi_handle tmp;
 
 	if (!mask)
 		return AE_BAD_PARAMETER;
@@ -331,10 +326,6 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 	if (!root)
 		return AE_NOT_EXIST;
 
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-
 	mutex_lock(&osc_lock);
 
 	*mask = ctrl | root->osc_control_set;

