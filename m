Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53559 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753508AbbJFREj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Oct 2015 13:04:39 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Rob Herring <robh+dt@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, Mark Rutland <Mark.Rutland@arm.com>,
	David Daney <ddaney.cavm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 7/8] PCI: Add per-device MSI domain hook
Date: Tue,  6 Oct 2015 18:04:02 +0100
Message-Id: <1444151043-31084-8-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
References: <1444151043-31084-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So far, we have considered that the MSI domain for a device was
either set via the architecture-dependent pcibios implementation
or inherited from the host bridge.

As we're about to break that assumption, add pci_dev_msi_domain
which is the equivalent of pci_host_bridge_msi_domain, but for
a single device.

Other than moving things around a bit, this patch on its own
has no effect.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/probe.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8361d27..7c333f8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1622,15 +1622,40 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_enable_acs(dev);
 }
 
+/*
+ * This is the equivalent of pci_host_bridge_msi_domain that acts on
+ * devices. Firmware interfaces that can select the MSI domain on a
+ * per-device basis should be called from here.
+ */
+static struct irq_domain *pci_dev_msi_domain(struct pci_dev *dev)
+{
+	struct irq_domain *d;
+
+	/*
+	 * If a domain has been set through the pcibios_add_device
+	 * callback, then this is the one (platform code knows best).
+	 */
+	d = dev_get_msi_domain(&dev->dev);
+	if (d)
+		return d;
+
+	return NULL;
+}
+
 static void pci_set_msi_domain(struct pci_dev *dev)
 {
+	struct irq_domain *d;
+
 	/*
-	 * If no domain has been set through the pcibios_add_device
-	 * callback, inherit the default from the bus device.
+	 * If the platform or firmware interfaces cannot supply a
+	 * device-specific MSI domain, then inherit the default domain
+	 * from the host bridge itself.
 	 */
-	if (!dev_get_msi_domain(&dev->dev))
-		dev_set_msi_domain(&dev->dev,
-				   dev_get_msi_domain(&dev->bus->dev));
+	d = pci_dev_msi_domain(dev);
+	if (!d)
+		d = dev_get_msi_domain(&dev->bus->dev);
+
+	dev_set_msi_domain(&dev->dev, d);
 }
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
-- 
2.1.4

