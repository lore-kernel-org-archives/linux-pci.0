Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch v3 09/36] x86, irq: Use helper irq_data_get_irq_handler_data() to hide irq_desc details
Date: Mon,  1 Jun 2015 16:05:18 +0800
Message-Id: <1433145945-789-10-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use helper function irq_data_get_irq_handler_data() to hide irq_desc
implementation details.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/kernel/apic/msi.c |    2 +-
 arch/x86/kernel/hpet.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 1a9d735e09c6..5f1feb6854af 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -264,7 +264,7 @@ static inline int hpet_dev_id(struct irq_domain *domain)
 
 static void hpet_msi_write_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	hpet_msi_write(data->handler_data, msg);
+	hpet_msi_write(irq_data_get_irq_handler_data(data), msg);
 }
 
 static struct irq_chip hpet_msi_controller = {
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index e2449cf38b06..40cf79a55fe7 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -426,7 +426,7 @@ static struct irq_domain *hpet_domain;
 
 void hpet_msi_unmask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = data->handler_data;
+	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* unmask it */
@@ -437,7 +437,7 @@ void hpet_msi_unmask(struct irq_data *data)
 
 void hpet_msi_mask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = data->handler_data;
+	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* mask it */
-- 
1.7.10.4

