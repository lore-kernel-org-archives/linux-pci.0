Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33539 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbaCEN0f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Mar 2014 08:26:35 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Shawn Guo <shawn.guo@linaro.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when possible
Date: Wed,  5 Mar 2014 14:25:47 +0100
Message-Id: <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the recommended method of doing the IRQ
mapping. For old devicetrees we fall back to the
previous practice.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 330f7e3a32dd..083cf37ca047 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -639,10 +639,15 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	struct tegra_pcie *pcie = sys_to_pcie(pdev->bus->sysdata);
+	int irq;
 
 	tegra_cpuidle_pcie_irqs_in_use();
 
-	return pcie->irq;
+	irq = of_irq_parse_and_map_pci(pdev, slot, pin);
+	if (!irq)
+		irq = pcie->irq;
+
+	return irq;
 }
 
 static void tegra_pcie_add_bus(struct pci_bus *bus)
-- 
1.9.0

