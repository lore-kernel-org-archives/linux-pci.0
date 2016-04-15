Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 15 Apr 2016 17:51:06 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] PCI: acpiphp_ibm: potential uninitialized variable bug
Message-ID: <20160415145106.GH8953@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If ibm_get_table_from_acpi() fails then "table" isn't initialized.  I
fixed this by adding a check for failure.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index 2f6d3a1..f6221d7 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -138,6 +138,8 @@ static union apci_descriptor *ibm_slot_from_id(int id)
 	char *table;
 
 	size = ibm_get_table_from_acpi(&table);
+	if (size < 0)
+		return NULL;
 	des = (union apci_descriptor *)table;
 	if (memcmp(des->header.sig, "aPCI", 4) != 0)
 		goto ibm_slot_done;
