Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36199 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbcBCVYe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 16:24:34 -0500
From: Bogicevic Sasa <brutallesale@gmail.com>
To: bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bogicevic Sasa <brutallesale@gmail.com>
Subject: [PATCH] drivers:pci Remove pcie folder from Kconfig
Date: Wed,  3 Feb 2016 13:24:22 -0800
Message-Id: <1454534662-33889-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This removes drivers/pci/pcie folder from Kconfig
files in arch/ and sources pcie in pci Kconfig directly

Signed-off-by: Sasa Bogicevic <brutallesale@gmail.com>
---
 arch/arm/Kconfig     | 1 -
 arch/arm64/Kconfig   | 1 -
 arch/ia64/Kconfig    | 1 -
 arch/mips/Kconfig    | 2 --
 arch/powerpc/Kconfig | 1 -
 arch/s390/Kconfig    | 1 -
 arch/sh/Kconfig      | 1 -
 arch/tile/Kconfig    | 1 -
 arch/x86/Kconfig     | 1 -
 drivers/pci/Kconfig  | 1 +
 10 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f799e5..1d00da1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1212,7 +1212,6 @@ config PCI_HOST_ITE8152
 	select DMABOUNCE
 
 source "drivers/pci/Kconfig"
-source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc6228..128ec3c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -235,7 +235,6 @@ config PCI_SYSCALL
 	def_bool PCI
 
 source "drivers/pci/Kconfig"
-source "drivers/pci/pcie/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
 endmenu
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index fb0515e..6245501 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -574,7 +574,6 @@ config PCI_DOMAINS
 config PCI_SYSCALL
 	def_bool PCI
 
-source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pci/Kconfig"
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57a945e..d21eec7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2876,8 +2876,6 @@ config PCI_DOMAINS
 
 source "drivers/pci/Kconfig"
 
-source "drivers/pci/pcie/Kconfig"
-
 #
 # ISA support is now enabled via select.  Too many systems still have the one
 # or other ISA chip on the board that users don't know about so don't expect
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e4824fd..d4ec17c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -828,7 +828,6 @@ config PCI_8260
 	select PPC_INDIRECT_PCI
 	default y
 
-source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pci/Kconfig"
 
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3be9c83..9918433 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -605,7 +605,6 @@ config PCI_NR_MSI
 	  PCI devices.
 
 source "drivers/pci/Kconfig"
-source "drivers/pci/pcie/Kconfig"
 source "drivers/pci/hotplug/Kconfig"
 
 endif	# PCI
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index e13da05..88a334c 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -847,7 +847,6 @@ config PCI
 config PCI_DOMAINS
 	bool
 
-source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pci/Kconfig"
 
diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
index de4a4ff..0c95266 100644
--- a/arch/tile/Kconfig
+++ b/arch/tile/Kconfig
@@ -455,7 +455,6 @@ config TILE_PCI_IO
 
 source "drivers/pci/Kconfig"
 
-source "drivers/pci/pcie/Kconfig"
 
 config TILE_USB
 	tristate "Tilera USB host adapter support"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9af2e63..688b222 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2430,7 +2430,6 @@ config PCI_CNB20LE_QUIRK
 
 	  You should say N unless you know you need this.
 
-source "drivers/pci/pcie/Kconfig"
 
 source "drivers/pci/Kconfig"
 
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 73de4ef..aae605a 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -119,3 +119,4 @@ config PCI_LABEL
 	select NLS
 
 source "drivers/pci/host/Kconfig"
+source "drivers/pci/pcie/Kconfig"
-- 
2.5.0

