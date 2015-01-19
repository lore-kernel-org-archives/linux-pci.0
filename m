Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sander Eikelenboom <linux@eikelenboom.it>,
	David Vrabel <david.vrabel@citrix.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [Bugfix 1/3] xen/irq, ACPI: Fix regression in xen PCI passthrough caused by cffe0a2b5a34
Date: Mon, 19 Jan 2015 12:55:42 +0800
Message-Id: <1421643344-17092-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1421643344-17092-1-git-send-email-jiang.liu@linux.intel.com>
References: <1421643344-17092-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Xen pciback driver assumes that pci_dev->irq won't change after calling
pci_disable_device(). But commit cffe0a2b5a34c95a4dadc9ec7132690a5b0f6687
("x86, irq: Keep balance of IOAPIC pin reference count") frees irq
resources and resets pci_dev->irq to zero when pci_disable_device() is
called.

So this is a hotfix for 3.19 to avoid resetting pci_dev->irq, and
another proper fix will be prepared for next merging window.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/pci_irq.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 5277a0ee5704..b1def411c0b8 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -512,7 +512,6 @@ void acpi_pci_irq_disable(struct pci_dev *dev)
 	dev_dbg(&dev->dev, "PCI INT %c disabled\n", pin_name(pin));
 	if (gsi >= 0) {
 		acpi_unregister_gsi(gsi);
-		dev->irq = 0;
 		dev->irq_managed = 0;
 	}
 }
-- 
1.7.10.4

