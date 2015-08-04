Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:58749 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbbHDUmn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 16:42:43 -0400
From: Jayachandran C <jchandra@broadcom.com>
To: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: Jayachandran C <jchandra@broadcom.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: [PATCH v4 3/3] PCI: generic: add arm64 support
Date: Wed, 5 Aug 2015 02:23:40 +0530
Message-ID: <1438721620-15493-3-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Make pci-host-generic driver (kernel option PCI_HOST_GENERIC) available
on arm64.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c132bdd..675c2d1 100644
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

