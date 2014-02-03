Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Aaron Lu <aaron.lu@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH 3/24][Resend] ACPI / hotplug / PCI: Scan root bus under the PCI rescan-remove lock
Date: Tue, 04 Feb 2014 00:16:47 +0100
Message-ID: <17625030.0nuH6OuXil@vostro.rjw.lan>
In-Reply-To: <7532948.aJNUotNMpR@vostro.rjw.lan>
References: <2217793.001RY6hKlo@vostro.rjw.lan> <20140203104408.GQ18029@intel.com> <7532948.aJNUotNMpR@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since acpiphp_check_bridge() called by acpiphp_check_host_bridge()
does things that require PCI rescan-remove locking around it,
make acpiphp_check_host_bridge() use that locking.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -829,7 +829,11 @@ void acpiphp_check_host_bridge(acpi_hand
 
 	bridge = acpiphp_handle_to_bridge(handle);
 	if (bridge) {
+		pci_lock_rescan_remove();
+
 		acpiphp_check_bridge(bridge);
+
+		pci_unlock_rescan_remove();
 		put_bridge(bridge);
 	}
 }

