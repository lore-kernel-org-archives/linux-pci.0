Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeFHUFa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:30 -0400
Subject: [PATCH v1 07/13] PCI/AER: Remove duplicate pcie_port_bus_type
 declaration
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:29 -0500
Message-ID: <152848832893.11888.6593179260714831306.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

pcie_port_bus_type is already declared in portdrv.h, so remove the
unnecessary duplicate declaration in aerdrv.h.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index 7fa902b1f7c1..f4fc71119cf2 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -76,7 +76,6 @@ struct aer_rpc {
 					 */
 };
 
-extern struct bus_type pcie_port_bus_type;
 irqreturn_t aer_irq(int irq, void *context);
 
 #ifdef CONFIG_ACPI_APEI
