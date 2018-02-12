Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:35315 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933760AbeBLKz1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 05:55:27 -0500
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, Mike Lothian <mike@fireburn.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
Date: Mon, 12 Feb 2018 13:55:23 +0300
Message-Id: <20180212105523.15984-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Mike Lothian reported that plugging in a USB-C device does not work
properly in his Dell Alienware system. This system has Intel Alpine
Ridge Thunderbolt controller providing USB-C functionality. In these
systems the USB controller (xHCI) is hotplugged whenever a device is
connected to the port using ACPI based hotplug.

The ACPI description of the root port in question looks as follows:

Device (RP01)
{
    Name (_ADR, 0x001C0000)

    Device (PXSX)
    {
        Name (_ADR, 0x02)

        Method (_RMV, 0, NotSerialized)
        {
            // ...
        }
    }

Here _ADR 0x02 means device 0, function 2 on the bus under root port
(RP1) but that seems to be incorrect because device 0 is the upstream
port of the Alpine Ridge PCIe switch and it does not have other
functions than 0 (the bridge itself). When we get ACPI Notify() to the
root port resulting from connecting a USB-C device, Linux tries to read
PCI_VENDOR_ID from device 0, function 2 which of course always returns
0xffffffff because there is no such function and we never find the
device.

In Windows this works fine.

Now, since we get ACPI Notify() to the root port and not to the PXSX
device we should actually start our scan from there as well and not from
the non-existent PXSX device so fix this by checking presence of the
slot itself (function 0) if we fail to do that otherwise.

While there use pci_bus_read_dev_vendor_id() in get_slot_status() which
is the recommended way to read device and vendor ID of device on PCI bus.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198557
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/hotplug/acpiphp_glue.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index e2198a2feeca..b45b375c0e6c 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -541,6 +541,7 @@ static unsigned int get_slot_status(struct acpiphp_slot *slot)
 {
 	unsigned long long sta = 0;
 	struct acpiphp_func *func;
+	u32 dvid;
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		if (func->flags & FUNC_HAS_STA) {
@@ -551,19 +552,27 @@ static unsigned int get_slot_status(struct acpiphp_slot *slot)
 			if (ACPI_SUCCESS(status) && sta)
 				break;
 		} else {
-			u32 dvid;
-
-			pci_bus_read_config_dword(slot->bus,
-						  PCI_DEVFN(slot->device,
-							    func->function),
-						  PCI_VENDOR_ID, &dvid);
-			if (dvid != 0xffffffff) {
+			if (pci_bus_read_dev_vendor_id(slot->bus,
+					PCI_DEVFN(slot->device, func->function),
+					&dvid, 0)) {
 				sta = ACPI_STA_ALL;
 				break;
 			}
 		}
 	}
 
+	if (!sta) {
+		/*
+		 * Check for the slot itself since it may be that the
+		 * ACPI slot is a device below PCIe upstream port so in
+		 * that case it may not even be reachable yet.
+		 */
+		if (pci_bus_read_dev_vendor_id(slot->bus,
+				PCI_DEVFN(slot->device, 0), &dvid, 0)) {
+			sta = ACPI_STA_ALL;
+		}
+	}
+
 	return (unsigned int)sta;
 }
 
-- 
2.15.1
