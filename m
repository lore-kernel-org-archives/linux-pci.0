Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/2] PCI: designware: Make config accessor override checking
 symmetric
To: Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Jan 2016 13:55:15 -0600
Message-ID: <20160106195515.24780.43906.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Drivers based on the DesignWare core can override the config read accessors
by supplying rd_own_conf() and rd_other_conf() function pointers.
dw_pcie_rd_conf() calls dw_pcie_rd_own_conf() (for accesses to the root
bus) or dw_pcie_rd_other_conf():

  dw_pcie_rd_conf
    dw_pcie_rd_own_conf                # if on root bus
    dw_pcie_rd_other_conf              # if not on root bus

Previously we checked for rd_other_conf() directly in dw_pcie_rd_conf(),
but we checked for rd_own_conf() in dw_pcie_rd_own_conf().

Check for rd_other_conf() in dw_pcie_rd_other_conf() to make this symmetric
with the rd_own_conf() checking, and similarly for the write path.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index c104bad..7a4ee06 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -564,6 +564,9 @@ static int dw_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
 
+	if (pp->ops->rd_other_conf)
+		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
+
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 
@@ -598,6 +601,9 @@ static int dw_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *bus,
 	u64 cpu_addr;
 	void __iomem *va_cfg_base;
 
+	if (pp->ops->wr_other_conf)
+		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
+
 	busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
 		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
 
@@ -660,9 +666,6 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	if (bus->number == pp->root_bus_nr)
 		return dw_pcie_rd_own_conf(pp, where, size, val);
 
-	if (pp->ops->rd_other_conf)
-		return pp->ops->rd_other_conf(pp, bus, devfn, where, size, val);
-
 	return dw_pcie_rd_other_conf(pp, bus, devfn, where, size, val);
 }
 
@@ -678,9 +681,6 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (bus->number == pp->root_bus_nr)
 		return dw_pcie_wr_own_conf(pp, where, size, val);
 
-	if (pp->ops->wr_other_conf)
-		return pp->ops->wr_other_conf(pp, bus, devfn, where, size, val);
-
 	return dw_pcie_wr_other_conf(pp, bus, devfn, where, size, val);
 }
 

