Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 03/26] x86, irq: Print out MSI/MSI-X clearly
Date: Fri,  8 Feb 2013 11:28:00 -0800
Message-Id: <1360351703-20571-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1360351703-20571-1-git-send-email-yinghai@kernel.org>
References: <1360351703-20571-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Print out exact MSI or MSI-X instead of MSI/MSI-X.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/x86/kernel/apic/io_apic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index f78f7f6..059589f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3125,7 +3125,8 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 
 	irq_set_chip_and_handler_name(irq, chip, handle_edge_irq, "edge");
 
-	dev_printk(KERN_DEBUG, &dev->dev, "irq %d for MSI/MSI-X\n", irq);
+	dev_printk(KERN_DEBUG, &dev->dev, "irq %d for MSI%s\n", irq,
+			 msidesc->msi_attrib.is_msix ? "-X" : "");
 
 	return 0;
 }
-- 
1.7.10.4

