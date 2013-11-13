Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60890 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751032Ab3KMXFi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2013 18:05:38 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hp.com>, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/3] ACPI / PCI root: Clear driver_data before failing enumeration
Date: Thu, 14 Nov 2013 00:17:49 +0100
Message-ID: <6884617.gWRuZsFG3E@vostro.rjw.lan>
In-Reply-To: <2434673.zhjYZOTQ4A@vostro.rjw.lan>
References: <2434673.zhjYZOTQ4A@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a PCI host bridge cannot be enumerated due to an error in
pci_acpi_scan_root(), its ACPI device object's driver_data field
has to be cleared by acpi_pci_root_add() before freeing the
object pointed to by that field, or some later acpi_pci_find_root()
checks that should fail may succeed and cause quite a bit of
confusion to ensue.

Fix acpi_pci_root_add() to clear device->driver_data before
returning an error code as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/pci_root.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/acpi/pci_root.c
===================================================================
--- linux-pm.orig/drivers/acpi/pci_root.c
+++ linux-pm/drivers/acpi/pci_root.c
@@ -525,6 +525,7 @@ static int acpi_pci_root_add(struct acpi
 		dev_err(&device->dev,
 			"Bus %04x:%02x not present in PCI namespace\n",
 			root->segment, (unsigned int)root->secondary.start);
+		device->driver_data = NULL;
 		result = -ENODEV;
 		goto end;
 	}

