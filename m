Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:32676 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbbG0WmQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 18:42:16 -0400
From: Ray Jui <rjui@broadcom.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <arm@kernel.org>,
	<linux-pci@vger.kernel.org>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH v5 2/4] PCI: iproc: Fix ARM64 dependency in Kconfig
Date: Mon, 27 Jul 2015 15:42:19 -0700
Message-ID: <1438036941-27210-3-git-send-email-rjui@broadcom.com>
In-Reply-To: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
References: <1438036941-27210-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow Broadcom iProc PCIe core driver to be compiled for ARM64

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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

