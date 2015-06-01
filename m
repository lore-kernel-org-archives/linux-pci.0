Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5991 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752230AbbFAIFl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jun 2015 04:05:41 -0400
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [Patch v3 10/36] x86, irq: Use helper irq_data_get_irq_handler_data() to hide irq_desc details
Date: Mon,  1 Jun 2015 16:05:19 +0800
Message-Id: <1433145945-789-11-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use helper function irq_data_get_irq_handler_data() to hide irq_desc
implementation details.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/gpio/gpio-davinci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index c5e05c82d67c..477d5b8616ab 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -396,7 +396,7 @@ static int gpio_irq_type_unbanked(struct irq_data *data, unsigned trigger)
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask;
 
-	d = (struct davinci_gpio_controller *)data->handler_data;
+	d = (struct davinci_gpio_controller *)irq_data_get_irq_handler_data(data);
 	g = (struct davinci_gpio_regs __iomem *)d->regs;
 	mask = __gpio_mask(data->irq - d->gpio_irq);
 
-- 
1.7.10.4

