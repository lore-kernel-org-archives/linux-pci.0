Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: keescook@chromium.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] PCI: acpiphp_ibm: add __ro_after_init to ibm_apci_table_attr
Date: Mon, 26 Dec 2016 21:06:35 +0530
Message-Id: <1482766595-12679-1-git-send-email-bhumirks@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The object ibm_apci_table_attr of type bin_attribute structure is not
modified after getting initialized by ibm_acpiphp_init. Apart from
getting referenced in init it is also passed as an argument to the functions
sysfs_{remove/create}_bin_file but both the arguments are of type const 
struct bin_attribute *. Therefore add __ro_after_init to its declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/pci/hotplug/acpiphp_ibm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index f6221d7..188cdfa 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -107,7 +107,7 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
 
 static acpi_handle ibm_acpi_handle;
 static struct notification ibm_note;
-static struct bin_attribute ibm_apci_table_attr = {
+static struct bin_attribute ibm_apci_table_attr __ro_after_init = {
 	    .attr = {
 		    .name = "apci_table",
 		    .mode = S_IRUGO,
-- 
1.9.1

