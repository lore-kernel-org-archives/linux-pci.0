Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:45589 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbbEDMm2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 May 2015 08:42:28 -0400
From: Stanimir Varbanov <svarbanov@mm-sol.com>
To: Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH v2 5/5] ARM: qcom: Add Qualcomm APQ8084 SoC
Date: Mon,  4 May 2015 15:42:18 +0300
Message-Id: <1430743338-10441-6-git-send-email-svarbanov@mm-sol.com>
In-Reply-To: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds Snapdragon 805 ARM-based SoC as multiplatform
compatible platform.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 arch/arm/mach-qcom/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 2256cd1..9cfebee 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -22,4 +22,11 @@ config ARCH_MSM8974
 	bool "Enable support for MSM8974"
 	select HAVE_ARM_ARCH_TIMER
 
+config ARCH_APQ8084
+	bool "Enable support for APQ8084"
+	select HAVE_ARM_ARCH_TIMER
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
+	select PCI_MSI if PCI
+
 endif
-- 
1.7.0.4

