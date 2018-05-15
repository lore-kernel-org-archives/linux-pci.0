Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:43313 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752599AbeEOJIe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 05:08:34 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH v4 8/8] PCI: Enable PCI_DOMAINS along with generic PCI host controller
Date: Tue, 15 May 2018 11:07:07 +0200
Message-Id: <4896b00d5f8142aff8f928863364c770b5c5156d.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This controller is often instantiated by hypervisors, and they may add
multiple of them or add them in addition to a physical host controller
like the Jailhouse hypervisor is doing. Therefore allow for multiple
domains so that we can handle them all.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 0d0177ce436c..3d25b35bb5ab 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -68,6 +68,7 @@ config PCI_HOST_GENERIC
 	depends on (ARM || ARM64) && OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
+	select PCI_DOMAINS
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
-- 
2.13.6
