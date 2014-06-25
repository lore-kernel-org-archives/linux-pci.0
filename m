Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Patch V3 01/16] x86, irq, ACPI: Protect acpi_pci_irq_enable() from reentrance
Date: Wed, 25 Jun 2014 16:40:32 +0800
Message-Id: <1403685648-10103-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1403685648-10103-1-git-send-email-jiang.liu@linux.intel.com>
References: <1403685648-10103-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Function acpi_pci_irq_enable() may be called twice for each PCI device
present at boot time as below:
1) pci_acpi_init()
	--> acpi_pci_irq_enable()
2) pci_enable_device()
	--> pcibios_enable_device()
		--> acpi_pci_irq_enable()

So protect acpi_pci_irq_enable() from reentrance to correctly manage
IOAPIC pin reference count.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/pci_irq.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 6ba463ceccc6..9d2ebd5fd9aa 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -413,6 +413,9 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 	}
 
+	if (dev->irq > 0)
+		return 0;
+
 	entry = acpi_pci_irq_lookup(dev, pin);
 	if (!entry) {
 		/*
@@ -498,6 +501,8 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	 */
 
 	dev_dbg(&dev->dev, "PCI INT %c disabled\n", pin_name(pin));
-	if (gsi >= 0 && dev->irq > 0)
+	if (gsi >= 0 && dev->irq > 0) {
 		acpi_unregister_gsi(gsi);
+		dev->irq = 0;
+	}
 }
-- 
1.7.10.4

