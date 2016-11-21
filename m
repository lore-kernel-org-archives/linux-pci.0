Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 2/9] PCI/PME: Log PME IRQ when claiming Root Port
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:45:26 -0600
Message-ID: <20161121214526.21036.73271.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We already log a "Signaling PME" whenever the PME service driver claims a
Root Port.  In fact, we also log the same message for every device in the
hierarchy below the Root Port.

Log the "Signaling PME" once (only for the Root Port, since we can
trivially find out which devices are below the Root Port), and include the
IRQ number in the message to help connect the dots with /proc/interrupts.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pme.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 9e8aa9d..7175293 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -300,8 +300,6 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
  */
 static int pcie_pme_set_native(struct pci_dev *dev, void *ign)
 {
-	dev_info(&dev->dev, "Signaling PME through PCIe PME interrupt\n");
-
 	device_set_run_wake(&dev->dev, true);
 	dev->pme_interrupt = true;
 	return 0;
@@ -349,12 +347,14 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", srv);
 	if (ret) {
 		kfree(data);
-	} else {
-		pcie_pme_mark_devices(port);
-		pcie_pme_interrupt_enable(port, true);
+		return ret;
 	}
 
-	return ret;
+	dev_info(&port->dev, "Signaling PME with IRQ %d\n", srv->irq);
+
+	pcie_pme_mark_devices(port);
+	pcie_pme_interrupt_enable(port, true);
+	return 0;
 }
 
 static bool pcie_pme_check_wakeup(struct pci_bus *bus)
