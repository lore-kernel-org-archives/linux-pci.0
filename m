Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/3] ACPI / hotplug: Do not execute "insert in progress" _OST
Date: Wed, 06 Nov 2013 00:36:22 +0100
Message-ID: <3194498.3N0mOaLMuZ@vostro.rjw.lan>
In-Reply-To: <18462848.9zsetEL1Yy@vostro.rjw.lan>
References: <5839747.7HXXGHmMBd@vostro.rjw.lan> <2970389.SeMGM45Qln@vostro.rjw.lan> <18462848.9zsetEL1Yy@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to the ACPI spec (5.0, Section 6.3.5), the "Device
insertion in progress (pending)" (0x80) _OST status code is
reserved for the "Insertion Processing" (0x200) source event
which is "a result of an OSPM action".  Specifically, it is not
a notification, so that status code should not be used during
notification processing, which unfortunately is done by
acpi_scan_bus_device_check().

For this reason, drop the ACPI_OST_SC_INSERT_IN_PROGRESS _OST
status evaluation from there (it was a mistake to put it in there
in the first place).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Material for stable, in my opinion.

Thanks,
Rafael

---
 drivers/acpi/scan.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -344,8 +344,6 @@ static void acpi_scan_bus_device_check(a
 			goto out;
 		}
 	}
-	acpi_evaluate_hotplug_ost(handle, ost_source,
-				  ACPI_OST_SC_INSERT_IN_PROGRESS, NULL);
 	error = acpi_bus_scan(handle);
 	if (error) {
 		acpi_handle_warn(handle, "Namespace scan failure\n");

