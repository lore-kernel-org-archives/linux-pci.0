Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] PCI/DPC: Do not enable DPC if AER control is not allowed by the BIOS
Date: Wed, 14 Mar 2018 14:41:25 +0300
Message-Id: <20180314114125.71132-2-mika.westerberg@linux.intel.com>
In-Reply-To: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
References: <20180314114125.71132-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit eed85ff4c0da ("PCI/DPC: Enable DPC only if AER is available")
made DPC control dependent whether AER is enabled in the OS. However, it
does not take into account situations where BIOS has not given OS
control of AER:

  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
  acpi PNP0A08:00: _OSC: platform does not support [AER]
  acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]

I think here it is better not to enable DPC even if the capability is
available because then it would be against what "Determination of DPC
Control" note in PCIe 4.0 sec 6.1.10 recommends.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_acpi.c | 4 ++--
 drivers/pci/pcie/portdrv_core.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index 319c94976873..504bedb63f38 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -48,11 +48,11 @@ void pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 
 	flags = root->osc_control_set;
 
-	*srv_mask = PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_DPC;
+	*srv_mask = PCIE_PORT_SERVICE_VC;
 	if (flags & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL)
 		*srv_mask |= PCIE_PORT_SERVICE_HP;
 	if (flags & OSC_PCI_EXPRESS_PME_CONTROL)
 		*srv_mask |= PCIE_PORT_SERVICE_PME;
 	if (flags & OSC_PCI_EXPRESS_AER_CONTROL)
-		*srv_mask |= PCIE_PORT_SERVICE_AER;
+		*srv_mask |= PCIE_PORT_SERVICE_AER | PCIE_PORT_SERVICE_DPC;
 }
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ef3bad4ad010..2619cd928a5a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -257,7 +257,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 		 */
 		pcie_pme_interrupt_enable(dev, false);
 	}
-	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC))
+	if ((cap_mask & PCIE_PORT_SERVICE_DPC) &&
+	    pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	return services;
-- 
2.16.1

