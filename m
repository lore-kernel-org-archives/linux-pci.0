Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeISVpS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 17:45:18 -0400
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Subject: [PATCH] MAINTAINERS: Move mobiveil PCI driver entry where it belongs
Date: Wed, 19 Sep 2018 17:06:36 +0100
Message-Id: <20180919160636.21312-1-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 92f9ccca4c08 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
driver DT bindings") managed to add a MAINTAINERS entry where it does
not really belong (ie in the middle of a totally unrelated series of
entries and in the wrong alphabetical order).

Fix it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
 MAINTAINERS | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..fb0474d7da61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9716,13 +9716,6 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/dvb-frontends/mn88473*
 
-PCI DRIVER FOR MOBIVEIL PCIE IP
-M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
-L:	linux-pci@vger.kernel.org
-S:	Supported
-F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
-F:	drivers/pci/controller/pcie-mobiveil.c
-
 MODULE SUPPORT
 M:	Jessica Yu <jeyu@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
@@ -11137,6 +11130,13 @@ F:	include/uapi/linux/switchtec_ioctl.h
 F:	include/linux/switchtec.h
 F:	drivers/ntb/hw/mscc/
 
+PCI DRIVER FOR MOBIVEIL PCIE IP
+M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+F:	drivers/pci/controller/pcie-mobiveil.c
+
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 M:	Jason Cooper <jason@lakedaemon.net>
-- 
2.15.0
