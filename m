Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeFHUEx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:04:53 -0400
Subject: [PATCH v1 01/13] PCI/AER: Remove forward declarations
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:04:51 -0500
Message-ID: <152848829181.11888.5633581350754960605.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Reorder code to remove forward declarations.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 9735c19bf39c..c6d1b664a6ea 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -23,22 +23,6 @@
 #include "aerdrv.h"
 #include "../../pci.h"
 
-static int aer_probe(struct pcie_device *dev);
-static void aer_remove(struct pcie_device *dev);
-static void aer_error_resume(struct pci_dev *dev);
-static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
-
-static struct pcie_port_service_driver aerdriver = {
-	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
-	.service	= PCIE_PORT_SERVICE_AER,
-
-	.probe		= aer_probe,
-	.remove		= aer_remove,
-	.error_resume	= aer_error_resume,
-	.reset_link	= aer_root_reset,
-};
-
 static int pcie_aer_disable;
 
 void pci_no_aer(void)
@@ -357,6 +341,17 @@ static void aer_error_resume(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
 }
 
+static struct pcie_port_service_driver aerdriver = {
+	.name		= "aer",
+	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.service	= PCIE_PORT_SERVICE_AER,
+
+	.probe		= aer_probe,
+	.remove		= aer_remove,
+	.error_resume	= aer_error_resume,
+	.reset_link	= aer_root_reset,
+};
+
 /**
  * aer_service_init - register AER root service driver
  *
