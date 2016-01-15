Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43956 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbcAOVel (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 16:34:41 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	tglx@linutronix.de, dan.j.williams@intel.com,
	bryan.e.veal@intel.com, keith.busch@intel.com, bhelgaas@google.com
Subject: [PATCH] x86/Kconfig: Move VMD to Processor Types and Features
Date: Fri, 15 Jan 2016 14:37:04 -0700
Message-Id: <1452893824-11326-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VMD is an Intel-specific, x86 device and should be listed under the
Processor Types and Features menu.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
Applies to https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-vmd
 arch/x86/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3e6aca8..6083255 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2137,6 +2137,19 @@ config MODIFY_LDT_SYSCALL
 
 source "kernel/livepatch/Kconfig"
 
+config VMD
+	depends on PCI_MSI
+	tristate "Volume Management Device Driver"
+	default N
+	---help---
+	  Adds support for the Intel Volume Management Device (VMD). VMD is a
+	  secondary PCI host bridge that allows PCI Express root ports,
+	  and devices attached to them, to be removed from the default
+	  PCI domain and placed within the VMD domain. This provides
+	  more bus resources than are otherwise possible with a
+	  single domain. If you know your system provides one of these and
+	  has devices attached to it, say Y; if you are not sure, say N.
+
 endmenu
 
 config ARCH_ENABLE_MEMORY_HOTPLUG
@@ -2665,19 +2678,6 @@ config PMC_ATOM
 	def_bool y
         depends on PCI
 
-config VMD
-	depends on PCI_MSI
-	tristate "Volume Management Device Driver"
-	default N
-	---help---
-	  Adds support for the Intel Volume Management Device (VMD). VMD is a
-	  secondary PCI host bridge that allows PCI Express root ports,
-	  and devices attached to them, to be removed from the default
-	  PCI domain and placed within the VMD domain. This provides
-	  more bus resources than are otherwise possible with a
-	  single domain. If you know your system provides one of these and
-	  has devices attached to it, say Y; if you are not sure, say N.
-
 source "net/Kconfig"
 
 source "drivers/Kconfig"
-- 
2.1.4

