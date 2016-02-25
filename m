Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39931 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbcBYAqI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2016 19:46:08 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] PCI: rcar, rcar-gen2: Use ARCH_RENESAS
Date: Thu, 25 Feb 2016 09:45:56 +0900
Message-Id: <1456361156-16798-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pci/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

 Based on the next branch of the pci tree

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 75a605426538..dcf4d5a349ca 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -41,7 +41,7 @@ config PCI_TEGRA
 config PCI_RCAR_GEN2
 	bool "Renesas R-Car Gen2 Internal PCI controller"
 	depends on ARM
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
 	  There are 3 internal PCI controllers available with a single
@@ -49,7 +49,7 @@ config PCI_RCAR_GEN2
 
 config PCI_RCAR_GEN2_PCIE
 	bool "Renesas R-Car PCIe controller"
-	depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
+	depends on ARCH_RENESAS || (ARM && COMPILE_TEST)
 	help
 	  Say Y here if you want PCIe controller support on R-Car Gen2 SoCs.
 
-- 
2.7.0.rc3.207.g0ac5344

