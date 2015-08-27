Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37267 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbbH0Med (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2015 08:34:33 -0400
Received: by widdq5 with SMTP id dq5so43715489wid.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2015 05:34:32 -0700 (PDT)
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	" David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 1/4] ARM: STi: Kconfig update for PCIe support
Date: Thu, 27 Aug 2015 14:34:14 +0200
Message-Id: <1440678857-27118-2-git-send-email-gabriel.fernandez@linaro.org>
In-Reply-To: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update Kconfig:
- MIGHT_HAVE_PCI
- PCI_DOMAINS

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/mach-sti/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 125865d..5f99e93 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -9,6 +9,8 @@ menuconfig ARCH_STI
 	select ARCH_HAS_RESET_CONTROLLER
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
+	select PCI_DOMAINS if PCI
+	select MIGHT_HAVE_PCI
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
-- 
1.9.1

