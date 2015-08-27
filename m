Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35893 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbbH0Mel (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2015 08:34:41 -0400
Received: by wicgk12 with SMTP id gk12so7211721wic.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2015 05:34:40 -0700 (PDT)
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
Subject: [PATCH v4 4/4] MAINTAINERS: Add pci-st.c to ARCH/STI architecture
Date: Thu, 27 Aug 2015 14:34:17 +0200
Message-Id: <1440678857-27118-5-git-send-email-gabriel.fernandez@linaro.org>
In-Reply-To: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the pci-st.c pci driver found on STMicroelectronics
SoC's into the STI arch section of the maintainers file.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..af5034f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1506,6 +1506,7 @@ F:	drivers/clocksource/arm_global_timer.c
 F:	drivers/i2c/busses/i2c-st.c
 F:	drivers/media/rc/st_rc.c
 F:	drivers/mmc/host/sdhci-st.c
+F:	drivers/pci/host/pci-st.c
 F:	drivers/phy/phy-miphy28lp.c
 F:	drivers/phy/phy-miphy365x.c
 F:	drivers/phy/phy-stih407-usb.c
-- 
1.9.1

