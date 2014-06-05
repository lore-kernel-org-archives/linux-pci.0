Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44064 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbaFEOqU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 10:46:20 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: linux-pci@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de
Subject: [PATCH 1/4] PCI: allow MSI chip providers to implement their own multiple MSI setup
Date: Thu,  5 Jun 2014 16:46:09 +0200
Message-Id: <1401979572-32101-2-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/msi.c   | 3 +++
 include/linux/msi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 27a7e67ddfe4..c45399d3061a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -68,9 +68,12 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
+	struct msi_chip *chip = dev->bus->msi;
 	struct msi_desc *entry;
 	int ret;
 
+	if (chip && chip->setup_irqs)
+		return chip->setup_irqs(chip, dev, nvec, type);
 	/*
 	 * If an architecture wants to support multiple MSI, it needs to
 	 * override arch_setup_msi_irqs()
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 92a2f991262a..d813f898194c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -75,6 +75,8 @@ struct msi_chip {
 
 	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
+	int (*setup_irqs)(struct msi_chip *chip, struct pci_dev *dev,
+			  int nvec, int type);
 	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
 	int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
 			    int nvec, int type);
-- 
2.0.0.rc2

