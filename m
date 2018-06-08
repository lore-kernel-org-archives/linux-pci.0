Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 11/13] PCI/AER: Squash Kconfig.debug into Kconfig
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:53 -0500
Message-ID: <152848835367.11888.14087620046663002613.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Squash Kconfig.debug into Kconfig.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/Kconfig       |   16 ++++++++++++++--
 drivers/pci/pcie/aer/Kconfig.debug |   19 -------------------
 2 files changed, 14 insertions(+), 21 deletions(-)
 delete mode 100644 drivers/pci/pcie/aer/Kconfig.debug

diff --git a/drivers/pci/pcie/aer/Kconfig b/drivers/pci/pcie/aer/Kconfig
index 5a64eb3d6c7a..1996df082e89 100644
--- a/drivers/pci/pcie/aer/Kconfig
+++ b/drivers/pci/pcie/aer/Kconfig
@@ -13,6 +13,20 @@ config PCIEAER
 	  (AER) driver support. Error reporting messages sent to Root
 	  Port will be handled by PCI Express AER driver.
 
+config PCIEAER_INJECT
+	tristate "PCIe AER error injector support"
+	depends on PCIEAER
+	default n
+	help
+	  This enables PCI Express Root Port Advanced Error Reporting
+	  (AER) software error injector.
+
+	  Debugging PCIe AER code is quite difficult because it is hard
+	  to trigger various real hardware errors. Software based
+	  error injection can fake almost all kinds of errors with the
+	  help of a user space helper tool aer-inject, which can be
+	  gotten from:
+	     http://www.kernel.org/pub/linux/utils/pci/aer-inject/
 
 #
 # PCI Express ECRC
@@ -25,5 +39,3 @@ config PCIE_ECRC
 	  (transaction layer end-to-end CRC checking).
 
 	  When in doubt, say N.
-
-source "drivers/pci/pcie/aer/Kconfig.debug"
diff --git a/drivers/pci/pcie/aer/Kconfig.debug b/drivers/pci/pcie/aer/Kconfig.debug
deleted file mode 100644
index 67e02174b65b..000000000000
--- a/drivers/pci/pcie/aer/Kconfig.debug
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# PCI Express Root Port Device AER Debug Configuration
-#
-
-config PCIEAER_INJECT
-	tristate "PCIe AER error injector support"
-	depends on PCIEAER
-	default n
-	help
-	  This enables PCI Express Root Port Advanced Error Reporting
-	  (AER) software error injector.
-
-	  Debugging PCIe AER code is quite difficult because it is hard
-	  to trigger various real hardware errors. Software based
-	  error injection can fake almost all kinds of errors with the
-	  help of a user space helper tool aer-inject, which can be
-	  gotten from:
-	     http://www.kernel.org/pub/linux/utils/pci/aer-inject/
