Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:44302 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753544AbcCOL2u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2016 07:28:50 -0400
From: Andreas Ziegler <andreas.ziegler@fau.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Ziegler <andreas.ziegler@fau.de>
Subject: [PATCH] PCI: cleanup pci/pcie/Kconfig
Date: Tue, 15 Mar 2016 12:28:32 +0100
Message-Id: <1458041312-11317-1-git-send-email-andreas.ziegler@fau.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This change cleans up style issues in drivers/pci/pcie/Kconfig, in
particular all indentation is now done using tabs, not spaces, and
the definition of PCIEASPM_DEBUG is now separated from the definition
of PCIEASPM with a newline.

Signed-off-by: Andreas Ziegler <andreas.ziegler@fau.de>
---
 drivers/pci/pcie/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index e294713..72db7f4 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -44,6 +44,7 @@ config PCIEASPM
 	  /sys/module/pcie_aspm/parameters/policy
 
 	  When in doubt, say Y.
+
 config PCIEASPM_DEBUG
 	bool "Debug PCI Express ASPM"
 	depends on PCIEASPM
@@ -58,20 +59,20 @@ choice
 	depends on PCIEASPM
 
 config PCIEASPM_DEFAULT
-        bool "BIOS default"
+	bool "BIOS default"
 	depends on PCIEASPM
 	help
 	  Use the BIOS defaults for PCI Express ASPM.
 
 config PCIEASPM_POWERSAVE
-        bool "Powersave"
+	bool "Powersave"
 	depends on PCIEASPM
 	help
 	  Enable PCI Express ASPM L0s and L1 where possible, even if the
 	  BIOS did not.
 
 config PCIEASPM_PERFORMANCE
-        bool "Performance"
+	bool "Performance"
 	depends on PCIEASPM
 	help
 	  Disable PCI Express ASPM L0s and L1, even if the BIOS enabled them.
-- 
1.9.1

