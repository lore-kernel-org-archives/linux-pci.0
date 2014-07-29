Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13071 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbaG2BjA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jul 2014 21:39:00 -0400
From: Jisheng Zhang <jszhang@marvell.com>
To: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
	<swarren@wwwdotorg.org>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v3] PCI: tegra: add missing cleanup in error path and teardown_irq
Date: Tue, 29 Jul 2014 09:33:30 +0800
Message-ID: <1406597610-6748-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We should call tegra_msi_free() to free the MSI bit if
irq_create_mapping() fails. And we need to dispose the IRQ mapping
during IRQ teardown.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pci-tegra.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 083cf37..4ccc418 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1203,8 +1203,10 @@ static int tegra_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 		return hwirq;
 
 	irq = irq_create_mapping(msi->domain, hwirq);
-	if (!irq)
+	if (!irq) {
+		tegra_msi_free(msi, hwirq);
 		return -EINVAL;
+	}
 
 	irq_set_msi_desc(irq, desc);
 
@@ -1222,8 +1224,10 @@ static void tegra_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
 {
 	struct tegra_msi *msi = to_tegra_msi(chip);
 	struct irq_data *d = irq_get_irq_data(irq);
+	unsigned long hwirq = d->hwirq;
 
-	tegra_msi_free(msi, d->hwirq);
+	irq_dispose_mapping(irq);
+	tegra_msi_free(msi, hwirq);
 }
 
 static struct irq_chip tegra_msi_irq_chip = {
-- 
2.0.1

