Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Huang Ying <ying.huang@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	ying.huang@intel.com, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH RESEND] ACPI/PCI: Make PCI devices notified when its power resource turned on
Date: Wed, 26 Sep 2012 21:59:31 +0800
Message-Id: <1348667971-30876-1-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry for bothering.  It appears that this patch should go through ACPI
tree because code changed are under drivers/acpi.

A set of power resources may be shared by multiple devices.  When all
devices share one set of power resources is put into D3_COLD state,
the power resources will be turned off.  When one of the device is
waked, the power resource will be turned on and all devices share it
will be powered on to D0uninitialized state.  These devices should be
resumed, so that they can get opportunity to go to low power state
later.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_bind.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/acpi/pci_bind.c
+++ b/drivers/acpi/pci_bind.c
@@ -45,6 +45,7 @@ static int acpi_pci_unbind(struct acpi_d
 
 	device_set_run_wake(&dev->dev, false);
 	pci_acpi_remove_pm_notifier(device);
+	acpi_power_resource_unregister_device(dev, device->handle);
 
 	if (!dev->subordinate)
 		goto out;
@@ -71,6 +72,7 @@ static int acpi_pci_bind(struct acpi_dev
 		return 0;
 
 	pci_acpi_add_pm_notifier(device, dev);
+	acpi_power_resource_register_device(dev, device->handle);
 	if (device->wakeup.flags.run_wake)
 		device_set_run_wake(&dev->dev, true);
 
