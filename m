Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH 8/24][Resend] ACPI / hotplug / PCI: Simplify register_slot()
Date: Tue, 04 Feb 2014 00:22:32 +0100
Message-ID: <1761770.yZzRr5SFh0@vostro.rjw.lan>
In-Reply-To: <7532948.aJNUotNMpR@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan> <20140203104408.GQ18029@intel.com> <7532948.aJNUotNMpR@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The err label in register_slot() is only jumped to from one place,
so move the code under the label to that place and drop the label.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -335,8 +335,10 @@ static acpi_status register_slot(acpi_ha
 
 	slot = kzalloc(sizeof(struct acpiphp_slot), GFP_KERNEL);
 	if (!slot) {
-		status = AE_NO_MEMORY;
-		goto err;
+		mutex_lock(&acpiphp_context_lock);
+		acpiphp_put_context(context);
+		mutex_unlock(&acpiphp_context_lock);
+		return AE_NO_MEMORY;
 	}
 
 	slot->bus = bridge->pci_bus;
@@ -404,12 +406,6 @@ static acpi_status register_slot(acpi_ha
 	}
 
 	return AE_OK;
-
- err:
-	mutex_lock(&acpiphp_context_lock);
-	acpiphp_put_context(context);
-	mutex_unlock(&acpiphp_context_lock);
-	return status;
 }
 
 static struct acpiphp_bridge *acpiphp_handle_to_bridge(acpi_handle handle)

