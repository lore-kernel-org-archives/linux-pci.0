Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v3 2/4] PCI: iproc: Fix ARM64 dependency in Kconfig
Date: Wed, 15 Jul 2015 21:39:21 -0700
Message-ID: <1437021563-29139-3-git-send-email-rjui@broadcom.com>
In-Reply-To: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
References: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow Broadcom iProc PCIe core driver to be compiled for ARM64

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pci/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c132bdd..d2c6144 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -117,7 +117,7 @@ config PCI_VERSATILE
 
 config PCIE_IPROC
 	tristate "Broadcom iProc PCIe controller"
-	depends on OF && ARM
+	depends on OF && (ARM || ARM64)
 	default n
 	help
 	  This enables the iProc PCIe core controller support for Broadcom's
-- 
1.7.9.5

