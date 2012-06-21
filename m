Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f202.google.com ([209.85.216.202]:47250 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab2FUARA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 20:17:00 -0400
Received: by mail-qc0-f202.google.com with SMTP id p5so9731qcs.1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:59 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id A834A100047
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:59 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 6295D180181
	for <linux-pci@vger.kernel.org>; Wed, 20 Jun 2012 17:16:59 -0700 (PDT)
Subject: [PATCH 5/6] PCI: acpiphp: check whether _ADR evaluation succeeded
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 20 Jun 2012 18:16:59 -0600
Message-ID: <20120621001659.4834.68296.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
References: <20120621000840.4834.26832.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Check whether we evaluated _ADR successfully.  Previously we ignored
failure, so we would have used garbage data from the stack as the device
and function number.

We return AE_OK so that we ignore only this slot and continue looking
for other slots.

Found by Coverity (CID 113981).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 806c44f..09bf377 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -132,6 +132,15 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 	if (!acpi_pci_check_ejectable(pbus, handle) && !is_dock_device(handle))
 		return AE_OK;
 
+	status = acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
+	if (ACPI_FAILURE(status)) {
+		warn("can't evaluate _ADR (%#x)\n", status);
+		return AE_OK;
+	}
+
+	device = (adr >> 16) & 0xffff;
+	function = adr & 0xffff;
+
 	pdev = pbus->self;
 	if (pdev && pci_is_pcie(pdev)) {
 		tmp = acpi_find_root_bridge_handle(pdev);
@@ -144,10 +153,6 @@ register_slot(acpi_handle handle, u32 lvl, void *context, void **rv)
 		}
 	}
 
-	acpi_evaluate_integer(handle, "_ADR", NULL, &adr);
-	device = (adr >> 16) & 0xffff;
-	function = adr & 0xffff;
-
 	newfunc = kzalloc(sizeof(struct acpiphp_func), GFP_KERNEL);
 	if (!newfunc)
 		return AE_NO_MEMORY;

