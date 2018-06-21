Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.37.59]:56867 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeFUOGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2018 10:06:21 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To: Vineet.Gupta1@synopsys.com, eugeniy.paltsev@synopsys.com,
        Alexey.Brodkin@synopsys.com, robh@kernel.org, bhelgaas@google.com,
        joao.pinto@synopsys.com
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2] ARC: Add PCIe support for ARC HSDK platform
Date: Thu, 21 Jun 2018 15:06:14 +0100
Message-Id: <e1d274a5ed756f86ced3df50538ef8c7e67ef4b6.1529589452.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCI support to the ARC HSDK platform allowing to use the generic PCI
setup functions.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/plat-hsdk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/plat-hsdk/Kconfig b/arch/arc/plat-hsdk/Kconfig
index 19ab3cf..556bc5e 100644
--- a/arch/arc/plat-hsdk/Kconfig
+++ b/arch/arc/plat-hsdk/Kconfig
@@ -9,3 +9,4 @@ menuconfig ARC_SOC_HSDK
 	bool "ARC HS Development Kit SOC"
 	select CLK_HSDK
 	select RESET_HSDK
+	select MIGHT_HAVE_PCI
-- 
2.7.4
