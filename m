Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:21837 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbCYHFp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 03:05:45 -0400
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Scott Branden <sbranden@broadcom.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: [PATCH v2 1/2] pci: iproc: fix PCIE_IPROC in Kconfig
Date: Wed, 25 Mar 2015 00:08:12 -0700
Message-ID: <1427267293-29585-2-git-send-email-rjui@broadcom.com>
In-Reply-To: <1427267293-29585-1-git-send-email-rjui@broadcom.com>
References: <1427267293-29585-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make PCIE_IPROC depending on both OF and ARM and default to be disabled,
so it cannot be accidentally enabled by other platforms

PCIE_IPROC is meant to be enabled by a front-end bus driver. Curenntly
it's enabled by PCIE_IPROC_PLTFM driver

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/pci/host/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index feccd0d..963b507 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -108,6 +108,8 @@ config PCI_VERSATILE
 
 config PCIE_IPROC
 	tristate "Broadcom iProc PCIe controller"
+	depends on OF && ARM
+	default n
 	help
 	  This enables the iProc PCIe core controller support for Broadcom's
 	  iProc family of SoCs. An appropriate bus interface driver also needs
-- 
1.7.9.5

