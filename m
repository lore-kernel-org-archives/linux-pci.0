Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:43428 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759598AbaLLCey (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Dec 2014 21:34:54 -0500
From: Ray Jui <rjui@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Ian Campbell" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	Christian Daudt <bcm@fixthebug.org>,
	Matt Porter <mporter@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Hauke Mehrtens <hauke@hauke-m.de>
CC: Lucas Stach <l.stach@pengutronix.de>,
	Scott Branden <sbranden@broadcom.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>, "Ray Jui" <rjui@broadcom.com>
Subject: [PATCH v2 3/4] ARM: mach-bcm: Enable PCIe support for iProc
Date: Thu, 11 Dec 2014 18:36:56 -0800
Message-ID: <1418351817-14898-4-git-send-email-rjui@broadcom.com>
In-Reply-To: <1418351817-14898-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1418351817-14898-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable PCIe driver support for Broadcom iProc family of SoCs by
selecting PCIE_IPROC

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index aaeec78..a13a0b2 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -19,6 +19,7 @@ config ARCH_BCM_IPROC
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
+	select PCIE_IPROC
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
-- 
1.7.9.5

