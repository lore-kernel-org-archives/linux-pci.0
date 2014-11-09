Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC Part4 v1 06/17] genirq: Introduce callback irq_chip.irq_write_msi_msg
Date: Sun,  9 Nov 2014 23:10:28 +0800
Message-Id: <1415545839-28263-7-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415545839-28263-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce callback irq_chip.irq_write_msi_msg, so we could share common
code among MSI alike interrupt controllers, such as HPET and DMAR.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 041edd6dc409..99aea9925b21 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -326,6 +326,7 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_release_resources:	optional to release resources acquired with
  *				irq_request_resources
  * @irq_compose_msi_msg:	optional to compose message content for MSI
+ * @irq_write_msi_msg:	optional to write message content for MSI
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -363,6 +364,7 @@ struct irq_chip {
 	void		(*irq_release_resources)(struct irq_data *data);
 
 	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
+	void		(*irq_write_msi_msg)(struct irq_data *data, struct msi_msg *msg);
 
 	unsigned long	flags;
 };
@@ -457,6 +459,12 @@ extern void irq_chip_ack_parent(struct irq_data *data);
 extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
 #endif
 
+static inline void irq_chip_write_msi_msg(struct irq_data *data,
+					  struct msi_msg *msg)
+{
+	data->chip->irq_write_msi_msg(data, msg);
+}
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   irqreturn_t action_ret);
-- 
1.7.10.4

