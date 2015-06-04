Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36512 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780AbbFDEPI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jun 2015 00:15:08 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFT v2 16/48] genirq: Introduce helper irq_desc_get_irq()
Date: Thu,  4 Jun 2015 12:13:26 +0800
Message-Id: <1433391238-19471-17-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Introduce helper irq_desc_get_irq() to hide irq_desc implementation
details.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irqdesc.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 8c84a2513665..a7aaef44a10e 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -100,6 +100,11 @@ static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
 #endif
 }
 
+static inline unsigned int irq_desc_get_irq(struct irq_desc *desc)
+{
+	return desc->irq_data.irq;
+}
+
 static inline struct irq_data *irq_desc_get_irq_data(struct irq_desc *desc)
 {
 	return &desc->irq_data;
-- 
1.7.10.4

