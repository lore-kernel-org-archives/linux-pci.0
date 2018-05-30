Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753895AbeE3RyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 13:54:17 -0400
Subject: [PATCH v1 1/2] PCI/AER: Decode Error Source Requester ID
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Wed, 30 May 2018 12:54:15 -0500
Message-ID: <152770285586.80701.6545710900591672975.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Decode the Requester ID from the AER Error Source Register into domain/
bus/device/function format to match other logging.  In cases where the ID
matches the device used for pci_err(), drop the extra ID completely so we
don't print it twice.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 21ca5e1b0ded..d7fde8368d81 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -163,17 +163,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int id = ((dev->bus->number << 8) | dev->devfn);
 
 	if (!info->status) {
-		pci_err(dev, "PCIe Bus Error: severity=%s, type=Unaccessible, id=%04x(Unregistered Agent ID)\n",
-			aer_error_severity_string[info->severity], id);
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
+			aer_error_severity_string[info->severity]);
 		goto out;
 	}
 
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, id=%04x(%s)\n",
+	pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		aer_error_severity_string[info->severity],
-		aer_error_layer[layer], id, aer_agent_string[agent]);
+		aer_error_layer[layer], aer_agent_string[agent]);
 
 	pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		dev->vendor, dev->device,
@@ -186,7 +186,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
-		pci_err(dev, "  Error of this Agent(%04x) is reported first\n", id);
+		pci_err(dev, "  Error of this Agent is reported first\n");
 
 	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
 			info->severity, info->tlp_header_valid, &info->tlp);
@@ -194,9 +194,13 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 {
-	pci_info(dev, "AER: %s%s error received: id=%04x\n",
+	u8 bus = info->id >> 8;
+	u8 devfn = info->id & 0xff;
+
+	pci_info(dev, "AER: %s%s error received: %04x:%02x:%02x.%d\n",
 		info->multi_error_valid ? "Multiple " : "",
-		aer_error_severity_string[info->severity], info->id);
+		aer_error_severity_string[info->severity],
+		pci_domain_nr(dev->bus), bus, devfn >> 3, devfn & 0x7);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
