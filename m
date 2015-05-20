Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42046 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500AbbETJml (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 May 2015 05:42:41 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [Patch v2 11/14] genirq: Rename irq_data_get_msi() as irq_data_get_msi_desc()
Date: Wed, 20 May 2015 17:40:42 +0800
Message-Id: <1432114845-24304-12-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename irq_data_get_msi() as irq_data_get_msi_desc() to keep consistency
with other irq_data access helpers.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/host/pcie-designware.c |    2 +-
 drivers/pci/msi.c                  |    2 +-
 include/linux/irq.h                |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2e9f84fdd9ce..7b3432d331fd 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -309,7 +309,7 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
 static void dw_msi_teardown_irq(struct msi_controller *chip, unsigned int irq)
 {
 	struct irq_data *data = irq_get_irq_data(irq);
-	struct msi_desc *msi = irq_data_get_msi(data);
+	struct msi_desc *msi = irq_data_get_msi_desc(data);
 	struct pcie_port *pp = sys_to_pcie(msi->dev->bus->sysdata);
 
 	clear_irq_range(pp, irq, 1, data->hwirq);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c3e7dfcf9ff5..be6034cf5c21 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -270,7 +270,7 @@ static void msix_mask_irq(struct msi_desc *desc, u32 flag)
 
 static void msi_set_mask_bit(struct irq_data *data, u32 flag)
 {
-	struct msi_desc *desc = irq_data_get_msi(data);
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
 	if (desc->msi_attrib.is_msix) {
 		msix_mask_irq(desc, flag);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index e33cc0b040f2..05b2266572ce 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -625,7 +625,7 @@ static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
 	return d ? d->msi_desc : NULL;
 }
 
-static inline struct msi_desc *irq_data_get_msi(struct irq_data *d)
+static inline struct msi_desc *irq_data_get_msi_desc(struct irq_data *d)
 {
 	return d->msi_desc;
 }
-- 
1.7.10.4

