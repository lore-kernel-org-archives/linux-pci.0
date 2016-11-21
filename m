Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 4/9] PCI/AER: Log errors with PCI device,
 not PCIe service device
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:45:41 -0600
Message-ID: <20161121214541.21036.3404.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All other AER-related log messages use the PCI device, e.g.,
"pci 0000:00:1c.0", not the PCIe service device, e.g.,
"aer 0000:00:1c.0:pcie02".

Change the probe error messages to match the rest and include a little
context.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 1c189e6..60e63d6 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -290,12 +290,12 @@ static int aer_probe(struct pcie_device *dev)
 {
 	int status;
 	struct aer_rpc *rpc;
-	struct device *device = &dev->device;
+	struct device *device = &dev->port->dev;
 
 	/* Alloc rpc data structure */
 	rpc = aer_alloc_rpc(dev);
 	if (!rpc) {
-		dev_printk(KERN_DEBUG, device, "alloc rpc failed\n");
+		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
 		aer_remove(dev);
 		return -ENOMEM;
 	}
@@ -303,7 +303,8 @@ static int aer_probe(struct pcie_device *dev)
 	/* Request IRQ ISR */
 	status = request_irq(dev->irq, aer_irq, IRQF_SHARED, "aerdrv", dev);
 	if (status) {
-		dev_printk(KERN_DEBUG, device, "request IRQ failed\n");
+		dev_printk(KERN_DEBUG, device, "request AER IRQ %d failed\n",
+			   dev->irq);
 		aer_remove(dev);
 		return status;
 	}
