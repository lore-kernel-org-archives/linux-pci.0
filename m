Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932268AbcIBPzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Sep 2016 11:55:40 -0400
Subject: [PATCH v2 12/15] Rename ROCKCHIP_PCIE_RPIFR1_INTR_MASK and
 ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT
To: Shawn Lin <shawn.lin@rock-chips.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Sep 2016 10:55:35 -0500
Message-ID: <20160902155535.8650.68415.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160902154501.8650.99790.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

to match similar definitions.
---
 drivers/pci/host/pcie-rockchip.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 88c16da..2a41439 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -56,8 +56,8 @@
 #define  PCIE_CLIENT_LINK_STATUS_MASK		0x3
 #define PCIE_CLIENT_INT_MASK		(PCIE_CLIENT_BASE + 0x4c)
 #define PCIE_CLIENT_INT_STATUS		(PCIE_CLIENT_BASE + 0x50)
-#define  ROCKCHIP_PCIE_RPIFR1_INTR_MASK		GENMASK(8, 5)
-#define  ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT	5
+#define  PCIE_CLIENT_INTR_MASK			GENMASK(8, 5)
+#define  PCIE_CLIENT_INTR_SHIFT			5
 #define  PCIE_CLIENT_INT_LEGACY_DONE		BIT(15)
 #define  PCIE_CLIENT_INT_MSG			BIT(14)
 #define  PCIE_CLIENT_INT_HOT_RST		BIT(13)
@@ -679,8 +679,7 @@ static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
-	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
-	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
+	reg = (reg & PCIE_CLIENT_INTR_MASK) >> PCIE_CLIENT_INTR_SHIFT;
 
 	while (reg) {
 		hwirq = ffs(reg) - 1;

