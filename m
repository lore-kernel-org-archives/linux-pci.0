Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:45905 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776Ab3GAHkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jul 2013 03:40:02 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree-discuss@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sean Cross <xobs@kosagi.com>
Subject: [PATCH 2/4] ARM: Enable PCI Express on ARM
Date: Mon,  1 Jul 2013 07:15:45 +0000
Message-Id: <1372662947-27160-3-git-send-email-xobs@kosagi.com>
In-Reply-To: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some ARM devices have PCI Express hardware, and should be able to take
advantage of PCI Express code present in the common driver files.  Enable
PCI Express on ARM, when PCI is available.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 arch/arm/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 136f263..2f51f13 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1418,6 +1418,8 @@ config PCI_HOST_ITE8152
 
 source "drivers/pci/Kconfig"
 
+source "drivers/pci/pcie/Kconfig"
+
 source "drivers/pcmcia/Kconfig"
 
 endmenu
-- 
1.7.9.5

