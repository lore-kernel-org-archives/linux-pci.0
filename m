Return-Path: <linux-kernel-owner@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>
Subject: [PATCH v14 7/9] ACPI / scan: do not enumerate Indirect IO host children
Date: Tue, 20 Feb 2018 01:48:38 +0800
Message-ID: <1519062520-198902-8-git-send-email-john.garry@huawei.com>
In-Reply-To: <1519062520-198902-1-git-send-email-john.garry@huawei.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Through the logical PIO framework systems which otherwise have
no IO space access to legacy ISA/LPC devices may access these
devices through so-called "indirect IO" method. In this, IO
space accesses for non-PCI hosts are redirected to a host
LLDD to manually generate the IO space (bus) accesses. Hosts
are able to register a region in logical PIO space to map to
its bus address range.

Indirect IO child devices have an associated host-specific bus
address. Special translation is required to map between
a logical PIO address for a device and it's host bus address.

Since in the ACPI tables the child device IO resources would
be the host-specific values, it is required the ACPI scan code
should not enumerate these devices, and that this should be
the responsibility of the host driver so that it can "fixup"
the resources so that they map to the appropriate logical PIO
addresses.

To avoid enumerating these child devices, we check whether
the parent for a device is a member of a known list of
"indirect IO" hosts. For now, the HiSilicon LPC host
controller ID is added.

To flag a device to not be enumerated, we reuse the existing
serial bus slave flag.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/acpi/scan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8e63d93..c1a60852 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1524,11 +1524,25 @@ static int acpi_check_serial_bus_slave(struct acpi_resource *ares, void *data)
 	return -1;
 }
 
+static bool acpi_is_indirect_io_slave(struct acpi_device *device)
+{
+	struct acpi_device *parent = device->parent;
+	const struct acpi_device_id indirect_io_hosts[] = {
+		{"HISI0191", 0},
+		{}
+	};
+
+	return parent && !acpi_match_device_ids(parent, indirect_io_hosts);
+}
+
 static bool acpi_is_serial_bus_slave(struct acpi_device *device)
 {
 	struct list_head resource_list;
 	bool is_serial_bus_slave = false;
 
+	if (acpi_is_indirect_io_slave(device))
+		return true;
+
 	/* Macs use device properties in lieu of _CRS resources */
 	if (x86_apple_machine &&
 	    (fwnode_property_present(&device->fwnode, "spiSclkPeriod") ||
-- 
1.9.1
