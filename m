Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:1367 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422682AbbD2LhF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2015 07:37:05 -0400
From: Jayachandran C <jchandra@broadcom.com>
To: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Arnd Bergmann" <arnd@arndb.de>, Liviu Dudau <Liviu.Dudau@arm.com>
CC: Jayachandran C <jchandra@broadcom.com>
Subject: [RFC PATCH 2/2] PCI: generic: add arm64 support
Date: Wed, 29 Apr 2015 17:09:59 +0530
Message-ID: <1430307599-20536-2-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make pci-host-generic driver available on arm64. This needs
drivers/pci/setup-irq.o to be built for the arm64 as well.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/Makefile     | 1 +
 drivers/pci/host/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 73e4af4..be3f631 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PCI_IOV) += iov.o
 #
 obj-$(CONFIG_ALPHA) += setup-irq.o
 obj-$(CONFIG_ARM) += setup-irq.o
+obj-$(CONFIG_ARM64) += setup-irq.o
 obj-$(CONFIG_UNICORE32) += setup-irq.o
 obj-$(CONFIG_SUPERH) += setup-irq.o
 obj-$(CONFIG_MIPS) += setup-irq.o
diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1dfb567..51741ad 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -53,7 +53,7 @@ config PCI_RCAR_GEN2_PCIE
 
 config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
-	depends on ARM && OF
+	depends on (ARM || ARM64) && OF
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
-- 
1.9.1

