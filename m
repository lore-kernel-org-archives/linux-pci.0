Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH rev.2 6/6] ACPI: Change the ordering of acpi_bus_check_add()
Date: Thu, 13 Dec 2012 23:23:18 +0100
Message-ID: <6413261.mhm3NBAO0r@vostro.rjw.lan>
In-Reply-To: <1499423.ez5cZl2uAf@vostro.rjw.lan>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <1499423.ez5cZl2uAf@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If acpi_bus_check_add() is called for a handle already having an
existing struct acpi_device object attached, it is not necessary to
check the type and status of the device correspondig to it, so
change the ordering of acpi_bus_check_add() to avoid that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux/drivers/acpi/scan.c
===================================================================
--- linux.orig/drivers/acpi/scan.c
+++ linux/drivers/acpi/scan.c
@@ -1582,6 +1582,10 @@ static acpi_status acpi_bus_check_add(ac
 	acpi_status status;
 	int result;
 
+	acpi_bus_get_device(handle, &device);
+	if (device)
+		goto out;
+
 	result = acpi_bus_type_and_status(handle, &type, &sta);
 	if (result)
 		return AE_OK;
@@ -1598,17 +1602,13 @@ static acpi_status acpi_bus_check_add(ac
 		return AE_CTRL_DEPTH;
 	}
 
-	acpi_bus_get_device(handle, &device);
-	if (!device) {
-		acpi_add_single_object(&device, handle, type, sta,
-				       ACPI_BUS_ADD_BASIC);
-		if (!device)
-			return AE_CTRL_DEPTH;
+	acpi_add_single_object(&device, handle, type, sta, ACPI_BUS_ADD_BASIC);
+	if (!device)
+		return AE_CTRL_DEPTH;
 
-		device->add_type = context ?
-					ACPI_BUS_ADD_START : ACPI_BUS_ADD_MATCH;
-	}
+	device->add_type = context ? ACPI_BUS_ADD_START : ACPI_BUS_ADD_MATCH;
 
+ out:
 	if (!*return_value)
 		*return_value = device;
 

