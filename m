Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1484 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbbETJ6W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 May 2015 05:58:22 -0400
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
	Haavard Skinnemoen <hskinnemoen@gmail.com>,
	Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [RFC v1 02/25] avr32, irq: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Date: Wed, 20 May 2015 17:59:50 +0800
Message-Id: <1432116013-25902-3-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/avr32/mach-at32ap/pio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/avr32/mach-at32ap/pio.c b/arch/avr32/mach-at32ap/pio.c
index 903c7d81d0d5..2583e6cc44e9 100644
--- a/arch/avr32/mach-at32ap/pio.c
+++ b/arch/avr32/mach-at32ap/pio.c
@@ -286,7 +286,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	struct pio_device	*pio = irq_desc_get_chip_data(desc);
 	unsigned		gpio_irq;
 
-	gpio_irq = (unsigned) irq_get_handler_data(irq);
+	gpio_irq = (unsigned) irq_desc_get_handler_data(desc);
 	for (;;) {
 		u32		isr;
 
-- 
1.7.10.4

