Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 05/10] PCI: portdrv: Resume upon exit from system suspend if left runtime suspended
Date: Thu, 13 Sep 2018 17:33:17 +0300
Message-Id: <20180913143322.77953-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently we try to keep PCIe ports runtime suspended over system
suspend if possible. This mostly happens when entering suspend-to-idle
because there is no need to re-configure wake settings.

This causes problems if the parent port goes into D3cold and it gets
resumed upon exit from system suspend. This may happen for example if
the port is part of PCIe switch and the same switch is connected to a
PCIe endpoint that needs to be resumed. The way exit from D3cold works
according PCIe 4.0 spec 5.3.1.4.2 is that power is restored and cold
reset is signaled. After this the device is in D0unitialized state
keeping PME context if it supports wake from D3cold.

The problem occurs when a PCIe hotplug port is left suspended and the
parent port goes into D3cold and back to D0, the port keeps its PME
context but since everything else is reset back to defaults
(D0unitialized) it is not set to detect hotplug events anymore.

For this reason change the PCIe portdrv power management logic so that
it is fine to keep the port runtime suspended over system suspend but it
needs to be resumed upon exit to make sure it gets properly re-initialized.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eef22dc29140..629d5fe4c9b5 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -109,8 +109,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 	pci_save_state(dev);
 
-	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_SUSPEND |
-					   DPM_FLAG_LEAVE_SUSPENDED);
+	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NEVER_SKIP |
+					   DPM_FLAG_SMART_SUSPEND);
 
 	if (pci_bridge_d3_possible(dev)) {
 		/*
-- 
2.18.0
