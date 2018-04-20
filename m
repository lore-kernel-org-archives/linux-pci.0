Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41887 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754607AbeDTMWF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 08:22:05 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI / PM: Do not clear state_saved in pci_pm_freeze() when smart suspend is set
Date: Fri, 20 Apr 2018 15:22:02 +0300
Message-Id: <20180420122202.29944-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If a driver uses DPM_FLAG_SMART_SUSPEND and the device is already
runtime suspended when hibernate is started PCI core skips runtime
resuming the device but still clears pci_dev->state_saved. After the
hibernation image is written pci_pm_thaw_noirq() makes sure subsequent
thaw phases for the device are also skipped leaving it runtime suspended
with pci_dev->state_saved == false.

When the device is eventually runtime resumed pci_pm_runtime_resume()
restores config space by calling pci_restore_standard_config(), however
because pci_dev->state_saved == false pci_restore_state() never actually
restores the config space leaving the device in a state that is not what
the driver might expect.

For example here is what happens for intel-lpss I2C devices once the
hibernation snapshot is taken:

  intel-lpss 0000:00:15.0: power state changed by ACPI to D0
  intel-lpss 0000:00:1e.0: power state changed by ACPI to D3cold
  video LNXVIDEO:00: Restoring backlight state
  PM: hibernation exit
  i2c_designware i2c_designware.1: Unknown Synopsys component type: 0xffffffff
  i2c_designware i2c_designware.0: Unknown Synopsys component type: 0xffffffff
  i2c_designware i2c_designware.1: timeout in disabling adapter
  i2c_designware i2c_designware.0: timeout in disabling adapter

Since PCI config space is not restored the device is still in D3hot
making MMIO register reads return 0xffffffff.

Fix this by clearing pci_dev->state_saved only if we actually end up
runtime resuming the device.

Fixes: c4b65157aeef ("PCI / PM: Take SMART_SUSPEND driver flag into account")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 6ace47099fc5..b9a131137e64 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -958,10 +958,11 @@ static int pci_pm_freeze(struct device *dev)
 	 * devices should not be touched during freeze/thaw transitions,
 	 * however.
 	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+	if (!dev_pm_smart_suspend_and_suspended(dev)) {
 		pm_runtime_resume(dev);
+		pci_dev->state_saved = false;
+	}
 
-	pci_dev->state_saved = false;
 	if (pm->freeze) {
 		int error;
 
-- 
2.17.0
