Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56149 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab2CHOvn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2012 09:51:43 -0500
From: Thierry Reding <thierry.reding@avionic-design.de>
To: linux-tegra@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 07/11] ARM: pci: Keep pci_common_init() around after init
Date: Thu,  8 Mar 2012 15:51:27 +0100
Message-Id: <1331218291-16119-8-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/kernel/bios32.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index be5d3b2..c88dcf5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -411,7 +411,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static void __init pcibios_init_hw(struct hw_pci *hw)
+static void pcibios_init_hw(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -457,7 +457,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 	}
 }
 
-void __init pci_common_init(struct hw_pci *hw)
+void pci_common_init(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
 
-- 
1.7.9.3

