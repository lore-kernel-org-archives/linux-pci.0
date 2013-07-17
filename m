Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 27/30] ACPI / hotplug / PCI: Sanitize acpiphp_get_(latch)|(adapter)_status()
Date: Thu, 18 Jul 2013 01:34:22 +0200
Message-ID: <1471580.IUgOB8bMx5@vostro.rjw.lan>
In-Reply-To: <2366394.4EoP1MXmG2@vostro.rjw.lan>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <3718119.FLASu5DBx8@vostro.rjw.lan> <2366394.4EoP1MXmG2@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

There is no need for a temporary variable and all the tricks with
ternary operators in acpiphp_get_(latch)|(adapter)_status(). Change
those functions to be a bit more straightforward.

[rjw: Changelog]
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -1107,11 +1107,7 @@ u8 acpiphp_get_power_status(struct acpip
  */
 u8 acpiphp_get_latch_status(struct acpiphp_slot *slot)
 {
-	unsigned int sta;
-
-	sta = get_slot_status(slot);
-
-	return (sta & ACPI_STA_DEVICE_UI) ? 0 : 1;
+	return !(get_slot_status(slot) & ACPI_STA_DEVICE_UI);
 }
 
 
@@ -1121,9 +1117,5 @@ u8 acpiphp_get_latch_status(struct acpip
  */
 u8 acpiphp_get_adapter_status(struct acpiphp_slot *slot)
 {
-	unsigned int sta;
-
-	sta = get_slot_status(slot);
-
-	return (sta == 0) ? 0 : 1;
+	return !!get_slot_status(slot);
 }

