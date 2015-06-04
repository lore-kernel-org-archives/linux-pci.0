Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21275 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbbFDEQp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Jun 2015 00:16:45 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org
Subject: [RFT v2 27/48] sh, irq: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:37 +0800
Message-Id: <1433391238-19471-28-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Change irq flow handlers to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/sh/boards/mach-se/7722/irq.c |    2 +-
 arch/sh/boards/mach-se/7724/irq.c |    2 +-
 drivers/sh/intc/virq.c            |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 00e699232621..60aebd14ccf8 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -30,7 +30,7 @@ struct irq_domain *se7722_irq_domain;
 
 static void se7722_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	struct irq_data *data = irq_get_irq_data(irq);
+	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	unsigned long mask;
 	int bit;
diff --git a/arch/sh/boards/mach-se/7724/irq.c b/arch/sh/boards/mach-se/7724/irq.c
index 5d1d3ec9a6cd..5feb246f642d 100644
--- a/arch/sh/boards/mach-se/7724/irq.c
+++ b/arch/sh/boards/mach-se/7724/irq.c
@@ -94,7 +94,7 @@ static struct irq_chip se7724_irq_chip __read_mostly = {
 
 static void se7724_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	struct fpga_irq set = get_fpga_irq(irq);
+	struct fpga_irq set = get_fpga_irq(irq_desc_get_irq(desc));
 	unsigned short intv = __raw_readw(set.sraddr);
 	unsigned int ext_irq = set.base;
 
diff --git a/drivers/sh/intc/virq.c b/drivers/sh/intc/virq.c
index bb7e745d4266..8704873e8186 100644
--- a/drivers/sh/intc/virq.c
+++ b/drivers/sh/intc/virq.c
@@ -114,7 +114,7 @@ static void intc_virq_handler(unsigned int irq, struct irq_desc *desc)
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
 	struct intc_virq_list *entry, *vlist = irq_data_get_irq_handler_data(data);
-	struct intc_desc_int *d = get_intc_desc(irq);
+	struct intc_desc_int *d = get_intc_desc(irq_desc_get_irq(desc));
 
 	chip->irq_mask_ack(data);
 
-- 
1.7.10.4

