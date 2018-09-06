Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 05/10] PCI: portdrv: Resume upon exit from system suspend if left runtime suspended
Date: Thu,  6 Sep 2018 18:50:15 +0300
Message-Id: <20180906155020.51700-6-mika.westerberg@linux.intel.com>
In-Reply-To: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
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
The custom ->prepare() hook with DPM_FLAG_SMART_PREPARE is needed
because otherwise pci_pm_prepare() instructs the PM core to go directly
to pci_pm_complete() on resume and this skips resuming the port.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/portdrv_pci.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eef22dc29140..74761f660a30 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -43,6 +43,21 @@ __setup("pcie_ports=", pcie_port_setup);
 /* global data */
 
 #ifdef CONFIG_PM
+int pcie_port_prepare(struct device *dev)
+{
+	/*
+	 * Return 0 here to indicate PCI core that:
+	 *   - Direct complete path should be avoided
+	 *   - It is OK to leave the port runtime suspended over system
+	 *     suspend
+	 *
+	 * However, the port needs to be resumed afterwards because it may
+	 * have been in D3cold in which case we need to re-initialize the
+	 * hardware as it is in D0uninitialized in that case.
+	 */
+	return 0;
+}
+
 static int pcie_port_runtime_suspend(struct device *dev)
 {
 	return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
@@ -64,6 +79,7 @@ static int pcie_port_runtime_idle(struct device *dev)
 }
 
 static const struct dev_pm_ops pcie_portdrv_pm_ops = {
+	.prepare	= pcie_port_prepare,
 	.suspend	= pcie_port_device_suspend,
 	.resume_noirq	= pcie_port_device_resume_noirq,
 	.resume		= pcie_port_device_resume,
@@ -109,8 +125,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 
 	pci_save_state(dev);
 
-	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_SUSPEND |
-					   DPM_FLAG_LEAVE_SUSPENDED);
+	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_SMART_PREPARE |
+					   DPM_FLAG_SMART_SUSPEND);
 
 	if (pci_bridge_d3_possible(dev)) {
 		/*
-- 
2.18.0
