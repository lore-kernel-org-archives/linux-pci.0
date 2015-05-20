Return-Path: <linux-kernel-owner@vger.kernel.org>
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
	Gilad Avidov <gavidov@codeaurora.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC v1 12/25] spmi: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Wed, 20 May 2015 18:00:00 +0800
Message-Id: <1432116013-25902-13-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/spmi/spmi-pmic-arb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index d7119db49cfe..b32cb0a813cb 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -453,8 +453,8 @@ static void periph_interrupt(struct spmi_pmic_arb_dev *pa, u8 apid)
 
 static void pmic_arb_chained_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct spmi_pmic_arb_dev *pa = irq_get_handler_data(irq);
-	struct irq_chip *chip = irq_get_chip(irq);
+	struct spmi_pmic_arb_dev *pa = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	void __iomem *intr = pa->intr;
 	int first = pa->min_apid >> 5;
 	int last = pa->max_apid >> 5;
-- 
1.7.10.4

