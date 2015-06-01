Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
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
Subject: [Patch v3 32/36] genirq: Rename irq_data_get_msi() as irq_data_get_msi_desc()
Date: Mon,  1 Jun 2015 16:05:41 +0800
Message-Id: <1433145945-789-33-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rename irq_data_get_msi() as irq_data_get_msi_desc() to keep consistency
with other irq_data access helpers.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
index 9d01cd8ca8a2..2b95fee48c55 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -631,7 +631,7 @@ static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
 	return d ? d->msi_desc : NULL;
 }
 
-static inline struct msi_desc *irq_data_get_msi(struct irq_data *d)
+static inline struct msi_desc *irq_data_get_msi_desc(struct irq_data *d)
 {
 	return d->msi_desc;
 }
-- 
1.7.10.4

