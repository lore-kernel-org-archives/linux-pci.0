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
Subject: [PATCH v4 5/5] PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
Date: Fri,  2 Oct 2015 11:44:03 -0700
Message-Id: <1443811443-18878-6-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Daney <david.daney@cavium.com>

If the bus is being configured with a bus-range that does not start at
zero, pass that starting bus number to pci_scan_root_bus().  Passing
the incorrect value of zero causes attempted config accesses outside
of the supported range, which cascades to an OOPs spew and eventual
kernel panic.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
No change from v3.

 drivers/pci/host/pci-host-generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index 5cce837..eb4b7c7 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -264,7 +264,8 @@ static int gen_pci_probe(struct platform_device *pdev)
 	if (!pci_has_flag(PCI_PROBE_ONLY))
 		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
-	bus = pci_scan_root_bus(dev, 0,
+
+	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
 				&pci->cfg.ops->ops, pci, &pci->resources);
 	if (!bus) {
 		dev_err(dev, "Scanning rootbus failed");
-- 
1.9.1

