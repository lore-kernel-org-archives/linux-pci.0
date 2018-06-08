Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753211AbeFHUGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:06:07 -0400
Subject: [PATCH v1 13/13] PCI/AER: Use "PCI Express" consistently in Kconfig
 text
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:06:06 -0500
Message-ID: <152848836627.11888.1434488594162355250.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Use "PCI Express" consistently in Kconfig text.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 4a8e26a2b012..0a1e9d379bc5 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -24,7 +24,7 @@ config HOTPLUG_PCI_PCIE
 	  When in doubt, say N.
 
 config PCIEAER
-	bool "Root Port Advanced Error Reporting support"
+	bool "PCI Express Advanced Error Reporting support"
 	depends on PCIEPORTBUS
 	select RAS
 	default y
@@ -34,15 +34,15 @@ config PCIEAER
 	  Port will be handled by PCI Express AER driver.
 
 config PCIEAER_INJECT
-	tristate "PCIe AER error injector support"
+	tristate "PCI Express error injection support"
 	depends on PCIEAER
 	default n
 	help
 	  This enables PCI Express Root Port Advanced Error Reporting
 	  (AER) software error injector.
 
-	  Debugging PCIe AER code is quite difficult because it is hard
-	  to trigger various real hardware errors. Software based
+	  Debugging AER code is quite difficult because it is hard
+	  to trigger various real hardware errors. Software-based
 	  error injection can fake almost all kinds of errors with the
 	  help of a user space helper tool aer-inject, which can be
 	  gotten from:
@@ -127,7 +127,7 @@ config PCIE_PME
 	depends on PCIEPORTBUS && PM
 
 config PCIE_DPC
-	bool "PCIe Downstream Port Containment support"
+	bool "PCI Express Downstream Port Containment support"
 	depends on PCIEPORTBUS && PCIEAER
 	default n
 	help
@@ -138,7 +138,7 @@ config PCIE_DPC
 	  it is safe to answer N.
 
 config PCIE_PTM
-	bool "PCIe Precision Time Measurement support"
+	bool "PCI Express Precision Time Measurement support"
 	default n
 	depends on PCIEPORTBUS
 	help
