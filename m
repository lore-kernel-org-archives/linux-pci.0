Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Daney <ddaney.cavm@gmail.com>
To: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>
Cc: David Daney <david.daney@cavium.com>
Subject: [PATCH v3 6/6] PCI: generic: Claim device resources if PCI_PROBE_ONLY
Date: Tue, 22 Sep 2015 16:49:17 -0700
Message-Id: <1442965757-12925-7-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
References: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

In the case where the PCI_PROBE_ONLY flag is set, we need to claim the
resources for all PCI devices added to the bus.  Failure to claim
SRIOV BAR resources prevents SRIOV devices from being being enabled.

So, when the PCI_PROBE_ONLY flag is set, claim MEM and IO resources
for all devices that were added to the bus.

Signed-off-by: David Daney <david.daney@cavium.com>
---
Added this patch in v3.

 drivers/pci/host/pci-host-generic.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index e364232..b163fdc 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -209,6 +209,24 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 	return 0;
 }
 
+static int gen_pci_claim_resource_cb(struct pci_dev *dev, void *arg)
+{
+	int resno;
+
+	for (resno = 0; resno < PCI_BRIDGE_RESOURCES; resno++) {
+		struct resource *res = &dev->resource[resno];
+
+		/* If it already has a parent, don't claim it. */
+		if (res->parent)
+			continue;
+
+		if (resource_type(res) == IORESOURCE_MEM ||
+		    resource_type(res) == IORESOURCE_IO)
+			pci_claim_resource(dev, resno);
+	}
+	return 0;
+}
+
 static int gen_pci_probe(struct platform_device *pdev)
 {
 	int err;
@@ -277,6 +295,9 @@ static int gen_pci_probe(struct platform_device *pdev)
 	}
 
 	pci_bus_add_devices(bus);
+
+	if (pci_has_flag(PCI_PROBE_ONLY))
+		pci_walk_bus(bus, gen_pci_claim_resource_cb, NULL);
 	return 0;
 }
 
-- 
1.9.1

