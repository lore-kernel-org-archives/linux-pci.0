Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFC][PATCH 3/30] ACPI / hotplug / PCI: Always return success after adding a function
Date: Fri, 12 Jul 2013 01:38:39 +0200
Message-ID: <59726852.ZdEFxTYbzn@vostro.rjw.lan>
In-Reply-To: <3718119.FLASu5DBx8@vostro.rjw.lan>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <3718119.FLASu5DBx8@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When a new ACPIPHP function is added by register_slot() and the
notify handler cannot be installed for it, register_slot() returns an
error status without cleaning up, which causes the entire namespace
walk in acpiphp_enumerate_slots() to be aborted, although it still
may be possible to successfully install the function notify handler
for other device objects under the given brigde.

To address this issue make register_slot() return success after
a new function has been added, even if the addition of the notify
handler for it has failed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/hotplug/acpiphp_glue.c
===================================================================
--- linux-pm.orig/drivers/pci/hotplug/acpiphp_glue.c
+++ linux-pm/drivers/pci/hotplug/acpiphp_glue.c
@@ -335,10 +335,9 @@ register_slot(acpi_handle handle, u32 lv
 
 		if (ACPI_FAILURE(status))
 			err("failed to register interrupt notify handler\n");
-	} else
-		status = AE_OK;
+	}
 
-	return status;
+	return AE_OK;
 
  err_exit:
 	bridge->nr_slots--;

